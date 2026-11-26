# Chapter 5.1. Root Domain I: Data Storage & Organization

## 1. Domain Definition and Scope

**Data Storage & Organization** governs the preservation, physical structuring, and deterministic retrieval of state across storage hierarchies. It is the architectural domain responsible for bridging the physical performance disparity between volatile, fast compute memory and non-volatile, persistent media.

The governing challenge of storage is that **media physics dictates access patterns**. A system that forces a storage medium to execute access patterns misaligned with its physical layout incurs catastrophic performance degradation, known as write or read amplification.

---

## 2. The Physical Hierarchy and Mechanical Realities

All storage architectures are fundamentally constrained by the hardware latency numbers every systems architect must memorize:

| Media Tier | Typical Latency | Sequential Throughput | Random I/O Penalty | Primary Failure Mode |
| :--- | :--- | :--- | :--- | :--- |
| **CPU L1/L2 Cache** | $1\text{--}4\text{ ns}$ | $>1\text{ TB/s}$ | Negligible | Core hardware fault |
| **Main Memory (DRAM)** | $50\text{--}100\text{ ns}$ | $50\text{--}100\text{ GB/s}$ | Low (cache line boundary) | Power loss (volatility) |
| **NVMe SSD (PCIe Gen 4/5)** | $10\text{--}50\text{ µs}$ | $5\text{--}14\text{ GB/s}$ | Medium (erase block amplification) | Controller crash, wear-out |
| **SATA SSD** | $100\text{--}200\text{ µs}$ | $\approx 500\text{ MB/s}$ | Medium | Controller/wear |
| **Mechanical HDD** | $5\text{--}10\text{ ms}$ | $150\text{--}250\text{ MB/s}$ | Extreme ($100\times$ slower seek) | Mechanical head/spindle crash |
| **Network Object Store** | $10\text{--}50\text{ ms}$ | Elastic (network bound) | High latency round-trip | Network partition, rate-limit |

### The Sequential vs. Random Asymmetry
Across every persistent tier (NVMe, HDD, Cloud Object Store), **sequential I/O dramatically outperforms random I/O**:
- On HDDs, random I/O requires mechanical arm repositioning ($5\text{--}10\text{ ms}$ seek time), capping random IOPS at $75\text{--}200\text{ IOPS}$. Sequential access streams continuous sectors at $>150\text{ MB/s}$.
- On NVMe SSDs, flash memory cannot be overwritten in place. Storage cells must be erased in large blocks (typically $2\text{--}8\text{ MB}$) before being programmed in smaller pages ($4\text{--}16\text{ KB}$). Random in-place overwrites trigger the Flash Translation Layer (FTL) to execute aggressive garbage collection, leading to severe **write amplification** and premature flash wear.

---

## 3. Physical Layout Architectures: B-Tree vs. LSM vs. Columnar

The physical organization of data on disk determines which workload signatures it can sustain:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        PHYSICAL STORAGE LAYOUTS                        │
├──────────────────────────┬──────────────────────────┬──────────────────┤
│ B+ Trees (In-Place)      │ LSM-Trees (Append-Only)  │ Columnar Layouts │
├──────────────────────────┼──────────────────────────┼──────────────────┤
│ • Page-based update      │ • Sequential write log   │ • Value per col  │
│ • Low read amplification │ • Memtable buffer        │ • SIMD vector    │
│ • High write amplif.     │ • High write throughput  │ • High scan rate │
│ • Ideal for OLTP reads   │ • High space amplification│ • Ideal for OLAP │
└──────────────────────────┴──────────────────────────┴──────────────────┘
```

### 1. B+ Trees (Update-in-Place)
- **Mechanism:** Organizes fixed-size pages (typically $4\text{ KB}\text{--}16\text{ KB}$) in a balanced tree. Updates locate the leaf page and rewrite it in place.
- **Trade-off:** Minimal read amplification ($O(\log_B N)$ page reads, easily cached), but severe random write amplification under high write rates because modifying a single byte requires writing an entire page to disk.
- **Archetypal Workload:** Traditional relational OLTP with balanced read-write profiles (PostgreSQL, MySQL InnoDB).

### 2. Log-Structured Merge-Trees (LSM-Trees)
- **Mechanism:** Writes are appended sequentially to a Write-Ahead Log (WAL) on disk and inserted into an in-memory sorted buffer (Memtable). When the Memtable fills, it is flushed sequentially to disk as an immutable SSTable (Sorted String Table). Background compaction merges SSTables.
- **Trade-off:** Eliminates random disk writes, achieving near-hardware-limit write throughput. Incurs read amplification (must check Bloom filters, Memtable, and multiple SSTable levels) and background compaction I/O spikes.
- **Archetypal Workload:** High-write event ingestion, time-series, log indexing (RocksDB, Cassandra, LevelDB).

### 3. Columnar Storage (Analytical Layouts)
- **Mechanism:** Stores values of the same attribute contiguously on disk rather than grouping attributes into rows. Applies run-length encoding, dictionary compression, and bit-packing.
- **Trade-off:** Extremely slow point updates and row inserts, but allows queries to read *only* the columns referenced, scanning compressed vectors at memory bandwidth using CPU SIMD instructions.
- **Archetypal Workload:** Data warehousing and analytical aggregation (Parquet, ORC, ClickHouse, BigQuery).

---

## 4. Durability, Crash Consistency, and the WAL Invariant

The fundamental invariant of persistent storage is:

$$\text{Durability Invariant: If an operation is acknowledged as committed, its state survives unannounced power failure or crash.}$$

### The Write-Ahead Log (WAL) Protocol
Operating systems buffer disk writes in the page cache. A write is not durable until the hardware executes an `fsync()` or `fdatasync()` barrier, flushing the drive write cache to non-volatile media.

To guarantee atomicity and durability without suffering the latency of random page flushes:
1. Every state mutation is first serialized as an append-only log record in the WAL.
2. The WAL record is flushed to persistent storage via `fsync()`.
3. Only after the WAL entry is durable are in-memory database pages modified.
4. If the machine crashes, the recovery manager replays the WAL from the last known clean checkpoint, reconstructing the consistent database state.

---

## 5. Hierarchical Namespaces, Metadata, and Object Identity

Organizing billions of stored entities requires decoupling **object identity** from **physical placement**.

### Inode and Prefix Tries
Hierarchical filesystems represent directory trees as directed acyclic graphs of inodes. Moving a subtree `/a/b/c` to `/d/c` is an $O(1)$ pointer update in the parent directory node rather than a physical movement of data bytes.
However, in distributed filesystems (e.g., GFS, HDFS), centralizing the namespace in a single coordinator introduces memory and throughput limits.

### Content-Addressable Storage (CAS)
In large-scale blob stores, mutability is abandoned in favor of cryptographic hashes:
$$\text{ObjectID} = \mathcal{H}(\text{DataBytes})$$
- **Guarantees:** Automatic deduplication, tamper evidence, and natural immutability.
- **Separation of Concerns:** A lightweight metadata database tracks user namespaces, permissions, and directory structures, pointing to immutable blob hashes stored on distributed storage nodes.

---

## 6. Mapping to Architectural Archetypes

Root Domain I manifests directly in two foundational architectural archetypes from the catalog:

### Archetype I: Large Object Storage & Distribution
- **Problem:** Storing and distributing files ranging from megabytes to gigabytes (media, disk images, backups) without saturating application databases or application servers.
- **Architectural Solution:** Complete architectural decoupling of the **control plane** (metadata, access control, versioning) from the **data plane** (chunked, content-addressed block storage nodes).
- **Core Mechanisms:** Chunking manifests, multipart parallel uploads, presigned short-lived download tokens, edge CDN reverse caching.

### Archetype XIV: Hierarchical Namespace & Metadata
- **Problem:** Managing deeply nested, multi-tenant directory hierarchies with atomic renames, recursive permission inheritance, and cycle prevention.
- **Architectural Solution:** Partitioned parent-child relational index paired with directory-level leasing and transactional move protocols.
- **Critical Invariant:** An ancestor can never be moved into its own descendant (acyclicity invariant); two concurrent valid move operations must never jointly create an isolated cycle.

# Chapter 5.8. Boundary Analysis and Multi-Domain System Composition

## 1. The Necessity of Boundary Analysis

A classification taxonomy is only as useful as its boundary definitions. When engineers encounter real-world requirements, superficial similarities between technologies frequently create architectural confusion:
- *"Is an Elasticsearch cluster Storage (Domain I) or Retrieval (Domain VI)?"*
- *"Is Apache Kafka Data Movement (Domain II) or Storage (Domain I)?"*
- *"Is a distributed lock service Coordination (Domain III) or Communication (Domain V)?"*

Misclassifying a component leads to fatal architectural mismatches—for example, treating a search engine as an authoritative storage engine, only to discover that it lacks write-barrier durability guarantees, or treating a messaging queue as a database, only to face compaction stalls and unbounded storage costs.

---

## 2. The Four Critical Domain Boundary Tensions

```
┌────────────────────────────────────────────────────────────────────────┐
│                        DOMAIN BOUNDARY TENSIONS                        │
├─────────────────────────┬─────────────────────────┬────────────────────┤
│ Storage (I) vs          │ Movement (II) vs        │ Coordination (III) │
│ Retrieval (VI)          │ Execution (IV)          │ vs Commun. (V)     │
├─────────────────────────┼─────────────────────────┼────────────────────┤
│ Authoritative byte truth│ Ingestion decoupling    │ Agreement & mutual │
│ vs derived, rebuildable │ vs compute scheduling,  │ exclusion vs data  │
│ multi-dim index index.  │ placement & workflows.  │ transfer protocols.│
└─────────────────────────┴─────────────────────────┴────────────────────┘
```

### Boundary 1: Data Storage (I) vs. Information Retrieval (VI)
- **The Core Distinction:** Storage preserves the **authoritative ground truth** of an entity. Information Retrieval maintains a **derived, rebuildable index** optimized for candidate extraction.
- **The Failure Mode:** If an index in Domain VI is corrupted, the system can rebuild it by replaying logs or scanning the authoritative storage engine in Domain I. However, if Domain I suffers data loss, the data is gone forever.
- **Rule of Architecture:** Never treat a search index, vector database, or geospatial cache as the system of record. Writes must commit to an authoritative Domain I datastore (with WAL and durability barriers) before being asynchronously propagated to Domain VI indexes.

### Boundary 2: Data Movement (II) vs. Execution & Resource Management (IV)
- **The Core Distinction:** Domain II buffers, decouples, and routes events between producers and consumers. Domain IV schedules, places, and manages the execution lifecycle of the computational workers themselves.
- **The Boundary Interaction:** Domain II provides the backpressure signals and queued message volume metrics; Domain IV acts on those metrics to autoscale worker clusters, allocate memory slots, and enforce task preemption.

### Boundary 3: State & Coordination (III) vs. Communication (V)
- **The Core Distinction:** Domain V is the physical transport pipe (TCP, HTTP/2, WebSockets, binary framing). Domain III is the mathematical agreement on distributed state (Paxos, Raft, leases, fencing).
- **The Boundary Interaction:** You can send messages over a reliable Domain V WebSocket pipe, but that provides zero guarantees against split-brain or concurrent update corruption without a Domain III consensus or fencing protocol governing state mutations.

### Boundary 4: Data Movement (II) vs. Computation (VII)
- **The Core Distinction:** Domain II focuses on low-latency streaming delivery and continuous windowed aggregations ($<1\text{ second}$). Domain VII focuses on heavy batch transformations, distributed shuffles, and complex relational joins over petabyte-scale historical datasets.

---

## 3. The Complete 14-Archetype to Domain Mapping Matrix

Every architectural archetype from the established catalog is anchored in a primary governing domain while maintaining well-defined interfaces with adjacent domains:

| Archetype ID | Archetype Name | Primary Domain | Secondary Interfaces | Core Invariant Guaranteed |
| :--- | :--- | :--- | :--- | :--- |
| **Archetype I** | Large Object Storage & Distribution | **Domain I (Storage)** | Domain V (CDN routing) | Byte-range immutability; manifest integrity |
| **Archetype II** | High-Write Ingestion & Logs | **Domain II (Movement)** | Domain I (WAL persistence) | Partition-level total order; consumer progress |
| **Archetype III** | Aggregation & Derived Views | **Domain II (Movement)** | Domain VI (Read models) | Event-time watermark monotonicity |
| **Archetype IV** | Contended Resource Allocation | **Domain III (Coord.)** | Domain I (State transition)| Mutual exclusion via monotonic fencing |
| **Archetype V** | Fan-Out & Information Distribution | **Domain II (Movement)** | Domain V (Multiplexing) | Push/pull fan-out bounded delivery SLA |
| **Archetype VI** | Partitioned & Replicated State | **Domain III (Coord.)** | Domain I (Replication log) | Quorum consistency ($R + W > N$); leader exclusivity |
| **Archetype VII** | Durable Workflow & Orchestration | **Domain IV (Execution)**| Domain III (State machine) | Saga compensation completeness |
| **Archetype VIII**| Real-Time Shared State | **Domain V (Commun.)** | Domain III (OT/CRDT) | Convergence across concurrent edits |
| **Archetype IX** | Geospatial Indexing & Routing | **Domain VI (Retrieval)**| Domain I (Geometry store) | Recall preservation under spatial coverings |
| **Archetype X** | Search & Information Retrieval | **Domain VI (Retrieval)**| Domain I (Document source) | Inverted index posting list determinism |
| **Archetype XI** | Graph Relationships & Traversal | **Domain VI (Retrieval)**| Domain I (Adjacency store) | Acyclic traversal termination |
| **Archetype XII** | Scheduling & Resource Placement | **Domain IV (Execution)**| Domain III (Lock placement)| Dominant Resource Fairness; no overcommit |
| **Archetype XIII**| Distributed Computation & Analytics| **Domain VII (Compute)** | Domain I (Data source/sink)| Lineage determinism; idempotent sink commit |
| **Archetype XIV** | Hierarchical Namespace & Metadata | **Domain I (Storage)** | Domain III (Atomic rename) | Directed acyclic graph namespace integrity |

---

## 4. System Composition Case Studies

To demonstrate how the taxonomy functions in real-world engineering, we examine three complex composite systems:

### Case Study 1: Global Ride-Hailing Platform (e.g., Uber, Lyft)
A ride-hailing backend is an intricate composition of five distinct domains:

```
[Driver Mobile App] ──(WebSockets: Dom V)──> [Ingress Gateway]
                                                    │
             ┌──────────────────────────────────────┼──────────────────────────────────┐
             ▼                                      ▼                                  ▼
   [High-Write Ingestion: Dom II]        [Geospatial Index: Dom VI]          [Driver Allocation: Dom III]
   • Location ping commit log            • S2 Hilbert cell candidate pool    • Atomic reservation lease
   • Downstream telemetry buffer         • Radial driver discovery           • Monotonic fencing token
             │                                                                         │
             ▼                                                                         ▼
   [Historical Analytics: Dom VII]                                           [Trip Workflow: Dom IV]
   • Surge pricing batch DAGs                                                • Saga orchestration engine
   • Driver incentive optimization                                           • Trip state & payment compensation
```

1. **Domain V (Communication):** Drivers maintain persistent full-duplex WebSocket connections to edge gateways, streaming location pings every 4 seconds.
2. **Domain II (Data Movement):** Location updates are ingested into a partitioned append-only log (Archetype II), absorbing write bursts and decoupling real-time dispatch from analytics.
3. **Domain VI (Information Retrieval):** The current driver positions are mapped into S2 space-filling cells (Archetype IX). When a rider requests a pickup, the dispatcher queries S2 cell ranges to extract the top-$K$ nearest available driver candidates within $3\text{ km}$.
4. **Domain III (State & Coordination):** Dispatching a driver is an act of contended resource allocation (Archetype IV). Multiple riders cannot be assigned the same driver. The system acquires a short-lived conditional lease on the driver entity using atomic Compare-And-Swap (CAS) with a monotonic fencing token.
5. **Domain IV (Execution & Workflows):** Once accepted, the trip enters a durable saga workflow (Archetype VII), orchestrating pickup, turn-by-turn tracking, arrival, and payment capture, ensuring compensating refund logic executes if the trip aborts mid-flight.

---

### Case Study 2: Distributed Video Publishing & Streaming (e.g., YouTube, Vimeo)

1. **Domain I (Storage - Archetype I):** Video uploads are broken into $8\text{ MB}$ chunks, hashed into Content-Addressable Storage (CAS) blocks, and uploaded via parallel multipart presigned URLs directly to object storage, bypassing application servers.
2. **Domain IV (Execution - Archetype XII & VII):** Upload completion triggers an asynchronous transcoding pipeline managed as a Directed Acyclic Graph (DAG) workflow: splitting video into resolutions ($1080p, 720p, 480p$), extracting audio tracks, and generating HLS/DASH streaming manifests.
3. **Domain VI (Retrieval - Archetype X):** Video titles, tags, descriptions, and transcripts are indexed into an inverted search engine cluster with BM25 relevance ranking for user discovery.
4. **Domain II (Movement - Archetype II & III):** Video view increments are buffered into a partitioned commit log, filtered for fraud detection via sliding window stream processors, and flushed periodically to database counters to avoid write contention.

---

### Case Study 3: Enterprise Collaborative Workspace (e.g., Google Docs, Figma)

1. **Domain V (Communication - Archetype VIII):** Active document editors establish bidirectional WebSocket sessions with an assigned session gateway node.
2. **Domain III (Coordination - Operational Transformation / CRDTs):** The gateway routes operations to an in-memory document state coordinator. Concurrent keystrokes are transformed using Operational Transformation (OT) matrices against a canonical revision log, broadcasting adjusted operations back to all connected clients.
3. **Domain I (Storage - Archetype XIV):** The document workspace organization (folders, shared team drives, permissions) is modeled as a hierarchical namespace with atomic rename/move guarantees and acyclicity verification.
4. **Domain VI (Retrieval - Archetype X):** Document content is asynchronously vectorized and tokenized into full-text and semantic vector indexes, allowing instant retrieval across enterprise corpora.

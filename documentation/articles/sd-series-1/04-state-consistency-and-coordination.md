# Chapter 5.3. Root Domain III: State, Consistency & Coordination

## 1. Domain Definition and Scope

**State, Consistency & Coordination** is the foundational core of distributed systems engineering. It addresses the governing tension of managing shared mutable state across independent physical machines connected by an unreliable network that experiences arbitrary latency, packet loss, and node crashes.

The central problem of this domain is that **in a distributed system, there is no shared physical memory and no global wall-clock time**. Coordination is the deliberate imposition of order on concurrent events to prevent conflicting operations, split-brain divergence, and corrupted invariants.

---

## 2. The Physics of Time and Network Partitions

### The Fallacy of Physical Clocks
Physical computer clocks rely on quartz crystal oscillators that drift due to thermal fluctuations, typically drifting by milliseconds each day. Network Time Protocol (NTP) synchronizes clocks periodically over the network, but NTP introduces:
1. **Clock Skew:** An unavoidable uncertainty window between any two nodes ($[\text{time} - \epsilon, \text{time} + \epsilon]$).
2. **Clock Jumps:** Abrupt forward or backward time adjustments during synchronization.

**Rule of Distributed Correctness:** Never use physical timestamps to establish causality, mutual exclusion, or total order in distributed algorithms, unless bounded by specialized synchronized hardware intervals (e.g., Google TrueTime with atomic clocks and GPS receivers).

### Logical and Vector Clocks
To establish order without physical time:
- **Lamport Timestamps:** Provide a strict partial ordering ($A \to B$) using monotonically incrementing local counters exchanged with each network message.
- **Vector Clocks:** An array of logical counters, one per node, allowing a system to distinguish whether two events are causally related or strictly concurrent ($A \parallel B$).

---

## 3. The Hierarchy of Consistency Models

Consistency models define the contract between a data store and its clients regarding the ordering and visibility of read and write operations:

```
┌────────────────────────────────────────────────────────┐
│               STRICT SERIALIZABILITY                   │
│   (Serializability + Real-Time Linearizability)        │
└──────────────────────────┬─────────────────────────────┘
                           │
         ┌─────────────────┴─────────────────┐
         ▼                                   ▼
┌──────────────────┐               ┌──────────────────┐
│ LINEARIZABILITY  │               │ SERIALIZABILITY  │
│ (Single-Object,  │               │ (Multi-Object,   │
│ Real-Time Order) │               │ Execution Order) │
└────────┬─────────┘               └─────────┬────────┘
         ▼                                   ▼
┌──────────────────┐               ┌──────────────────┐
│ CAUSAL CONSIST.  │               │ SNAPSHOT ISOLAT. │
│ (Preserves ->)   │               │ (Read Stable Pt) │
└────────┬─────────┘               └─────────┬────────┘
         ▼                                   ▼
┌──────────────────┐               ┌──────────────────┐
│ READ-COMMITTED   │               │ EVENTUAL CONSIST.│
│ (No Dirty Reads) │               │ (Converges Late) │
└──────────────────┘               └──────────────────┘
```

1. **Linearizability (Strong Consistency):** Every operation appears to take effect atomically at a discrete point in time between its start and its completion. Reads are guaranteed to see the most recent committed write in physical real time. Requires cross-node coordination on every read or write.
2. **Serializability:** A multi-transaction guarantee. The execution of a set of concurrent transactions produces the same state as some serial (sequential) execution, but that serial order does not necessarily match real-time arrival order.
3. **Causal Consistency:** Operations that are causally related must be seen by every node in the same order. Concurrent operations that are independent may be observed in differing orders. This is the strongest theoretically achievable consistency model under permanent network partitions (per Mahajan et al.).
4. **Eventual Consistency:** Replicas converge to an identical state if no new updates are made, but offer zero bounds on visibility delays or intermediate read anomalies.

---

## 4. Replication and Quorum Mechanics

Replicating state across $N$ nodes prevents data loss when nodes fail:

### Single-Leader Replication
- One node is designated the Leader; all writes route through the leader, which appends to its local WAL and streams updates to Follower nodes.
- If the leader crashes, followers must elect a new leader without split-brain (two nodes claiming leadership).

### Leaderless Quorums ($R + W > N$)
In leaderless systems (e.g., Dynamo, Cassandra), clients write to $W$ nodes and read from $R$ nodes out of a total cluster replication factor of $N$:

$$R + W > N$$

By the Pigeonhole Principle, the set of nodes written to and the set of nodes read from must overlap by at least one node, guaranteeing that a read quorum encounters at least one replica holding the latest version.
- **Limitation:** Quorum overlap guarantees *overlap of versions*, but does not automatically guarantee linearizability without read-repair or consensus coordination on the read path.

---

## 5. Mutual Exclusion, Leases, and the Fencing Token Invariant

A recurring requirement is ensuring that only one process at a time can modify a protected resource (e.g., allocating a limited inventory seat, acting as cluster primary).

### Why Distributed Locks Fail Without Fencing
A common antipattern is acquiring a lock in an in-memory store (e.g., Redis `SETNX`) with a Time-To-Live (TTL):

```
Client 1: [Acquire Lock TTL=10s] ---> [Thread Pauses for 15s (GC / VM Steal)]
Lock Store: -----------------------> [Lock Expires at t=10s]
Client 2: -------------------------> [Acquire Lock TTL=10s (Granted)]
Client 2: [Write to Storage with Token 2] ------------------------> [Storage Updated]
Client 1: [Wakes up from GC, unaware lease expired] -------------> [Write to Storage] 💥 CORRUPTION
```

Because an unannounced thread pause or network delay can cause a process to outlive its lease without knowing it, **the lock holder cannot be trusted to self-police its own expiration**.

### The Fencing Token Invariant
To guarantee mutual exclusion under arbitrary thread pauses, the destination storage service must enforce monotonic authorization:

$$\text{Fencing Invariant: A storage engine must reject any write bearing a token } T \le T_{\text{highest seen}}$$

1. The lock service issues a monotonically increasing sequence number ($T_1, T_2, T_3, \dots$) with every granted lease.
2. The client attaches its token to every write request sent to the backend datastore.
3. When Client 1 wakes up with stale token $T_1$, the storage engine observes that it has already accepted a write from Client 2 with token $T_2$ ($T_1 < T_2$), and immediately rejects Client 1's write.

---

## 6. Mapping to Architectural Archetypes

Root Domain III manifests in two essential archetypes:

### Archetype IV: Contended Resource Allocation
- **Problem:** Mediating simultaneous, conflicting claims to scarce physical or virtual assets (seat reservations, flash sales, inventory allocation) under high concurrency without double-allocation.
- **Architectural Solution:** Two-phase reservation state machine combining short-lived expiring reservation leases with atomic Compare-And-Swap (CAS) state transitions and downstream fencing.
- **Core Mechanisms:** Distributed leases, conditional CAS operations, monotonic fencing tokens, TTL reaper workers.

### Archetype VI: Partitioned & Replicated State
- **Problem:** Horizontally scaling mutable state across a cluster while maintaining fault tolerance and declared consistency boundaries.
- **Architectural Solution:** Consistent hashing ring with virtual nodes for uniform data distribution, paired with Raft/Paxos consensus groups managing quorum replication per partition.
- **Core Mechanisms:** Consistent hashing, Raft leader election and log replication, read leases, multi-version concurrency control (MVCC).

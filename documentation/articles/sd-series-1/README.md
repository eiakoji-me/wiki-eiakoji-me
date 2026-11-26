# System Design Series I: Classification of Computational Problems

**Series Focus:** Foundational classification of industrial software problems from first principles, establishing the six-tier abstraction hierarchy and the seven root computational problem domains.

---

## Series Reading Order

1. [01. Conceptual Foundations of Problem Classification](01-classification-foundations.md)
   - Why memorizing reference architectures fails.
   - The six-tier abstraction hierarchy (Domains, Signatures, Invariants, Mechanisms, Archetypes, Systems).
   - The forward derivation & reverse failure-validation method.
2. [02. Root Domain I: Data Storage & Organization](02-data-storage-and-organization.md)
   - The physical memory/NVMe/disk hierarchy and mechanical sequential vs. random realities.
   - Physical layout paradigms: B+ Trees vs. Log-Structured Merge-Trees (LSM) vs. Columnar formats.
   - The Write-Ahead Log (WAL) durability barrier and crash consistency invariants.
   - Anchored Archetypes: Archetype I (Large Object Storage) & Archetype XIV (Hierarchical Namespace & Metadata).
3. [03. Root Domain II: Data Movement & Transformation](03-data-movement-and-transformation.md)
   - Decoupling physics, queueing dynamics, and Little's Law ($L = \lambda W$).
   - Streaming delivery semantics: at-most-once, at-least-once, and the idempotency invariant.
   - Change Data Capture (CDC) and the Transactional Outbox pattern.
   - Windowing archetypes, event time vs. processing time, and watermark heuristics.
   - Push vs. pull fan-out topologies.
   - Anchored Archetypes: Archetype II (High-Write Ingestion), Archetype III (Aggregation & Views), Archetype V (Fan-Out).
4. [04. Root Domain III: State, Consistency & Coordination](04-state-consistency-and-coordination.md)
   - The physical clock fallacy and vector clocks.
   - The consistency hierarchy: linearizability, serializability, causal consistency, and eventual consistency.
   - Quorum mechanics ($R + W > N$) and consensus algorithms (Raft/Paxos).
   - The distributed lock fallacy and the fencing token invariant.
   - Anchored Archetypes: Archetype IV (Contended Resource Allocation) & Archetype VI (Partitioned & Replicated State).
5. [05. Root Domain IV: Execution & Resource Management](05-execution-and-resource-management.md)
   - Ephemeral task leasing and heartbeat failure recovery.
   - Cluster scheduling architectures: monolithic, two-level, and shared-state optimistic schedulers.
   - Dominant Resource Fairness (DRF) in multi-tenant environments.
   - Durable distributed workflows: the Saga invariant, orchestration vs. choreography.
   - Anchored Archetypes: Archetype VII (Durable Workflow & Orchestration) & Archetype XII (Scheduling & Placement).
6. [06. Root Domain V: Communication & Interaction](06-communication-and-interaction.md)
   - Protocol mechanics: HTTP/1.1 vs. HTTP/2 multiplexing vs. HTTP/3 (QUIC over UDP).
   - Resilience: deadline propagation, jittered exponential backoff, and circuit breakers.
   - Real-time collaborative synchronization: Operational Transformation (OT) vs. Conflict-Free Replicated Data Types (CRDTs).
   - Anchored Archetype: Archetype VIII (Real-Time Synchronization & Collaboration).
7. [07. Root Domain VI: Information Retrieval & Discovery](07-information-retrieval-and-discovery.md)
   - The tension between query expressiveness and index maintenance.
   - Inverted indexes: posting lists, skip pointers, Roaring Bitmaps, and BM25 relevance ranking.
   - Geospatial indexing: space-filling curves (S2 Hilbert, H3 hexagons) and road-network Contraction Hierarchies.
   - Graph topologies: Compressed Sparse Row (CSR) arrays and bounded traversal.
   - Vector search: Hierarchical Navigable Small World (HNSW) and Approximate Nearest Neighbors (ANN).
   - Anchored Archetypes: Archetype IX (Geospatial), Archetype X (Search), Archetype XI (Graph Traversal).
8. [08. Root Domain VII: Computation & Optimization](08-computation-and-optimization.md)
   - The limits of single-server compute and compute-storage disaggregation.
   - MapReduce to Directed Acyclic Graph (DAG) stage execution.
   - The shuffle phase: all-to-all network saturation and data skew mitigation via key salting.
   - Distributed join strategies: Broadcast hash join vs. shuffle hash join vs. sort-merge join.
   - Lineage-based fault recovery and idempotent two-phase sink commits.
   - Anchored Archetype: Archetype XIII (Distributed Computation & Analytics).
9. [09. Boundary Analysis and Multi-Domain System Composition](09-boundaries-and-composition.md)
   - The four critical boundary tensions (Storage vs. Retrieval, Movement vs. Execution, Coordination vs. Communication, Movement vs. Computation).
   - The complete 14-archetype to root-domain mapping matrix.
   - Three end-to-end composite case study analyses: Ride-Hailing Platform, Distributed Video Streaming, and Enterprise Collaborative Workspace.

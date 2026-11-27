# Chapter 5.5. Root Domain V: Communication & Interaction

## 1. Domain Definition and Scope

**Communication & Interaction** governs the protocols, network topologies, session semantics, and data framing mechanisms that enable independent software processes to exchange information across physical network boundaries.

While Domain II handles high-volume continuous data pipelines, Domain V is concerned with **the interactive boundaries between actors**: client-to-server interaction, inter-service RPC communication, and low-latency bidirectional state synchronization.

---

## 2. Protocol Mechanics and Transport Physics

The performance of networked interactions is governed by packet dynamics, transport handshakes, and framing boundaries:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        INTERACTION PROTOCOLS                           │
├────────────────────┬────────────────────┬──────────────────────────────┤
│ HTTP/1.1           │ HTTP/2 & gRPC      │ WebSockets / HTTP/3          │
├────────────────────┼────────────────────┼──────────────────────────────┤
│ • 1 request per conn│ • Binary framing   │ • Full-duplex persistent     │
│ • Head-of-line blk │ • Stream multiplex │ • Zero per-message handshake │
│ • Text header cost │ • Header compress  │ • UDP-based QUIC (HTTP/3)    │
│ • High conn churn  │ • Protobuf serial. │ • Bypasses TCP HoL blocking  │
└────────────────────┴────────────────────┴──────────────────────────────┘
```

### The Head-of-Line (HoL) Blocking Problem
- **Application-Layer HoL Blocking (HTTP/1.1):** A client can only send one request at a time over a single TCP connection. If the first request stalls, subsequent requests wait in line. Clients worked around this by opening 6 parallel TCP connections per host, wasting server resources on duplicate handshakes.
- **Transport-Layer HoL Blocking (HTTP/2):** HTTP/2 multiplexes hundreds of streams over a single TCP connection using binary framing. However, because TCP enforces a strict byte-stream order, a single dropped packet stalls *all* multiplexed HTTP/2 streams until the lost packet is retransmitted.
- **HTTP/3 (QUIC over UDP):** Moves reliability and congestion control from the kernel TCP stack into userspace UDP packets. Each stream is acknowledged independently, so a lost packet on Stream 1 does not delay packets for Stream 2.

---

## 3. Resilience at the Inter-Service Boundary

In large-scale distributed call graphs, naive RPC communication causes systemic collapse via cascading failure.

### 1. Deadline Propagation
A request initiated by a user has an overall budget (e.g., $500\text{ ms}$). If Service A calls Service B with a $500\text{ ms}$ timeout, and Service B spends $480\text{ ms}$ before calling Service C, Service C must not be granted a new $500\text{ ms}$ timeout.
- **Mechanism:** The ingress gateway assigns an absolute deadline timestamp or decrements remaining context timeouts across RPC headers (gRPC `grpc-timeout`). Downstream services immediately drop requests whose deadline has already elapsed, terminating useless computation.

### 2. Circuit Breakers and Jittered Exponential Backoff
When a downstream dependency fails, callers that immediately retry saturate the already struggling dependency.
- **Exponential Backoff with Full Jitter:** 
  $$t_{\text{sleep}} = \text{random}(0, \min(T_{\text{max}}, T_{\text{base}} \cdot 2^{\text{attempt}}))$$
  Adding randomness (jitter) breaks synchronized retry waves that would otherwise storm the recovering service in synchronized pulses.
- **Circuit Breaker:** Tracks the moving error rate. When failures exceed a threshold (e.g., $50\%$ over $10\text{ seconds}$), the circuit transitions from `CLOSED` to `OPEN`, immediately failing fast without sending network traffic downstream. After a sleep window, it enters `HALF-OPEN` to probe recovery.

---

## 4. Real-Time Bidirectional Synchronization: OT vs. CRDTs

When multiple distributed users concurrently edit a shared document or virtual canvas, the system must guarantee that all clients converge to an identical state despite concurrent edits and out-of-order message delivery.

```
┌────────────────────────────────────────────────────────────────────────┐
│                   COLLABORATIVE EDITING PARADIGMS                      │
├───────────────────────────────────┬────────────────────────────────────┤
│ Operational Transformation (OT)   │ Conflict-Free Replicated Data (CRDT│
├───────────────────────────────────┼────────────────────────────────────┤
│ • Central server required         │ • Peer-to-peer / decentralized     │
│ • Transforms intent against hist. │ • Mathematically commutative ops   │
│ • Complex state transformation fn │ • Larger memory footprint          │
│ • Industrial standard for text doc│ • Ideal for offline / local-first  │
└───────────────────────────────────┴────────────────────────────────────┘
```

### 1. Operational Transformation (OT)
- **Concept:** When Client A executes an insertion at index 3, and Client B concurrently executes an insertion at index 1, the central coordinator transforms Client A's operation relative to Client B's operation ($T(op_A, op_B)$), shifting Client A's index to 4 before applying it.
- **Constraint:** Requires an authoritative central server to establish total order and perform transformation matrices (the foundation of Google Docs).

### 2. Conflict-Free Replicated Data Types (CRDTs)
- **Concept:** Operations are designed to satisfy mathematical properties of a join-semilattice:
  - **Commutativity:** $x \cdot y = y \cdot x$ (order does not matter).
  - **Associativity:** $(x \cdot y) \cdot z = x \cdot (y \cdot z)$ (grouping does not matter).
  - **Idempotence:** $x \cdot x = x$ (duplicates do not matter).
- **Outcome:** Replicas can exchange updates in any arbitrary order, over any mesh network, and are mathematically guaranteed to converge to the exact same state without a central coordinator.

---

## 5. Mapping to Architectural Archetypes

Root Domain V manifests in:

### Archetype VIII: Real-Time Synchronization & Collaboration
- **Problem:** Enabling multiple geographically dispersed users to concurrently view, mutate, and synchronize high-frequency state updates (collaborative canvas, shared documents, live presence, real-time gaming) with low latency.
- **Architectural Solution:** Edge-terminated WebSocket gateway cluster paired with an in-memory pub/sub routing plane and conflict-resolution engines (OT coordinators or CRDT state-vector merge engines).
- **Core Mechanisms:** Full-duplex WebSocket connections, session affinity, client sequence numbers, operational transform algorithms, heartbeats, presence ephemeral storage (Redis TTL hashes).

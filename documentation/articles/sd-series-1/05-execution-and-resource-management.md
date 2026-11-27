# Chapter 5.4. Root Domain IV: Execution & Resource Management

## 1. Domain Definition and Scope

**Execution & Resource Management** governs the lifecycle, scheduling, placement, coordination, and durable execution of computational workloads across a distributed pool of hardware resources.

While Domain I stores bytes and Domain III manages consistency of state, Domain IV answers: **Where, when, and how does work execute, and what guarantees exist that long-running operations reach a definitive terminal state despite crashes and network partitions?**

---

## 2. Workload Classification: Ephemeral Tasks vs. Durable Workflows

Systems execute workloads across two distinct paradigms:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        COMPUTATION WORKLOADS                           │
├──────────────────────────┬─────────────────────────────────────────────┤
│ Ephemeral Tasks          │ Durable Distributed Workflows               │
├──────────────────────────┼─────────────────────────────────────────────┤
│ • Stateless execution    │ • Multi-step business processes             │
│ • Idempotent re-runnable │ • Spans minutes, hours, or days             │
│ • Local failure handled  │ • Survives orchestrator/worker crashes      │
│ • e.g., image resizing   │ • e.g., order fulfillment, payment checkout │
└──────────────────────────┴─────────────────────────────────────────────┘
```

### The Worker Leasing and Heartbeat Protocol
For ephemeral tasks, workers pull tasks from a priority queue:
1. When Worker $W_1$ dequeues Task $T$, the queue marks $T$ as in-flight and attaches an **invisibility timeout / lease** (e.g., $30\text{ seconds}$).
2. $W_1$ must periodically send heartbeat messages extending the lease while processing.
3. If $W_1$ crashes or suffers a hardware fault, the lease expires. The queue manager transitions $T$ back to `READY` status, allowing Worker $W_2$ to pick it up.
4. **Invariant:** The task execution logic must be idempotent, because $W_1$ might still be running when $W_2$ re-executes $T$ (at-least-once task dispatch).

---

## 3. Cluster Scheduling and Placement Architectures

Placing containerized workloads across a cluster of $M$ nodes with heterogeneous CPU, memory, GPU, and disk constraints is an NP-hard multidimensional bin-packing problem.

Three major scheduling architectures have evolved:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        SCHEDULING ARCHITECTURES                        │
├───────────────────┬──────────────────────┬─────────────────────────────┤
│ Monolithic        │ Two-Level (Mesos)    │ Shared-State (Borg / Omega) │
├───────────────────┼──────────────────────┼─────────────────────────────┤
│ • Single master   │ • Central master     │ • Multiple parallel sched.  │
│ • Full cluster map│ • Resource offers    │ • Optimistic concurrency    │
│ • Low latency     │ • Framework locks    │ • Conflict retry on commit  │
│ • Scalability wall│ • Coarse allocation  │ • Highest cluster throughput│
└───────────────────┴──────────────────────┴─────────────────────────────┘
```

1. **Monolithic Schedulers (e.g., standard Kubernetes `kube-scheduler`):** A centralized scheduler evaluates every pending pod against all cluster nodes sequentially. Provides globally optimal placement, but becomes an admission bottleneck beyond $\approx 100$ pod scheduling decisions per second.
2. **Two-Level Schedulers (e.g., Apache Mesos):** The central coordinator makes coarse-grained resource offers to independent framework schedulers (e.g., Spark framework, Marathon framework). Frameworks accept or decline offers. Solves scalability, but frameworks make placement decisions without full cluster visibility.
3. **Shared-State Schedulers (e.g., Google Borg, Omega):** Multiple parallel scheduler instances operate against an optimistic in-memory copy of cluster state. Schedulers compute placement independently and attempt to commit transactions atomically against the central cluster state store. Conflicting claims are resolved via Compare-And-Swap (CAS), rolling back the loser to retry.

### Dominant Resource Fairness (DRF)
In multi-tenant clusters where tasks demand different ratios of resources (User A requests $1\text{ CPU} : 4\text{ GB RAM}$, User B requests $4\text{ CPU} : 1\text{ GB RAM}$), simple slot-based sharing leads to starvation. DRF equalizes the **dominant share** (the percentage of the cluster's most-consumed resource) allocated to each tenant.

---

## 4. Durable Workflows and the Saga Pattern

When a business process spans multiple independent microservices (e.g., charging a payment, reserving warehouse inventory, booking a carrier), distributed two-phase commit (2PC) is impractical because holding distributed locks across services introduces unacceptable latency and unavailability under partitions.

### The Saga Execution Invariant
A Saga is a sequence of local transactions $T_1, T_2, \dots, T_n$. Each local transaction modifies data within a single service and commits immediately:

$$\text{Saga Invariant: Either all transactions } T_1 \dots T_n \text{ succeed, or for every executed } T_i \text{, its compensating action } C_i \text{ is executed.}$$

```
Forward Path:       [T1: Reserve Seat]  ---> [T2: Charge Card] ---> [T3: Book Hotel (FAILS)]
                                                                                │
                                                                                ▼
Compensation Path:  [C1: Release Seat]  <--- [C2: Refund Card] <----------------┘
```

### Orchestration vs. Choreography
- **Choreography (Event-Driven):** Services publish events that trigger local transactions in other services without a centralized coordinator. Easy to start, but difficult to monitor, debug, or verify cyclic dependency deadlocks.
- **Orchestration (State Machine):** A centralized orchestrator (e.g., Temporal, AWS Step Functions) tracks the exact execution state machine, persisting state transitions to a durable event log before invoking remote activities. If the orchestrator host crashes, a replacement orchestrator node replays the execution history and resumes the saga seamlessly.

---

## 5. Mapping to Architectural Archetypes

Root Domain IV manifests in two core archetypes:

### Archetype VII: Durable Workflow & Asynchronous Orchestration
- **Problem:** Executing multi-step, distributed operational workflows that must run to completion despite arbitrary machine crashes, service timeouts, and network delays.
- **Architectural Solution:** An event-sourced workflow state machine engine maintaining durable activity task queues, deterministic state replay, and automated backward compensation chains.
- **Core Mechanisms:** State-machine event logs, compensation rollbacks, activity retry policies with exponential backoff and jitter, heartbeat monitoring.

### Archetype XII: Scheduling & Resource Placement
- **Problem:** Assigning bursty computational tasks to heterogeneous worker machines while respecting hard placement constraints (CPU, RAM, locality, anti-affinity) and maintaining high cluster utilization.
- **Architectural Solution:** Multi-tier resource scheduler combining priority-ranked ready queues with optimistic lock placement and resource reservation fencing.
- **Core Mechanisms:** Bin-packing heuristics, Dominant Resource Fairness (DRF), optimistic concurrency control, worker capability manifests.

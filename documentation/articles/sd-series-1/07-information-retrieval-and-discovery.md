# Chapter 5.6. Root Domain VI: Information Retrieval & Discovery

## 1. Domain Definition and Scope

**Information Retrieval & Discovery** governs the indexing, multi-dimensional filtering, ranking, and candidate extraction of records from massive, high-cardinality datasets where brute-force full table scans are computationally prohibitive.

In Domain I, we retrieve objects by their known, unique keys ($O(1)$ key-value lookup). In Domain VI, **the exact identity of the target object is unknown at query time**. Instead, the user provides partial constraints, free-form text, spatial coordinates, semantic concepts, or graph relationships, requiring the system to identify the top-$K$ most relevant matches from billions of candidates within tens of milliseconds.

---

## 2. Inverted Indexing and Full-Text Search

Text search requires reversing the physical document-to-word relationship:

```
┌────────────────────────────────────────────────────────┐
│                   INVERTED INDEX STRUCTURE             │
├───────────────┬────────────────────────────────────────┤
│ Lexicon (Term)│ Posting List (DocID, Position, Payload)│
├───────────────┼────────────────────────────────────────┤
│ "distributed" │ [12, 45, 108, 250, 412, ...]           │
│ "systems"     │ [4, 12, 89, 108, 301, ...]             │
│ "consensus"   │ [12, 108, 940, ...]                    │
└───────────────┴────────────────────────────────────────┘
```

### Posting Lists and Compression
- **Posting Lists:** Sorted arrays of document IDs containing the term.
- **Query Intersection (AND Queries):** Intersecting posting lists for `"distributed"` and `"systems"` is an $O(M + N)$ linear scan over two sorted arrays.
- **Skip Pointers & Roaring Bitmaps:** To accelerate intersection without scanning every entry, posting lists embed skip pointers every $\sqrt{N}$ items, or encode dense docIDs as compact Roaring Bitmaps using bitwise CPU instructions.
- **Relevance Scoring (BM25):** Evaluates Term Frequency (TF) dampened by saturation, balanced against Inverse Document Frequency (IDF) to down-weight ubiquitous words.

---

## 3. Geospatial Indexing and Space-Filling Curves

Geographic latitude and longitude $(\phi, \lambda)$ represent a two-dimensional spherical surface. Traditional 1D database indexes (B-Trees) cannot efficiently index 2D coordinates because a range query in latitude does not constrain longitude, resulting in massive bounding-box table scans.

```
┌────────────────────────────────────────────────────────────────────────┐
│                        GEOSPATIAL INDEXES                              │
├──────────────────────────┬─────────────────────────────────────────────┤
│ Google S2 (Hilbert Curve)│ Uber H3 (Hexagonal Hierarchy)               │
├──────────────────────────┼─────────────────────────────────────────────┤
│ • Quadrilateral cells    │ • Hexagonal cells                           │
│ • Hilbert space curve    │ • Uniform neighbor distance                 │
│ • 1D uint64 index key    │ • Ideal for radius/proximity aggregations   │
│ • Cell range covers area │ • Continuous cell tiling                    │
└──────────────────────────┴─────────────────────────────────────────────┘
```

### Space-Filling Curves (The 2D to 1D Mapping)
A space-filling curve (e.g., Hilbert curve, Peano curve) maps 2D coordinates onto a continuous one-dimensional line while preserving spatial locality: points close together in 2D space remain close together along the 1D curve.
- **S2 Cell Token:** Projects the sphere onto a cube, dividing faces hierarchically into cells identified by a 64-bit integer (`uint64`).
- **Range Covering:** A geographic polygon or query radius is approximated as a collection of disjoint 1D integer ranges ($[\text{start}_1, \text{end}_1], [\text{start}_2, \text{end}_2]$). The query transforms into standard 1D B-Tree range scans in standard databases.

### Road Networks and Contraction Hierarchies
Calculating the fastest travel route between two points is not a geometric straight-line query; it is a shortest-path graph search over millions of road segments.
- Standard Dijkstra's algorithm evaluates millions of nodes, taking seconds.
- **Contraction Hierarchies (CH):** Precomputes shortcuts by iteratively bypassing minor nodes (e.g., residential streets) to create high-speed highway transit layers, accelerating queries by $10,000\times$ down to sub-millisecond latencies.

---

## 4. Graph Relationships and Topological Traversal

Social networks, fraud detection, and recommendation engines model entities as nodes connected by directed or undirected edges.

### The Index Penalty in Relational Tables
In a relational table (`edges(source_id, target_id)`), executing an $N$-hop traversal requires $N$ sequential relational `JOIN` operations. At 3 hops, join cardinality explodes exponentially ($100 \times 100 \times 100 = 1,000,000$ rows), stalling query engines.

### Native Graph Storage: Compressed Sparse Row (CSR)
- **Mechanism:** Stores adjacency lists as two contiguous arrays: an offset array pointing to the start of each vertex's edge list, and a contiguous edge array listing destination vertex IDs.
- **Guarantees:** Traversing an edge is a direct array offset lookup ($O(1)$ pointer chase), maximizing hardware CPU cache line prefetching.

---

## 5. Vector Search and Approximate Nearest Neighbors (ANN)

Modern GenAI and semantic search systems represent unstructured content (text, audio, images) as dense embedding vectors ($\mathbb{R}^{768}\text{--}\mathbb{R}^{1536}$).

- Exact k-nearest-neighbor search ($k$-NN) requires calculating cosine distance against every vector in the dataset ($O(N \cdot D)$), taking minutes per query at scale.
- **Hierarchical Navigable Small World (HNSW):** Constructs a multi-layer graph where upper layers have long-range skip edges and bottom layers have dense local clustering. Queries navigate top layers greedily before descending, achieving $O(\log N)$ logarithmic retrieval.

---

## 6. Mapping to Architectural Archetypes

Root Domain VI directly anchors three major archetypes:

### Archetype IX: Geospatial Indexing & Routing
- **Problem:** Finding moving or static entities within dynamic spatial boundaries and computing real-time travel durations.
- **Architectural Solution:** Multi-resolution space-filling curve hierarchy (S2/H3) for spatial cell candidate retrieval, coupled with precomputed road-graph Contraction Hierarchies for routing.
- **Core Mechanisms:** Spatial cell coverings, candidate bounding filters, edge contraction routing graphs, road-network pre-processing.

### Archetype X: Search & Information Retrieval
- **Problem:** Full-text keyword and parametric query execution across millions of distributed documents with sub-second relevance ranking.
- **Architectural Solution:** Distributed inverted index fabric using scatter-gather shard coordination, skip-pointer posting lists, and segment merge compaction.
- **Core Mechanisms:** Inverted posting lists, BM25 scoring, Roaring Bitmaps, shard scatter-gather query aggregation.

### Archetype XI: Graph Relationships & Traversal
- **Problem:** Exploring multi-hop relationship paths (degrees of connection, fraud rings, organizational hierarchies) across billions of interconnected entities.
- **Architectural Solution:** Sharded graph topology engine utilizing Compressed Sparse Row (CSR) adjacency representations and bidirectional bounded breadth-first traversal.
- **Core Mechanisms:** Adjacency lists, min-cut graph partitioning, bidirectional Dijkstra, bounded traversal expansion.

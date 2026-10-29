<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-2-hero-monochrome" name="PoEAA Part II Hero Monochrome">
    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- ========================================== -->
        <!-- 1. LEFT COLUMN: IN-MEMORY DOMAIN GRAPH     -->
        <!-- ========================================== -->
        <mxCell id="domain-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="790" width="430" x="50" y="55" as="geometry" />
        </mxCell>
        <mxCell id="domain-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="IN-MEMORY DOMAIN GRAPH" vertex="1">
          <mxGeometry height="24" width="390" x="70" y="65" as="geometry" />
        </mxCell>
        <mxCell id="domain-subtitle" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="Object Identity · Direct Pointers · Polymorphic Dispatch" vertex="1">
          <mxGeometry height="20" width="390" x="70" y="87" as="geometry" />
        </mxCell>

        <!-- Domain Box 1: Entities & Aggregates -->
        <mxCell id="domain-box-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=12;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Entities &amp;amp; Aggregate Graphs&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Encapsulates business behavior &amp;amp; state invariants&lt;br&gt;• Traverses rich object graphs via direct pointers&lt;br&gt;&amp;nbsp;&amp;nbsp;&lt;i&gt;order.customer.tier&lt;/i&gt; · &lt;i&gt;order.lines[0].product&lt;/i&gt;&lt;br&gt;• Cyclic and bidirectional object references&lt;/font&gt;" vertex="1">
          <mxGeometry height="140" width="390" x="70" y="115" as="geometry" />
        </mxCell>

        <!-- Domain Box 2: Polymorphism -->
        <mxCell id="domain-box-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=12;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Inheritance &amp;amp; Polymorphism&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Class hierarchies and behavioral polymorphism&lt;br&gt;&amp;nbsp;&amp;nbsp;&lt;i&gt;CorporateOrder&lt;/i&gt; &amp;amp; &lt;i&gt;RetailOrder&lt;/i&gt; extend &lt;i&gt;Order&lt;/i&gt;&lt;br&gt;• Dynamic method dispatch based on runtime type&lt;br&gt;• Abstract interfaces decouple callers from subtypes&lt;/font&gt;" vertex="1">
          <mxGeometry height="135" width="390" x="70" y="275" as="geometry" />
        </mxCell>

        <!-- Domain Box 3: Identity Model -->
        <mxCell id="domain-box-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=12;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Reference Identity Model&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Object equality determined by memory address:&lt;br&gt;&amp;nbsp;&amp;nbsp;&lt;i&gt;entityA === entityB&lt;/i&gt; (same memory reference)&lt;br&gt;• Independent from persistence primary keys&lt;br&gt;• Ephemeral lifespan bounded by application session&lt;/font&gt;" vertex="1">
          <mxGeometry height="135" width="390" x="70" y="430" as="geometry" />
        </mxCell>

        <!-- Domain Box 4: In-Memory Mutations -->
        <mxCell id="domain-box-4" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=12;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;In-Memory State Mutations&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Domain operations modify internal entity state:&lt;br&gt;&amp;nbsp;&amp;nbsp;&lt;i&gt;order.confirmAllocation(inventoryBatch)&lt;/i&gt;&lt;br&gt;• Business rules execute without issuing ad-hoc SQL&lt;br&gt;• Mutations are collected before transaction commit&lt;/font&gt;" vertex="1">
          <mxGeometry height="135" width="390" x="70" y="585" as="geometry" />
        </mxCell>

        <!-- Domain Box 5: Summary Note -->
        <mxCell id="domain-box-note" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b&gt;Zero Database Dependencies&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Domain entities are pure POJOs / POCOs without SQL or table schemas&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="390" x="70" y="740" as="geometry" />
        </mxCell>


        <!-- ======================================================= -->
        <!-- 2. CENTER COLUMN: THE PERSISTENCE BOUNDARY (O/R MEDIATION) -->
        <!-- ======================================================= -->
        <mxCell id="pers-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="790" width="580" x="510" y="55" as="geometry" />
        </mxCell>
        <mxCell id="pers-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="THE PERSISTENCE BOUNDARY (O/R MEDIATION)" vertex="1">
          <mxGeometry height="24" width="540" x="530" y="65" as="geometry" />
        </mxCell>
        <mxCell id="pers-subtitle" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="Session Lifecycle Coordination · Instance Isolation · Change Tracking" vertex="1">
          <mxGeometry height="20" width="540" x="530" y="87" as="geometry" />
        </mxCell>

        <!-- Persistence Box 1: Unit of Work -->
        <mxCell id="pers-box-uow" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=14;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Unit of Work (Session Coordinator)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Maintains atomic identity registries throughout the business transaction:&lt;br&gt;&amp;nbsp;&amp;nbsp;&lt;b&gt;[New]&lt;/b&gt; entities to insert &amp;nbsp;|&amp;nbsp; &lt;b&gt;[Dirty]&lt;/b&gt; entities with mutated state&lt;br&gt;&amp;nbsp;&amp;nbsp;&lt;b&gt;[Clean]&lt;/b&gt; unchanged reads &amp;nbsp;|&amp;nbsp; &lt;b&gt;[Removed]&lt;/b&gt; entities marked for deletion&lt;br&gt;• Orchestrates deterministic commit pipeline:&lt;br&gt;&amp;nbsp;&amp;nbsp;&lt;i&gt;Topological Sort (FK Dependencies) ➔ Batched SQL Execution&lt;/i&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="165" width="540" x="530" y="115" as="geometry" />
        </mxCell>

        <!-- Persistence Box 2: Identity Map -->
        <mxCell id="pers-box-idmap" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=14;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Identity Map (Instance Uniqueness Registry)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Lookup index: &lt;i&gt;(Class, PrimaryKey) ➔ In-Memory Object Reference&lt;/i&gt;&lt;br&gt;• Guarantees 1 database row = exactly 1 object instance in memory&lt;br&gt;• Prevents redundant SQL read trips and eliminates dirty-write hazards&lt;br&gt;• Ensures polymorphic references point to the identical memory instance&lt;/font&gt;" vertex="1">
          <mxGeometry height="145" width="540" x="530" y="300" as="geometry" />
        </mxCell>

        <!-- Persistence Box 3: Data Mapper -->
        <mxCell id="pers-box-mapper" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=14;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Data Mapper (Structural &amp;amp; Schema Decoupling)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Bidirectional translation: &lt;i&gt;Domain Object Graph ⟷ Tabular SQL Rows&lt;/i&gt;&lt;br&gt;• Bridges structural mismatch (inheritance strategies, foreign key joins)&lt;br&gt;• Reconstitutes domain objects with invariants without triggering business events&lt;br&gt;• Keeps domain code completely clean of table names, columns, or SQL text&lt;/font&gt;" vertex="1">
          <mxGeometry height="155" width="540" x="530" y="465" as="geometry" />
        </mxCell>

        <!-- Persistence Box 4: Concurrency Guard -->
        <mxCell id="pers-box-lock" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=14;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Concurrency &amp;amp; Offline Locking Barrier&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• &lt;b&gt;Optimistic Offline Lock&lt;/b&gt;: Validates &lt;i&gt;version_id&lt;/i&gt; during SQL update&lt;br&gt;• Detects and prevents lost updates across multi-step user sessions&lt;br&gt;• &lt;b&gt;Pessimistic Offline Lock&lt;/b&gt;: Exclusive lock sessions for critical workflows&lt;/font&gt;" vertex="1">
          <mxGeometry height="130" width="540" x="530" y="640" as="geometry" />
        </mxCell>


        <!-- ============================================= -->
        <!-- 3. RIGHT COLUMN: RELATIONAL DATABASE ENGINE   -->
        <!-- ============================================= -->
        <mxCell id="db-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="790" width="450" x="1115" y="55" as="geometry" />
        </mxCell>
        <mxCell id="db-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="RELATIONAL DATABASE ENGINE" vertex="1">
          <mxGeometry height="24" width="410" x="1135" y="65" as="geometry" />
        </mxCell>
        <mxCell id="db-subtitle" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="Tabular Relations · Foreign Keys · ACID Transactions" vertex="1">
          <mxGeometry height="20" width="410" x="1135" y="87" as="geometry" />
        </mxCell>

        <!-- DB Box 1: Normalized Tables -->
        <mxCell id="db-box-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=12;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Normalized Tabular Relations&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Flat 2D relational tables: &lt;i&gt;orders, items, customers&lt;/i&gt;&lt;br&gt;• Columnar schemas, fixed types, NOT NULL constraints&lt;br&gt;• Set-oriented mathematical projections &amp;amp; filters&lt;br&gt;• Zero direct concept of object behavior or methods&lt;/font&gt;" vertex="1">
          <mxGeometry height="140" width="410" x="1135" y="115" as="geometry" />
        </mxCell>

        <!-- DB Box 2: Keys & Constraints -->
        <mxCell id="db-box-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=12;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Relational Keys &amp;amp; Integrity&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Primary Key identity: &lt;i&gt;orders.id = 1042&lt;/i&gt;&lt;br&gt;• Foreign Key relationships: &lt;i&gt;items.order_id ➔ orders.id&lt;/i&gt;&lt;br&gt;• Enforces referential integrity at storage level&lt;br&gt;• Join queries (&lt;i&gt;INNER JOIN, LEFT JOIN&lt;/i&gt;) reconstruct sets&lt;/font&gt;" vertex="1">
          <mxGeometry height="135" width="410" x="1135" y="275" as="geometry" />
        </mxCell>

        <!-- DB Box 3: ACID Transactions -->
        <mxCell id="db-box-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=12;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;ACID Transaction Engine&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• &lt;i&gt;BEGIN TRANSACTION ... COMMIT / ROLLBACK&lt;/i&gt;&lt;br&gt;• Row locks, table locks, and MVCC isolation levels&lt;br&gt;• Atomicity guaranteed across multi-row statements&lt;br&gt;• Immediate durability upon commit to disk&lt;/font&gt;" vertex="1">
          <mxGeometry height="135" width="410" x="1135" y="430" as="geometry" />
        </mxCell>

        <!-- DB Box 4: Physical Storage -->
        <mxCell id="db-box-4" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=top;spacingLeft=12;spacingTop=10;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Physical Storage &amp;amp; Indexing&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• B-Tree / Hash Indexes on primary and foreign keys&lt;br&gt;• Write-Ahead Log (WAL) ensures crash recovery&lt;br&gt;• Disk page buffers and database cache managers&lt;/font&gt;" vertex="1">
          <mxGeometry height="135" width="410" x="1135" y="585" as="geometry" />
        </mxCell>

        <!-- DB Box 5: Summary Note -->
        <mxCell id="db-box-note" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b&gt;Relational Foundation&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Structured persistence optimized for relational queries, concurrency, and durability&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="410" x="1135" y="740" as="geometry" />
        </mxCell>


        <!-- ============================================== -->
        <!-- CONNECTORS / FLOW ARROWS ACROSS THE BOUNDARIES -->
        <!-- ============================================== -->

        <!-- Domain -> Unit of Work (Registration) -->
        <mxCell id="arrow-domain-uow" edge="1" parent="1" source="domain-box-4" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="pers-box-uow" value="Registers Mutations (New / Dirty / Removed)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="490" y="652" />
              <mxPoint x="490" y="198" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Identity Map <-> Domain Graph (Lookup) -->
        <mxCell id="arrow-idmap-domain" edge="1" parent="1" source="pers-box-idmap" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;startArrow=block;endFill=1;startFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="domain-box-3" value="Resolves 1:1 In-Memory Instance">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="495" y="372" />
              <mxPoint x="495" y="497" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Unit of Work -> Data Mapper (Commit Pipeline) -->
        <mxCell id="arrow-uow-mapper" edge="1" parent="1" source="pers-box-uow" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="pers-box-mapper" value="Coordinates Commit Sequence">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Data Mapper -> DB Relations (Batched SQL DML) -->
        <mxCell id="arrow-mapper-db" edge="1" parent="1" source="pers-box-mapper" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="db-box-1" value="Batched SQL DML (INSERT / UPDATE / DELETE)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1090" y="542" />
              <mxPoint x="1090" y="185" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- DB Relations -> Data Mapper (Hydration) -->
        <mxCell id="arrow-db-mapper" edge="1" parent="1" source="db-box-2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="pers-box-mapper" value="Raw SQL RowSets &amp;amp; Relational Projections">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1090" y="342" />
              <mxPoint x="1090" y="565" />
            </Array>
          </mxGeometry>
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
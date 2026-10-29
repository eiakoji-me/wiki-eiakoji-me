<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-2-hero-flow" name="PoEAA Part II High-Level Flow">
    <mxGraphModel dx="2361" dy="1214" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="hdr-left" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#1E40AF;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. READ / QUERY PHASE (IDENTITY RESOLUTION)" vertex="1">
          <mxGeometry height="36" width="520" x="100" y="24" as="geometry" />
        </mxCell>
        <mxCell id="hdr-right" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#92400E;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. COMMIT / FLUSH PHASE (ATOMIC BATCHING)" vertex="1">
          <mxGeometry height="36" width="540" x="970" y="24" as="geometry" />
        </mxCell>
        <mxCell id="box-domain" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#EFF6FF;strokeColor=#2563EB;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="185" width="540" x="100" y="115" as="geometry" />
        </mxCell>
        <mxCell id="title-domain" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#1E40AF;fontFamily=Comic Sans MS;" value="IN-MEMORY DOMAIN GRAPH" vertex="1">
          <mxGeometry height="30" width="480" x="120" y="128" as="geometry" />
        </mxCell>
        <mxCell id="text-domain" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#1E3A8A;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;b&gt;• Entities &amp;amp; Aggregate Roots&lt;/b&gt;: Encapsulate business logic, rules, and invariants&lt;br&gt;&lt;b&gt;• Cyclic Object Pointers&lt;/b&gt;: Traverses rich relationships (&lt;i&gt;order.customer.tier&lt;/i&gt;)&lt;br&gt;&lt;b&gt;• Reference Identity&lt;/b&gt;: Memory reference equality (&lt;i&gt;entityA === entityB&lt;/i&gt;)&lt;br&gt;&lt;b&gt;• Clean Architecture&lt;/b&gt;: Pure domain models with zero database dependencies" vertex="1">
          <mxGeometry height="135" width="480" x="102" y="165" as="geometry" />
        </mxCell>
        <mxCell id="box-uow" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FEF3C7;strokeColor=#D97706;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="185" width="560" x="960" y="115" as="geometry" />
        </mxCell>
        <mxCell id="title-uow" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#92400E;fontFamily=Comic Sans MS;" value="UNIT OF WORK (TRANSACTION COORDINATOR)" vertex="1">
          <mxGeometry height="30" width="600" x="880" y="128" as="geometry" />
        </mxCell>
        <mxCell id="text-uow" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#78350F;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;b&gt;• Change Set Tracking&lt;/b&gt;: Registers entity mutations across the active business session&lt;br&gt;&lt;b&gt;• Identity Buckets&lt;/b&gt;: &lt;i&gt;[New] · [Dirty] · [Clean] · [Removed]&lt;/i&gt;&lt;br&gt;&lt;b&gt;• Topological Dependency Ordering&lt;/b&gt;: Sorts statements by foreign key constraints&lt;br&gt;&lt;b&gt;• Atomic Batch Commit&lt;/b&gt;: Flushes all queued DML statements in a single transaction" vertex="1">
          <mxGeometry height="125" width="530" x="944" y="165" as="geometry" />
        </mxCell>
        <mxCell id="arr-domain-uow" edge="1" parent="1" source="box-domain" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="box-uow" value="Registers Mutations ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="box-idmap" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F5F3FF;strokeColor=#7C3AED;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="162" width="540" x="100" y="410" as="geometry" />
        </mxCell>
        <mxCell id="title-idmap" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#5B21B6;fontFamily=Comic Sans MS;" value="IDENTITY MAP (INSTANCE REGISTRY &amp;amp; L1 CACHE)" vertex="1">
          <mxGeometry height="36" width="470" x="120" y="421" as="geometry" />
        </mxCell>
        <mxCell id="text-idmap" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#4C1D95;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;b&gt;• 1:1 In-Memory Guarantee&lt;/b&gt;: Exactly one object instance per database primary key&lt;br&gt;&lt;b&gt;• Eliminates Redundant Reads&lt;/b&gt;: Repeated lookups resolve immediately from cache&lt;br&gt;&lt;b&gt;• Prevents Overwrite Hazards&lt;/b&gt;: Eliminates stale in-memory state collisions&lt;br&gt;&lt;b&gt;• Lookup Index&lt;/b&gt;: &lt;i&gt;(Class, PrimaryKey) ➔ In-Memory Object Reference&lt;/i&gt;" vertex="1">
          <mxGeometry height="135" width="490" x="83" y="440" as="geometry" />
        </mxCell>
        <mxCell id="arr-domain-idmap" edge="1" parent="1" source="box-idmap" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;startArrow=block;endFill=1;startFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="box-domain" value="1:1 Instance Resolution &amp;amp; Lookup">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="box-db" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#ECFDF5;strokeColor=#059669;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="162" width="560" x="960" y="403" as="geometry" />
        </mxCell>
        <mxCell id="title-db" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#065F46;fontFamily=Comic Sans MS;" value="RELATIONAL STORAGE &amp;amp; DATABASE ENGINE" vertex="1">
          <mxGeometry height="30" width="510" x="975" y="410" as="geometry" />
        </mxCell>
        <mxCell id="text-db" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#064E3B;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;b&gt;• 2D Normalized Relations&lt;/b&gt;: Structured tables with rigid columns, types, and constraints&lt;br&gt;&lt;b&gt;• Foreign Key Integrity&lt;/b&gt;: Enforces parent/child relational integrity at storage engine&lt;br&gt;&lt;b&gt;• Primary Key Identity&lt;/b&gt;: Numerical/UUID primary keys (&lt;i&gt;orders.id = 42&lt;/i&gt;)&lt;br&gt;&lt;b&gt;• ACID Transaction Boundary&lt;/b&gt;: Atomicity and write-ahead log (WAL) disk durability" vertex="1">
          <mxGeometry height="125" width="510" x="942" y="440" as="geometry" />
        </mxCell>
        <mxCell id="arr-uow-db" edge="1" parent="1" source="box-uow" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="box-db" value="Batched SQL DML (INSERT / UPDATE / DELETE) ➔">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1240" y="360" />
              <mxPoint x="1240" y="360" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="box-mapper" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="135" width="1420" x="100" y="653" as="geometry" />
        </mxCell>
        <mxCell id="title-mapper" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="DATA MAPPER (THE BEHAVIORAL PERSISTENCE BARRIER)" vertex="1">
          <mxGeometry height="28" width="1360" x="120" y="663" as="geometry" />
        </mxCell>
        <mxCell id="text-mapper" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=13;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• The Object-Relational Impedance Bridge&lt;/b&gt;: Mediates bidirectionally between in-memory object graphs and relational table rows&lt;br&gt;&lt;b&gt;• Schema Decoupling&lt;/b&gt;: Domain entities contain zero SQL strings, table schemas, column names, or database dependencies&lt;br&gt;&lt;b&gt;• Object Reconstitution&lt;/b&gt;: Hydrates domain entities enforcing business invariants without firing spurious business events" vertex="1">
          <mxGeometry height="85" width="1360" x="120" y="703" as="geometry" />
        </mxCell>
        <mxCell id="arr-mapper-left" edge="1" parent="1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;startArrow=block;endFill=1;startFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" value="Hydrates Instances ⟷ Registers Pointers">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="360" y="635" />
              <mxPoint x="360" y="635" />
            </Array>
            <mxPoint x="360.06" y="660" as="sourcePoint" />
            <mxPoint x="360.0588235294117" y="565" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="arr-mapper-right" edge="1" parent="1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;startArrow=block;endFill=1;startFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" value="Translates SQL RowSets ⟷ Persists Mutations">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1239" y="635" />
              <mxPoint x="1239" y="635" />
            </Array>
            <mxPoint x="1239.06" y="660" as="sourcePoint" />
            <mxPoint x="1239.0588235294122" y="565" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="U-RA09PUbqEnKlH8eNqP-4" edge="1" parent="1" source="hdr-left" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;exitX=0.5;exitY=1;exitDx=0;exitDy=0;" value="">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="360" y="72" />
            </Array>
            <mxPoint x="359.5" y="72" as="sourcePoint" />
            <mxPoint x="359.5" y="115" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="U-RA09PUbqEnKlH8eNqP-5" edge="1" parent="1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;exitX=0.5;exitY=1;exitDx=0;exitDy=0;" value="">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1240.08" y="72" />
            </Array>
            <mxPoint x="1240.08" y="60" as="sourcePoint" />
            <mxPoint x="1239.58" y="115" as="targetPoint" />
          </mxGeometry>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-2-persistence-patterns" name="The Four Persistence Archetypes">
    <mxGraphModel dx="1200" dy="750" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="750" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Background -->
        <mxCell id="bg" parent="1" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=none;" value="" vertex="1">
          <mxGeometry height="750" width="1200" as="geometry" />
        </mxCell>

        <!-- Header -->
        <mxCell id="title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=22;" value="The Persistence Continuum: Four Architectural Data Source Patterns" vertex="1">
          <mxGeometry height="35" width="1040" x="80" y="25" as="geometry" />
        </mxCell>
        <mxCell id="subtitle" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#475569;fontSize=14;" value="Evaluating domain decoupling, testability, schema entanglement, and complexity thresholds across the continuum" vertex="1">
          <mxGeometry height="25" width="1040" x="80" y="60" as="geometry" />
        </mxCell>

        <!-- QUADRANT 1: Table Data Gateway -->
        <mxCell id="q1_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="300" width="510" x="80" y="95" as="geometry" />
        </mxCell>
        <mxCell id="q1_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f1f5f9;strokeColor=#64748b;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#0f172a; font-size:15px;&quot;&gt;1. Table Data Gateway&lt;/b&gt; &amp;nbsp;&lt;span style=&quot;font-size:11px; color:#475569;&quot;&gt;(Gateway per Table)&lt;/span&gt;" vertex="1">
          <mxGeometry height="40" width="490" x="90" y="105" as="geometry" />
        </mxCell>
        <mxCell id="q1_desc" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=top;whiteSpace=wrap;rounded=0;fontColor:#334155;fontSize=12;" value="&lt;b&gt;Definition:&lt;/b&gt; An object that acts as a Gateway to a database table. One instance handles all the rows in the table.&lt;br&gt;&lt;br&gt;• &lt;b&gt;Data Structure:&lt;/b&gt; Returns untyped tabular recordsets (DataSets, Arrays of Maps, Knex query results).&lt;br&gt;• &lt;b&gt;Synergy:&lt;/b&gt; Ideal match for &lt;b&gt;Table Module&lt;/b&gt; and transaction-script-heavy batch pipelines.&lt;br&gt;• &lt;b&gt;Limitations:&lt;/b&gt; Awkward with polymorphic objects; does not encapsulate domain invariants." vertex="1">
          <mxGeometry height="150" width="490" x="95" y="155" as="geometry" />
        </mxCell>
        <mxCell id="q1_badge" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#cbd5e1;strokeWidth=1;fontSize=11;fontColor:#475569;" value="Complexity: Low · Coupling: Database Schema Centric · State: Stateless Gateway" vertex="1">
          <mxGeometry height="30" width="490" x="90" y="355" as="geometry" />
        </mxCell>

        <!-- QUADRANT 2: Row Data Gateway -->
        <mxCell id="q2_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="300" width="510" x="610" y="95" as="geometry" />
        </mxCell>
        <mxCell id="q2_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#1e40af; font-size:15px;&quot;&gt;2. Row Data Gateway&lt;/b&gt; &amp;nbsp;&lt;span style=&quot;font-size:11px; color:#2563eb;&quot;&gt;(Gateway per Record)&lt;/span&gt;" vertex="1">
          <mxGeometry height="40" width="490" x="620" y="105" as="geometry" />
        </mxCell>
        <mxCell id="q2_desc" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=top;whiteSpace=wrap;rounded=0;fontColor:#334155;fontSize=12;" value="&lt;b&gt;Definition:&lt;/b&gt; An object that acts as a Gateway to a single record in a data source. One instance per row.&lt;br&gt;&lt;br&gt;• &lt;b&gt;Data Structure:&lt;/b&gt; Strongly typed properties mirroring table columns exactly (getters/setters, &lt;i&gt;update()&lt;/i&gt;, &lt;i&gt;delete()&lt;/i&gt;).&lt;br&gt;• &lt;b&gt;Separation:&lt;/b&gt; Isolates SQL access code from domain logic; business logic lives in separate domain objects.&lt;br&gt;• &lt;b&gt;Limitations:&lt;/b&gt; High boilerplate; creates duplicate class hierarchies (Domain Entity + Row Gateway)." vertex="1">
          <mxGeometry height="150" width="490" x="625" y="155" as="geometry" />
        </mxCell>
        <mxCell id="q2_badge" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#bfdbfe;strokeWidth=1;fontSize=11;fontColor:#1e40af;" value="Complexity: Low–Medium · Coupling: Schema Mirroring · State: Stateful Record" vertex="1">
          <mxGeometry height="30" width="490" x="620" y="355" as="geometry" />
        </mxCell>

        <!-- QUADRANT 3: Active Record -->
        <mxCell id="q3_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#f59e0b;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="320" width="510" x="80" y="410" as="geometry" />
        </mxCell>
        <mxCell id="q3_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef3c7;strokeColor=#f59e0b;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#92400e; font-size:15px;&quot;&gt;3. Active Record&lt;/b&gt; &amp;nbsp;&lt;span style=&quot;font-size:11px; color:#b45309;&quot;&gt;(Prisma / Rails ActiveRecord / TypeORM)&lt;/span&gt;" vertex="1">
          <mxGeometry height="40" width="490" x="90" y="420" as="geometry" />
        </mxCell>
        <mxCell id="q3_desc" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=top;whiteSpace=wrap;rounded=0;fontColor:#78350f;fontSize=12;" value="&lt;b&gt;Definition:&lt;/b&gt; An object that wraps a database row, encapsulates database access, and adds domain logic.&lt;br&gt;&lt;br&gt;• &lt;b&gt;Sweet Spot:&lt;/b&gt; Rapid application development, straightforward CRUD, simple domain invariants.&lt;br&gt;• &lt;b&gt;The Trap at Scale:&lt;/b&gt; Domain entities are hardcoded to database tables. Business rules become deeply entangled with ORM query builders, making unit testing impossible without mocking database connections.&lt;br&gt;• &lt;b&gt;Violation:&lt;/b&gt; Violates Single Responsibility Principle (Domain Logic + SQL persistence)." vertex="1">
          <mxGeometry height="170" width="490" x="95" y="470" as="geometry" />
        </mxCell>
        <mxCell id="q3_badge" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef3c7;strokeColor=#fde68a;strokeWidth=1;fontSize=11;fontColor:#92400e;" value="Complexity: Medium · Coupling: Very High (Table-Bound) · Testing: Requires DB Mocks" vertex="1">
          <mxGeometry height="30" width="490" x="90" y="690" as="geometry" />
        </mxCell>

        <!-- QUADRANT 4: Data Mapper -->
        <mxCell id="q4_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#10b981;strokeWidth=2.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="320" width="510" x="610" y="410" as="geometry" />
        </mxCell>
        <mxCell id="q4_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#10b981;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46; font-size:15px;&quot;&gt;4. Data Mapper&lt;/b&gt; &amp;nbsp;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;(Hibernate / Doctrine / Pure DDD Mapping)&lt;/span&gt;" vertex="1">
          <mxGeometry height="40" width="490" x="620" y="420" as="geometry" />
        </mxCell>
        <mxCell id="q4_desc" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=top;whiteSpace=wrap;rounded=0;fontColor:#064e3b;fontSize=12;" value="&lt;b&gt;Definition:&lt;/b&gt; A layer of mappers that moves data between objects and a database while keeping them independent of each other and the mapper itself.&lt;br&gt;&lt;br&gt;• &lt;b&gt;Complete Decoupling:&lt;/b&gt; Domain entities are pure TypeScript/Java POJOs. Zero SQL, zero ORM decorator leakages. Invariants are self-protecting and testable in pure in-memory unit tests.&lt;br&gt;• &lt;b&gt;Coordination:&lt;/b&gt; Pairs with &lt;b&gt;Unit of Work&lt;/b&gt; and &lt;b&gt;Identity Map&lt;/b&gt; for transactional batch execution.&lt;br&gt;• &lt;b&gt;Trade-off:&lt;/b&gt; Higher initial architectural complexity; requires explicit mapping configuration." vertex="1">
          <mxGeometry height="170" width="490" x="625" y="470" as="geometry" />
        </mxCell>
        <mxCell id="q4_badge" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#a7f3d0;strokeWidth=1;fontSize=11;fontColor:#065f46;" value="Complexity: High (Architectural) · Coupling: Zero (Pure POJO) · Testing: Pure In-Memory" vertex="1">
          <mxGeometry height="30" width="490" x="620" y="690" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
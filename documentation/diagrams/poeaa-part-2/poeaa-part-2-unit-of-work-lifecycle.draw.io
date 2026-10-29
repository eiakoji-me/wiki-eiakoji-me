<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-2-uow-lifecycle" name="Unit of Work Lifecycle">
    <mxGraphModel dx="1400" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="800" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Canvas Background -->
        <mxCell id="bg" parent="1" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=none;" value="" vertex="1">
          <mxGeometry height="800" width="1400" as="geometry" />
        </mxCell>

        <!-- Header -->
        <mxCell id="title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=22;" value="Unit of Work &amp;amp; Identity Map Coordination Lifecycle" vertex="1">
          <mxGeometry height="35" width="1240" x="80" y="25" as="geometry" />
        </mxCell>
        <mxCell id="subtitle" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#475569;fontSize=14;" value="Coordinating change tracking, reference equality, and atomic topological batch flushes across transactional boundaries" vertex="1">
          <mxGeometry height="25" width="1240" x="80" y="60" as="geometry" />
        </mxCell>

        <!-- STAGE 1: Read & Identity Map Check -->
        <mxCell id="stg1_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#3b82f6;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="660" width="280" x="80" y="100" as="geometry" />
        </mxCell>
        <mxCell id="stg1_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#1e40af; font-size:14px;&quot;&gt;1. Read &amp;amp; Identity Cache&lt;/b&gt;" vertex="1">
          <mxGeometry height="40" width="260" x="90" y="110" as="geometry" />
        </mxCell>
        <mxCell id="stg1_step1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#cbd5e1;strokeWidth=1;arcSize=6;" value="&lt;b&gt;Repository.findById(id)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#475569;&quot;&gt;Client requests entity&lt;/span&gt;" vertex="1">
          <mxGeometry height="55" width="250" x="95" y="165" as="geometry" />
        </mxCell>
        <mxCell id="stg1_step2" parent="1" style="rhombus;whiteSpace=wrap;html=1;fillColor=#f5f3ff;strokeColor=#8b5cf6;strokeWidth=1.5;fontColor:#5b21b6;fontStyle=1;fontSize=12;" value="Identity Map&lt;br&gt;contains id?" vertex="1">
          <mxGeometry height="90" width="180" x="130" y="240" as="geometry" />
        </mxCell>
        <mxCell id="stg1_hit" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#10b981;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46;&quot;&gt;Cache HIT&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Return cached pointer&lt;br&gt;• 0 SQL queries executed&lt;br&gt;• Strict reference equality (&lt;i&gt;a === b&lt;/i&gt;)&lt;/span&gt;" vertex="1">
          <mxGeometry height="80" width="250" x="95" y="360" as="geometry" />
        </mxCell>
        <mxCell id="stg1_miss" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef2f2;strokeColor=#ef4444;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#991b1b;&quot;&gt;Cache MISS&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#b91c1c;&quot;&gt;Data Mapper queries DB&lt;br&gt;Hydrates entity &amp;amp; registers in Identity Map as [clean]&lt;/span&gt;" vertex="1">
          <mxGeometry height="80" width="250" x="95" y="460" as="geometry" />
        </mxCell>
        <mxCell id="stg1_footer" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;fontColor:#64748b;fontSize=11;" value="Identity Map guarantees single source of in-memory truth." vertex="1">
          <mxGeometry height="40" width="250" x="95" y="700" as="geometry" />
        </mxCell>

        <!-- STAGE 2: Mutation & Dirty Tracking -->
        <mxCell id="stg2_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#f59e0b;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="660" width="280" x="390" y="100" as="geometry" />
        </mxCell>
        <mxCell id="stg2_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef3c7;strokeColor=#f59e0b;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#92400e; font-size:14px;&quot;&gt;2. In-Memory Mutation&lt;/b&gt;" vertex="1">
          <mxGeometry height="40" width="260" x="400" y="110" as="geometry" />
        </mxCell>
        <mxCell id="stg2_desc" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=top;whiteSpace=wrap;rounded=0;fontColor:#78350f;fontSize=12;" value="Business logic modifies entities in RAM. The Unit of Work categorizes entities into four discrete change sets:" vertex="1">
          <mxGeometry height="50" width="260" x="405" y="165" as="geometry" />
        </mxCell>
        <mxCell id="stg2_set_new" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#10b981;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#065f46;&quot;&gt;Set: NEW&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Entities added via &lt;i&gt;registerNew()&lt;/i&gt;&lt;br&gt;Pending INSERT&lt;/span&gt;" vertex="1">
          <mxGeometry height="65" width="250" x="405" y="225" as="geometry" />
        </mxCell>
        <mxCell id="stg2_set_dirty" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef3c7;strokeColor=#f59e0b;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#92400e;&quot;&gt;Set: DIRTY&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#78350f;&quot;&gt;Modified via &lt;i&gt;registerDirty()&lt;/i&gt;&lt;br&gt;Pending UPDATE&lt;/span&gt;" vertex="1">
          <mxGeometry height="65" width="250" x="405" y="305" as="geometry" />
        </mxCell>
        <mxCell id="stg2_set_clean" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#1e40af;&quot;&gt;Set: CLEAN&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#1d4ed8;&quot;&gt;Read-only; unmodified in session&lt;br&gt;Excluded from DB writes&lt;/span&gt;" vertex="1">
          <mxGeometry height="65" width="250" x="405" y="385" as="geometry" />
        </mxCell>
        <mxCell id="stg2_set_deleted" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef2f2;strokeColor=#ef4444;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#991b1b;&quot;&gt;Set: DELETED&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#b91c1c;&quot;&gt;Marked via &lt;i&gt;registerRemoved()&lt;/i&gt;&lt;br&gt;Pending DELETE&lt;/span&gt;" vertex="1">
          <mxGeometry height="65" width="250" x="405" y="465" as="geometry" />
        </mxCell>
        <mxCell id="stg2_footer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fffbeb;strokeColor=#fde68a;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#92400e; font-size:11px;&quot;&gt;Zero Database Locks:&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:10px; color:#78350f;&quot;&gt;All mutations happen in memory without holding open database transactions.&lt;/span&gt;" vertex="1">
          <mxGeometry height="60" width="250" x="405" y="555" as="geometry" />
        </mxCell>

        <!-- STAGE 3: Topological Dependency Ordering -->
        <mxCell id="stg3_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#8b5cf6;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="660" width="310" x="700" y="100" as="geometry" />
        </mxCell>
        <mxCell id="stg3_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f5f3ff;strokeColor=#8b5cf6;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#5b21b6; font-size:14px;&quot;&gt;3. Topological Sort on Commit&lt;/b&gt;" vertex="1">
          <mxGeometry height="40" width="290" x="710" y="110" as="geometry" />
        </mxCell>
        <mxCell id="stg3_desc" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=top;whiteSpace=wrap;rounded=0;fontColor:#4c1d95;fontSize=12;" value="When &lt;i&gt;uow.commit()&lt;/i&gt; is invoked, foreign key constraints require strict execution ordering to prevent DB violations:" vertex="1">
          <mxGeometry height="50" width="290" x="715" y="165" as="geometry" />
        </mxCell>
        <mxCell id="stg3_step_insert" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#10b981;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46;&quot;&gt;Step A: Execute INSERTS&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Parent tables before child tables&lt;br&gt;(e.g., Customer ➔ Order ➔ OrderItem)&lt;/span&gt;" vertex="1">
          <mxGeometry height="75" width="280" x="715" y="225" as="geometry" />
        </mxCell>
        <mxCell id="stg3_step_update" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef3c7;strokeColor=#f59e0b;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#92400e;&quot;&gt;Step B: Execute UPDATES&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#78350f;&quot;&gt;Batch dirty statements;&lt;br&gt;Optimistic lock check: &lt;i&gt;WHERE version = v&lt;/i&gt;&lt;/span&gt;" vertex="1">
          <mxGeometry height="75" width="280" x="715" y="320" as="geometry" />
        </mxCell>
        <mxCell id="stg3_step_delete" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef2f2;strokeColor=#ef4444;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#991b1b;&quot;&gt;Step C: Execute DELETES&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#b91c1c;&quot;&gt;Child tables before parent tables&lt;br&gt;(e.g., OrderItem ➔ Order)&lt;/span&gt;" vertex="1">
          <mxGeometry height="75" width="280" x="715" y="415" as="geometry" />
        </mxCell>
        <mxCell id="stg3_footer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f5f3ff;strokeColor=#ddd6fe;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#5b21b6; font-size:11px;&quot;&gt;Graph Resolution:&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:10px; color:#6d28d9;&quot;&gt;Prevents foreign key constraint errors and SQL deadlocks caused by unordered writes.&lt;/span&gt;" vertex="1">
          <mxGeometry height="60" width="280" x="715" y="555" as="geometry" />
        </mxCell>

        <!-- STAGE 4: Atomic Batch Flush -->
        <mxCell id="stg4_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#10b981;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="660" width="350" x="1040" y="100" as="geometry" />
        </mxCell>
        <mxCell id="stg4_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#10b981;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46; font-size:14px;&quot;&gt;4. Database Batch Flush &amp;amp; Sync&lt;/b&gt;" vertex="1">
          <mxGeometry height="40" width="330" x="1050" y="110" as="geometry" />
        </mxCell>
        <mxCell id="stg4_db" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#64748b;strokeWidth=2;arcSize=6;" value="&lt;b style=&quot;color:#0f172a; font-size:13px;&quot;&gt;Relational Database (PostgreSQL)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#475569;&quot;&gt;BEGIN TRANSACTION&lt;br&gt;&amp;nbsp;&amp;nbsp;INSERT INTO orders (...) VALUES (...);&lt;br&gt;&amp;nbsp;&amp;nbsp;UPDATE warehouse_stocks SET ... WHERE version = 3;&lt;br&gt;&amp;nbsp;&amp;nbsp;DELETE FROM order_items WHERE id = 99;&lt;br&gt;COMMIT TRANSACTION;&lt;/span&gt;" vertex="1">
          <mxGeometry height="150" width="320" x="1055" y="165" as="geometry" />
        </mxCell>
        <mxCell id="stg4_outcome_ok" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#10b981;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46;&quot;&gt;On SUCCESS:&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;• Promotes [new] &amp;amp; [dirty] sets to [clean]&lt;br&gt;• Removes [deleted] entities from Identity Map&lt;br&gt;• Clears Unit of Work tracking buffer&lt;/span&gt;" vertex="1">
          <mxGeometry height="90" width="320" x="1055" y="340" as="geometry" />
        </mxCell>
        <mxCell id="stg4_outcome_err" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef2f2;strokeColor=#ef4444;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#991b1b;&quot;&gt;On Concurrency Conflict / Failure:&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#b91c1c;&quot;&gt;• Database transaction rolls back instantly&lt;br&gt;• Discards modified in-memory references&lt;br&gt;• Throws &lt;i&gt;OptimisticConcurrencyException&lt;/i&gt;&lt;/span&gt;" vertex="1">
          <mxGeometry height="90" width="320" x="1055" y="450" as="geometry" />
        </mxCell>
        <mxCell id="stg4_footer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f0fdf4;strokeColor=#bbf7d0;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#166534; font-size:11px;&quot;&gt;Minimal Lock Duration:&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:10px; color:#15803d;&quot;&gt;Database transaction is open only during the batch flush (milliseconds), maximizing throughput.&lt;/span&gt;" vertex="1">
          <mxGeometry height="60" width="320" x="1055" y="555" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-2-cover" name="PoEAA Part II Cover">
    <mxGraphModel dx="1837" dy="944" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Canvas Background (Safe 16:9 canvas with light aesthetic) -->
        <mxCell id="bg" parent="1" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=none;" value="" vertex="1">
          <mxGeometry height="900" width="1600" as="geometry" />
        </mxCell>

        <!-- Header Pill & Titles (Safe margins >80px) -->
        <mxCell id="badge" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#e0e7ff;strokeColor=#6366f1;strokeWidth=1.5;fontColor=#4338ca;fontStyle=1;fontSize=13;letterSpacing=1;" value="PATTERNS OF ENTERPRISE APPLICATION ARCHITECTURE — PART II" vertex="1">
          <mxGeometry height="32" width="490" x="100" y="55" as="geometry" />
        </mxCell>

        <mxCell id="title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=36;" value="Data Source &amp;amp; Object-Relational Persistence Patterns" vertex="1">
          <mxGeometry height="50" width="1400" x="100" y="95" as="geometry" />
        </mxCell>

        <mxCell id="subtitle" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#475569;fontSize=16;" value="The O/R Chasm · Active Record vs. Data Mapper · Unit of Work Lifecycle · Identity Map · Concurrency Bounds" vertex="1">
          <mxGeometry height="30" width="1400" x="100" y="148" as="geometry" />
        </mxCell>

        <!-- PANEL 1: The O/R Chasm -->
        <mxCell id="panel1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="640" width="440" x="100" y="195" as="geometry" />
        </mxCell>

        <mxCell id="p1_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=18;" value="1. The O/R Impedance Mismatch" vertex="1">
          <mxGeometry height="30" width="400" x="120" y="210" as="geometry" />
        </mxCell>

        <mxCell id="p1_obj_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;font-size:14px; color:#1d4ed8;&quot;&gt;In-Memory Domain Graph&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#2563eb;&quot;&gt;• Rich polymorphic inheritance&lt;br&gt;• Reference identity (&lt;i&gt;a === b&lt;/i&gt;)&lt;br&gt;• Bidirectional pointers &amp;amp; collections&lt;br&gt;• Fine-grained behavioral methods&lt;/span&gt;" vertex="1">
          <mxGeometry height="120" width="400" x="120" y="255" as="geometry" />
        </mxCell>

        <mxCell id="p1_chasm" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef2f2;strokeColor=#ef4444;strokeWidth=2;dashed=1;arcSize=6;" value="&lt;b style=&quot;color:#b91c1c; font-size:13px;&quot;&gt;⚡ The O/R Impedance Chasm ⚡&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#991b1b;&quot;&gt;Identity mismatch · Structural divide · Concurrency bounds&lt;/span&gt;" vertex="1">
          <mxGeometry height="60" width="400" x="120" y="405" as="geometry" />
        </mxCell>

        <mxCell id="p1_rel_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#64748b;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;font-size:14px; color:#334155;&quot;&gt;Relational Database Schema&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#475569;&quot;&gt;• Normalized 2D tabular relations&lt;br&gt;• Foreign key constraints &amp;amp; joins&lt;br&gt;• Primary key identity (&lt;i&gt;id = 42&lt;/i&gt;)&lt;br&gt;• Coarse-grained ACID transactions&lt;/span&gt;" vertex="1">
          <mxGeometry height="120" width="400" x="120" y="495" as="geometry" />
        </mxCell>

        <mxCell id="p1_footer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f1f5f9;strokeColor=#cbd5e1;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#475569; font-size:11px;&quot;&gt;Core Invariant:&lt;/b&gt;&lt;span style=&quot;font-size:11px; color:#64748b;&quot;&gt; Domain logic must remain clean, free of SQL strings and schema leakages.&lt;/span&gt;" vertex="1">
          <mxGeometry height="50" width="400" x="120" y="645" as="geometry" />
        </mxCell>

        <!-- PANEL 2: Architectural Data Source Continuum -->
        <mxCell id="panel2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="640" width="450" x="575" y="195" as="geometry" />
        </mxCell>

        <mxCell id="p2_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=18;" value="2. The Persistence Continuum" vertex="1">
          <mxGeometry height="30" width="410" x="595" y="210" as="geometry" />
        </mxCell>

        <mxCell id="p2_gw" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#94a3b8;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;font-size:13px; color:#1e293b;&quot;&gt;Table / Row Data Gateway&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#475569;&quot;&gt;Wraps raw tables/rows. No domain logic; returns recordsets.&lt;br&gt;Pairs with Transaction Script or Table Module.&lt;/span&gt;" vertex="1">
          <mxGeometry height="75" width="410" x="595" y="255" as="geometry" />
        </mxCell>

        <mxCell id="p2_ar" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef3c7;strokeColor=#f59e0b;strokeWidth=2;arcSize=6;" value="&lt;b style=&quot;font-size:13px; color:#92400e;&quot;&gt;Active Record (Prisma / Rails / TypeORM)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#78350f;&quot;&gt;One class per table; wraps row + data access + domain logic.&lt;br&gt;&lt;b&gt;Sweet spot:&lt;/b&gt; Rapid CRUD. &lt;b&gt;Penalty:&lt;/b&gt; Extreme coupling at scale.&lt;/span&gt;" vertex="1">
          <mxGeometry height="95" width="410" x="595" y="350" as="geometry" />
        </mxCell>

        <mxCell id="p2_dm" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#10b981;strokeWidth=2.5;arcSize=6;" value="&lt;b style=&quot;font-size:14px; color:#065f46;&quot;&gt;Data Mapper (Complete Decoupling)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Independent layer coordinating persistence and domain entities.&lt;br&gt;Domain entities are 100% POJO/POKO; zero database dependencies.&lt;br&gt;&lt;b&gt;Essential for:&lt;/b&gt; Rich Domain Models &amp;amp; DDD Aggregate boundaries.&lt;/span&gt;" vertex="1">
          <mxGeometry height="110" width="410" x="595" y="465" as="geometry" />
        </mxCell>

        <mxCell id="p2_repo" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#e0e7ff;strokeColor=#6366f1;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;font-size:13px; color:#3730a3;&quot;&gt;Repository Pattern (The Domain Facade)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#4338ca;&quot;&gt;Mediates between domain and Data Mapper; provides in-memory collection semantics (&lt;i&gt;find&lt;/i&gt;, &lt;i&gt;add&lt;/i&gt;, &lt;i&gt;remove&lt;/i&gt;).&lt;/span&gt;" vertex="1">
          <mxGeometry height="85" width="410" x="595" y="595" as="geometry" />
        </mxCell>

        <!-- PANEL 3: Behavioral Coordination -->
        <mxCell id="panel3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="640" width="440" x="1060" y="195" as="geometry" />
        </mxCell>

        <mxCell id="p3_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=18;" value="3. Behavioral Coordination" vertex="1">
          <mxGeometry height="30" width="400" x="1080" y="210" as="geometry" />
        </mxCell>

        <mxCell id="p3_uow" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=2;arcSize=6;" value="&lt;b style=&quot;font-size:14px; color:#1e40af;&quot;&gt;Unit of Work (Transaction Coordinator)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#1d4ed8;&quot;&gt;Tracks change sets across active session:&lt;br&gt;[new] · [dirty] · [clean] · [deleted]&lt;br&gt;Topologically sorts statements &amp;amp; flushes in single batch.&lt;/span&gt;" vertex="1">
          <mxGeometry height="110" width="400" x="1080" y="255" as="geometry" />
        </mxCell>

        <mxCell id="p3_idmap" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f5f3ff;strokeColor=#8b5cf6;strokeWidth=2;arcSize=6;" value="&lt;b style=&quot;font-size:14px; color:#5b21b6;&quot;&gt;Identity Map (Consistency &amp;amp; Cache)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#6d28d9;&quot;&gt;Ensures exactly one in-memory object per database row.&lt;br&gt;Eliminates stale read anomalies, prevents duplicated instances,&lt;br&gt;and serves as session-level L1 cache.&lt;/span&gt;" vertex="1">
          <mxGeometry height="110" width="400" x="1080" y="385" as="geometry" />
        </mxCell>

        <mxCell id="p3_lazy" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfeff;strokeColor=#06b6d4;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;font-size:13px; color:#155e75;&quot;&gt;Lazy Load Strategies&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#0e7490;&quot;&gt;• Virtual Proxy · Value Holder · Ghost Object&lt;br&gt;Defers expensive relationship loading until needed;&lt;br&gt;avoids loading entire relational database graph into RAM.&lt;/span&gt;" vertex="1">
          <mxGeometry height="95" width="400" x="1080" y="515" as="geometry" />
        </mxCell>

        <mxCell id="p3_concurrency" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fff7ed;strokeColor=#ea580c;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;font-size:13px; color:#9a3412;&quot;&gt;Optimistic Concurrency Control&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#c2410c;&quot;&gt;Version tokens (&lt;i&gt;version = version + 1&lt;/i&gt;) preventing lost updates without holding persistent database locks.&lt;/span&gt;" vertex="1">
          <mxGeometry height="75" width="400" x="1080" y="630" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
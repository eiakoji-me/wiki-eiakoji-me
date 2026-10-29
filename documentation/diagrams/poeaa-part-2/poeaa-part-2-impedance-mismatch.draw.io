<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-2-impedance-mismatch" name="The O/R Impedance Mismatch">
    <mxGraphModel dx="1200" dy="700" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="700" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Background -->
        <mxCell id="bg" parent="1" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=none;" value="" vertex="1">
          <mxGeometry height="700" width="1200" as="geometry" />
        </mxCell>

        <!-- Header -->
        <mxCell id="title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=22;" value="The Object-Relational Impedance Mismatch: Three Architectural Rifts" vertex="1">
          <mxGeometry height="35" width="1040" x="80" y="25" as="geometry" />
        </mxCell>
        <mxCell id="subtitle" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#475569;fontSize=14;" value="Why mapping rich object graphs directly to relational database tables creates structural friction and data anomalies" vertex="1">
          <mxGeometry height="25" width="1040" x="80" y="60" as="geometry" />
        </mxCell>

        <!-- COLUMN 1: Structural Divide -->
        <mxCell id="col1_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="570" width="330" x="80" y="95" as="geometry" />
        </mxCell>
        <mxCell id="col1_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#1e40af; font-size:15px;&quot;&gt;1. Structural &amp;amp; Schema Rift&lt;/b&gt;" vertex="1">
          <mxGeometry height="45" width="310" x="90" y="105" as="geometry" />
        </mxCell>
        <mxCell id="col1_obj" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f0fdf4;strokeColor=#22c55e;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#15803d;&quot;&gt;Domain Object Graph&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#166534;&quot;&gt;• Deep inheritance hierarchies&lt;br&gt;• Polymorphic associations&lt;br&gt;• Nested Value Objects (Address)&lt;br&gt;• Unordered graph navigation&lt;/span&gt;" vertex="1">
          <mxGeometry height="110" width="300" x="95" y="165" as="geometry" />
        </mxCell>
        <mxCell id="col1_vs" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;fontColor=#ef4444;fontStyle=1;fontSize=14;" value="⚡ VS ⚡" vertex="1">
          <mxGeometry height="25" width="300" x="95" y="285" as="geometry" />
        </mxCell>
        <mxCell id="col1_rel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#64748b;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#334155;&quot;&gt;Relational RDBMS&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#475569;&quot;&gt;• Flat, normalized 2D tables&lt;br&gt;• No native concept of inheritance&lt;br&gt;• Primitive scalar column types&lt;br&gt;• Relational joins &amp;amp; foreign keys&lt;/span&gt;" vertex="1">
          <mxGeometry height="110" width="300" x="95" y="320" as="geometry" />
        </mxCell>
        <mxCell id="col1_consequence" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef2f2;strokeColor=#fca5a5;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#991b1b; font-size:12px;&quot;&gt;Architectural Consequence:&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#b91c1c;&quot;&gt;Demands inheritance mapping strategies (Single Table, Class Table, Concrete Table) and Value Object serialization.&lt;/span&gt;" vertex="1">
          <mxGeometry height="95" width="300" x="95" y="450" as="geometry" />
        </mxCell>

        <!-- COLUMN 2: Identity Rift -->
        <mxCell id="col2_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="570" width="330" x="435" y="95" as="geometry" />
        </mxCell>
        <mxCell id="col2_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f5f3ff;strokeColor=#8b5cf6;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#5b21b6; font-size:15px;&quot;&gt;2. Identity &amp;amp; Reference Rift&lt;/b&gt;" vertex="1">
          <mxGeometry height="45" width="310" x="445" y="105" as="geometry" />
        </mxCell>
        <mxCell id="col2_obj" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f0fdf4;strokeColor=#22c55e;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#15803d;&quot;&gt;Memory Reference Equality&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#166534;&quot;&gt;• Identity determined by memory pointer&lt;br&gt;• Two instances with ID 42 are distinct&lt;br&gt;• Modifying one leaks stale state to other&lt;br&gt;• Bidirectional cycles risk infinite loops&lt;/span&gt;" vertex="1">
          <mxGeometry height="110" width="300" x="450" y="165" as="geometry" />
        </mxCell>
        <mxCell id="col2_vs" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;fontColor=#ef4444;fontStyle=1;fontSize=14;" value="⚡ VS ⚡" vertex="1">
          <mxGeometry height="25" width="300" x="450" y="285" as="geometry" />
        </mxCell>
        <mxCell id="col2_rel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#64748b;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#334155;&quot;&gt;Primary Key Equality&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#475569;&quot;&gt;• Row uniqueness governed by PK&lt;br&gt;• Every SELECT returns independent tuple&lt;br&gt;• Database has no pointer awareness&lt;br&gt;• Concurrent reads create split views&lt;/span&gt;" vertex="1">
          <mxGeometry height="110" width="300" x="450" y="320" as="geometry" />
        </mxCell>
        <mxCell id="col2_consequence" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef2f2;strokeColor=#fca5a5;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#991b1b; font-size:12px;&quot;&gt;Architectural Consequence:&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#b91c1c;&quot;&gt;Demands an &lt;b&gt;Identity Map&lt;/b&gt; to guarantee exactly one in-memory object instance per database record per session.&lt;/span&gt;" vertex="1">
          <mxGeometry height="95" width="300" x="450" y="450" as="geometry" />
        </mxCell>

        <!-- COLUMN 3: Transactional Rift -->
        <mxCell id="col3_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="570" width="330" x="790" y="95" as="geometry" />
        </mxCell>
        <mxCell id="col3_hdr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fff7ed;strokeColor=#ea580c;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#9a3412; font-size:15px;&quot;&gt;3. Transaction &amp;amp; Write Rift&lt;/b&gt;" vertex="1">
          <mxGeometry height="45" width="310" x="800" y="105" as="geometry" />
        </mxCell>
        <mxCell id="col3_obj" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f0fdf4;strokeColor=#22c55e;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#15803d;&quot;&gt;Fine-Grained In-Memory Mutation&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#166534;&quot;&gt;• Objects mutated incrementally in RAM&lt;br&gt;• 100 method invocations on 20 objects&lt;br&gt;• Instant state visibility in current thread&lt;br&gt;• Zero network or serialization latency&lt;/span&gt;" vertex="1">
          <mxGeometry height="110" width="300" x="805" y="165" as="geometry" />
        </mxCell>
        <mxCell id="col3_vs" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;fontColor=#ef4444;fontStyle=1;fontSize=14;" value="⚡ VS ⚡" vertex="1">
          <mxGeometry height="25" width="300" x="805" y="285" as="geometry" />
        </mxCell>
        <mxCell id="col3_rel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#64748b;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#334155;&quot;&gt;Coarse-Grained Database ACID&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#475569;&quot;&gt;• SQL network round-trips are expensive&lt;br&gt;• Immediate writes hold DB row locks&lt;br&gt;• High deadlocks under concurrent traffic&lt;br&gt;• Rolling back DB transaction loses state&lt;/span&gt;" vertex="1">
          <mxGeometry height="110" width="300" x="805" y="320" as="geometry" />
        </mxCell>
        <mxCell id="col3_consequence" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef2f2;strokeColor=#fca5a5;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#991b1b; font-size:12px;&quot;&gt;Architectural Consequence:&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#b91c1c;&quot;&gt;Demands a &lt;b&gt;Unit of Work&lt;/b&gt; to accumulate dirty entities and execute atomic, batched commits at transaction close.&lt;/span&gt;" vertex="1">
          <mxGeometry height="95" width="300" x="805" y="450" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
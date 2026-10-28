<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-1-cover" name="PoEAA Part I Cover">
    <mxGraphModel dx="1837" dy="944" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="bg" parent="1" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=none;" value="" vertex="1">
          <mxGeometry height="900" width="1600" as="geometry" />
        </mxCell>
        <mxCell id="badge" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#e0e7ff;strokeColor=#6366f1;strokeWidth=1.5;fontColor=#4338ca;fontStyle=1;fontSize=13;letterSpacing=1;" value="PATTERNS OF ENTERPRISE APPLICATION ARCHITECTURE" vertex="1">
          <mxGeometry height="32" width="450" x="100" y="60" as="geometry" />
        </mxCell>
        <mxCell id="title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=36;" value="Layering &amp;amp; Domain Logic Architecture" vertex="1">
          <mxGeometry height="50" width="1400" x="100" y="100" as="geometry" />
        </mxCell>
        <mxCell id="subtitle" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#475569;fontSize=16;" value="Three-Layer System · Service Layer Coordinator · Rich Domain Model · Value Objects" vertex="1">
          <mxGeometry height="30" width="1400" x="100" y="152" as="geometry" />
        </mxCell>
        <mxCell id="left_panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="600" width="660" x="100" y="200" as="geometry" />
        </mxCell>
        <mxCell id="left_panel_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=20;" value="1. Strict Unidirectional Layering" vertex="1">
          <mxGeometry height="30" width="600" x="130" y="220" as="geometry" />
        </mxCell>
        <mxCell id="pres_layer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=1.5;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b style=&quot;font-size:16px; color:#1d4ed8;&quot;&gt;Presentation Layer&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:13px; color:#2563eb;&quot;&gt;HTTP Controllers · REST / GraphQL Resolvers · DTO Serialization&lt;/span&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#64748b;&quot;&gt;Translates network requests ➔ dispatches domain commands&lt;/span&gt;" vertex="1">
          <mxGeometry height="95" width="600" x="130" y="265" as="geometry" />
        </mxCell>
        <mxCell id="arrow1" edge="1" parent="1" source="pres_layer" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#64748b;strokeWidth=2;fontColor=#64748b;fontSize=12;fontStyle=1;" target="domain_layer" value="invokes ↓">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="domain_layer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#059669;strokeWidth=2.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="150" width="600" x="130" y="405" as="geometry" />
        </mxCell>
        <mxCell id="domain_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=top;whiteSpace=wrap;rounded=0;" value="&lt;b style=&quot;font-size:16px; color:#047857;&quot;&gt;Domain Layer (The Core)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#059669;&quot;&gt;Entities · Aggregates · Value Objects · Pure Business Rules&lt;/span&gt;" vertex="1">
          <mxGeometry height="40" width="580" x="140" y="415" as="geometry" />
        </mxCell>
        <mxCell id="domain_service_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#10b981;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46;&quot;&gt;Service Layer&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Workflow Boundary &amp;amp; Orchestrator&lt;/span&gt;" vertex="1">
          <mxGeometry height="65" width="260" x="155" y="470" as="geometry" />
        </mxCell>
        <mxCell id="domain_entities_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#10b981;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46;&quot;&gt;Rich Domain Entities&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Invariant Self-Protection&lt;/span&gt;" vertex="1">
          <mxGeometry height="65" width="260" x="445" y="470" as="geometry" />
        </mxCell>
        <mxCell id="arrow2" edge="1" parent="1" source="domain_layer" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#64748b;strokeWidth=2;fontColor=#64748b;fontSize=12;fontStyle=1;" target="data_layer" value="invokes ↓">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="data_layer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#faf5ff;strokeColor=#a855f7;strokeWidth=1.5;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b style=&quot;font-size:16px; color:#7e22ce;&quot;&gt;Data Source Layer&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:13px; color:#9333ea;&quot;&gt;PostgreSQL · Repositories · ORM Mappers · Third-Party Gateways&lt;/span&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#64748b;&quot;&gt;Abstracted behind interfaces · Zero business logic or math&lt;/span&gt;" vertex="1">
          <mxGeometry height="95" width="600" x="130" y="600" as="geometry" />
        </mxCell>
        <mxCell id="left_rule_badge" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f1f5f9;strokeColor=#cbd5e1;fontColor=#475569;fontSize=11;fontStyle=2;" value="Rule: Lower layers NEVER depend on upper layers. Domain has zero infrastructure coupling." vertex="1">
          <mxGeometry height="30" width="600" x="130" y="715" as="geometry" />
        </mxCell>
        <mxCell id="right_panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="600" width="700" x="800" y="200" as="geometry" />
        </mxCell>
        <mxCell id="right_panel_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=20;" value="2. Domain Logic Continuum &amp;amp; Value Objects" vertex="1">
          <mxGeometry height="30" width="640" x="830" y="220" as="geometry" />
        </mxCell>
        <mxCell id="ts_card" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fffbeb;strokeColor=#f59e0b;strokeWidth=1.5;arcSize=6;" value="&lt;div style=&quot;text-align:left; padding:4px;&quot;&gt;&lt;b style=&quot;font-size:15px; color:#b45309;&quot;&gt;Transaction Script (Procedural)&lt;/b&gt; &lt;span style=&quot;float:right; font-size:11px; background:#fef3c7; color:#92400e; padding:2px 8px; border-radius:4px; border:1px solid #f59e0b;&quot;&gt;Low Complexity&lt;/span&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#78350f;&quot;&gt;Single procedure coordinates request directly against database tables.&lt;/span&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#15803d;&quot;&gt;✓ Simple CRUD, ETL, reports&lt;/span&gt; &amp;nbsp;&amp;nbsp; &lt;span style=&quot;font-size:11px; color:#b91c1c;&quot;&gt;✗ Duplication &amp;amp; scattered invariants as logic grows&lt;/span&gt;&lt;/div&gt;" vertex="1">
          <mxGeometry height="90" width="640" x="830" y="265" as="geometry" />
        </mxCell>
        <mxCell id="rdm_card" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f0fdf4;strokeColor=#16a34a;strokeWidth=2;arcSize=6;" value="&lt;div style=&quot;text-align:left; padding:4px;&quot;&gt;&lt;b style=&quot;font-size:15px; color:#15803d;&quot;&gt;Rich Domain Model (Encapsulated Behavior)&lt;/b&gt; &lt;span style=&quot;float:right; font-size:11px; background:#dcfce7; color:#166534; padding:2px 8px; border-radius:4px; border:1px solid #16a34a;&quot;&gt;High Complexity&lt;/span&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#166534;&quot;&gt;Graph of Entities &amp;amp; Value Objects encapsulating private state and rich business logic.&lt;/span&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#15803d;&quot;&gt;✓ Invariants self-enforced&lt;/span&gt; &amp;nbsp; &lt;span style=&quot;font-size:11px; color:#15803d;&quot;&gt;✓ Complex state transitions&lt;/span&gt; &amp;nbsp; &lt;span style=&quot;font-size:11px; color:#15803d;&quot;&gt;✓ High testability without DB I/O&lt;/span&gt;&lt;/div&gt;" vertex="1">
          <mxGeometry height="100" width="640" x="830" y="375" as="geometry" />
        </mxCell>
        <mxCell id="vo_container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#64748b;strokeWidth=1.5;strokeDasharray=4 2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="215" width="640" x="830" y="495" as="geometry" />
        </mxCell>
        <mxCell id="vo_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=top;whiteSpace=wrap;rounded=0;" value="&lt;b style=&quot;font-size:15px; color:#0f172a;&quot;&gt;Pattern Spotlight: Self-Validating Value Objects&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#64748b;&quot;&gt;Cures Primitive Obsession (e.g. replacing raw numbers with Money &amp;amp; BillingPeriod)&lt;/span&gt;" vertex="1">
          <mxGeometry height="35" width="600" x="850" y="505" as="geometry" />
        </mxCell>
        <mxCell id="vo_p1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#1e293b;&quot;&gt;1. Immutability&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#64748b;&quot;&gt;State cannot mutate.&lt;br&gt;Operations return new instances.&lt;/span&gt;" vertex="1">
          <mxGeometry height="75" width="190" x="850" y="555" as="geometry" />
        </mxCell>
        <mxCell id="vo_p2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#1e293b;&quot;&gt;2. Value Equality&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#64748b;&quot;&gt;No synthetic DB ID.&lt;br&gt;Equal by internal attributes.&lt;/span&gt;" vertex="1">
          <mxGeometry height="75" width="190" x="1055" y="555" as="geometry" />
        </mxCell>
        <mxCell id="vo_p3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#cbd5e1;strokeWidth=1;arcSize=6;" value="&lt;b style=&quot;color:#1e293b;&quot;&gt;3. Self-Validation&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#64748b;&quot;&gt;Invariants checked at construction.&lt;br&gt;Invalid state is impossible.&lt;/span&gt;" vertex="1">
          <mxGeometry height="75" width="190" x="1260" y="555" as="geometry" />
        </mxCell>
        <mxCell id="vo_code_snippet" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f1f5f9;strokeColor=#e2e8f0;strokeWidth=1;arcSize=4;" value="&lt;span style=&quot;font-family:Courier New, monospace; font-size:11px; color:#334155;&quot;&gt;const charge = new Money(9900, &quot;USD&quot;).subtract(credit); // Safe invariant arithmetic&lt;/span&gt;" vertex="1">
          <mxGeometry height="40" width="600" x="850" y="645" as="geometry" />
        </mxCell>
        <mxCell id="right_footer_note" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor:#64748b;fontSize=11;fontStyle=2;" value="Example: Subscription.applyPlanUpgrade() computes proration math without database I/O" vertex="1">
          <mxGeometry height="25" width="640" x="830" y="720" as="geometry" />
        </mxCell>
        <mxCell id="canvas_footer" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#94a3b8;fontSize=13;" value="wiki.eiakoji.me · Technical Architectural Knowledge Series · Part I of IV" vertex="1">
          <mxGeometry height="25" width="600" x="100" y="820" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

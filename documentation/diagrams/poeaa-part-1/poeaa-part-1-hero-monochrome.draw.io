<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-1-hero-monochrome" name="PoEAA Part I Hero Monochrome">
    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- 1. PRESENTATION BOUNDARY (TOP CONTAINER) -->
        <mxCell id="pres-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="115" width="1440" x="80" y="60" as="geometry" />
        </mxCell>
        <mxCell id="pres-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="PRESENTATION &amp;amp; EXTERNAL ENTRY BOUNDARY" vertex="1">
          <mxGeometry height="22" width="600" x="105" y="70" as="geometry" />
        </mxCell>
        <mxCell id="pres-box-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b&gt;HTTP &amp;amp; REST Controllers&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size: 11px;&quot;&gt;Parameter extraction · JSON validation · Identity headers&lt;/font&gt;" vertex="1">
          <mxGeometry height="58" width="430" x="105" y="98" as="geometry" />
        </mxCell>
        <mxCell id="pres-box-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b&gt;GraphQL &amp;amp; RPC Resolvers&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size: 11px;&quot;&gt;Query field selection · Schema authorization · DTO marshaling&lt;/font&gt;" vertex="1">
          <mxGeometry height="58" width="430" x="585" y="98" as="geometry" />
        </mxCell>
        <mxCell id="pres-box-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b&gt;CLI &amp;amp; Event Queue Intake&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size: 11px;&quot;&gt;Async message ingestion · Command-line flags · Job triggers&lt;/font&gt;" vertex="1">
          <mxGeometry height="58" width="430" x="1065" y="98" as="geometry" />
        </mxCell>

        <!-- ARROW DOWN: Presentation -> Service Layer -->
        <mxCell id="arrow-pres-service" edge="1" parent="1" source="pres-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="service-container" value="Dispatches Command DTOs / Request Envelopes">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- 2. SERVICE LAYER (MIDDLE CONTAINER) -->
        <mxCell id="service-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="120" width="1440" x="80" y="215" as="geometry" />
        </mxCell>
        <mxCell id="service-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="APPLICATION &amp;amp; SERVICE LAYER FACADE" vertex="1">
          <mxGeometry height="22" width="600" x="105" y="225" as="geometry" />
        </mxCell>
        <mxCell id="service-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;spacingLeft=25;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Service Layer Coordinator&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;• Coordinates end-to-end use-case workflows while maintaining strict presentation independence&lt;br&gt;• Demarcates atomic transactional boundaries (&lt;i&gt;BEGIN ... COMMIT / ROLLBACK&lt;/i&gt;) and enforces security bounds&lt;br&gt;• Directs execution flow into either procedural transaction scripts or a behavior-rich domain model&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="1390" x="105" y="250" as="geometry" />
        </mxCell>

        <!-- DUAL ROUTING ARROWS: Service Layer -> Path A and Path B -->
        <mxCell id="arrow-service-pathA" edge="1" parent="1" source="service-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="pathA-container" value="Path A: Procedural Routing">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="430" y="355" />
              <mxPoint x="430" y="385" />
            </Array>
          </mxGeometry>
        </mxCell>

        <mxCell id="arrow-service-pathB" edge="1" parent="1" source="service-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="pathB-container" value="Path B: Object-Oriented Domain Routing">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1170" y="355" />
              <mxPoint x="1170" y="385" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- 3. PATH A: TRANSACTION SCRIPT & TABLE MODULE (BOTTOM LEFT) -->
        <mxCell id="pathA-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="455" width="695" x="80" y="385" as="geometry" />
        </mxCell>
        <mxCell id="pathA-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="PATH A: TRANSACTION SCRIPT &amp;amp; TABLE MODULE (DATA-CENTRIC)" vertex="1">
          <mxGeometry height="22" width="650" x="105" y="395" as="geometry" />
        </mxCell>
        <mxCell id="pathA-subtitle" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="Best for low-complexity business logic, reporting pipelines, and straightforward CRUD workflows" vertex="1">
          <mxGeometry height="18" width="650" x="105" y="417" as="geometry" />
        </mxCell>

        <mxCell id="pathA-box-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;spacingLeft=15;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Transaction Script Pattern&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Organizes business logic as a single procedural routine per request.&lt;br&gt;Directly executes calculations, database queries, and updates in linear sequence.&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="645" x="105" y="440" as="geometry" />
        </mxCell>

        <mxCell id="pathA-box-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;spacingLeft=15;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Table Module Pattern&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Single singleton instance encapsulates domain logic for an entire database table or view.&lt;br&gt;Operates directly over tabular RecordSets without per-row domain entity objects.&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="645" x="105" y="518" as="geometry" />
        </mxCell>

        <mxCell id="pathA-box-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;spacingLeft=15;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Table / Row Data Gateway&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Encapsulates SQL queries (&lt;i&gt;SELECT, INSERT, UPDATE&lt;/i&gt;) without domain abstractions.&lt;br&gt;Passes raw data structures and records straight to scripts and callers.&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="645" x="105" y="596" as="geometry" />
        </mxCell>

        <mxCell id="pathA-box-4" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Relational Database Schema &amp;amp; Tabular Records&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Database tables and columns directly dictate application structure · Tight schema coupling&lt;/font&gt;" vertex="1">
          <mxGeometry height="62" width="645" x="105" y="755" as="geometry" />
        </mxCell>

        <mxCell id="arrow-pathA-db" edge="1" parent="1" source="pathA-box-3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;" target="pathA-box-4" value="Direct SQL Execution &amp;amp; RecordSet Hydration">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- 4. PATH B: RICH DOMAIN MODEL (BOTTOM RIGHT) -->
        <mxCell id="pathB-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="455" width="705" x="815" y="385" as="geometry" />
        </mxCell>
        <mxCell id="pathB-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="PATH B: RICH DOMAIN MODEL (BEHAVIOR-CENTRIC)" vertex="1">
          <mxGeometry height="22" width="660" x="840" y="395" as="geometry" />
        </mxCell>
        <mxCell id="pathB-subtitle" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="Best for complex invariant enforcement, intricate domain rules, and evolving business behavior" vertex="1">
          <mxGeometry height="18" width="660" x="840" y="417" as="geometry" />
        </mxCell>

        <mxCell id="pathB-box-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;spacingLeft=12;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Domain Entities &amp;amp; Aggregates&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Identity-based objects encapsulating state mutations and invariant rules.&lt;br&gt;Root entities protect internal consistency boundaries.&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="410" x="840" y="440" as="geometry" />
        </mxCell>

        <mxCell id="pathB-box-vo" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Value Objects&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Immutable equality by value&lt;br&gt;&lt;i&gt;Money, DateRange, Unit&lt;/i&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="225" x="1270" y="440" as="geometry" />
        </mxCell>

        <mxCell id="pathB-box-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;spacingLeft=15;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Domain Services &amp;amp; Business Rules&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Stateless operations coordinating multiple domain entities without leaking persistence concerns.&lt;br&gt;Pure business logic completely decoupled from web frameworks, SQL, and database storage.&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="655" x="840" y="518" as="geometry" />
        </mxCell>

        <mxCell id="pathB-box-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;spacingLeft=15;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Repository Interface &amp;amp; Data Mapper Boundary&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Mediates between the in-memory domain graph and relational tables.&lt;br&gt;Domain entities remain completely unaware of database tables, columns, and SQL dialect.&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="655" x="840" y="596" as="geometry" />
        </mxCell>

        <mxCell id="pathB-box-4" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Relational Database Engine &amp;amp; Persistence Layer&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Decoupled storage target · Schema changes do not infect domain business models&lt;/font&gt;" vertex="1">
          <mxGeometry height="62" width="655" x="840" y="755" as="geometry" />
        </mxCell>

        <mxCell id="arrow-pathB-db" edge="1" parent="1" source="pathB-box-3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;" target="pathB-box-4" value="O/R Mapping, Identity Map &amp;amp; Unit of Work Commit">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
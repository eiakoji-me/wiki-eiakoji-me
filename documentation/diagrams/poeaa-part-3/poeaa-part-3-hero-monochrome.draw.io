<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-3-hero-flow" name="PoEAA Part III High-Level Flow">
    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- 1. LEFT PHASE HEADER -->
        <mxCell id="hdr-left" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. PRESENTATION TIER (REQUEST ROUTING &amp; WORKFLOW)" vertex="1">
          <mxGeometry height="36" width="560" x="80" y="38" as="geometry" />
        </mxCell>

        <!-- 2. RIGHT PHASE HEADER -->
        <mxCell id="hdr-right" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. DISTRIBUTION BOUNDARY &amp; DOMAIN" vertex="1">
          <mxGeometry height="36" width="560" x="960" y="38" as="geometry" />
        </mxCell>

        <!-- TOP LEFT: FRONT CONTROLLER -->
        <mxCell id="box-front" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#1E293B;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="170" width="560" x="80" y="90" as="geometry" />
        </mxCell>
        <mxCell id="title-front" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="FRONT CONTROLLER (CENTRAL DISPATCHER)" vertex="1">
          <mxGeometry height="30" width="560" x="80" y="102" as="geometry" />
        </mxCell>
        <mxCell id="text-front" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#1E293B;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Centralized Request Handler&lt;/b&gt;: Single entry point intercepting all incoming HTTP/web requests&lt;br&gt;&lt;b&gt;• Filter &amp;amp; Middleware Chains&lt;/b&gt;: Applies authentication, authorization, CORS, and request logging&lt;br&gt;&lt;b&gt;• Command Dispatching&lt;/b&gt;: Resolves and delegates to dedicated command handlers or actions&lt;br&gt;&lt;b&gt;• Modern Manifestations&lt;/b&gt;: Spring DispatcherServlet, Express routers, Next.js routing middleware&lt;/font&gt;" vertex="1">
          <mxGeometry height="120" width="560" x="80" y="132" as="geometry" />
        </mxCell>

        <!-- MIDDLE LEFT: APPLICATION CONTROLLER -->
        <mxCell id="box-appctrl" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#334155;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="170" width="560" x="80" y="360" as="geometry" />
        </mxCell>
        <mxCell id="title-appctrl" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="APPLICATION CONTROLLER (WORKFLOW ENGINE)" vertex="1">
          <mxGeometry height="30" width="560" x="80" y="372" as="geometry" />
        </mxCell>
        <mxCell id="text-appctrl" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#334155;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Screen Flow Decoupling&lt;/b&gt;: Extracts multi-step wizard and navigation logic out of UI view files&lt;br&gt;&lt;b&gt;• State Machine Coordinator&lt;/b&gt;: Manages business steps (&lt;i&gt;Cart → Shipping → Payment → Confirm&lt;/i&gt;)&lt;br&gt;&lt;b&gt;• Dynamic View Target Resolution&lt;/b&gt;: Selects next view based on application state and domain results&lt;br&gt;&lt;b&gt;• View-Model Assembly&lt;/b&gt;: Prepares presentation-ready models before handing off to the view layer&lt;/font&gt;" vertex="1">
          <mxGeometry height="115" width="560" x="80" y="405" as="geometry" />
        </mxCell>

        <!-- BOTTOM LEFT: TEMPLATE / TRANSFORM VIEW -->
        <mxCell id="box-view" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#E2E8F0;strokeColor=#475569;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="170" width="560" x="80" y="630" as="geometry" />
        </mxCell>
        <mxCell id="title-view" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="&lt;font style=&quot;font-size: 14px;&quot;&gt;TEMPLATE / TRANSFORM VIEW (PRESENTATION RENDERING)&lt;/font&gt;" vertex="1">
          <mxGeometry height="30" width="560" x="80" y="642" as="geometry" />
        </mxCell>
        <mxCell id="text-view" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#334155;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Template View (Component SSR)&lt;/b&gt;: Embeds markers in static markup (Astro, React JSX, ERB, JSP)&lt;br&gt;&lt;b&gt;• Transform View (Data Projections)&lt;/b&gt;: Transforms domain representations into wire payloads or JSON-LD&lt;br&gt;&lt;b&gt;• Zero Domain Leakage&lt;/b&gt;: View layer contains zero database queries, SQL strings, or business rules&lt;br&gt;&lt;b&gt;• Deterministic Output&lt;/b&gt;: Pure rendering function consuming immutable view models&lt;/font&gt;" vertex="1">
          <mxGeometry height="115" width="560" x="80" y="675" as="geometry" />
        </mxCell>

        <!-- LEFT ARROW: FRONT CTRL -> APP CTRL -->
        <mxCell id="arr-front-app" edge="1" parent="1" source="box-front" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="box-appctrl" value="Dispatches Action to Workflow State Machine">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- LEFT ARROW: APP CTRL -> TEMPLATE VIEW -->
        <mxCell id="arr-app-view" edge="1" parent="1" source="box-appctrl" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="box-view" value="Supplies View-Model to Resolved View Target">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- CENTER DIVIDER: FOWLER'S FIRST LAW (THE NETWORK CHASM) -->
        <mxCell id="box-chasm" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=8;" value="" vertex="1">
          <mxGeometry height="329" width="140" x="730" y="378" as="geometry" />
        </mxCell>
        <mxCell id="title-chasm" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;FOWLER&#39;S 1ST LAW&lt;/font&gt;" vertex="1">
          <mxGeometry height="23.5" width="125" x="737.5" y="387" as="geometry" />
        </mxCell>
        <mxCell id="quote-chasm" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=12;fontStyle=3;fontColor=#1E293B;fontFamily=Comic Sans MS;" value="&lt;font style=&quot;font-size: 9px;&quot;&gt;&quot;Don&#39;t Distribute&lt;br&gt;Your Objects!&quot;&lt;/font&gt;" vertex="1">
          <mxGeometry height="40" width="125" x="737.5" y="410.5" as="geometry" />
        </mxCell>
        <mxCell id="text-chasm" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=10;fontColor=#475569;fontFamily=Comic Sans MS;" value="&lt;font style=&quot;font-size: 8px;&quot;&gt;═══════════&lt;br&gt;&lt;b&gt;PROCESS &amp;amp; NETWORK&lt;br&gt;BOUNDARY&lt;/b&gt;&lt;br&gt;═══════════&lt;br&gt;• Latency penalty (100,000x)&lt;br&gt;• Serialization cost&lt;br&gt;• Partial failure risk&lt;br&gt;• Concurrency chasm&lt;br&gt;═══════════&lt;br&gt;&lt;i&gt;Coarse interfaces only;&lt;br&gt;keep entity graphs local.&lt;/i&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="150" width="125" x="737.5" y="467.5" as="geometry" />
        </mxCell>

        <!-- TOP RIGHT: REMOTE FACADE -->
        <mxCell id="box-facade" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#1E293B;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="160" width="560" x="960" y="90" as="geometry" />
        </mxCell>
        <mxCell id="title-facade" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="REMOTE FACADE (COARSE-GRAINED API)" vertex="1">
          <mxGeometry height="30" width="560" x="960" y="102" as="geometry" />
        </mxCell>
        <mxCell id="text-facade" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#1E293B;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Anti-Chatty Network Boundary&lt;/b&gt;: Consolidates dozens of fine-grained domain calls into single round trips&lt;br&gt;&lt;b&gt;• Coarse-Grained Protocol Contract&lt;/b&gt;: Optimized wire interface (REST / gRPC / GraphQL endpoints)&lt;br&gt;&lt;b&gt;• Bulk Transaction Boundary&lt;/b&gt;: Initiates and commits application transactions across remote sessions&lt;br&gt;&lt;b&gt;• Context Translation&lt;/b&gt;: Bridges client authentication and tenant headers into internal domain context&lt;/font&gt;" vertex="1">
          <mxGeometry height="120" width="560" x="960" y="125" as="geometry" />
        </mxCell>

        <!-- MIDDLE RIGHT: DATA TRANSFER OBJECT (DTO) -->
        <mxCell id="box-dto" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#334155;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="160" width="560" x="960" y="360" as="geometry" />
        </mxCell>
        <mxCell id="title-dto" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="DATA TRANSFER OBJECT (DTO WIRE CONTRACT)" vertex="1">
          <mxGeometry height="30" width="560" x="960" y="372" as="geometry" />
        </mxCell>
        <mxCell id="text-dto" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#334155;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Flat, Serializable Payloads&lt;/b&gt;: Dumb data carriers designed exclusively for wire serialization&lt;br&gt;&lt;b&gt;• Zero Business Logic&lt;/b&gt;: Contains getters/setters or raw values with zero domain behavioral methods&lt;br&gt;&lt;b&gt;• Cycle-Free Structures&lt;/b&gt;: Eliminates complex recursive object graph pointers (&lt;i&gt;order.customer.order...&lt;/i&gt;)&lt;br&gt;&lt;b&gt;• Versioning &amp;amp; Schema Shield&lt;/b&gt;: Protects internal database and entity schemas from leaking across APIs&lt;/font&gt;" vertex="1">
          <mxGeometry height="116.5" width="560" x="960" y="393.5" as="geometry" />
        </mxCell>

        <!-- BOTTOM RIGHT: IN-MEMORY DOMAIN -->
        <mxCell id="box-domain" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#E2E8F0;strokeColor=#475569;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="160" width="560" x="960" y="630" as="geometry" />
        </mxCell>
        <mxCell id="title-domain" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=16;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="IN-MEMORY DOMAIN GRAPH" vertex="1">
          <mxGeometry height="30" width="560" x="960" y="642" as="geometry" />
        </mxCell>
        <mxCell id="text-domain" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontColor=#334155;fontFamily=Comic Sans MS;spacingLeft=25;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Rich Aggregate Roots &amp;amp; Entities&lt;/b&gt;: Encapsulate business invariants, validations, and state machines&lt;br&gt;&lt;b&gt;• Fine-Grained Behavioral Methods&lt;/b&gt;: Traverses cyclic in-memory references (&lt;i&gt;order.applyDiscount()&lt;/i&gt;)&lt;br&gt;&lt;b&gt;• Zero Wire Knowledge&lt;/b&gt;: Domain model remains completely pure, with no knowledge of HTTP, DTOs, or RPC&lt;br&gt;&lt;b&gt;• Assembler / Mapper Isolation&lt;/b&gt;: Transforms between flat DTOs and rich entities at the boundary&lt;/font&gt;" vertex="1">
          <mxGeometry height="120" width="560" x="960" y="665" as="geometry" />
        </mxCell>

        <!-- RIGHT ARROW: REMOTE FACADE -> DTO -->
        <mxCell id="arr-facade-dto" edge="1" parent="1" source="box-facade" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;startArrow=block;endFill=1;startFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="box-dto" value="Serializes Return Payloads ⟷ Parses Requests">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- RIGHT ARROW: DTO -> DOMAIN GRAPH -->
        <mxCell id="arr-dto-domain" edge="1" parent="1" source="box-dto" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;startArrow=block;endFill=1;startFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="box-domain" value="Assembler Hydrates Entities ⟷ Extracts DTO State">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1240" y="600" />
              <mxPoint x="1240" y="600" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- CROSS-TIER ARROWS -->
        <!-- Front Controller -> Remote Facade across top -->
        <mxCell id="arr-front-facade" edge="1" parent="1" source="box-front" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;exitX=1;exitY=0.35;exitDx=0;exitDy=0;entryX=0;entryY=0.35;entryDx=0;entryDy=0;" target="box-facade" value="Coarse-Grained API Request">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- App Controller <-> DTO across middle through chasm -->
        <mxCell id="arr-app-dto" edge="1" parent="1" source="box-appctrl" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;startArrow=block;endFill=1;startFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;exitX=1;exitY=0.5;exitDx=0;exitDy=0;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" target="box-dto" value="Exchanges Immutable DTOs">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
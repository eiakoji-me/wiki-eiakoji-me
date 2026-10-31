<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-4-hero-flow" name="PoEAA Part IV Concurrency and Session State">
    <mxGraphModel dx="1945" dy="1000" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="hdr-col1" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. THE CONCURRENCY CHASM" vertex="1">
          <mxGeometry height="36" width="450" x="70" y="38" as="geometry" />
        </mxCell>
        <mxCell id="hdr-col2" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. OFFLINE LOCKING STRATEGIES" vertex="1">
          <mxGeometry height="36" width="450" x="575" y="38" as="geometry" />
        </mxCell>
        <mxCell id="hdr-col3" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="3. STATE &amp; RESILIENT FOUNDATION" vertex="1">
          <mxGeometry height="36" width="450" x="1080" y="38" as="geometry" />
        </mxCell>
        <mxCell id="box-think" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#1E293B;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="183" width="450" x="70" y="88" as="geometry" />
        </mxCell>
        <mxCell id="title-think" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="BUSINESS TRANSACTIONS (MINUTES)" vertex="1">
          <mxGeometry height="30" width="450" x="70" y="100" as="geometry" />
        </mxCell>
        <mxCell id="text-think" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontColor=#1E293B;fontFamily=Comic Sans MS;spacingLeft=18;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Human Decision Time&lt;/b&gt;: Multi-step user booking, catalog browsing &amp;amp; data entry&lt;br&gt;&lt;b&gt;• Disconnected HTTP Requests&lt;/b&gt;: Multiple distinct request/response round-trips&lt;br&gt;&lt;b&gt;• Zero Cross-Request Locks&lt;/b&gt;: Never hold JDBC connections across human think-time&lt;br&gt;&lt;b&gt;• Resource Starvation Trap&lt;/b&gt;: Holding DB connections causes HikariCP pool exhaustion&lt;/font&gt;" vertex="1">
          <mxGeometry height="111" width="450" x="80" y="130" as="geometry" />
        </mxCell>
        <mxCell id="box-chasm" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=8;" value="" vertex="1">
          <mxGeometry height="183" width="450" x="70" y="400" as="geometry" />
        </mxCell>
        <mxCell id="title-chasm" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="THE OFFLINE CONCURRENCY CHASM" vertex="1">
          <mxGeometry height="30" width="450" x="70" y="405" as="geometry" />
        </mxCell>
        <mxCell id="quote-chasm" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontStyle=3;fontColor=#1E293B;fontFamily=Comic Sans MS;" value="&quot;System transactions must be short; business transactions are long.&quot;" vertex="1">
          <mxGeometry height="26" width="450" x="70" y="435" as="geometry" />
        </mxCell>
        <mxCell id="text-chasm" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontColor=#475569;fontFamily=Comic Sans MS;spacingLeft=18;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Physical Incompatibility&lt;/b&gt;: Relational ACID boundary != Multi-screen user session&lt;br&gt;&lt;b&gt;• Cascading Failures&lt;/b&gt;: Hanging worker threads lead to cascading service restarts&lt;br&gt;&lt;b&gt;• Isolation Boundary&lt;/b&gt;: Application-level locks must bridge the disconnected steps&lt;br&gt;&lt;b&gt;• Reversible Failure&lt;/b&gt;: Stale edits must abort safely without corrupting shared state&lt;/font&gt;" vertex="1">
          <mxGeometry height="98" width="450" x="70" y="460" as="geometry" />
        </mxCell>
        <mxCell id="box-acid" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#E2E8F0;strokeColor=#475569;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="175" width="450" x="70" y="678" as="geometry" />
        </mxCell>
        <mxCell id="title-acid" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="ACID SYSTEM TRANSACTIONS (MILLISECONDS)" vertex="1">
          <mxGeometry height="30" width="450" x="70" y="688" as="geometry" />
        </mxCell>
        <mxCell id="text-acid" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontColor=#334155;fontFamily=Comic Sans MS;spacingLeft=18;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Sub-Second Execution&lt;/b&gt;: Spring @Transactional boundaries scoped to single requests&lt;br&gt;&lt;b&gt;• ACID Guarantees&lt;/b&gt;: Atomicity, Consistency, Isolation, Durability at storage engine&lt;br&gt;&lt;b&gt;• Short Connection Leases&lt;/b&gt;: Borrow from pool, update, commit, return immediately&lt;br&gt;&lt;b&gt;• Verification Point&lt;/b&gt;: Offline tokens evaluated atomically during commit phase&lt;/font&gt;" vertex="1">
          <mxGeometry height="98" width="450" x="70" y="730" as="geometry" />
        </mxCell>
        <mxCell id="arr-think-chasm" edge="1" parent="1" source="box-think" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="box-chasm" value="Spans Multiple HTTP Calls">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-chasm-acid" edge="1" parent="1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" value="Commits In Microsecond Burst">
          <mxGeometry relative="1" as="geometry">
            <mxPoint x="194" y="583" as="sourcePoint" />
            <mxPoint x="194" y="678" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="box-opt" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#1E293B;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="183" width="450" x="575" y="88" as="geometry" />
        </mxCell>
        <mxCell id="title-opt" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="OPTIMISTIC OFFLINE LOCK (@Version)" vertex="1">
          <mxGeometry height="30" width="450" x="575" y="100" as="geometry" />
        </mxCell>
        <mxCell id="text-opt" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontColor=#1E293B;fontFamily=Comic Sans MS;spacingLeft=18;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Non-Blocking Validation&lt;/b&gt;: Detects concurrent overwrites without holding locks&lt;br&gt;&lt;b&gt;• JPA @Version Mechanics&lt;/b&gt;: WHERE id = :id AND version = :clientVersion&lt;br&gt;&lt;b&gt;• Low-Contention Fit&lt;/b&gt;: Highly scalable when conflict probabilities remain low&lt;br&gt;&lt;b&gt;• Conflict Reconciliation&lt;/b&gt;: Spring OptimisticLockingFailureException -&gt; HTTP 409&lt;/font&gt;" vertex="1">
          <mxGeometry height="128" width="450" x="575" y="121.5" as="geometry" />
        </mxCell>
        <mxCell id="box-pess" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#334155;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="183" width="450" x="575" y="400" as="geometry" />
        </mxCell>
        <mxCell id="title-pess" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="PESSIMISTIC OFFLINE LEASE (REDIS TTL)" vertex="1">
          <mxGeometry height="30" width="450" x="575" y="419" as="geometry" />
        </mxCell>
        <mxCell id="text-pess" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontColor=#334155;fontFamily=Comic Sans MS;spacingLeft=18;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• High-Contention Defense&lt;/b&gt;: Reserves scarce resources (hotel rooms, concert seats)&lt;br&gt;&lt;b&gt;• Time-Bounded Lease&lt;/b&gt;: SET lock:room:101 session_id NX PX 600000 (10 min TTL)&lt;br&gt;&lt;b&gt;• Safe Atomic Release&lt;/b&gt;: Lua script guarantees only lock owner can release key&lt;br&gt;&lt;b&gt;• Heartbeat Renewal&lt;/b&gt;: Extends expiration during active multi-step browser session&lt;/font&gt;" vertex="1">
          <mxGeometry height="87.5" width="450" x="575" y="470.5" as="geometry" />
        </mxCell>
        <mxCell id="box-coarse" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#E2E8F0;strokeColor=#475569;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="175" width="450" x="575" y="678" as="geometry" />
        </mxCell>
        <mxCell id="title-coarse" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="COARSE-GRAINED AGGREGATE LOCK" vertex="1">
          <mxGeometry height="30" width="450" x="575" y="690" as="geometry" />
        </mxCell>
        <mxCell id="text-coarse" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontColor=#334155;fontFamily=Comic Sans MS;spacingLeft=18;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Aggregate Protection&lt;/b&gt;: Locks root entity to protect all child items from race conditions&lt;br&gt;&lt;b&gt;• Eliminates Phantom Edits&lt;/b&gt;: Prevents simultaneous child additions without root version bump&lt;br&gt;&lt;b&gt;• OPTIMISTIC_FORCE_INCREMENT&lt;/b&gt;: JPA increments root version on child mutations&lt;br&gt;&lt;b&gt;• Unit of Work Scope&lt;/b&gt;: Coordinates aggregate consistency across transaction boundaries&lt;/font&gt;" vertex="1">
          <mxGeometry height="87.5" width="450" x="575" y="735.5" as="geometry" />
        </mxCell>
        <mxCell id="arr-opt-pess" edge="1" parent="1" source="box-opt" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;startArrow=block;endFill=1;startFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="box-pess" value="Hybrid Strategy: Pre-Hold + Version Check">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-pess-coarse" edge="1" parent="1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" value="Protects Child Graph During Commit">
          <mxGeometry relative="1" as="geometry">
            <mxPoint x="901" y="583" as="sourcePoint" />
            <mxPoint x="901" y="678" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="box-session" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#1E293B;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="183" width="450" x="1080" y="88" as="geometry" />
        </mxCell>
        <mxCell id="title-session" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="DISTRIBUTED SESSION HUB (REDIS)" vertex="1">
          <mxGeometry height="30" width="450" x="1080" y="100" as="geometry" />
        </mxCell>
        <mxCell id="text-session" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontColor=#1E293B;fontFamily=Comic Sans MS;spacingLeft=18;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Stateless Web Containers&lt;/b&gt;: Externalizes session state away from JVM heaps&lt;br&gt;&lt;b&gt;• Zero Sticky Sessions&lt;/b&gt;: Any cluster instance serves any incoming HTTP request&lt;br&gt;&lt;b&gt;• Rolling Deploy Safety&lt;/b&gt;: Node restarts &amp;amp; autoscaling events never drop checkout state&lt;br&gt;&lt;b&gt;• Central Invalidation&lt;/b&gt;: Instantaneous revocation upon checkout completion or logout&lt;/font&gt;" vertex="1">
          <mxGeometry height="128" width="450" x="1080" y="121.5" as="geometry" />
        </mxCell>
        <mxCell id="box-gateway" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#334155;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="183" width="450" x="1080" y="400" as="geometry" />
        </mxCell>
        <mxCell id="title-gateway" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="RESILIENT GATEWAY (RestClient BOUNDARY)" vertex="1">
          <mxGeometry height="30" width="450" x="1080" y="419" as="geometry" />
        </mxCell>
        <mxCell id="text-gateway" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontColor=#334155;fontFamily=Comic Sans MS;spacingLeft=18;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Encapsulated Third-Party APIs&lt;/b&gt;: Bridges to external GDS, inventory &amp;amp; payment networks&lt;br&gt;&lt;b&gt;• Strict Timeout Budgets&lt;/b&gt;: Spring 6 RestClient with connect (1s) &amp;amp; read (3s) limits&lt;br&gt;&lt;b&gt;• Circuit Breaker Isolation&lt;/b&gt;: Resilience4j fails fast to prevent worker pool saturation&lt;br&gt;&lt;b&gt;• Intention-Revealing Contract&lt;/b&gt;: Domain invokes pure interface; wire protocol is hidden&lt;/font&gt;" vertex="1">
          <mxGeometry height="87.5" width="450" x="1080" y="470.5" as="geometry" />
        </mxCell>
        <mxCell id="box-plugin" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#E2E8F0;strokeColor=#475569;strokeWidth=2;arcSize=8;" value="" vertex="1">
          <mxGeometry height="175" width="450" x="1080" y="678" as="geometry" />
        </mxCell>
        <mxCell id="title-plugin" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=15;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="PLUGIN &amp; SEPARATED INTERFACE" vertex="1">
          <mxGeometry height="30" width="450" x="1080" y="688" as="geometry" />
        </mxCell>
        <mxCell id="text-plugin" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontColor=#334155;fontFamily=Comic Sans MS;spacingLeft=18;" value="&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;b&gt;• Contract in Domain Package&lt;/b&gt;: Inversion of Control decoupled from implementations&lt;br&gt;&lt;b&gt;• Infrastructure Modules&lt;/b&gt;: StripePaymentGateway, GdsInventoryGateway, MockStubs&lt;br&gt;&lt;b&gt;• Spring Bean Resolution&lt;/b&gt;: @ConditionalOnProperty swaps providers without code edits&lt;br&gt;&lt;b&gt;• Special Case / Null Object&lt;/b&gt;: Polymorphic anonymous &amp;amp; zero-discount implementations&lt;/font&gt;" vertex="1">
          <mxGeometry height="98" width="450" x="1080" y="731.25" as="geometry" />
        </mxCell>
        <mxCell id="arr-session-gw" edge="1" parent="1" source="box-session" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="box-gateway" value="Feeds Token &amp; State to Gateway">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-gw-plugin" edge="1" parent="1" source="box-gateway" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="box-plugin" value="Dynamically Binds Provider Bean">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-chasm-pess" edge="1" parent="1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" value="Acquires Lease During Think Time">
          <mxGeometry relative="1" x="0.0222" as="geometry">
            <mxPoint as="offset" />
            <Array as="points">
              <mxPoint x="320" y="640" />
              <mxPoint x="730" y="640" />
            </Array>
            <mxPoint x="320" y="590" as="sourcePoint" />
            <mxPoint x="730" y="590" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="arr-pess-session" edge="1" parent="1" source="box-pess" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;startArrow=block;endFill=1;startFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;entryX=0;entryY=0.413;entryDx=0;entryDy=0;entryPerimeter=0;" target="text-session" value="Coordinates Lease with Session State">
          <mxGeometry relative="1" as="geometry">
            <mxPoint x="1060" y="220" as="targetPoint" />
          </mxGeometry>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

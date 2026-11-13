<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-7-wiretap-and-controlbus" name="Wire Tap Non-Intrusive Interception and Control Bus Dynamic Detour">
    <mxGraphModel dx="1500" dy="750" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1500" pageHeight="750" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- MAIN CONTAINER -->
        <mxCell id="main-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="670" width="1420" x="40" y="40" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="TELEMETRY &amp;amp; CONTROL: NON-INTRUSIVE WIRE TAP AND CONTROL BUS DYNAMIC DETOUR" vertex="1">
          <mxGeometry height="24" width="1000" x="65" y="52" as="geometry" />
        </mxCell>

        <!-- TOP HALF: PASSIVE WIRE TAP INTERCEPTION -->
        <mxCell id="tap-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="1370" x="65" y="90" as="geometry" />
        </mxCell>
        <mxCell id="tap-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="A. PASSIVE WIRE TAP ARCHITECTURE: ZERO-CONTENTION AUDIT LOGGING" vertex="1">
          <mxGeometry height="22" width="600" x="80" y="98" as="geometry" />
        </mxCell>

        <!-- Ingress Channel -->
        <mxCell id="tap-chan-in" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Inbound Channel&lt;/b&gt;&lt;br&gt;Live Production Stream" vertex="1">
          <mxGeometry height="60" width="150" x="85" y="140" as="geometry" />
        </mxCell>

        <!-- Wire Tap Component -->
        <mxCell id="tap-core" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Wire Tap Interceptor&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Channel Interceptor hook&lt;br&gt;Atomic publish clone&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="180" x="290" y="140" as="geometry" />
        </mxCell>

        <!-- Primary Path -->
        <mxCell id="tap-primary" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Primary Processing Pipeline&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Direct Zero-Copy Forwarding&lt;br&gt;SLA Latency Target: &amp;lt; 5ms&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="220" x="540" y="140" as="geometry" />
        </mxCell>

        <!-- Non-Blocking Buffer -->
        <mxCell id="tap-buffer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Non-Blocking Ring Buffer&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Bounded in-memory queue&lt;br&gt;Drop-on-Full policy on surge&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="220" x="540" y="235" as="geometry" />
        </mxCell>

        <!-- Audit Store -->
        <mxCell id="tap-store" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Immutable Message Store&lt;/b&gt;&lt;br&gt;Object Store / Parquet / S3&lt;br&gt;Long-term compliance &amp;amp; replay" vertex="1">
          <mxGeometry height="70" width="200" x="830" y="230" as="geometry" />
        </mxCell>

        <!-- Metrics Sink -->
        <mxCell id="tap-metrics" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Prometheus / Telemetry Sink&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Message sizes &amp;bull; Schema versions&lt;br&gt;Throughput &amp;amp; Arrival Rates&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="230" x="1100" y="235" as="geometry" />
        </mxCell>

        <!-- Arrows in Top Section -->
        <mxCell id="arr-in-tap" edge="1" parent="1" source="tap-chan-in" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="tap-core">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-tap-pri" edge="1" parent="1" source="tap-core" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="tap-primary">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-tap-buf" edge="1" parent="1" source="tap-core" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;dashed=1;endArrow=block;endFill=1;" target="tap-buffer">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="380" y="265" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="arr-buf-store" edge="1" parent="1" source="tap-buffer" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="tap-store">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-store-met" edge="1" parent="1" source="tap-store" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="tap-metrics">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- BOTTOM HALF: ACTIVE CONTROL BUS & DYNAMIC DETOUR -->
        <mxCell id="ctrl-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="330" width="1370" x="65" y="365" as="geometry" />
        </mxCell>
        <mxCell id="ctrl-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="B. CONTROL BUS &amp;amp; DYNAMIC DETOUR: RUNTIME TOPOLOGY RECONFIGURATION" vertex="1">
          <mxGeometry height="22" width="650" x="80" y="373" as="geometry" />
        </mxCell>

        <!-- Control Plane Box -->
        <mxCell id="ctrl-plane" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Control Plane / SRE Console&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Admin Commands:&lt;br&gt;ACTIVATE_DETOUR, FLUSH_DLQ&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="200" x="85" y="410" as="geometry" />
        </mxCell>

        <!-- Control Bus Channel -->
        <mxCell id="ctrl-bus-chan" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Architectural Control Bus&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Dedicated administrative topic&lt;br&gt;Isolated from business queues&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="220" x="340" y="410" as="geometry" />
        </mxCell>

        <!-- Smart Proxy / Detour Router -->
        <mxCell id="ctrl-detour" parent="1" style="rhombus;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Detour Active?&lt;/b&gt;&lt;br&gt;Atomic boolean flag" vertex="1">
          <mxGeometry height="80" width="160" x="630" y="402" as="geometry" />
        </mxCell>

        <!-- Normal Flow -->
        <mxCell id="ctrl-normal" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Normal Production Worker&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Fast execution path&lt;/font&gt;" vertex="1">
          <mxGeometry height="55" width="210" x="860" y="390" as="geometry" />
        </mxCell>

        <!-- Diagnostic Detour -->
        <mxCell id="ctrl-diag" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Diagnostic Detour Inspector&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Deep schema validation &amp;bull; Payload trace&lt;br&gt;Simulated canary evaluation&lt;/font&gt;" vertex="1">
          <mxGeometry height="55" width="240" x="860" y="465" as="geometry" />
        </mxCell>

        <!-- DLQ Redrive Orchestrator -->
        <mxCell id="ctrl-dlq-redrive" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;DLQ Redrive Loop&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Rate Limiter: Leaky Bucket&lt;br&gt;Idempotent Fence Check&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="200" x="1170" y="412" as="geometry" />
        </mxCell>

        <!-- Bottom Shaded Policy Box with White Label Background -->
        <mxCell id="ctrl-policy" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;&amp;nbsp;&amp;nbsp;OPERATIONAL POLICY ENFORCEMENT &amp;amp; INVARIANTS:&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#000000&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;bull; &lt;b&gt;Wire Tap Backpressure Isolation:&lt;/b&gt; Wire Tap buffer capacity K bounds maximum memory. Buffer saturation drops tap events, preserving primary SLA.&lt;br&gt;&amp;nbsp;&amp;nbsp;&amp;bull; &lt;b&gt;Dynamic Detour Hot-Swapping:&lt;/b&gt; Control Bus broadcasts reconfiguration events to all live proxy instances without requiring service restarts or redeployments.&lt;br&gt;&amp;nbsp;&amp;nbsp;&amp;bull; &lt;b&gt;DLQ Redrive Safety:&lt;/b&gt; Poison pills must be quarantined or remediated before redrive to prevent recurring crash loops. Redrive rate must not exceed 10% of channel capacity.&lt;/font&gt;" vertex="1">
          <mxGeometry height="90" width="1335" x="80" y="585" as="geometry" />
        </mxCell>

        <!-- Arrows in Bottom Section -->
        <mxCell id="arr-cmd-bus" edge="1" parent="1" source="ctrl-plane" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="ctrl-bus-chan">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-bus-detour" edge="1" parent="1" source="ctrl-bus-chan" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="ctrl-detour">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-detour-norm" edge="1" parent="1" source="ctrl-detour" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="ctrl-normal">
          <mxGeometry relative="1" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="arr-detour-diag" edge="1" parent="1" source="ctrl-detour" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;dashed=1;endArrow=block;endFill=1;" target="ctrl-diag">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="710" y="492" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="arr-diag-redrive" edge="1" parent="1" source="ctrl-diag" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="ctrl-dlq-redrive">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1130" y="492" />
              <mxPoint x="1130" y="442" />
            </Array>
          </mxGeometry>
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

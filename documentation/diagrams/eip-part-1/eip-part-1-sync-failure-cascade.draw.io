<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-1-sync-failure-cascade" name="Synchronous Failure Cascades and Thread Starvation">
    <mxGraphModel dx="1200" dy="650" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="650" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- LEFT PANEL: HEALTHY EQUILIBRIUM -->
        <mxCell id="h-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="570" width="530" x="50" y="40" as="geometry" />
        </mxCell>
        <mxCell id="h-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="STATE A: HEALTHY EQUILIBRIUM (75% HEADROOM)" vertex="1">
          <mxGeometry height="24" width="480" x="70" y="55" as="geometry" />
        </mxCell>

        <!-- Healthy Ingress -->
        <mxCell id="h-client" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Inbound Traffic&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;λ = 1,000 req/sec&lt;/font&gt;" vertex="1">
          <mxGeometry height="55" width="130" x="70" y="100" as="geometry" />
        </mxCell>
        <mxCell id="h-gw" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Order Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Pool: 200 Worker Threads&lt;/font&gt;" vertex="1">
          <mxGeometry height="55" width="160" x="235" y="100" as="geometry" />
        </mxCell>
        <mxCell id="h-dep" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Inventory Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;W = 50ms latency&lt;/font&gt;" vertex="1">
          <mxGeometry height="55" width="130" x="430" y="100" as="geometry" />
        </mxCell>

        <mxCell id="h-arr1" edge="1" parent="1" source="h-client" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="h-gw">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="h-arr2" edge="1" parent="1" source="h-gw" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="h-dep">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Healthy Thread Allocation Visualization -->
        <mxCell id="h-pool-bg" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;" value="" vertex="1">
          <mxGeometry height="180" width="490" x="70" y="180" as="geometry" />
        </mxCell>
        <mxCell id="h-pool-label" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="Worker Thread Pool Capacity: 200 Threads" vertex="1">
          <mxGeometry height="20" width="450" x="90" y="190" as="geometry" />
        </mxCell>
        <mxCell id="h-pool-active" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#334155;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#FFFFFF;fontSize=11;fontStyle=1;fontFamily=Comic Sans MS;" value="Active: 50 Threads (25%)" vertex="1">
          <mxGeometry height="40" width="115" x="90" y="220" as="geometry" />
        </mxCell>
        <mxCell id="h-pool-free" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#94A3B8;strokeWidth=1.5;dashed=1;dashPattern=4 4;fontColor=#64748B;fontSize=11;fontFamily=Comic Sans MS;" value="Available Headroom: 150 Threads (75%)" vertex="1">
          <mxGeometry height="40" width="335" x="215" y="220" as="geometry" />
        </mxCell>
        <mxCell id="h-math-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=left;spacingLeft=10;" value="&lt;b&gt;Little&#39;s Law Calculation:&lt;/b&gt;&lt;br&gt;L = λ × W = 1,000 req/sec × 0.050 sec = &lt;b&gt;50 concurrent threads&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;• Mean Latency: 50ms | Thread Utilization: 25% | Queue Delay: 0ms&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="450" x="90" y="275" as="geometry" />
        </mxCell>

        <mxCell id="h-outcome" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;System Behavior:&lt;/b&gt;&lt;br&gt;The service smoothly absorbs fluctuations. Threads return instantly to the idle pool upon downstream response. Requests complete with sub-second turnaround." vertex="1">
          <mxGeometry height="140" width="480" x="70" y="380" as="geometry" />
        </mxCell>

        <!-- RIGHT PANEL: DEGRADED CASCADE -->
        <mxCell id="d-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="570" width="530" x="620" y="40" as="geometry" />
        </mxCell>
        <mxCell id="d-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="STATE B: TAIL LATENCY DEGRADATION (THREAD STARVATION)" vertex="1">
          <mxGeometry height="24" width="480" x="640" y="55" as="geometry" />
        </mxCell>

        <!-- Degraded Ingress -->
        <mxCell id="d-client" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Inbound Traffic&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;λ = 1,000 req/sec&lt;/font&gt;" vertex="1">
          <mxGeometry height="55" width="130" x="640" y="100" as="geometry" />
        </mxCell>
        <mxCell id="d-gw" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=2;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Order Service&lt;/b&gt;&lt;br&gt;&lt;b style=&quot;color:#0F172A;&quot;&gt;[!] POOL SATURATED&lt;/b&gt;" vertex="1">
          <mxGeometry height="55" width="160" x="805" y="100" as="geometry" />
        </mxCell>
        <mxCell id="d-dep" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Inventory Service&lt;/b&gt;&lt;br&gt;&lt;b style=&quot;color:#0F172A;&quot;&gt;W = 500ms (10× Latency)&lt;/b&gt;" vertex="1">
          <mxGeometry height="55" width="150" x="980" y="100" as="geometry" />
        </mxCell>

        <mxCell id="d-arr1" edge="1" parent="1" source="d-client" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="d-gw">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="d-arr2" edge="1" parent="1" source="d-gw" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="d-dep">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Degraded Thread Allocation Visualization -->
        <mxCell id="d-pool-bg" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;" value="" vertex="1">
          <mxGeometry height="180" width="490" x="640" y="180" as="geometry" />
        </mxCell>
        <mxCell id="d-pool-label" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="Worker Thread Pool Capacity: 200 Threads" vertex="1">
          <mxGeometry height="20" width="450" x="660" y="190" as="geometry" />
        </mxCell>
        <mxCell id="d-pool-active" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#0F172A;strokeColor=#0F172A;strokeWidth=2;fontColor=#FFFFFF;fontSize=11;fontStyle=1;fontFamily=Comic Sans MS;" value="BLOCKED: 200 Threads (100% Saturated)" vertex="1">
          <mxGeometry height="40" width="450" x="660" y="220" as="geometry" />
        </mxCell>
        <mxCell id="d-math-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=left;spacingLeft=10;" value="&lt;b&gt;Little&#39;s Law Demand vs Pool Ceiling:&lt;/b&gt;&lt;br&gt;Required L = λ × W = 1,000 req/sec × 0.500 sec = &lt;b&gt;500 threads needed&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#0F172A&quot;&gt;&lt;b&gt;Deficit:&lt;/b&gt; +300 threads beyond hard pool capacity (Saturates in &amp;lt; 300ms)&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="450" x="660" y="275" as="geometry" />
        </mxCell>

        <mxCell id="d-outcome" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Cascading Failure Mechanics:&lt;/b&gt;&lt;br&gt;1. Sockets queue on OS TCP backlog until net.core.somaxconn overflows.&lt;br&gt;2. Inbound requests are dropped or rejected with HTTP 504 Gateway Timeout.&lt;br&gt;3. Upstream API Gateway exhausts its own thread pool waiting on Order Service.&lt;br&gt;&lt;b&gt;The entire synchronous topology collapses from a single edge latency hiccup.&lt;/b&gt;" vertex="1">
          <mxGeometry height="140" width="480" x="640" y="380" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
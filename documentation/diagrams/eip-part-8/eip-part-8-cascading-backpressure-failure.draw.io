<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-8-cascading-backpressure-failure" name="Anatomy of Integration Cascading Failure and Defense in Depth">
    <mxGraphModel dx="1500" dy="750" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1500" pageHeight="750" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- MAIN CONTAINER -->
        <mxCell id="main-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="670" width="1420" x="40" y="40" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="ANATOMY OF INTEGRATION CASCADING FAILURE VS. ARCHITECTURAL DEFENSE IN DEPTH" vertex="1">
          <mxGeometry height="24" width="1000" x="65" y="52" as="geometry" />
        </mxCell>

        <!-- TOP SECTION: THE UNPROTECTED CASCADING COLLAPSE -->
        <mxCell id="top-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFF1F2;strokeColor=#E11D48;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="250" width="1370" x="65" y="90" as="geometry" />
        </mxCell>
        <mxCell id="top-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#E11D48;fontFamily=Comic Sans MS;" value="PATHOLOGY: UNCONSTRAINED BUFFERS &amp;amp; CASCADING OUTAGE CASCADE" vertex="1">
          <mxGeometry height="20" width="600" x="85" y="98" as="geometry" />
        </mxCell>

        <!-- Sequence of Collapse -->
        <mxCell id="col-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#E11D48;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;1. Downstream Outage&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;DB slow query or 3rd party API&lt;br&gt;Processing latency spikes 100x&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="85" y="130" as="geometry" />
        </mxCell>

        <mxCell id="col-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#E11D48;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;2. Consumer Starvation&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Worker thread pool exhausted&lt;br&gt;Lag L(t) explodes exponentially&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="365" y="130" as="geometry" />
        </mxCell>

        <mxCell id="col-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#E11D48;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;3. Buffer Saturation&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Queue fills without backpressure&lt;br&gt;JVM memory exceeds heap: OOM Crash&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="645" y="130" as="geometry" />
        </mxCell>

        <mxCell id="col-4" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#E11D48;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;4. Upstream Block&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Producers stall on full queue&lt;br&gt;TCP connections pile up&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="925" y="130" as="geometry" />
        </mxCell>

        <mxCell id="col-5" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#E11D48;strokeWidth=2;fontColor=#E11D48;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;5. Gateway 503 Collapse&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#E11D48&quot;&gt;Ingress API crashes entirely&lt;br&gt;Complete systemic blackout&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="210" x="1205" y="130" as="geometry" />
        </mxCell>

        <!-- Red Cascading Arrows -->
        <mxCell id="arr-c1-c2" edge="1" parent="1" source="col-1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#E11D48;strokeWidth=1.8;endArrow=block;endFill=1;" target="col-2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-c2-c3" edge="1" parent="1" source="col-2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#E11D48;strokeWidth=1.8;endArrow=block;endFill=1;" target="col-3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-c3-c4" edge="1" parent="1" source="col-3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#E11D48;strokeWidth=1.8;endArrow=block;endFill=1;" target="col-4">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-c4-c5" edge="1" parent="1" source="col-4" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#E11D48;strokeWidth=1.8;endArrow=block;endFill=1;" target="col-5">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="top-summary" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#881337;fontFamily=Comic Sans MS;" value="Consequence: Without backpressure isolation, a single degraded dependency brings down the entire enterprise ingress surface." vertex="1">
          <mxGeometry height="20" width="1300" x="85" y="210" as="geometry" />
        </mxCell>

        <!-- BOTTOM SECTION: DEFENSE IN DEPTH -->
        <mxCell id="bot-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="250" width="1370" x="65" y="360" as="geometry" />
        </mxCell>
        <mxCell id="bot-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="REMEDIATION: ARCHITECTURAL DEFENSE IN DEPTH &amp;amp; FAULT ISOLATION" vertex="1">
          <mxGeometry height="20" width="600" x="85" y="368" as="geometry" />
        </mxCell>

        <!-- Defense Components -->
        <mxCell id="def-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;1. Bounded Buffers&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Finite queue capacity K&lt;br&gt;Immediate Drop-on-Full&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="85" y="405" as="geometry" />
        </mxCell>

        <mxCell id="def-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;2. Circuit Breaker&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Trips upon error threshold&lt;br&gt;Fails fast in &amp;lt; 1ms&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="365" y="405" as="geometry" />
        </mxCell>

        <mxCell id="def-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;3. Dead-Letter Quarantine&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Poison pills isolated to DLQ&lt;br&gt;Channel drains normally&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="645" y="405" as="geometry" />
        </mxCell>

        <mxCell id="def-4" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;4. Dynamic Detour Switch&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Control Bus flips routing&lt;br&gt;Bypasses failing nodes&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="925" y="405" as="geometry" />
        </mxCell>

        <mxCell id="def-5" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;5. Upstream Resiliency&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Ingress API maintains SLA&lt;br&gt;Degraded but OPERATIONAL&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="210" x="1205" y="405" as="geometry" />
        </mxCell>

        <!-- Black Resilient Arrows -->
        <mxCell id="arr-d1-d2" edge="1" parent="1" source="def-1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="def-2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-d2-d3" edge="1" parent="1" source="def-2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="def-3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-d3-d4" edge="1" parent="1" source="def-3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="def-4">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-d4-d5" edge="1" parent="1" source="def-4" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="def-5">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- FOOTER SHADED INVARIANT BOX -->
        <mxCell id="def-footer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;arcSize=6;" value="" vertex="1">
          <mxGeometry height="80" width="1335" x="80" y="500" as="geometry" />
        </mxCell>
        <mxCell id="def-foot-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontStyle=1;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontFamily=Comic Sans MS;" value="MATHEMATICAL CRITICAL SATURATION THRESHOLD (M/M/1 POLE):" vertex="1">
          <mxGeometry height="18" width="600" x="95" y="508" as="geometry" />
        </mxCell>
        <mxCell id="def-foot-text" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontFamily=Comic Sans MS;" value="When arrival rate approaches processing capacity (rho = lambda / mu -&gt; 1), queue length L_q = rho^2 / (1 - rho) diverges toward infinity.&lt;br&gt;Without strict buffer bounds, queue residence time explodes asymptotically, transforming temporary network hiccups into fatal cascading outages." vertex="1">
          <mxGeometry height="40" width="1300" x="95" y="528" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

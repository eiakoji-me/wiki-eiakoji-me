<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-7-opentelemetry-w3c-trace" name="OpenTelemetry W3C Trace Context Propagation Across Broker Horizons">
    <mxGraphModel dx="1500" dy="750" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1500" pageHeight="750" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- MAIN CONTAINER -->
        <mxCell id="main-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="670" width="1420" x="40" y="40" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="DISTRIBUTED OBSERVABILITY: OPENTELEMETRY W3C CONTEXT PROPAGATION ACROSS BROKER HORIZONS" vertex="1">
          <mxGeometry height="24" width="1000" x="65" y="52" as="geometry" />
        </mxCell>

        <!-- LEFT PANEL: UPSTREAM PRODUCER -->
        <mxCell id="left-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="390" width="380" x="65" y="95" as="geometry" />
        </mxCell>
        <mxCell id="left-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="1. PRODUCER SERVICE (SPAN A)" vertex="1">
          <mxGeometry height="22" width="350" x="80" y="105" as="geometry" />
        </mxCell>

        <mxCell id="l-span" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Active Trace Context (Span A)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;traceId: 4bf92f3577b34da6a3ce929d0e0e4736&lt;br&gt;spanId: 00f067aa0ba902b7 &amp;bull; flags: 01 (sampled)&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="350" x="80" y="135" as="geometry" />
        </mxCell>

        <mxCell id="l-injector" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;W3C TraceContext Propagator&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;openTelemetry.getPropagators().getTextMapPropagator()&lt;br&gt;.inject(context, headers, HeaderSetter)&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="350" x="80" y="215" as="geometry" />
        </mxCell>

        <mxCell id="l-sender" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Message Dispatcher / Client SDK&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Attaches metadata headers to binary record&lt;br&gt;Dispatches to topic / exchange&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="350" x="80" y="300" as="geometry" />
        </mxCell>

        <mxCell id="l-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#475569;fontFamily=Comic Sans MS;" value="&amp;bull; Injects traceparent: version-traceId-parentId-flags&lt;br&gt;&amp;bull; Preserves tracestate vendor pairs (ro=0.5,tenant=x)" vertex="1">
          <mxGeometry height="40" width="350" x="80" y="380" as="geometry" />
        </mxCell>

        <!-- CENTER PANEL: BROKER HORIZON -->
        <mxCell id="center-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="390" width="460" x="485" y="95" as="geometry" />
        </mxCell>
        <mxCell id="center-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="2. BROKER CONDUIT &amp;amp; ASYNCHRONOUS BOUNDARY" vertex="1">
          <mxGeometry height="22" width="430" x="500" y="105" as="geometry" />
        </mxCell>

        <mxCell id="c-envelope" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;" value="&lt;b&gt;&amp;nbsp;&amp;nbsp;Message Record Envelope (On-Wire / At-Rest)&lt;/b&gt;&lt;br&gt;&lt;hr style=&quot;margin: 4px 0;&quot;&gt;&lt;font color=&quot;#1E293B&quot;&gt;&amp;nbsp;&amp;bull; &lt;b&gt;Headers:&lt;/b&gt;&lt;br&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;i&gt;traceparent&lt;/i&gt;: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01&lt;br&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;i&gt;tracestate&lt;/i&gt;: vendor=live,route=vip&lt;br&gt;&amp;nbsp;&amp;bull; &lt;b&gt;Payload:&lt;/b&gt; {&quot;orderId&quot;:&quot;ord-992&quot;,&quot;amount&quot;:340.50}&lt;br&gt;&amp;nbsp;&amp;bull; &lt;b&gt;Timestamp:&lt;/b&gt; 2026-11-13T09:00:00Z&lt;/font&gt;" vertex="1">
          <mxGeometry height="140" width="430" x="500" y="135" as="geometry" />
        </mxCell>

        <!-- Temporal Gap Banner -->
        <mxCell id="c-gap" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Durable Partitioned Log / Queue&lt;/b&gt;&lt;br&gt;Temporal Gap: Consumer may process seconds or hours later.&lt;br&gt;Thread context destroyed &amp;bull; Trace preserved purely via headers." vertex="1">
          <mxGeometry height="95" width="430" x="500" y="290" as="geometry" />
        </mxCell>

        <mxCell id="c-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#475569;fontFamily=Comic Sans MS;" value="&amp;bull; Brokered delivery decouples thread execution in time and space.&lt;br&gt;&amp;bull; Trace headers survive broker re-serialization, compaction, and replay." vertex="1">
          <mxGeometry height="40" width="430" x="500" y="395" as="geometry" />
        </mxCell>

        <!-- RIGHT PANEL: DOWNSTREAM CONSUMER -->
        <mxCell id="right-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="390" width="455" x="985" y="95" as="geometry" />
        </mxCell>
        <mxCell id="right-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="3. CONSUMER SERVICE (SPAN B &amp;amp; SPAN LINKS)" vertex="1">
          <mxGeometry height="22" width="430" x="1000" y="105" as="geometry" />
        </mxCell>

        <mxCell id="r-extractor" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;W3C Context Extractor&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;openTelemetry.getPropagators().getTextMapPropagator()&lt;br&gt;.extract(Context.root(), headers, HeaderGetter)&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="425" x="1000" y="135" as="geometry" />
        </mxCell>

        <mxCell id="r-span-b" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Single Record Mode: Parent-Child Span&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Span B created with parent = extracted Context&lt;br&gt;Direct DAG lineage: Span A ➔ Span B (Receive/Process)&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="425" x="1000" y="210" as="geometry" />
        </mxCell>

        <mxCell id="r-span-link" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Batch Processing Mode: Span Links&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Batch Consumer cannot have multiple parents.&lt;br&gt;Creates independent Span B with Span Links to each trace parent.&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="425" x="1000" y="285" as="geometry" />
        </mxCell>

        <mxCell id="r-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#475569;fontFamily=Comic Sans MS;" value="&amp;bull; Single consumer preserves hierarchy: Parent A -&gt; Child B -&gt; Child C.&lt;br&gt;&amp;bull; Batch consumer creates Link collection to avoid invalid multi-parent trees." vertex="1">
          <mxGeometry height="40" width="425" x="1000" y="360" as="geometry" />
        </mxCell>

        <!-- FLOW ARROWS -->
        <mxCell id="arr-l-c" edge="1" parent="1" source="l-sender" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;" target="c-envelope">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-c-r" edge="1" parent="1" source="c-gap" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;" target="r-extractor">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- BOTTOM COMPARISON / SHADED STANDARD CALLOUT -->
        <mxCell id="bottom-shaded" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#000000;labelBackgroundColor=#FFFFFF;arcSize=6;" value="" vertex="1">
          <mxGeometry height="150" width="1375" x="65" y="505" as="geometry" />
        </mxCell>
        <mxCell id="b-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontFamily=Comic Sans MS;" value="ARCHITECTURAL INVARIANT: SYNCHRONOUS RPC VS. ASYNCHRONOUS BROKER OBSERVABILITY" vertex="1">
          <mxGeometry height="20" width="700" x="85" y="515" as="geometry" />
        </mxCell>
        <mxCell id="b-text" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Synchronous HTTP/gRPC:&lt;/b&gt; Thread-local storage (ThreadLocal/MDC) retains execution context naturally during blocking calls. Call stacks are contiguous.&lt;br&gt;&lt;b&gt;• Asynchronous Event Broker:&lt;/b&gt; Execution thread terminates immediately upon broker publish acknowledgment. The receiving worker runs on an unrelated thread pool hours later.&lt;br&gt;&lt;b&gt;• Consequence:&lt;/b&gt; Distributed tracing in message queues cannot rely on implicit runtime context. Context MUST be serialized into protocol headers (&lt;i&gt;traceparent&lt;/i&gt;) at producer ingress and reconstituted at receiver egress. When consumers aggregate multiple messages in batches, standard single-parent hierarchy breaks, requiring W3C Span Links." vertex="1">
          <mxGeometry height="100" width="1335" x="85" y="540" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

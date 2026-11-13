<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-7-hero-monochrome" name="EIP Part VII Hero Operations Observability and Governance">
    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="920" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- TIER 1: PRODUCTION TRAFFIC & INTERCEPTION -->
        <mxCell id="tier1-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="140" width="1440" x="80" y="40" as="geometry" />
        </mxCell>
        <mxCell id="tier1-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. RUNTIME PIPELINE &amp;amp; PASSIVE/ACTIVE INTERCEPTION MECHANISMS" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="48" as="geometry" />
        </mxCell>

        <!-- Tier 1 Components -->
        <mxCell id="t1-wiretap" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Wire Tap Interceptor&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Passive tee &amp;bull; Zero-overhead non-blocking shadow copy to audit pipeline&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="105" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-detour" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Smart Proxy &amp;amp; Detour Router&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Dynamically routes live messages to diagnostics or alternate paths&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="580" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-msgstore" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Message Store &amp;amp; History&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Immutable append-only ledger &amp;bull; Headers, payload audit, and replay log&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="1055" y="78" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 1 -> 2 -->
        <mxCell id="arr-tier1-tier2" edge="1" parent="1" source="tier1-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier2-container" value="Continuous Telemetry Stream &amp;amp; Context Trace Ingress ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 2: OBSERVABILITY FABRIC & CONTEXT PROPAGATION -->
        <mxCell id="tier2-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=6;" value="" vertex="1">
          <mxGeometry height="330" width="1440" x="80" y="225" as="geometry" />
        </mxCell>
        <mxCell id="tier2-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. DISTRIBUTED OBSERVABILITY FABRIC: OPENTELEMETRY, LOGGING &amp;amp; CANARIES" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="235" as="geometry" />
        </mxCell>

        <!-- PANEL A: W3C TRACE CONTEXT -->
        <mxCell id="p2a-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="105" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2a-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="A. OPENTELEMETRY W3C CONTEXT PROPAGATION" vertex="1">
          <mxGeometry height="20" width="420" x="120" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2a-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Broken Call Stacks:&lt;/b&gt; Inverted execution breaks thread-local traces.&lt;br&gt;&lt;b&gt;W3C Headers:&lt;/b&gt; traceparent &amp;amp; tracestate injected into message metadata.&lt;br&gt;&lt;b&gt;Span Linking:&lt;/b&gt; Batch receivers link multiple producer traces cleanly." vertex="1">
          <mxGeometry height="65" width="420" x="120" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2a-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Trace Invariant&lt;/b&gt;: Preserves causal graph across temporal broker gaps.&lt;br&gt;&lt;b&gt;• Sampling Propagation&lt;/b&gt;: Respects upstream trace-flags (e.g. 01 sampled).&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: OpenTelemetry Java Agent, Kafka Record Headers.&lt;br&gt;&lt;b&gt;• Fallback&lt;/b&gt;: Synthesizes new root trace if traceparent header missing." vertex="1">
          <mxGeometry height="145" width="420" x="120" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL B: NON-BLOCKING AUDIT WIRE TAP -->
        <mxCell id="p2b-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="580" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2b-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="B. NON-BLOCKING WIRE TAP &amp;amp; MESSAGE STORE" vertex="1">
          <mxGeometry height="20" width="420" x="595" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2b-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Passive Tap:&lt;/b&gt; Duplicates messages to secondary auditing channel.&lt;br&gt;&lt;b&gt;Disruptor Ring Buffer:&lt;/b&gt; Zero lock contention protects main pipeline SLA.&lt;br&gt;&lt;b&gt;Drop-on-Full Policy:&lt;/b&gt; Sheds tap copies before impacting primary throughput." vertex="1">
          <mxGeometry height="65" width="420" x="595" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2b-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• SLA Isolation&lt;/b&gt;: Slow audit sink never throttles critical business paths.&lt;br&gt;&lt;b&gt;• Message Store&lt;/b&gt;: Append-only immutable store with TTL/tiering.&lt;br&gt;&lt;b&gt;• Audit History&lt;/b&gt;: Captures intermediate states across routing steps.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: LMAX Disruptor, Virtual Thread Async Tap, S3/Parquet." vertex="1">
          <mxGeometry height="145" width="420" x="595" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL C: CANARY PROBING & TEST MESSAGES -->
        <mxCell id="p2c-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="1055" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2c-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="C. TEST MESSAGE PROBES &amp;amp; CONSUMER LAG" vertex="1">
          <mxGeometry height="20" width="420" x="1070" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2c-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Synthetic Canaries:&lt;/b&gt; Injects flagged test messages into active stream.&lt;br&gt;&lt;b&gt;Test Filter:&lt;/b&gt; Downstream services execute logic without side-effects.&lt;br&gt;&lt;b&gt;E2E Latency Metric:&lt;/b&gt; Quantifies end-to-end pipeline transit delay." vertex="1">
          <mxGeometry height="65" width="420" x="1070" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2c-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Consumer Lag&lt;/b&gt;: L(t) = integral of (arrival_rate - drain_rate).&lt;br&gt;&lt;b&gt;• Zero Side-Effects&lt;/b&gt;: Rolling transactions roll back synthetic test rows.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Synthetic health check injectors, Burrow/Prometheus.&lt;br&gt;&lt;b&gt;• Anomaly Detection&lt;/b&gt;: Alerts when p99 queue residence exceeds threshold." vertex="1">
          <mxGeometry height="145" width="420" x="1070" y="380" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 2 -> 3 -->
        <mxCell id="arr-tier2-tier3" edge="1" parent="1" source="tier2-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier3-container" value="Control Bus Feedback Loop: Dynamic Topologies &amp;amp; DLQ Redrive ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 3: CONTROL BUS & TOPOLOGY GOVERNANCE -->
        <mxCell id="tier3-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="1440" x="80" y="595" as="geometry" />
        </mxCell>
        <mxCell id="tier3-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="3. ARCHITECTURAL CONTROL BUS: GOVERNANCE, DYNAMIC DETOUR &amp;amp; DLQ REDRIVE" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="605" as="geometry" />
        </mxCell>

        <!-- Tier 3 Components -->
        <mxCell id="t3-controlbus" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Architectural Control Bus&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Isolated administrative message conduit &amp;bull; Dynamic control plane&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="340" x="105" y="635" as="geometry" />
        </mxCell>
        <mxCell id="t3-detour-switch" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Dynamic Detour Switch&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Toggles message diversion to debug pipelines without restarts&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="340" x="470" y="635" as="geometry" />
        </mxCell>
        <mxCell id="t3-redrive" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;DLQ Redrive Orchestrator&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Rate-limited redrive with backpressure &amp;amp; deduplication fence&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="340" x="835" y="635" as="geometry" />
        </mxCell>

        <!-- Shaded standard shape with dark font and white label background -->
        <mxCell id="t3-shaded-standard" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Governance &amp;amp; Policy Plane&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#000000&quot;&gt;Strict schema registry enforcement &amp;bull; Poison pill quarantine &amp;bull; Audit TTLs&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="315" x="1195" y="635" as="geometry" />
        </mxCell>

        <!-- SUMMARY BULLET BOX -->
        <mxCell id="t3-summary" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#1E293B;fontFamily=Comic Sans MS;" value="&lt;b&gt;Key Operations &amp;amp; Governance Principles:&lt;/b&gt;&lt;br&gt;&lt;b&gt;• Zero-Intrusiveness&lt;/b&gt;: Wire Tap and Message History must execute asynchronously via bounded queues; dropping audit copies is strictly preferred to blocking production.&lt;br&gt;&lt;b&gt;• W3C Causality&lt;/b&gt;: Every asynchronous message boundary must propagate standard traceparent headers to reconstruct distributed DAG execution trees.&lt;br&gt;&lt;b&gt;• Administrative Isolation&lt;/b&gt;: Control Bus commands operate on dedicated broker subjects/channels to prevent queue starvation during traffic surges.&lt;br&gt;&lt;b&gt;• Controlled Redrive&lt;/b&gt;: Dead-letter redrive requires rate-limiting and deduplication fencing to prevent secondary thundering herd collapses." vertex="1">
          <mxGeometry height="130" width="1400" x="105" y="715" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

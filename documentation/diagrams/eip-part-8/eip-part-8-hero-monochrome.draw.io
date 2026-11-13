<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-8-hero-monochrome" name="EIP Part VIII Hero Composing Enterprise Integration Patterns">
    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="920" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- TIER 1: INGRESS & EVENT INGESTION -->
        <mxCell id="tier1-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="140" width="1440" x="80" y="40" as="geometry" />
        </mxCell>
        <mxCell id="tier1-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. INGRESS &amp;amp; DUAL-WRITE DEFENSE: TRANSACTIONAL OUTBOX &amp;amp; CLAIM CHECK" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="48" as="geometry" />
        </mxCell>

        <!-- Tier 1 Components -->
        <mxCell id="t1-outbox" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Transactional Outbox &amp;amp; CDC&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;ACID DB Commit + Debezium Log Tail &amp;bull; Zero dual-write risk&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="105" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-router" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Content-Based Router&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Evaluates tenant, region, order tier &amp;bull; Dynamic destination resolution&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="580" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-claimcheck" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Claim Check Storage Pattern&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Heavy payloads (&amp;gt; 1MB) offloaded to S3 &amp;bull; Lightweight pointer in event&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="1055" y="78" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 1 -> 2 -->
        <mxCell id="arr-tier1-tier2" edge="1" parent="1" source="tier1-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier2-container" value="Normalized Composite Event Envelope Dispatched to Orchestration Mesh ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 2: DISTRIBUTED ORCHESTRATION & SAGA COORDINATION -->
        <mxCell id="tier2-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=6;" value="" vertex="1">
          <mxGeometry height="330" width="1440" x="80" y="225" as="geometry" />
        </mxCell>
        <mxCell id="tier2-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. COMPOSITE ORCHESTRATION: SCATTER-GATHER, SAGA COMPENSATION &amp;amp; FENCES" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="235" as="geometry" />
        </mxCell>

        <!-- PANEL A: SCATTER-GATHER -->
        <mxCell id="p2a-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="105" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2a-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="A. PARALLEL SCATTER-GATHER MESH" vertex="1">
          <mxGeometry height="20" width="420" x="120" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2a-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Parallel Fan-Out:&lt;/b&gt; Queries N supplier partners concurrently.&lt;br&gt;&lt;b&gt;Structured Concurrency:&lt;/b&gt; Java 21 StructuredTaskScope handles forks.&lt;br&gt;&lt;b&gt;Aggregator Barrier:&lt;/b&gt; Timeouts or best-quote quorum selects winner." vertex="1">
          <mxGeometry height="65" width="420" x="120" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2a-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Splitter / Aggregator&lt;/b&gt;: Splits cart into line items; reassembles totals.&lt;br&gt;&lt;b&gt;• Dead-Mans Timer&lt;/b&gt;: Drops lagging suppliers after 300ms SLA barrier.&lt;br&gt;&lt;b&gt;• Resilience&lt;/b&gt;: Partial fulfillment fallback if non-critical suppliers fail.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Virtual threads, Kafka RecipientList / Aggregator." vertex="1">
          <mxGeometry height="145" width="420" x="120" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL B: SAGA COORDINATION -->
        <mxCell id="p2b-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="580" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2b-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="B. DISTRIBUTED SAGA &amp;amp; COMPENSATION" vertex="1">
          <mxGeometry height="20" width="420" x="595" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2b-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Forward Workflow:&lt;/b&gt; T1: Credit -&gt; T2: Inventory -&gt; T3: Payment -&gt; T4: Ship.&lt;br&gt;&lt;b&gt;Backward Compensation:&lt;/b&gt; C3: Void -&gt; C2: Release -&gt; C1: Refund.&lt;br&gt;&lt;b&gt;Durable State Log:&lt;/b&gt; Persists active step state across crashes." vertex="1">
          <mxGeometry height="65" width="420" x="595" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2b-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Atomicity without 2PC&lt;/b&gt;: Replaces heavy distributed XA locks.&lt;br&gt;&lt;b&gt;• Orchestrator vs Choreography&lt;/b&gt;: Centralized state engine prevents loops.&lt;br&gt;&lt;b&gt;• Idempotent Compensations&lt;/b&gt;: Compensation actions MUST be idempotent.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Temporal, AWS Step Functions, Custom State Machine." vertex="1">
          <mxGeometry height="145" width="420" x="595" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL C: IDEMPOTENT RECEIVERS & FENCES -->
        <mxCell id="p2c-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="1055" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2c-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="C. IDEMPOTENT CONSUMERS &amp;amp; DEDUPLICATION" vertex="1">
          <mxGeometry height="20" width="420" x="1070" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2c-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;At-Least-Once Reality:&lt;/b&gt; Network retries and redrives cause duplicates.&lt;br&gt;&lt;b&gt;Atomic Deduplication:&lt;/b&gt; Unique message key inserted with state in 1 TX.&lt;br&gt;&lt;b&gt;Fencing Tokens:&lt;/b&gt; Monotonic sequence numbers block stale executions." vertex="1">
          <mxGeometry height="65" width="420" x="1070" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2c-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Compare-And-Swap&lt;/b&gt;: Guards against racing concurrent consumers.&lt;br&gt;&lt;b&gt;• Expiring Key Cache&lt;/b&gt;: Sliding Redis Bloom filter suppresses redundant checks.&lt;br&gt;&lt;b&gt;• State Determinism&lt;/b&gt;: Duplicate message returns cached result cleanly.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: PostgreSQL UNIQUE index, Redis SETNX, DynamoDB COND." vertex="1">
          <mxGeometry height="145" width="420" x="1070" y="380" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 2 -> 3 -->
        <mxCell id="arr-tier2-tier3" edge="1" parent="1" source="tier2-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier3-container" value="Unified Telemetry, Health Monitoring &amp;amp; Dynamic Governance ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 3: OBSERVABILITY, CASCADING DEFENSE & GOVERNANCE -->
        <mxCell id="tier3-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="1440" x="80" y="595" as="geometry" />
        </mxCell>
        <mxCell id="tier3-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="3. COMPOSITE RESILIENCE: CASCADING FAILURE DEFENSE, WIRE TAP &amp;amp; CONTROL BUS" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="605" as="geometry" />
        </mxCell>

        <!-- Tier 3 Components -->
        <mxCell id="t3-circuitbreaker" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Circuit Breaker &amp;amp; Backpressure&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Fails fast on downstream lag &amp;bull; Prevents buffer queue saturation&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="340" x="105" y="635" as="geometry" />
        </mxCell>
        <mxCell id="t3-wiretap" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Async Wire Tap &amp;amp; Message Store&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Non-blocking audit tee &amp;bull; Drop-on-full SLA protection&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="340" x="470" y="635" as="geometry" />
        </mxCell>
        <mxCell id="t3-controlbus" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Architectural Control Bus&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Admin commands &amp;bull; Dynamic Detour &amp;amp; Leaky-bucket DLQ redrive&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="340" x="835" y="635" as="geometry" />
        </mxCell>

        <!-- Shaded standard shape with dark font and white label background -->
        <mxCell id="t3-shaded-standard" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Macro Synthesis Invariant&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#000000&quot;&gt;Atomic Ingress &amp;bull; Non-Blocking Conduits &amp;bull; Idempotent Processing&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="315" x="1195" y="635" as="geometry" />
        </mxCell>

        <!-- SUMMARY BULLET BOX -->
        <mxCell id="t3-summary" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#1E293B;fontFamily=Comic Sans MS;" value="&lt;b&gt;Core Architectural Principles of EIP Macro Composition:&lt;/b&gt;&lt;br&gt;&lt;b&gt;• The Dual-Write Barrier&lt;/b&gt;: Ingress must use Transactional Outbox + CDC to eliminate distributed inconsistency between databases and brokers.&lt;br&gt;&lt;b&gt;• Bounded Concurrency &amp;amp; Backpressure&lt;/b&gt;: Every consumer and pipeline must define strict queue depth bounds; unconstrained buffers inevitably trigger cascading OOM failures.&lt;br&gt;&lt;b&gt;• Universal Idempotence&lt;/b&gt;: In at-least-once distributed fabrics, network retries, broker rebalances, and saga rollbacks guarantee duplicate deliveries.&lt;br&gt;&lt;b&gt;• Distributed Observability&lt;/b&gt;: W3C traceparent headers must traverse every broker boundary to maintain end-to-end causal DAG visibility." vertex="1">
          <mxGeometry height="130" width="1400" x="105" y="715" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

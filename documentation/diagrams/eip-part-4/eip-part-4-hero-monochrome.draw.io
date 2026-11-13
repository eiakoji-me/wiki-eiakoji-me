<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-4-hero-monochrome" name="EIP Part IV Hero Message Routing">
    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="920" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- TIER 1: STATELESS INSPECTION & SELECTIVE DISPATCH -->
        <mxCell id="tier1-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="140" width="1440" x="80" y="40" as="geometry" />
        </mxCell>
        <mxCell id="tier1-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. STATELESS INSPECTION &amp;amp; SELECTIVE DISPATCH" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="48" as="geometry" />
        </mxCell>

        <!-- Tier 1 Components -->
        <mxCell id="t1-cbr" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Content-Based Router&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Inspects payload/headers &amp;bull; Dynamic destination selection&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="330" x="105" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-filter" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Message Filter&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Predicate evaluation &amp;bull; Silent drop vs Dead-letter divert&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="330" x="465" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-dyn-router" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Dynamic Router&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Control-plane routing table &amp;bull; External rule engine lookup&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="330" x="825" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-recipient" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Recipient List&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Iterative multiple destination fan-out &amp;bull; Dynamic subscriber lists&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="330" x="1175" y="78" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 1 -> 2 -->
        <mxCell id="arr-tier1-tier2" edge="1" parent="1" source="tier1-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier2-container" value="Streams Dispatched to Decomposition &amp;amp; Processing Conduits ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 2: STREAM DECOMPOSITION & STATEFUL REASSEMBLY -->
        <mxCell id="tier2-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=6;" value="" vertex="1">
          <mxGeometry height="330" width="1440" x="80" y="225" as="geometry" />
        </mxCell>
        <mxCell id="tier2-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. STREAM DECOMPOSITION, AGGREGATION &amp;amp; REORDERING" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="235" as="geometry" />
        </mxCell>

        <!-- PANEL A: SPLITTER & AGGREGATOR -->
        <mxCell id="p2a-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="105" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2a-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="A. SPLITTER &amp;amp; AGGREGATOR (COMPOSITION CYCLE)" vertex="1">
          <mxGeometry height="20" width="420" x="120" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2a-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Splitter:&lt;/b&gt; Decomposes composite batch into N child items.&lt;br&gt;&lt;b&gt;Metadata:&lt;/b&gt; Injects correlation_id, sequence_number, sequence_size.&lt;br&gt;&lt;b&gt;Aggregator:&lt;/b&gt; Accumulates items until completion predicate or TTL." vertex="1">
          <mxGeometry height="65" width="420" x="120" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2a-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• State Store&lt;/b&gt;: In-memory heap or distributed Redis/Cassandra.&lt;br&gt;&lt;b&gt;• Memory Hazard&lt;/b&gt;: Unbounded leak if 1 of N child messages drops.&lt;br&gt;&lt;b&gt;• Completion Policy&lt;/b&gt;: Count-based, timeout-based, or predicate.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Apache Flink window, Spring Integration Aggregator." vertex="1">
          <mxGeometry height="95" width="420" x="120" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL B: RESEQUENCER -->
        <mxCell id="p2b-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="575" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2b-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="B. RESEQUENCER (STREAM RE-ORDERING BUFFER)" vertex="1">
          <mxGeometry height="20" width="420" x="590" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2b-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Problem:&lt;/b&gt; Parallel worker pools emit messages out-of-order.&lt;br&gt;&lt;b&gt;Mechanic:&lt;/b&gt; Sliding window buffer holds future items.&lt;br&gt;&lt;b&gt;Release:&lt;/b&gt; Emits item k only when items 0..k-1 have been emitted." vertex="1">
          <mxGeometry height="65" width="420" x="590" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2b-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Window Discipline&lt;/b&gt;: Max buffer size W and timeout &amp;tau;_max.&lt;br&gt;&lt;b&gt;• Gap Handling&lt;/b&gt;: If missing item times out, skip gap or abort.&lt;br&gt;&lt;b&gt;• Head-of-Line Blocking&lt;/b&gt;: A single stalled message halts the stream.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: TCP receive buffer, Kafka consumer offset alignment." vertex="1">
          <mxGeometry height="95" width="420" x="590" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL C: SCATTER-GATHER -->
        <mxCell id="p2c-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="1045" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2c-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="C. SCATTER-GATHER (PARALLEL BIDDING &amp;amp; AGGREGATION)" vertex="1">
          <mxGeometry height="20" width="420" x="1060" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2c-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Scatter:&lt;/b&gt; Broadcasts request to multiple autonomous suppliers.&lt;br&gt;&lt;b&gt;Execution:&lt;/b&gt; Suppliers calculate quotes independently in parallel.&lt;br&gt;&lt;b&gt;Gather:&lt;/b&gt; Selects best bid (lowest price / fastest delivery)." vertex="1">
          <mxGeometry height="65" width="420" x="1060" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2c-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Latency Bound&lt;/b&gt;: Governed by slowest respondent or strict deadline.&lt;br&gt;&lt;b&gt;• Late Responses&lt;/b&gt;: Discarded into DLQ or logged as orphans.&lt;br&gt;&lt;b&gt;• Selection Policy&lt;/b&gt;: First-response, minimum cost, or N-quorum.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Flight price search aggregators, insurance bidding." vertex="1">
          <mxGeometry height="95" width="420" x="1060" y="380" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 2 -> 3 -->
        <mxCell id="arr-tier2-tier3" edge="1" parent="1" source="tier2-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier3-container" value="Coordinated Across Multi-Step Enterprise Business Processes ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 3: DISTRIBUTED PROCESS COORDINATION -->
        <mxCell id="tier3-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="1440" x="80" y="600" as="geometry" />
        </mxCell>
        <mxCell id="tier3-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="3. DISTRIBUTED COORDINATION: ROUTING SLIP VS. PROCESS MANAGER (SAGA)" vertex="1">
          <mxGeometry height="22" width="900" x="105" y="610" as="geometry" />
        </mxCell>

        <!-- Coordination Comparison Boxes -->
        <mxCell id="t3-routing-slip" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Routing Slip (Decentralized Choreography)&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;State Location&lt;/b&gt;: Carried directly inside message header itinerary.&lt;br&gt;&amp;bull; &lt;b&gt;Coupling&lt;/b&gt;: Services know only their own step and pop next target.&lt;br&gt;&amp;bull; &lt;b&gt;Failure Mode&lt;/b&gt;: Complex compensation routing; no central ledger.&lt;br&gt;&amp;bull; &lt;b&gt;Best Fit&lt;/b&gt;: Linear validation pipelines, content transformation chains." vertex="1">
          <mxGeometry height="135" width="450" x="105" y="640" as="geometry" />
        </mxCell>

        <mxCell id="t3-process-manager" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Process Manager / Saga (Centralized Orchestration)&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;State Location&lt;/b&gt;: Centralized persistent database / state machine.&lt;br&gt;&amp;bull; &lt;b&gt;Coupling&lt;/b&gt;: Services remain generic task workers; coordinator commands them.&lt;br&gt;&amp;bull; &lt;b&gt;Failure Mode&lt;/b&gt;: Executes deterministic reverse compensating actions.&lt;br&gt;&amp;bull; &lt;b&gt;Best Fit&lt;/b&gt;: Multi-party transactions (Order, Payment, Inventory, Shipping)." vertex="1">
          <mxGeometry height="135" width="450" x="575" y="640" as="geometry" />
        </mxCell>

        <!-- Shaded Invariant Rectangle adhering to standard -->
        <mxCell id="t3-shaded-invariants" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Enterprise Architectural Invariants&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Memory Finiteness&lt;/b&gt;: All stateful buffers (Aggregator, Resequencer) must define strict TTL eviction.&lt;br&gt;&amp;bull; &lt;b&gt;Correlation Identity&lt;/b&gt;: Sub-messages must preserve root correlation ID alongside sequence index.&lt;br&gt;&amp;bull; &lt;b&gt;Compensating Idempotency&lt;/b&gt;: Saga reverse actions must be strictly idempotent under at-least-once delivery." vertex="1">
          <mxGeometry height="135" width="450" x="1045" y="640" as="geometry" />
        </mxCell>

        <!-- Summary Footer -->
        <mxCell id="footer-text" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="Gregor Hohpe &amp;amp; Bobby Woolf &amp;bull; Enterprise Integration Patterns: Part IV Message Routing &amp;amp; Process Coordination" vertex="1">
          <mxGeometry height="20" width="1440" x="80" y="790" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-6-hero-monochrome" name="EIP Part VI Hero Messaging Endpoints">
    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="920" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- TIER 1: CLIENT GATEWAYS & TRANSACTIONAL OUTBOX INGRESS -->
        <mxCell id="tier1-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="140" width="1440" x="80" y="40" as="geometry" />
        </mxCell>
        <mxCell id="tier1-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. PRODUCER ENDPOINTS &amp;amp; TRANSACTIONAL OUTBOX DISPATCH" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="48" as="geometry" />
        </mxCell>

        <!-- Tier 1 Components -->
        <mxCell id="t1-gateway" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Messaging Gateway&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Domain-centric interface &amp;bull; Hides broker SDK dependencies&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="105" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-outbox" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Transactional Outbox Table&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Atomic ACID commit: Business State + Outbox Row in 1 TX&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="580" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-cdc" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Debezium CDC Engine&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Reads DB WAL tail &amp;bull; Dispatches events with zero dual-write risk&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="1055" y="78" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 1 -> 2 -->
        <mxCell id="arr-tier1-tier2" edge="1" parent="1" source="tier1-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier2-container" value="Events Streamed to Distributed Broker Fabric &amp;amp; Competing Consumers ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 2: BROKER CONDUITS & CONSUMER TOPOLOGIES -->
        <mxCell id="tier2-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=6;" value="" vertex="1">
          <mxGeometry height="330" width="1440" x="80" y="225" as="geometry" />
        </mxCell>
        <mxCell id="tier2-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. CONSUMER TOPOLOGIES: POLLING, EVENT-DRIVEN &amp;amp; COMPETING CONSUMERS" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="235" as="geometry" />
        </mxCell>

        <!-- PANEL A: POLLING VS PUSH -->
        <mxCell id="p2a-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="105" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2a-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="A. POLLING VS. EVENT-DRIVEN (PUSH) CONSUMERS" vertex="1">
          <mxGeometry height="20" width="420" x="120" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2a-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Polling Consumer:&lt;/b&gt; Worker calls poll(timeout) on its own schedule.&lt;br&gt;&lt;b&gt;Backpressure Control:&lt;/b&gt; Consumer never gets overwhelmed by burst traffic.&lt;br&gt;&lt;b&gt;Event-Driven Push:&lt;/b&gt; Broker invokes callback immediately on arrival." vertex="1">
          <mxGeometry height="65" width="420" x="120" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2a-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Polling Overhead&lt;/b&gt;: Empty queue polling burns CPU without long-polling.&lt;br&gt;&lt;b&gt;• Push Overflow&lt;/b&gt;: Fast publisher overwhelms slow receiver memory.&lt;br&gt;&lt;b&gt;• Realization (Poll)&lt;/b&gt;: Kafka Consumer poll loop, SQS ReceiveMessage.&lt;br&gt;&lt;b&gt;• Realization (Push)&lt;/b&gt;: Webhooks, RabbitMQ basic.consume, GCP Pub/Sub push." vertex="1">
          <mxGeometry height="95" width="420" x="120" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL B: COMPETING CONSUMERS -->
        <mxCell id="p2b-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="575" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2b-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="B. COMPETING CONSUMERS (DYNAMIC LOAD SHIFTING)" vertex="1">
          <mxGeometry height="20" width="420" x="590" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2b-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Mechanic:&lt;/b&gt; Multiple worker instances read from a single shared queue.&lt;br&gt;&lt;b&gt;Single Receiver:&lt;/b&gt; Each message delivered to exactly one active worker.&lt;br&gt;&lt;b&gt;Elasticity:&lt;/b&gt; Scale workers up/down dynamically based on queue lag." vertex="1">
          <mxGeometry height="65" width="420" x="590" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2b-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Ordering Loss&lt;/b&gt;: Out-of-order execution inevitable under variable worker latency.&lt;br&gt;&lt;b&gt;• Partition Assignment&lt;/b&gt;: In Kafka, concurrency is capped by partition count.&lt;br&gt;&lt;b&gt;• Rebalance Storms&lt;/b&gt;: Worker heartbeats fail, triggering cluster-wide pauses.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Kafka Consumer Groups, SQS competing worker pools." vertex="1">
          <mxGeometry height="95" width="420" x="590" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL C: SELECTIVE CONSUMER & DISPATCHER -->
        <mxCell id="p2c-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="1045" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2c-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="C. SELECTIVE CONSUMER &amp;amp; INTERNAL DISPATCHER" vertex="1">
          <mxGeometry height="20" width="420" x="1060" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2c-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Selective Consumer:&lt;/b&gt; Filters messages using selector headers before delivery.&lt;br&gt;&lt;b&gt;Message Dispatcher:&lt;/b&gt; Demuxes incoming channel across internal thread pool.&lt;br&gt;&lt;b&gt;Service Activator:&lt;/b&gt; Invokes business method without messaging imports." vertex="1">
          <mxGeometry height="65" width="420" x="1060" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2c-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Broker Performance&lt;/b&gt;: Complex JMS SQL-92 selectors degrade broker throughput.&lt;br&gt;&lt;b&gt;• Thread Pool Saturation&lt;/b&gt;: Internal dispatcher queues can cause silent OOM.&lt;br&gt;&lt;b&gt;• Virtual Threads&lt;/b&gt;: Java 21 eliminates OS thread exhaustion in dispatchers.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Spring @JmsListener, JMS MessageSelectors, Camel Activator." vertex="1">
          <mxGeometry height="95" width="420" x="1060" y="380" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 2 -> 3 -->
        <mxCell id="arr-tier2-tier3" edge="1" parent="1" source="tier2-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier3-container" value="Protected by Deduplication Fences &amp;amp; Idempotent Processing ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 3: IDEMPOTENT RECEIVERS & POISON PILL TRIAGE -->
        <mxCell id="tier3-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="1440" x="80" y="600" as="geometry" />
        </mxCell>
        <mxCell id="tier3-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="3. RELIABLE RECEIVERS: AT-LEAST-ONCE REALITY &amp;amp; DEDUPLICATION FENCES" vertex="1">
          <mxGeometry height="22" width="900" x="105" y="610" as="geometry" />
        </mxCell>

        <!-- Left Model Box -->
        <mxCell id="t3-idempotent" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Idempotent Receiver (Atomic Token Lock)&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;The Reality&lt;/b&gt;: Exactly-once delivery is physically impossible across open networks.&lt;br&gt;&amp;bull; &lt;b&gt;Deduplication Table&lt;/b&gt;: Atomic INSERT of message_id in the same DB transaction.&lt;br&gt;&amp;bull; &lt;b&gt;Duplicate Action&lt;/b&gt;: Primary key collision triggers immediate ACK and discard.&lt;br&gt;&amp;bull; &lt;b&gt;Result&lt;/b&gt;: Effectively-once side-effect execution with zero duplicate state mutations." vertex="1">
          <mxGeometry height="135" width="450" x="105" y="640" as="geometry" />
        </mxCell>

        <!-- Center Model Box -->
        <mxCell id="t3-poison-pill" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Poison Pill Quarantine &amp;amp; Dead Letter Handling&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Poison Pill&lt;/b&gt;: A malformed message that crashes the consumer deserializer every time.&lt;br&gt;&amp;bull; &lt;b&gt;Infinite Loop&lt;/b&gt;: Worker crashes ➔ message returns to queue ➔ worker crashes again.&lt;br&gt;&amp;bull; &lt;b&gt;Circuit Breaker&lt;/b&gt;: Max delivery count exceeded ➔ divert to Dead Letter Channel.&lt;br&gt;&amp;bull; &lt;b&gt;Operator Redrive&lt;/b&gt;: Quarantine preserves payload for schema patch &amp;amp; manual re-injection." vertex="1">
          <mxGeometry height="135" width="450" x="575" y="640" as="geometry" />
        </mxCell>

        <!-- Shaded Invariant Rectangle adhering to standard -->
        <mxCell id="t3-shaded-invariants" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Enterprise Architectural Invariants&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Never Dual-Write&lt;/b&gt;: Never update a local DB and emit a message in separate uncoordinated calls.&lt;br&gt;&amp;bull; &lt;b&gt;Deduplication TTL&lt;/b&gt;: Dedup tables must define sliding retention windows to prevent disk exhaustion.&lt;br&gt;&amp;bull; &lt;b&gt;Fencing Tokens&lt;/b&gt;: State mutations must assert monotonic version increments (v_fence &amp;gt; v_current)." vertex="1">
          <mxGeometry height="135" width="450" x="1045" y="640" as="geometry" />
        </mxCell>

        <!-- Summary Footer -->
        <mxCell id="footer-text" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="Gregor Hohpe &amp;amp; Bobby Woolf &amp;bull; Enterprise Integration Patterns: Part VI Messaging Endpoints &amp;amp; Reliable Processing" vertex="1">
          <mxGeometry height="20" width="1440" x="80" y="790" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
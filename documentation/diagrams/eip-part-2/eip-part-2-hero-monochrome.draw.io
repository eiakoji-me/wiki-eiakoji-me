<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-2-hero-monochrome" name="EIP Part II Hero Channels">
    <mxGraphModel dx="1140" dy="586" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- TIER 1: CLIENT RUNTIMES & PRODUCERS -->
        <mxCell id="tier1-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="130" width="1440" x="80" y="45" as="geometry" />
        </mxCell>
        <mxCell id="tier1-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. PRODUCER LANDSCAPE &amp;amp; CONTRACT INGRESS" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="55" as="geometry" />
        </mxCell>
        <mxCell id="t1-producer-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Transactional Core &amp;amp; Outbox&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Orders · Payments · Financial Ledgers&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="430" x="105" y="85" as="geometry" />
        </mxCell>
        <mxCell id="t1-producer-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Edge Microservices &amp;amp; APIs&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Customer Actions · Webhook Ingress · Ephemeral Tasks&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="430" x="585" y="85" as="geometry" />
        </mxCell>
        <mxCell id="t1-producer-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Datatype Channel Enforcement&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Schema Registry · Strict Typed Envelopes (Avro/JSON)&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="430" x="1065" y="85" as="geometry" />
        </mxCell>

        <!-- DISPATCH ARROW -->
        <mxCell id="arr-tier1-tier2" edge="1" parent="1" source="tier1-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier2-container" value="Dispatches into Managed Conduits ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 2: CHANNEL TOPOLOGIES & DURABILITY BACKBONE -->
        <mxCell id="tier2-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=6;" value="" vertex="1">
          <mxGeometry height="330" width="1440" x="80" y="215" as="geometry" />
        </mxCell>
        <mxCell id="tier2-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. THE CHANNEL TOPOLOGY &amp;amp; DURABILITY FABRIC" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="225" as="geometry" />
        </mxCell>

        <!-- TOPOLOGY A: POINT-TO-POINT -->
        <mxCell id="p2p-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="440" x="105" y="255" as="geometry" />
        </mxCell>
        <mxCell id="p2p-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="A. POINT-TO-POINT CHANNELS (P2P)" vertex="1">
          <mxGeometry height="20" width="410" x="120" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2p-queue" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Work Queue Buffer&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;FIFO Bounded Channel&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="160" x="120" y="295" as="geometry" />
        </mxCell>
        <mxCell id="p2p-workers" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Competing Consumers&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Worker 1 &amp;bull; Worker 2 &amp;bull; Worker N&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="220" x="310" y="295" as="geometry" />
        </mxCell>
        <mxCell id="arr-queue-workers" edge="1" parent="1" source="p2p-queue" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="p2p-workers">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="p2p-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Single-Receiver Semantics&lt;/b&gt;: Exactly one worker processes each item&lt;br&gt;&lt;b&gt;• Dynamic Load Balancing&lt;/b&gt;: Workers pull at their autonomous rate&lt;br&gt;&lt;b&gt;• Post-Ack Deletion&lt;/b&gt;: Message purged upon consumer acknowledgement&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: AWS SQS Standard, RabbitMQ Direct Work Queues" vertex="1">
          <mxGeometry height="95" width="410" x="120" y="365" as="geometry" />
        </mxCell>

        <!-- TOPOLOGY B: GUARANTEED DELIVERY ENGINE -->
        <mxCell id="wal-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="440" x="580" y="255" as="geometry" />
        </mxCell>
        <mxCell id="wal-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="B. GUARANTEED DELIVERY MECHANICS" vertex="1">
          <mxGeometry height="20" width="410" x="595" y="265" as="geometry" />
        </mxCell>
        <mxCell id="wal-disk" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Write-Ahead Log (WAL)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Append-Only Disk Segment&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="180" x="595" y="295" as="geometry" />
        </mxCell>
        <mxCell id="wal-quorum" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Replication Quorum&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#0F172A&quot;&gt;&lt;b&gt;W + R &amp;gt; N&lt;/b&gt;&lt;/font&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Majority ISR Ack Barrier&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="200" x="805" y="295" as="geometry" />
        </mxCell>
        <mxCell id="arr-wal-quorum" edge="1" parent="1" source="wal-disk" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="wal-quorum">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="wal-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Durability Guarantee&lt;/b&gt;: fsync barrier flushes OS buffer to non-volatile disk&lt;br&gt;&lt;b&gt;• Split-Brain Protection&lt;/b&gt;: Quorum intersection guarantees zero state loss&lt;br&gt;&lt;b&gt;• Consequence&lt;/b&gt;: Guarantees At-Least-Once delivery; duplicates inevitable&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Kafka min.insync.replicas=2, RabbitMQ quorum queues" vertex="1">
          <mxGeometry height="95" width="410" x="595" y="365" as="geometry" />
        </mxCell>

        <!-- TOPOLOGY C: PUBLISH-SUBSCRIBE -->
        <mxCell id="pubsub-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="440" x="1055" y="255" as="geometry" />
        </mxCell>
        <mxCell id="pubsub-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="C. PUBLISH-SUBSCRIBE (FANOUT &amp;amp; LOGS)" vertex="1">
          <mxGeometry height="20" width="410" x="1070" y="265" as="geometry" />
        </mxCell>
        <mxCell id="pubsub-topic" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Partitioned Topic&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Log Stream [P0, P1, P2]&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="160" x="1070" y="295" as="geometry" />
        </mxCell>
        <mxCell id="pubsub-groups" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Consumer Groups&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;CG-Billing &amp;bull; CG-Audit &amp;bull; CG-ML&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="220" x="1260" y="295" as="geometry" />
        </mxCell>
        <mxCell id="arr-topic-groups" edge="1" parent="1" source="pubsub-topic" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="pubsub-groups">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="pubsub-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• One-to-Many Broadcast&lt;/b&gt;: Each consumer group receives identical stream&lt;br&gt;&lt;b&gt;• Consumer Independence&lt;/b&gt;: Slow consumer never blocks peers&lt;br&gt;&lt;b&gt;• Non-Destructive Reads&lt;/b&gt;: Replayable streams tracked by consumer offset&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Apache Kafka Topics, Google Cloud Pub/Sub, AWS SNS" vertex="1">
          <mxGeometry height="95" width="410" x="1070" y="365" as="geometry" />
        </mxCell>

        <!-- DISPATCH ARROW TO TIER 3 -->
        <mxCell id="arr-tier2-tier3" edge="1" parent="1" source="tier2-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier3-container" value="Governs Failure Triage &amp;amp; Cross-Fabric Interconnects ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 3: TRIAGE & ENTERPRISE BUS INTERCONNECTS -->
        <mxCell id="tier3-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="280" width="1440" x="80" y="580" as="geometry" />
        </mxCell>
        <mxCell id="tier3-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="3. TRIAGE CHANNELS, ADAPTERS &amp;amp; ENTERPRISE MESSAGE BUS" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="590" as="geometry" />
        </mxCell>

        <!-- TRIAGE 1: INVALID MESSAGE CHANNEL -->
        <mxCell id="triage-invalid" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Invalid Message Channel&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Syntactic Schema Failure Quarantine&lt;br&gt;Zero Retries Wasted &amp;bull; Immediate Divert&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="320" x="105" y="625" as="geometry" />
        </mxCell>

        <!-- TRIAGE 2: DEAD LETTER CHANNEL -->
        <mxCell id="triage-dlq" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Dead Letter Channel (DLQ)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Semantic Processing Retry Exhaustion&lt;br&gt;Exponential Backoff &amp;bull; Operator Redrive&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="320" x="465" y="625" as="geometry" />
        </mxCell>

        <!-- INTERCONNECT 1: CHANNEL ADAPTER -->
        <mxCell id="inter-adapter" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Channel Adapter (CDC/Kafka Connect)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Bridges Legacy Databases &amp;amp; Storage Feeds&lt;br&gt;Translates Native Events to Broker Conduits&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="340" x="825" y="625" as="geometry" />
        </mxCell>

        <!-- INTERCONNECT 2: MESSAGING BRIDGE & BUS -->
        <mxCell id="inter-bus" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#334155;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#FFFFFF;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px; color: #FFFFFF;&quot;&gt;Messaging Bridge &amp;amp; Enterprise Message Bus&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#E2E8F0&quot;&gt;MirrorMaker 2 &amp;bull; Cross-Region Mesh &amp;bull; Event Mesh Backbone&lt;br&gt;Federated Decoupled Interoperability Across Organizations&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="330" x="1195" y="625" as="geometry" />
        </mxCell>

        <!-- FOOTER SUMMARY NOTE -->
        <mxCell id="tier3-footer" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Enterprise Invariant Summary:&lt;/b&gt;&lt;br&gt;• &lt;b&gt;Decoupled Transmission:&lt;/b&gt; Producers address logical channels without binding to consumer scale, topology, or operational uptime.&lt;br&gt;• &lt;b&gt;Storage Persistence:&lt;/b&gt; Durability is enforced via fsync write-ahead logs and majority replica quorums before producer acknowledgement.&lt;br&gt;• &lt;b&gt;Deterministic Triage:&lt;/b&gt; Unrecoverable syntax errors bypass retry loops directly to Invalid Message Channels, while transient semantic failures exhaust backoff budgets before containment in Dead Letter Channels." vertex="1">
          <mxGeometry height="60" width="1400" x="105" y="720" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
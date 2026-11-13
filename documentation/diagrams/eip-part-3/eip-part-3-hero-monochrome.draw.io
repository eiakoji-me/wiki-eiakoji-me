<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-3-hero-monochrome" name="EIP Part III Hero Message Construction">
    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- TIER 1: ENVELOPE ANATOMY & METADATA -->
        <mxCell id="tier1-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="130" width="1440" x="80" y="45" as="geometry" />
        </mxCell>
        <mxCell id="tier1-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. MESSAGE ANATOMY &amp;amp; ENVELOPE SPECIFICATION" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="55" as="geometry" />
        </mxCell>

        <!-- Tier 1 Components -->
        <mxCell id="t1-headers" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Structured Header Envelope&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Message ID &amp;bull; Correlation ID &amp;bull; Return Address &amp;bull; Timestamp &amp;bull; TTL&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="450" x="105" y="85" as="geometry" />
        </mxCell>
        <mxCell id="t1-payload" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Encapsulated Domain Payload&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Serialized Business State &amp;bull; Binary / Avro / JSON / Protobuf DTO&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="450" x="580" y="85" as="geometry" />
        </mxCell>
        <mxCell id="t1-format" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Format Indicator &amp;amp; Schema ID&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Content-Type &amp;bull; Confluent / Apicurio Global Schema Fingerprint&lt;/font&gt;" vertex="1">
          <mxGeometry height="68" width="450" x="1055" y="85" as="geometry" />
        </mxCell>

        <!-- DISPATCH CONNECTOR -->
        <mxCell id="arr-tier1-tier2" edge="1" parent="1" source="tier1-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier2-container" value="Classified by Semantic Intent ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 2: INTENT TAXONOMY (COMMAND, DOCUMENT, EVENT) -->
        <mxCell id="tier2-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=6;" value="" vertex="1">
          <mxGeometry height="330" width="1440" x="80" y="215" as="geometry" />
        </mxCell>
        <mxCell id="tier2-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. THE INTENT TRIAD: COMMAND, DOCUMENT &amp;amp; EVENT SEMANTICS" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="225" as="geometry" />
        </mxCell>

        <!-- PANEL A: COMMAND MESSAGE -->
        <mxCell id="cmd-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="440" x="105" y="255" as="geometry" />
        </mxCell>
        <mxCell id="cmd-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="A. COMMAND MESSAGE (INVOCATION INTENT)" vertex="1">
          <mxGeometry height="20" width="410" x="120" y="265" as="geometry" />
        </mxCell>
        <mxCell id="cmd-sample" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Intent:&lt;/b&gt; Imperative action request&lt;br&gt;&lt;b&gt;Naming:&lt;/b&gt; Imperative verb (&lt;i&gt;SubmitPayment&lt;/i&gt;)&lt;br&gt;&lt;b&gt;Recipient:&lt;/b&gt; Exactly one designated worker" vertex="1">
          <mxGeometry height="65" width="410" x="120" y="295" as="geometry" />
        </mxCell>
        <mxCell id="cmd-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Sender Coupling&lt;/b&gt;: Caller knows the action to perform.&lt;br&gt;&lt;b&gt;• Side-Effect Expectation&lt;/b&gt;: Mutates state in recipient domain.&lt;br&gt;&lt;b&gt;• Response Model&lt;/b&gt;: Often expects ACK or Reply Message.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Task queue jobs, Saga command messages." vertex="1">
          <mxGeometry height="95" width="410" x="120" y="365" as="geometry" />
        </mxCell>

        <!-- PANEL B: DOCUMENT MESSAGE -->
        <mxCell id="doc-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="440" x="580" y="255" as="geometry" />
        </mxCell>
        <mxCell id="doc-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="B. DOCUMENT MESSAGE (INFORMATION INTENT)" vertex="1">
          <mxGeometry height="20" width="410" x="595" y="265" as="geometry" />
        </mxCell>
        <mxCell id="doc-sample" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Intent:&lt;/b&gt; Transport state without commanding action&lt;br&gt;&lt;b&gt;Naming:&lt;/b&gt; Domain entity noun (&lt;i&gt;InvoiceDocumentDTO&lt;/i&gt;)&lt;br&gt;&lt;b&gt;Recipient:&lt;/b&gt; Any subscriber needing state snapshot" vertex="1">
          <mxGeometry height="65" width="410" x="595" y="295" as="geometry" />
        </mxCell>
        <mxCell id="doc-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Payload Completeness&lt;/b&gt;: Carries entire entity representation.&lt;br&gt;&lt;b&gt;• Decoupled Action&lt;/b&gt;: Receiver decides how to interpret state.&lt;br&gt;&lt;b&gt;• Contract Governance&lt;/b&gt;: Requires schema registry backward compatibility.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: CDC snapshot records, data replication streams." vertex="1">
          <mxGeometry height="95" width="410" x="595" y="365" as="geometry" />
        </mxCell>

        <!-- PANEL C: EVENT MESSAGE -->
        <mxCell id="evt-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="460" x="1045" y="255" as="geometry" />
        </mxCell>
        <mxCell id="evt-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="C. EVENT MESSAGE (NOTIFICATION INTENT)" vertex="1">
          <mxGeometry height="20" width="430" x="1060" y="265" as="geometry" />
        </mxCell>
        <mxCell id="evt-sample" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Intent:&lt;/b&gt; Announce past state change (historical fact)&lt;br&gt;&lt;b&gt;Naming:&lt;/b&gt; Past-tense verb phrase (&lt;i&gt;PaymentAuthorized&lt;/i&gt;)&lt;br&gt;&lt;b&gt;Recipient:&lt;/b&gt; Zero, one, or multiple independent consumer groups" vertex="1">
          <mxGeometry height="65" width="430" x="1060" y="295" as="geometry" />
        </mxCell>
        <mxCell id="evt-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Complete Independence&lt;/b&gt;: Emitter is agnostic to downstream existence.&lt;br&gt;&lt;b&gt;• Immutability&lt;/b&gt;: Historical event cannot be altered, only compensated.&lt;br&gt;&lt;b&gt;• Temporal Decoupling&lt;/b&gt;: Consumers consume at individual latencies.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Kafka topic logs, AWS EventBridge domain events." vertex="1">
          <mxGeometry height="95" width="430" x="1060" y="365" as="geometry" />
        </mxCell>

        <!-- COORDINATION CONNECTOR -->
        <mxCell id="arr-tier2-tier3" edge="1" parent="1" source="tier2-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier3-container" value="Coordinated via Asynchronous Correlation Primitives ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 3: ASYNC REQUEST-REPLY CORRELATION FABRIC -->
        <mxCell id="tier3-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="280" width="1440" x="80" y="580" as="geometry" />
        </mxCell>
        <mxCell id="tier3-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="3. ASYNCHRONOUS REQUEST-REPLY CORRELATION FABRIC" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="590" as="geometry" />
        </mxCell>

        <!-- Client Box -->
        <mxCell id="t3-client" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b&gt;Originating Client&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Generates Correlation ID (UUIDv7)&lt;br&gt;Stores pending Promise / Future&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="220" x="105" y="630" as="geometry" />
        </mxCell>

        <!-- Request Channel -->
        <mxCell id="t3-req-pipe" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=6;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Request Channel&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;[Command Payload]&lt;br&gt;&lt;i&gt;reply_to = client.replies&lt;/i&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="170" x="385" y="615" as="geometry" />
        </mxCell>

        <!-- Worker Box -->
        <mxCell id="t3-worker" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b&gt;Processing Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Executes Domain Transaction&lt;br&gt;Echoes Correlation ID into Response&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="210" x="625" y="630" as="geometry" />
        </mxCell>

        <!-- Reply Channel -->
        <mxCell id="t3-reply-pipe" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=6;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Return Address Channel&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;[Response Payload]&lt;br&gt;&lt;i&gt;correlation_id = id_req&lt;/i&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="170" x="900" y="685" as="geometry" />
        </mxCell>

        <!-- Dispatcher & Promise Resolver -->
        <mxCell id="t3-resolver" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b&gt;Correlation Dispatcher&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Lookup &amp;amp; Complete Future&lt;br&gt;Evict from Correlation Map&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="190" x="1130" y="630" as="geometry" />
        </mxCell>

        <!-- Shaded Rectangle: Orphan & Timeout Quarantine (Using standard: dark font, white text background) -->
        <mxCell id="t3-quarantine" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#334155;strokeColor=#0F172A;strokeWidth=1.8;fontColor=light-dark(#080808,#000000);fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;span style=&quot;background-color: light-dark(#ffffff, var(--ge-dark-color, #121212));&quot;&gt;&lt;b style=&quot;font-size: 11px;&quot;&gt;Orphan Quarantine Sink&lt;/b&gt;&lt;br&gt;Expired correlation TTL • Late replies dropped&lt;br&gt;Circuit breaker memory cleanup&lt;/span&gt;" vertex="1">
          <mxGeometry height="70" width="170" x="1335" y="630" as="geometry" />
        </mxCell>

        <!-- Connecting Flows -->
        <mxCell id="arr-c-req" edge="1" parent="1" source="t3-client" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="t3-req-pipe">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-req-w" edge="1" parent="1" source="t3-req-pipe" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="t3-worker">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-w-rep" edge="1" parent="1" source="t3-worker" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="t3-reply-pipe">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-rep-res" edge="1" parent="1" source="t3-reply-pipe" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="t3-resolver">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-res-quar" edge="1" parent="1" source="t3-resolver" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;dashed=1;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="t3-quarantine" value="Timeout">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- FOOTER INVARIANT NOTE -->
        <mxCell id="tier3-footer" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Enterprise Construction Invariants:&lt;/b&gt;&lt;br&gt;• &lt;b&gt;Intent Disambiguation:&lt;/b&gt; Do not overload Event Messages with invocation commands; events report what has occurred, commands state what must happen.&lt;br&gt;• &lt;b&gt;Asynchronous Correlation:&lt;/b&gt; Request-Reply over queues requires immutable Correlation IDs and dynamic Return Addresses to prevent client thread pool blocking.&lt;br&gt;• &lt;b&gt;TTL Bounds:&lt;/b&gt; Every in-flight correlation must define a client-side expiration deadline to prevent unbounded memory growth from lost response packets." vertex="1">
          <mxGeometry height="50" width="1400" x="105" y="790" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

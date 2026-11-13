<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-6-transactional-outbox-cdc" name="Transactional Outbox CDC vs Dual Write">
    <mxGraphModel dx="1400" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="720" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Title Banner -->
        <mxCell id="main-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="660" width="1320" x="40" y="30" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="ELIMINATING THE DUAL-WRITE HAZARD: DIRECT TWO-PHASE WRITE VS. TRANSACTIONAL OUTBOX CDC" vertex="1">
          <mxGeometry height="25" width="1100" x="65" y="40" as="geometry" />
        </mxCell>

        <!-- LEFT PANEL: THE DUAL WRITE ANTI-PATTERN -->
        <mxCell id="left-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="470" width="620" x="65" y="75" as="geometry" />
        </mxCell>
        <mxCell id="left-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#DC2626;fontFamily=Comic Sans MS;" value="A. THE DUAL-WRITE HAZARD (NON-ATOMIC SPLIT BRAIN)" vertex="1">
          <mxGeometry height="20" width="550" x="85" y="85" as="geometry" />
        </mxCell>

        <!-- App Client Box -->
        <mxCell id="dw-client" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Application Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Attempts dual write:&lt;br&gt;1. Commit to DB&lt;br&gt;2. Publish to Broker&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="160" x="85" y="160" as="geometry" />
        </mxCell>

        <!-- Database Box -->
        <mxCell id="dw-db" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#DCFCE7;strokeColor=#16A34A;strokeWidth=1.8;fontColor=#166534;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Relational DB&lt;/b&gt;&lt;br&gt;UPDATE orders&lt;br&gt;SET status='PAID'&lt;br&gt;&lt;b style=&quot;color:#16A34A;&quot;&gt;✓ COMMITTED&lt;/b&gt;" vertex="1">
          <mxGeometry height="110" width="160" x="380" y="115" as="geometry" />
        </mxCell>

        <!-- Broker Box with Failure -->
        <mxCell id="dw-broker" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FEE2E2;strokeColor=#DC2626;strokeWidth=1.8;fontColor=#991B1B;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Message Broker&lt;/b&gt;&lt;br&gt;Kafka Topic&lt;br&gt;&lt;b style=&quot;color:#DC2626;&quot;&gt;✗ TIMEOUT / CRASH!&lt;br&gt;(Event Never Sent)&lt;/b&gt;" vertex="1">
          <mxGeometry height="110" width="160" x="380" y="275" as="geometry" />
        </mxCell>

        <!-- Arrows showing dual write failure -->
        <mxCell id="arr-dw-1" edge="1" parent="1" source="dw-client" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.5;endArrow=block;endFill=1;" target="dw-db">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-dw-2" edge="1" parent="1" source="dw-client" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.5;dashed=1;endArrow=block;endFill=1;" target="dw-broker">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Dual Write Consequences Box -->
        <mxCell id="dw-props" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#334155;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" value="&lt;b style=&quot;color:#DC2626;font-size:11px;&quot;&gt;The Catastrophic Split-Brain State:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Local DB Committed&lt;/b&gt;: Customer credit was deducted and order is marked PAID.&lt;br&gt;&amp;bull; &lt;b&gt;Broker Publish Failed&lt;/b&gt;: Network blip severed connection before event landed.&lt;br&gt;&amp;bull; &lt;b&gt;Downstream Consequence&lt;/b&gt;: Warehouse never receives notification; goods are never shipped.&lt;br&gt;&amp;bull; &lt;b&gt;No Rollback Possible&lt;/b&gt;: The DB transaction already completed before broker call failed." vertex="1">
          <mxGeometry height="95" width="580" x="85" y="435" as="geometry" />
        </mxCell>

        <!-- RIGHT PANEL: TRANSACTIONAL OUTBOX CDC -->
        <mxCell id="right-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="470" width="650" x="710" y="75" as="geometry" />
        </mxCell>
        <mxCell id="right-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#16A34A;fontFamily=Comic Sans MS;" value="B. THE TRANSACTIONAL OUTBOX + DEBEZIUM CDC PATTERN" vertex="1">
          <mxGeometry height="20" width="550" x="730" y="85" as="geometry" />
        </mxCell>

        <!-- Outbox App Client -->
        <mxCell id="ob-client" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Application Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#16A34A&quot;&gt;&lt;b&gt;Single Atomic ACID TX:&lt;/b&gt;&lt;/font&gt;&lt;br&gt;1. UPDATE orders&lt;br&gt;2. INSERT INTO outbox" vertex="1">
          <mxGeometry height="80" width="160" x="730" y="160" as="geometry" />
        </mxCell>

        <!-- Postgres DB with Outbox Table -->
        <mxCell id="ob-db" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b style=&quot;font-size: 11px;&quot;&gt;PostgreSQL DB&lt;/b&gt;&lt;br&gt;&lt;b&gt;orders table&lt;/b&gt;&lt;br&gt;&lt;b&gt;outbox table&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#2563EB&quot;&gt;&lt;b&gt;Write-Ahead Log (WAL)&lt;/b&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="130" width="150" x="930" y="135" as="geometry" />
        </mxCell>

        <!-- Arrow Client -> DB -->
        <mxCell id="arr-ob-1" edge="1" parent="1" source="ob-client" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.8;endArrow=block;endFill=1;" target="ob-db">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Debezium CDC Engine -->
        <mxCell id="ob-cdc" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#DCFCE7;strokeColor=#16A34A;strokeWidth=1.8;fontColor=#166534;fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b style=&quot;font-size: 11px;&quot;&gt;Debezium CDC&lt;/b&gt;&lt;br&gt;Tails WAL stream&lt;br&gt;Zero DB queries&lt;br&gt;Guarantees order" vertex="1">
          <mxGeometry height="80" width="120" x="1120" y="160" as="geometry" />
        </mxCell>

        <!-- Arrow WAL -> CDC -->
        <mxCell id="arr-ob-2" edge="1" parent="1" source="ob-db" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#2563EB;strokeWidth=1.8;endArrow=block;endFill=1;" target="ob-cdc">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Kafka Topic -->
        <mxCell id="ob-kafka" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b style=&quot;font-size: 11px;&quot;&gt;Apache Kafka&lt;/b&gt;&lt;br&gt;orders.events&lt;br&gt;&lt;b style=&quot;color:#16A34A;&quot;&gt;Ack: all replicas&lt;/b&gt;" vertex="1">
          <mxGeometry height="100" width="130" x="1115" y="300" as="geometry" />
        </mxCell>

        <!-- Arrow CDC -> Kafka -->
        <mxCell id="arr-ob-3" edge="1" parent="1" source="ob-cdc" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.8;endArrow=block;endFill=1;" target="ob-kafka">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Outbox Advantages Box -->
        <mxCell id="ob-props" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#334155;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" value="&lt;b style=&quot;color:#16A34A;font-size:11px;&quot;&gt;Transactional Outbox Guarantees:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Atomic Ingress&lt;/b&gt;: Either both the order state and the outbox event commit, or neither does.&lt;br&gt;&amp;bull; &lt;b&gt;Asynchronous Decoupling&lt;/b&gt;: CDC publisher operates independently of application thread pool.&lt;br&gt;&amp;bull; &lt;b&gt;Zero Database Polling Overhead&lt;/b&gt;: WAL tailing imposes zero lock contention on business tables." vertex="1">
          <mxGeometry height="95" width="600" x="730" y="435" as="geometry" />
        </mxCell>

        <!-- BOTTOM DECISION RULE SHADED BOX adhering to standard -->
        <mxCell id="bot-rule-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;arcSize=4;" value="&lt;b&gt;The Invariant:&lt;/b&gt; Never attempt two-phase commits (2PC) or uncoordinated dual writes across database and message broker boundaries. Standardize on the &lt;b&gt;Transactional Outbox Pattern&lt;/b&gt; backed by Change Data Capture (CDC) write-ahead log tailing." vertex="1">
          <mxGeometry height="50" width="1270" x="65" y="570" as="geometry" />
        </mxCell>

        <!-- Footer -->
        <mxCell id="footer-text" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="EIP Part VI: Messaging Endpoints and Reliable Processing &amp;bull; wiki.eiakoji.me" vertex="1">
          <mxGeometry height="20" width="1320" x="40" y="635" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
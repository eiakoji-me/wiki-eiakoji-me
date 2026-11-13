<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-4-routing-slip-vs-saga" name="Routing Slip vs Process Manager Saga">
    <mxGraphModel dx="1400" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="720" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Title Banner -->
        <mxCell id="main-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="660" width="1320" x="40" y="30" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="PROCESS COORDINATION ARCHETYPES: ROUTING SLIP (CHOREOGRAPHY) VS. PROCESS MANAGER (SAGA)" vertex="1">
          <mxGeometry height="25" width="1000" x="65" y="40" as="geometry" />
        </mxCell>

        <!-- LEFT PANEL: ROUTING SLIP -->
        <mxCell id="left-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="470" width="620" x="65" y="75" as="geometry" />
        </mxCell>
        <mxCell id="left-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="A. ROUTING SLIP: DECENTRALIZED CHOREOGRAPHY" vertex="1">
          <mxGeometry height="20" width="450" x="85" y="85" as="geometry" />
        </mxCell>

        <!-- Message with Itinerary Header -->
        <mxCell id="slip-msg-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b&gt;Inbound Message Envelope&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#3B82F6&quot;&gt;&lt;b&gt;Header: routing-slip&lt;/b&gt;&lt;/font&gt;&lt;br&gt;&lt;font color=&quot;#64748B&quot;&gt;[Validator, Billing, Inventory]&lt;/font&gt;&lt;br&gt;&lt;b&gt;Payload:&lt;/b&gt; OrderDTO" vertex="1">
          <mxGeometry height="75" width="180" x="85" y="125" as="geometry" />
        </mxCell>

        <!-- Arrow to Step 1 -->
        <mxCell id="arr-slip-s1" edge="1" parent="1" source="slip-msg-1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="slip-svc1">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Step 1: Validator -->
        <mxCell id="slip-svc1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;1. Validator Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Validates payload schema&lt;br&gt;Pops self from itinerary&lt;br&gt;Forwards to: &lt;b&gt;Billing&lt;/b&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="160" x="310" y="128" as="geometry" />
        </mxCell>

        <!-- Arrow to Step 2 -->
        <mxCell id="arr-slip-s2" edge="1" parent="1" source="slip-svc1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="slip-svc2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Step 2: Billing -->
        <mxCell id="slip-svc2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;2. Billing Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Charges customer credit&lt;br&gt;Pops self from itinerary&lt;br&gt;Forwards to: &lt;b&gt;Inventory&lt;/b&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="160" x="310" y="235" as="geometry" />
        </mxCell>

        <!-- Arrow to Step 3 -->
        <mxCell id="arr-slip-s3" edge="1" parent="1" source="slip-svc2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="slip-svc3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Step 3: Inventory -->
        <mxCell id="slip-svc3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;3. Inventory Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Allocates warehouse stock&lt;br&gt;Itinerary is now empty&lt;br&gt;&lt;b style=&quot;color:#16A34A;&quot;&gt;Route Completed&lt;/b&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="160" x="310" y="340" as="geometry" />
        </mxCell>

        <!-- Left Properties Box -->
        <mxCell id="slip-props" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#334155;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" value="&lt;b style=&quot;color:#0F172A;font-size:11px;&quot;&gt;Choreography Trade-Offs:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Decentralized&lt;/b&gt;: No single coordinator or bottleneck.&lt;br&gt;&amp;bull; &lt;b&gt;Extensibility&lt;/b&gt;: Dynamic itinerary determined at runtime.&lt;br&gt;&amp;bull; &lt;b&gt;Failure Liability&lt;/b&gt;: If Inventory fails, Billing doesn't know it must refund unless reverse compensation slips are embedded." vertex="1">
          <mxGeometry height="85" width="580" x="85" y="440" as="geometry" />
        </mxCell>

        <!-- RIGHT PANEL: PROCESS MANAGER / SAGA -->
        <mxCell id="right-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="470" width="650" x="710" y="75" as="geometry" />
        </mxCell>
        <mxCell id="right-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="B. PROCESS MANAGER (SAGA): CENTRALIZED ORCHESTRATION" vertex="1">
          <mxGeometry height="20" width="500" x="730" y="85" as="geometry" />
        </mxCell>

        <!-- Central Coordinator Box -->
        <mxCell id="saga-coordinator" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Order Saga Coordinator&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Persistent State Machine (WAL)&lt;br&gt;Current State: &lt;b&gt;PAYMENT_SETTLED&lt;/b&gt;&lt;br&gt;Awaiting: InventoryAllocation&lt;br&gt;Executes Compensations on Error&lt;/font&gt;" vertex="1">
          <mxGeometry height="140" width="220" x="730" y="160" as="geometry" />
        </mxCell>

        <!-- Service 1: Payment -->
        <mxCell id="saga-svc-pay" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Payment Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#16A34A&quot;&gt;[1] AuthorizePayment ➔ OK&lt;/font&gt;&lt;br&gt;&lt;font color=&quot;#DC2626&quot;&gt;[3] Compensate: RefundPayment&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="1090" y="125" as="geometry" />
        </mxCell>

        <!-- Service 2: Inventory -->
        <mxCell id="saga-svc-inv" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Inventory Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#DC2626&quot;&gt;[2] ReserveStock ➔ FAILED!&lt;br&gt;(Item Out of Stock)&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="230" x="1090" y="240" as="geometry" />
        </mxCell>

        <!-- Forward / Compensating Arrows -->
        <mxCell id="arr-saga-fwd1" edge="1" parent="1" source="saga-coordinator" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.5;endArrow=block;endFill=1;" target="saga-svc-pay">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-saga-fwd2" edge="1" parent="1" source="saga-coordinator" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.5;endArrow=block;endFill=1;" target="saga-svc-inv">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Compensation trigger back to payment -->
        <mxCell id="arr-saga-comp" edge="1" parent="1" source="saga-coordinator" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.5;dashed=1;endArrow=block;endFill=1;" target="saga-svc-pay">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="840" y="325" />
              <mxPoint x="1205" y="325" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Right Properties Box -->
        <mxCell id="saga-props" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#334155;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" value="&lt;b style=&quot;color:#0F172A;font-size:11px;&quot;&gt;Orchestration Trade-Offs:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Deterministic Recovery&lt;/b&gt;: Coordinator manages rollback matrix and state history.&lt;br&gt;&amp;bull; &lt;b&gt;Decoupled Services&lt;/b&gt;: Workers know only their own task API, not the workflow sequence.&lt;br&gt;&amp;bull; &lt;b&gt;Coordination Overhead&lt;/b&gt;: Coordinator requires database state storage and crash recovery." vertex="1">
          <mxGeometry height="85" width="600" x="730" y="440" as="geometry" />
        </mxCell>

        <!-- BOTTOM DECISION RULE SHADED BOX adhering to standard -->
        <mxCell id="bot-rule-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;arcSize=4;" value="&lt;b&gt;Architectural Rule of Thumb:&lt;/b&gt; Use &lt;b&gt;Routing Slip&lt;/b&gt; for linear, forward-only data transformations with zero backward dependencies. Use &lt;b&gt;Process Manager (Saga)&lt;/b&gt; whenever transactions require multi-entity coordination, timeouts, or semantic compensating rollbacks." vertex="1">
          <mxGeometry height="60" width="1270" x="65" y="560" as="geometry" />
        </mxCell>

        <!-- Footer -->
        <mxCell id="footer-text" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="EIP Part IV: Message Routing and Process Coordination &amp;bull; wiki.eiakoji.me" vertex="1">
          <mxGeometry height="20" width="1320" x="40" y="635" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
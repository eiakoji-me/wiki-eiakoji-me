<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-8-saga-compensation-matrix" name="Distributed Saga State Machine and Compensation Matrix">
    <mxGraphModel dx="1500" dy="750" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1500" pageHeight="750" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- MAIN CONTAINER -->
        <mxCell id="main-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="670" width="1420" x="40" y="40" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="DISTRIBUTED SAGA STATE MACHINE: FORWARD EXECUTION &amp;amp; BACKWARD COMPENSATION MATRIX" vertex="1">
          <mxGeometry height="24" width="1000" x="65" y="52" as="geometry" />
        </mxCell>

        <!-- TOP SECTION: FORWARD TRANSACTIONS (T1 -> T2 -> T3 -> T4) -->
        <mxCell id="fwd-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="160" width="1370" x="65" y="90" as="geometry" />
        </mxCell>
        <mxCell id="fwd-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="FORWARD TRANSACTION SEQUENCE (T1 ➔ T2 ➔ T3 ➔ T4)" vertex="1">
          <mxGeometry height="20" width="600" x="85" y="98" as="geometry" />
        </mxCell>

        <mxCell id="t1-node" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;T1: Reserve Credit&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Customer Balance Hold&lt;br&gt;Local ACID Commit&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="220" x="85" y="135" as="geometry" />
        </mxCell>

        <mxCell id="t2-node" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;T2: Allocate Inventory&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Warehouse Stock Lock&lt;br&gt;Local ACID Commit&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="220" x="385" y="135" as="geometry" />
        </mxCell>

        <mxCell id="t3-node" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;T3: Authorize Payment&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Card Capture Gateway&lt;br&gt;External PSP Call&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="220" x="685" y="135" as="geometry" />
        </mxCell>

        <mxCell id="t4-failure-node" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#DC2626;strokeWidth=2;fontColor=#DC2626;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;T4: Dispatch Shipment&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#DC2626&quot;&gt;&lt;b&gt;CRITICAL FAILURE / REJECTION&lt;/b&gt;&lt;br&gt;Carrier Outage / Address Invalid&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="240" x="985" y="135" as="geometry" />
        </mxCell>

        <!-- Forward Arrows -->
        <mxCell id="arr-t1-t2" edge="1" parent="1" source="t1-node" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="t2-node">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-t2-t3" edge="1" parent="1" source="t2-node" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="t3-node">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-t3-t4" edge="1" parent="1" source="t3-node" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="t4-failure-node">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- MIDDLE SECTION: SAGA ORCHESTRATOR & DURABLE LOG -->
        <mxCell id="orch-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="140" width="1370" x="65" y="270" as="geometry" />
        </mxCell>
        <mxCell id="orch-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="DURABLE SAGA ORCHESTRATION ENGINE &amp;amp; STATE REPOSITORY" vertex="1">
          <mxGeometry height="20" width="600" x="85" y="278" as="geometry" />
        </mxCell>

        <mxCell id="orch-engine" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Saga Coordinator (Finite State Machine)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Detects T4 failure &amp;bull; Evaluates compensation DAG&lt;br&gt;Schedules reverse compensation sequence: C3 ➔ C2 ➔ C1&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="550" x="85" y="315" as="geometry" />
        </mxCell>

        <mxCell id="orch-db" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Durable Saga Log (DB / Kafka)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;SagaID &amp;bull; CurrentState (FAILED_COMPENSATING)&lt;br&gt;Payload Snapshots &amp;bull; Idempotency Keys&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="400" x="685" y="307" as="geometry" />
        </mxCell>

        <!-- Downward Failure Trigger -->
        <mxCell id="arr-fail-orch" edge="1" parent="1" source="t4-failure-node" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#DC2626;strokeWidth=2;endArrow=block;endFill=1;dashed=1;" target="orch-engine">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1105" y="240" />
              <mxPoint x="360" y="240" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- BOTTOM SECTION: BACKWARD COMPENSATING TRANSACTIONS (C3 -> C2 -> C1) -->
        <mxCell id="comp-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="160" width="1370" x="65" y="430" as="geometry" />
        </mxCell>
        <mxCell id="comp-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="BACKWARD COMPENSATING SEQUENCE (C3 ➔ C2 ➔ C1)" vertex="1">
          <mxGeometry height="20" width="600" x="85" y="438" as="geometry" />
        </mxCell>

        <mxCell id="c3-node" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;C3: Void Payment Authorization&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Cancels capture hold at PSP&lt;br&gt;Idempotent reversal API&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="230" x="685" y="475" as="geometry" />
        </mxCell>

        <mxCell id="c2-node" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;C2: Release Warehouse Stock&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Increments available inventory&lt;br&gt;Compensating ACID commit&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="220" x="385" y="475" as="geometry" />
        </mxCell>

        <mxCell id="c1-node" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;C1: Release Credit Hold&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Restores customer credit limit&lt;br&gt;Emits OrderCancelled event&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="220" x="85" y="475" as="geometry" />
        </mxCell>

        <!-- Compensation Arrows -->
        <mxCell id="arr-orch-c3" edge="1" parent="1" source="orch-engine" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="c3-node">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-c3-c2" edge="1" parent="1" source="c3-node" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="c2-node">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-c2-c1" edge="1" parent="1" source="c2-node" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="c1-node">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- FOOTER SHADED INVARIANT BOX -->
        <mxCell id="footer-shaded" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#000000;labelBackgroundColor=#FFFFFF;arcSize=6;" value="" vertex="1">
          <mxGeometry height="80" width="1370" x="65" y="610" as="geometry" />
        </mxCell>
        <mxCell id="f-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontStyle=1;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontFamily=Comic Sans MS;" value="SAGA COMPENSATION AXIOMS &amp;amp; INVARIANTS:" vertex="1">
          <mxGeometry height="18" width="600" x="85" y="616" as="geometry" />
        </mxCell>
        <mxCell id="f-text" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontFamily=Comic Sans MS;" value="&lt;b&gt;1. Strict Reverse Order:&lt;/b&gt; Compensations execute in exact reverse order (C_k, C_{k-1}, ..., C_1) to unwind partial state without side-effect collisions.&lt;br&gt;&lt;b&gt;2. Mandatory Idempotence:&lt;/b&gt; A compensating transaction must be retryable indefinitely until success. If C_k fails due to network outage, it must retry without multiplying refunds.&lt;br&gt;&lt;b&gt;3. Semantic Rollback:&lt;/b&gt; Sagas do NOT restore physical database snapshots; they apply forward-correcting semantic compensations (e.g., credit adjustment entries)." vertex="1">
          <mxGeometry height="50" width="1330" x="85" y="635" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

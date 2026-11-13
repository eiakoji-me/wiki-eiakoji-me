<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-1-four-integration-styles" name="The Four Integration Styles">
    <mxGraphModel dx="1200" dy="650" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="650" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- STYLE 1: FILE TRANSFER -->
        <mxCell id="s1-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="530" x="50" y="40" as="geometry" />
        </mxCell>
        <mxCell id="s1-label" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="1. FILE TRANSFER (BATCH INTEGRATION)" vertex="1">
          <mxGeometry height="24" width="480" x="70" y="55" as="geometry" />
        </mxCell>
        <mxCell id="s1-producer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Producer App&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Generates CSV / Parquet&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="130" x="70" y="100" as="geometry" />
        </mxCell>
        <mxCell id="s1-storage" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Shared File Store&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;NFS / S3 Bucket&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="130" x="250" y="95" as="geometry" />
        </mxCell>
        <mxCell id="s1-consumer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Consumer App&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Periodic Batch Poll&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="130" x="430" y="100" as="geometry" />
        </mxCell>
        <mxCell id="s1-arr1" edge="1" parent="1" source="s1-producer" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="s1-storage" value="Export">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s1-arr2" edge="1" parent="1" source="s1-storage" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="s1-consumer" value="Poll">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s1-desc" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Decoupling:&lt;/b&gt; High temporal decoupling; callers never coordinate execution.&lt;br&gt;&lt;b&gt;Tradeoff:&lt;/b&gt; High latency (batch intervals) and fragile file schema agreement." vertex="1">
          <mxGeometry height="50" width="480" x="70" y="190" as="geometry" />
        </mxCell>

        <!-- STYLE 2: SHARED DATABASE -->
        <mxCell id="s2-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="530" x="620" y="40" as="geometry" />
        </mxCell>
        <mxCell id="s2-label" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="2. SHARED DATABASE (DATA COUPLING)" vertex="1">
          <mxGeometry height="24" width="480" x="640" y="55" as="geometry" />
        </mxCell>
        <mxCell id="s2-appA" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Service A&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Writes to tables&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="130" x="640" y="100" as="geometry" />
        </mxCell>
        <mxCell id="s2-db" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Unified DB&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Shared Schema &amp;amp; Locks&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="130" x="820" y="95" as="geometry" />
        </mxCell>
        <mxCell id="s2-appB" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Service B&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Reads from tables&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="130" x="1000" y="100" as="geometry" />
        </mxCell>
        <mxCell id="s2-arr1" edge="1" parent="1" source="s2-appA" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="s2-db" value="INSERT">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s2-arr2" edge="1" parent="1" source="s2-db" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="s2-appB" value="SELECT">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s2-desc" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Advantage:&lt;/b&gt; Immediate consistent data availability and transactional isolation.&lt;br&gt;&lt;b&gt;Tradeoff:&lt;/b&gt; Severe data coupling; schema migrations lock both services simultaneously." vertex="1">
          <mxGeometry height="50" width="480" x="640" y="190" as="geometry" />
        </mxCell>

        <!-- STYLE 3: REMOTE PROCEDURE INVOCATION -->
        <mxCell id="s3-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="530" x="50" y="340" as="geometry" />
        </mxCell>
        <mxCell id="s3-label" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="3. REMOTE PROCEDURE INVOCATION (RPC / REST)" vertex="1">
          <mxGeometry height="24" width="480" x="70" y="355" as="geometry" />
        </mxCell>
        <mxCell id="s3-client" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Caller / Client&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Blocks worker thread&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="150" x="70" y="400" as="geometry" />
        </mxCell>
        <mxCell id="s3-server" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Callee / Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Executes sync request&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="150" x="410" y="400" as="geometry" />
        </mxCell>
        <mxCell id="s3-req" edge="1" parent="1" source="s3-client" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="s3-server" value="HTTP POST / gRPC (Blocking)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="310" y="415" />
              <mxPoint x="310" y="415" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="s3-res" edge="1" parent="1" source="s3-server" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#64748B;strokeWidth=1.5;strokeFactor=1;dashed=1;dashPattern=4 4;endArrow=open;endFill=0;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="s3-client" value="Response Payload">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="310" y="445" />
              <mxPoint x="310" y="445" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="s3-desc" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Advantage:&lt;/b&gt; Familiar method-call ergonomics and immediate response semantics.&lt;br&gt;&lt;b&gt;Tradeoff:&lt;/b&gt; Temporal &amp;amp; spatial lockstep; downstream stalls saturate caller threads." vertex="1">
          <mxGeometry height="50" width="480" x="70" y="490" as="geometry" />
        </mxCell>

        <!-- STYLE 4: ASYNCHRONOUS MESSAGING -->
        <mxCell id="s4-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="530" x="620" y="340" as="geometry" />
        </mxCell>
        <mxCell id="s4-label" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="4. ASYNCHRONOUS MESSAGING (DECOUPLED PIPELINE)" vertex="1">
          <mxGeometry height="24" width="480" x="640" y="355" as="geometry" />
        </mxCell>
        <mxCell id="s4-producer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Producer&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Fire-and-forget emit&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="130" x="640" y="400" as="geometry" />
        </mxCell>
        <mxCell id="s4-channel" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Message Channel&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Durable Queue Buffer&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="130" x="820" y="395" as="geometry" />
        </mxCell>
        <mxCell id="s4-consumer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Consumer&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Decoupled listener&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="130" x="1000" y="400" as="geometry" />
        </mxCell>
        <mxCell id="s4-arr1" edge="1" parent="1" source="s4-producer" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="s4-channel" value="Enqueue">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s4-arr2" edge="1" parent="1" source="s4-channel" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;" target="s4-consumer" value="Deliver">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s4-desc" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Advantage:&lt;/b&gt; Temporal &amp;amp; spatial decoupling; elasticity &amp;amp; graceful traffic absorption.&lt;br&gt;&lt;b&gt;Tradeoff:&lt;/b&gt; Eventual consistency, asynchronous error handling, messaging broker ops." vertex="1">
          <mxGeometry height="50" width="480" x="640" y="490" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
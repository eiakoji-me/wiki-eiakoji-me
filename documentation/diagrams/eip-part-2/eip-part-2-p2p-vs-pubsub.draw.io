<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-2-p2p-vs-pubsub" name="Point-to-Point vs Publish-Subscribe Topologies">
    <mxGraphModel dx="1200" dy="700" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="400" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- MAIN CONTAINER -->
        <mxCell id="main-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="300" width="1120" x="40" y="30" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="CHANNEL TOPOLOGY COMPARISON: POINT-TO-POINT QUEUE VS. PUBLISH-SUBSCRIBE TOPIC" vertex="1">
          <mxGeometry height="22" width="900" x="60" y="40" as="geometry" />
        </mxCell>

        <!-- PANEL A: POINT-TO-POINT -->
        <mxCell id="p2p-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="225" width="510" x="60" y="75" as="geometry" />
        </mxCell>
        <mxCell id="p2p-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="POINT-TO-POINT CHANNEL (COMPETING CONSUMERS)" vertex="1">
          <mxGeometry height="20" width="480" x="75" y="85" as="geometry" />
        </mxCell>

        <!-- P2P Producer -->
        <mxCell id="p2p-prod" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Producer&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Enqueue&lt;/font&gt;" vertex="1">
          <mxGeometry height="50" width="85" x="75" y="115" as="geometry" />
        </mxCell>
        <!-- P2P Queue -->
        <mxCell id="p2p-cyl" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=8;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Work Queue&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:10px;&quot;&gt;[m3][m2][m1]&lt;/font&gt;" vertex="1">
          <mxGeometry height="55" width="110" x="190" y="112" as="geometry" />
        </mxCell>
        <!-- P2P Workers -->
        <mxCell id="p2p-w1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Worker 1&lt;/b&gt; (Pulls m1)" vertex="1">
          <mxGeometry height="24" width="135" x="330" y="105" as="geometry" />
        </mxCell>
        <mxCell id="p2p-w2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Worker 2&lt;/b&gt; (Pulls m2)" vertex="1">
          <mxGeometry height="24" width="135" x="330" y="132" as="geometry" />
        </mxCell>
        <mxCell id="p2p-w3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Worker 3&lt;/b&gt; (Idle / Ready)" vertex="1">
          <mxGeometry height="24" width="135" x="330" y="159" as="geometry" />
        </mxCell>

        <!-- Arrows P2P -->
        <mxCell id="arr-p2p-1" edge="1" parent="1" source="p2p-prod" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="p2p-cyl">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-p2p-2" edge="1" parent="1" source="p2p-cyl" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="p2p-w1">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-p2p-3" edge="1" parent="1" source="p2p-cyl" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="p2p-w2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="p2p-desc" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Key Mechanics:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Exactly-One Receiver&lt;/b&gt;: Each message delivered to one worker only.&lt;br&gt;&amp;bull; &lt;b&gt;Dynamic Load Distribution&lt;/b&gt;: Faster workers drain more work.&lt;br&gt;&amp;bull; &lt;b&gt;Destructive Consumption&lt;/b&gt;: Message deleted upon ACK." vertex="1">
          <mxGeometry height="45" width="480" x="75" y="195" as="geometry" />
        </mxCell>

        <!-- PANEL B: PUBLISH-SUBSCRIBE -->
        <mxCell id="pubsub-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="225" width="570" x="590" y="75" as="geometry" />
        </mxCell>
        <mxCell id="pubsub-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="PUBLISH-SUBSCRIBE CHANNEL (TOPIC FANOUT &amp;amp; CONSUMER GROUPS)" vertex="1">
          <mxGeometry height="20" width="540" x="605" y="85" as="geometry" />
        </mxCell>

        <!-- PubSub Producer -->
        <mxCell id="ps-prod" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Publisher&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Publish Event&lt;/font&gt;" vertex="1">
          <mxGeometry height="50" width="85" x="605" y="115" as="geometry" />
        </mxCell>
        <!-- PubSub Topic -->
        <mxCell id="ps-topic" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=8;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Topic Log&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:10px;&quot;&gt;Partitioned WAL&lt;br&gt;[o0][o1][o2][o3]&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="120" x="720" y="110" as="geometry" />
        </mxCell>
        <!-- PubSub Groups -->
        <mxCell id="ps-g1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Consumer Group A (Billing)&lt;/b&gt;&lt;br&gt;Offset: 3 &amp;bull; Independent Cursor" vertex="1">
          <mxGeometry height="32" width="200" x="875" y="105" as="geometry" />
        </mxCell>
        <mxCell id="ps-g2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Consumer Group B (Audit/Log)&lt;/b&gt;&lt;br&gt;Offset: 2 &amp;bull; Replayable Stream" vertex="1">
          <mxGeometry height="32" width="200" x="875" y="145" as="geometry" />
        </mxCell>

        <!-- Arrows PubSub -->
        <mxCell id="arr-ps-1" edge="1" parent="1" source="ps-prod" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="ps-topic">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-ps-2" edge="1" parent="1" source="ps-topic" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="ps-g1">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-ps-3" edge="1" parent="1" source="ps-topic" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="ps-g2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <mxCell id="ps-desc" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Key Mechanics:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;One-to-Many Broadcast&lt;/b&gt;: Every registered group receives all messages.&lt;br&gt;&amp;bull; &lt;b&gt;Subscriber Independence&lt;/b&gt;: Slow group B never throttles fast group A.&lt;br&gt;&amp;bull; &lt;b&gt;Non-Destructive Reads&lt;/b&gt;: Messages retained according to log retention policy." vertex="1">
          <mxGeometry height="45" width="540" x="605" y="195" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
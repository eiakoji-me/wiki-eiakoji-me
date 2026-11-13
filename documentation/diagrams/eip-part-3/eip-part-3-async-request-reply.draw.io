<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-3-async-request-reply" name="Asynchronous Request-Reply Mechanics">
    <mxGraphModel dx="1200" dy="700" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="450" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- MAIN CONTAINER -->
        <mxCell id="main-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="360" width="1120" x="40" y="30" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="NON-BLOCKING ASYNCHRONOUS REQUEST-REPLY WITH DYNAMIC RETURN ADDRESSES" vertex="1">
          <mxGeometry height="22" width="900" x="65" y="40" as="geometry" />
        </mxCell>

        <!-- SENDER / CLIENT RUNTIME BOUNDARY -->
        <mxCell id="client-lane" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="280" width="310" x="65" y="75" as="geometry" />
        </mxCell>
        <mxCell id="client-hdr" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="CLIENT PROCESS (NON-BLOCKING)" vertex="1">
          <mxGeometry height="20" width="280" x="80" y="85" as="geometry" />
        </mxCell>

        <!-- Client Caller Box -->
        <mxCell id="c-caller" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;1. Caller Thread&lt;/b&gt;&lt;br&gt;&amp;bull; Generate Correlation ID (C_ID)&lt;br&gt;&amp;bull; Registers CompletableFuture&amp;lt;T&amp;gt;&lt;br&gt;&amp;bull; Immediately returns to caller" vertex="1">
          <mxGeometry height="65" width="280" x="80" y="115" as="geometry" />
        </mxCell>

        <!-- Correlation Map Store -->
        <mxCell id="c-table" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=6;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Correlation State Table&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:9px;&quot;&gt;ConcurrentHashMap&amp;lt;UUID, Promise&amp;gt;&lt;br&gt;Key: C_ID &amp;bull; Value: Future + Timeout Timer&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="280" x="80" y="195" as="geometry" />
        </mxCell>

        <mxCell id="c-listener" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;4. Reply Listener Callback&lt;/b&gt;&lt;br&gt;&amp;bull; Look up C_ID in Table &amp;bull; Complete Future" vertex="1">
          <mxGeometry height="40" width="280" x="80" y="270" as="geometry" />
        </mxCell>

        <!-- BROKER CHANNELS (MIDDLE) -->
        <!-- Request Queue -->
        <mxCell id="b-req-q" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=8;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Request Channel (Queue)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:9px;&quot;&gt;Payload: [CommandDTO]&lt;br&gt;Headers: [correlation_id=C_ID, reply_to=client.rep]&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="280" x="420" y="105" as="geometry" />
        </mxCell>

        <!-- Reply Queue -->
        <mxCell id="b-rep-q" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=8;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;Return Address Channel&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:9px;&quot;&gt;Queue: client.rep.&amp;lt;client_id&amp;gt;&lt;br&gt;Headers: [correlation_id=C_ID]&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="280" x="420" y="240" as="geometry" />
        </mxCell>

        <!-- SERVER / WORKER SERVICE BOUNDARY -->
        <mxCell id="srv-lane" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="280" width="310" x="745" y="75" as="geometry" />
        </mxCell>
        <mxCell id="srv-hdr" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="SERVICE WORKER (EXECUTOR)" vertex="1">
          <mxGeometry height="20" width="280" x="760" y="85" as="geometry" />
        </mxCell>

        <mxCell id="srv-consumer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;2. Consumer Pull &amp;amp; Processing&lt;/b&gt;&lt;br&gt;&amp;bull; Dequeues Command Message&lt;br&gt;&amp;bull; Extracts C_ID and Return Address (&lt;i&gt;reply_to&lt;/i&gt;)&lt;br&gt;&amp;bull; Commits Business Transaction" vertex="1">
          <mxGeometry height="65" width="280" x="760" y="115" as="geometry" />
        </mxCell>

        <mxCell id="srv-producer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;" value="&lt;b&gt;3. Response Emission&lt;/b&gt;&lt;br&gt;&amp;bull; Generates Response Document DTO&lt;br&gt;&amp;bull; Sets &lt;i&gt;correlation_id = C_ID&lt;/i&gt;&lt;br&gt;&amp;bull; Sends to dynamic queue specified in &lt;i&gt;reply_to&lt;/i&gt;" vertex="1">
          <mxGeometry height="65" width="280" x="760" y="215" as="geometry" />
        </mxCell>

        <!-- Shaded Box: Timeout Eviction Sink (Standard: dark font with white text background) -->
        <mxCell id="srv-timeout" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#334155;strokeColor=#0F172A;strokeWidth=1.5;fontColor=light-dark(#080808,#000000);fontSize=9;fontFamily=Comic Sans MS;align=center;" value="&lt;span style=&quot;background-color: light-dark(#ffffff, var(--ge-dark-color, #121212));&quot;&gt;&lt;b&gt;Timeout Guard:&lt;/b&gt; If response exceeds deadline,&lt;br&gt;client evicts C_ID; late replies dropped.&lt;/span&gt;" vertex="1">
          <mxGeometry height="40" width="280" x="760" y="295" as="geometry" />
        </mxCell>

        <!-- CONNECTORS -->
        <mxCell id="arr-c1-req" edge="1" parent="1" source="c-caller" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="b-req-q">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-c1-tbl" edge="1" parent="1" source="c-caller" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;dashed=1;endArrow=block;endFill=1;" target="c-table">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-req-srv" edge="1" parent="1" source="b-req-q" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="srv-consumer">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-srv-proc" edge="1" parent="1" source="srv-consumer" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="srv-producer">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-srv-rep" edge="1" parent="1" source="srv-producer" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="b-rep-q">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-rep-lis" edge="1" parent="1" source="b-rep-q" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="c-listener">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-lis-tbl" edge="1" parent="1" source="c-listener" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;dashed=1;endArrow=block;endFill=1;" target="c-table">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- FOOTER INVARIANT NOTE -->
        <mxCell id="main-footer" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Core Architectural Advantage:&lt;/b&gt; Zero threads remain blocked during downstream execution; client thread pool throughput is completely decoupled from downstream service latency." vertex="1">
          <mxGeometry height="22" width="1080" x="65" y="360" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

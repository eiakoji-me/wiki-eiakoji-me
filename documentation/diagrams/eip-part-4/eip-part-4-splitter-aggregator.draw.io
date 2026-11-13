<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-4-splitter-aggregator" name="Splitter Aggregator &amp; Resequencer Dynamics">
    <mxGraphModel dx="1400" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="750" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Title Banner -->
        <mxCell id="main-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="680" width="1320" x="40" y="30" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="STREAM DECOMPOSITION &amp;amp; REASSEMBLY: SPLITTER, AGGREGATOR &amp;amp; RESEQUENCER" vertex="1">
          <mxGeometry height="25" width="900" x="65" y="40" as="geometry" />
        </mxCell>

        <!-- TOP HALF: SPLITTER -> WORKERS -> AGGREGATOR -->
        <mxCell id="top-section" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;dashed=1;dashPattern=4 4;arcSize=4;" value="" vertex="1">
          <mxGeometry height="330" width="1270" x="65" y="75" as="geometry" />
        </mxCell>
        <mxCell id="top-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="A. THE SPLITTER-AGGREGATOR LIFECYCLE" vertex="1">
          <mxGeometry height="20" width="400" x="80" y="85" as="geometry" />
        </mxCell>

        <!-- Inbound Composite Message -->
        <mxCell id="inbound-composite" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Composite Batch&lt;/b&gt;&lt;br&gt;Order #901&lt;br&gt;&lt;font color=&quot;#64748B&quot;&gt;Items: [A, B, C]&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="140" x="85" y="145" as="geometry" />
        </mxCell>

        <!-- Arrow to Splitter -->
        <mxCell id="arr-split-in" edge="1" parent="1" source="inbound-composite" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="splitter-box">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Splitter Component -->
        <mxCell id="splitter-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Splitter&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Iterates items&lt;br&gt;Injects metadata:&lt;br&gt;&amp;bull; correlation_id&lt;br&gt;&amp;bull; seq_num: 1, 2, 3&lt;br&gt;&amp;bull; seq_size: 3&lt;/font&gt;" vertex="1">
          <mxGeometry height="130" width="160" x="270" y="115" as="geometry" />
        </mxCell>

        <!-- Splitter to Workers -->
        <mxCell id="arr-split-w1" edge="1" parent="1" source="splitter-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="worker-1">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-split-w2" edge="1" parent="1" source="splitter-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="worker-2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-split-w3" edge="1" parent="1" source="splitter-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="worker-3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Parallel Workers -->
        <mxCell id="worker-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Worker 1&lt;/b&gt;&lt;br&gt;Item A (Processed)" vertex="1">
          <mxGeometry height="50" width="150" x="480" y="115" as="geometry" />
        </mxCell>
        <mxCell id="worker-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Worker 2&lt;/b&gt;&lt;br&gt;Item B (Processed)" vertex="1">
          <mxGeometry height="50" width="150" x="480" y="180" as="geometry" />
        </mxCell>
        <mxCell id="worker-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Worker 3&lt;/b&gt;&lt;br&gt;Item C (Processed)" vertex="1">
          <mxGeometry height="50" width="150" x="480" y="245" as="geometry" />
        </mxCell>

        <!-- Workers to Aggregator -->
        <mxCell id="arr-w1-agg" edge="1" parent="1" source="worker-1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="aggregator-box">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-w2-agg" edge="1" parent="1" source="worker-2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="aggregator-box">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-w3-agg" edge="1" parent="1" source="worker-3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.2;endArrow=block;endFill=1;" target="aggregator-box">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Aggregator Component -->
        <mxCell id="aggregator-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Aggregator&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;State Buffer Map&lt;br&gt;Key: correlation_id&lt;br&gt;Accumulates: [A, B, C]&lt;br&gt;Check: count == size (3)&lt;br&gt;Eviction TTL Timeout&lt;/font&gt;" vertex="1">
          <mxGeometry height="140" width="170" x="690" y="135" as="geometry" />
        </mxCell>

        <!-- Aggregator to Outbound -->
        <mxCell id="arr-agg-out" edge="1" parent="1" source="aggregator-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="outbound-assembled">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Outbound Assembled Message -->
        <mxCell id="outbound-assembled" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Reassembled Result&lt;/b&gt;&lt;br&gt;Order #901 Completed&lt;br&gt;&lt;font color=&quot;#16A34A&quot;&gt;&lt;b&gt;[A*, B*, C*]&lt;/b&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="150" x="910" y="170" as="geometry" />
        </mxCell>

        <!-- Shaded Hazard Box for Aggregator adhering to standard -->
        <mxCell id="agg-hazard-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b&gt;Memory Starvation Hazard:&lt;/b&gt;&lt;br&gt;If Worker 2 crashes and message B is dropped, the accumulator entry remains unclosed. Without strict TTL eviction, memory grows as O(&amp;lambda; &amp;times; window)." vertex="1">
          <mxGeometry height="110" width="190" x="1115" y="150" as="geometry" />
        </mxCell>

        <!-- BOTTOM HALF: RESEQUENCER MECHANICS -->
        <mxCell id="bot-section" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;dashed=1;dashPattern=4 4;arcSize=4;" value="" vertex="1">
          <mxGeometry height="260" width="1270" x="65" y="425" as="geometry" />
        </mxCell>
        <mxCell id="bot-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="B. THE RESEQUENCER: REORDERING BUFFER &amp;amp; MONOTONIC STREAMING" vertex="1">
          <mxGeometry height="20" width="550" x="80" y="435" as="geometry" />
        </mxCell>

        <!-- Out-of-Order Input Stream -->
        <mxCell id="reseq-in" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Out-of-Order Input&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#DC2626&quot;&gt;&lt;b&gt;[#3] ➔ [#1] ➔ [#2]&lt;/b&gt;&lt;/font&gt;&lt;br&gt;&lt;font color=&quot;#64748B&quot;&gt;Non-deterministic arrival&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="180" x="85" y="485" as="geometry" />
        </mxCell>

        <!-- Arrow to Resequencer -->
        <mxCell id="arr-reseq-in" edge="1" parent="1" source="reseq-in" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="reseq-buffer">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Resequencer Sliding Buffer -->
        <mxCell id="reseq-buffer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Resequencer Buffer Window&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Internal PriorityQueue / SortedMap&lt;br&gt;Current Expected Cursor: &lt;b&gt;seq = 1&lt;/b&gt;&lt;br&gt;Stores #2, #3 until #1 arrives&lt;br&gt;Releases: 1, then 2, then 3&lt;/font&gt;" vertex="1">
          <mxGeometry height="110" width="240" x="320" y="465" as="geometry" />
        </mxCell>

        <!-- Arrow to Monotonic Stream -->
        <mxCell id="arr-reseq-out" edge="1" parent="1" source="reseq-buffer" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="reseq-out">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Monotonic Output Stream -->
        <mxCell id="reseq-out" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Monotonic Output&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#16A34A&quot;&gt;&lt;b&gt;[#1] ➔ [#2] ➔ [#3]&lt;/b&gt;&lt;/font&gt;&lt;br&gt;&lt;font color=&quot;#64748B&quot;&gt;Strict sequential order&lt;/font&gt;" vertex="1">
          <mxGeometry height="70" width="180" x="620" y="485" as="geometry" />
        </mxCell>

        <!-- Shaded HOL Blocking Box adhering to standard -->
        <mxCell id="reseq-hol-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b&gt;Head-of-Line (HoL) Blocking:&lt;/b&gt;&lt;br&gt;If message #1 is delayed, subsequent messages #2 and #3 cannot be emitted, even if already buffered in memory. Window capacity and timeout prevent deadlock." vertex="1">
          <mxGeometry height="110" width="240" x="850" y="465" as="geometry" />
        </mxCell>

        <mxCell id="reseq-params-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#475569;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b&gt;Window Tuning Parameters:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;W_max&lt;/b&gt;: Buffer size upper bound&lt;br&gt;&amp;bull; &lt;b&gt;T_timeout&lt;/b&gt;: Gap skip deadline&lt;br&gt;&amp;bull; &lt;b&gt;On Timeout&lt;/b&gt;: Skip gap or DLQ stream" vertex="1">
          <mxGeometry height="110" width="190" x="1115" y="465" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
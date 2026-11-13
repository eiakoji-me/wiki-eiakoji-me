<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-1-pipes-and-filters" name="Pipes and Filters Composition Pipeline">
    <mxGraphModel dx="1200" dy="400" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="400" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- PIPELINE CONTAINER -->
        <mxCell id="pipe-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="320" width="1100" x="50" y="40" as="geometry" />
        </mxCell>
        <mxCell id="pipe-label" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=14;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="PIPES AND FILTERS ARCHITECTURAL COMPOSITION" vertex="1">
          <mxGeometry height="24" width="800" x="70" y="55" as="geometry" />
        </mxCell>

        <!-- 1. INBOUND PIPE -->
        <mxCell id="p1" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Inbound Pipe&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Ingress Queue Buffer&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="130" x="80" y="110" as="geometry" />
        </mxCell>

        <!-- 2. FILTER 1 -->
        <mxCell id="f1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Filter 1&lt;/b&gt;&lt;br&gt;Schema Validator&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:10px;&quot;&gt;Drops Invalid Payloads&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="140" x="270" y="110" as="geometry" />
        </mxCell>

        <!-- 3. INTERMEDIATE PIPE -->
        <mxCell id="p2" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Intermediate Pipe&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Decoupling Buffer&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="130" x="470" y="110" as="geometry" />
        </mxCell>

        <!-- 4. FILTER 2 -->
        <mxCell id="f2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Filter 2&lt;/b&gt;&lt;br&gt;Tax &amp;amp; Surcharge&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:10px;&quot;&gt;Payload Enrichment&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="140" x="660" y="110" as="geometry" />
        </mxCell>

        <!-- 5. EGRESS PIPE -->
        <mxCell id="p3" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=10;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Egress Pipe&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Outbound Queue&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="130" x="860" y="110" as="geometry" />
        </mxCell>

        <!-- 6. SINK -->
        <mxCell id="sink" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#334155;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#FFFFFF;fontSize=12;fontFamily=Comic Sans MS;" value="&lt;b&gt;Ledger / ERP&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#CBD5E1&quot; style=&quot;font-size:10px;&quot;&gt;Downstream Sink&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="120" x="1010" y="110" as="geometry" />
        </mxCell>

        <!-- CONNECTORS -->
        <mxCell id="arr1" edge="1" parent="1" source="p1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="f1">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr2" edge="1" parent="1" source="f1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="p2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr3" edge="1" parent="1" source="p2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="f2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr4" edge="1" parent="1" source="f2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="p3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr5" edge="1" parent="1" source="p3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="sink">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- FOOTER EXPLANATION -->
        <mxCell id="p-desc" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Key Architectural Properties:&lt;/b&gt;&lt;br&gt;• &lt;b&gt;Single Responsibility Filters:&lt;/b&gt; Each filter performs one stateless transformation without knowledge of adjacent filters.&lt;br&gt;• &lt;b&gt;Decoupling Pipes:&lt;/b&gt; Message queues serve as point-to-point pipes, allowing filters to execute at independent processing rates.&lt;br&gt;• &lt;b&gt;Recomposability:&lt;/b&gt; Filters can be added, reordered, or branched dynamically without modifying existing components." vertex="1">
          <mxGeometry height="80" width="1020" x="80" y="240" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
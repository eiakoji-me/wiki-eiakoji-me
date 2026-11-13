<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-2-dead-letter-quarantine" name="Invalid Message vs Dead Letter Channel Triage">
    <mxGraphModel dx="1414" dy="850" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="450" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="triage-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="320" width="1120" x="40" y="25" as="geometry" />
        </mxCell>
        <mxCell id="triage-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="ANATOMY OF INTEGRATION FAILURE: SYNTACTIC QUARANTINE VS. SEMANTIC RETRY TRIAGE" vertex="1">
          <mxGeometry height="22" width="900" x="65" y="35" as="geometry" />
        </mxCell>
        <mxCell id="in-pipe" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=8;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Inbound Channel&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Ingress Stream&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="120" x="65" y="110" as="geometry" />
        </mxCell>
        <mxCell id="gate-schema" parent="1" style="rhombus;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Schema Valid?&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:9px;&quot;&gt;Syntactic Check&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="120" x="240" y="100" as="geometry" />
        </mxCell>
        <mxCell id="q-invalid" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Invalid Message Channel&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Malformed / Unparseable DTOs&lt;br&gt;&lt;b&gt;Zero retries&lt;/b&gt; &amp;bull; Immediate quarantine&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="220" x="190" y="240" as="geometry" />
        </mxCell>
        <mxCell id="worker-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Processing Worker&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Business Logic Execution&lt;br&gt;Transactional Database Commit&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="170" x="465" y="110" as="geometry" />
        </mxCell>
        <mxCell id="gate-retry" parent="1" style="rhombus;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;k &amp;lt; k_max?&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:9px;&quot;&gt;Retry Budget&lt;/font&gt;" vertex="1">
          <mxGeometry height="80" width="120" x="695" y="100" as="geometry" />
        </mxCell>
        <mxCell id="pipe-delay" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=center;" value="&lt;b&gt;Exponential Backoff + Jitter&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;t_retry = min(t_max, t_base &amp;bull; 2^k) &amp;plusmn; J&lt;/font&gt;" vertex="1">
          <mxGeometry height="40" width="220" x="515" y="240" as="geometry" />
        </mxCell>
        <mxCell id="dlq-box" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=8;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Dead Letter Channel&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot; style=&quot;font-size:10px;&quot;&gt;Quarantined Poison Pills&lt;br&gt;Budget Exhausted (k &amp;ge; k_max)&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="160" x="948" y="108" as="geometry" />
        </mxCell>
        <mxCell id="redrive-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#334155;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#FFFFFF;fontSize=11;fontFamily=Comic Sans MS;align=center;" value="&lt;span style=&quot;color: light-dark(rgb(8, 8, 8), rgb(0, 0, 0)); background-color: light-dark(#ffffff, var(--ge-dark-color, #121212));&quot;&gt;&lt;b&gt;Operator &amp;amp; Redrive Plane&lt;/b&gt;&lt;br&gt;&lt;/span&gt;&lt;font style=&quot;font-size: 10px;&quot;&gt;&lt;span style=&quot;color: light-dark(rgb(8, 8, 8), rgb(0, 0, 0)); background-color: light-dark(#ffffff, var(--ge-dark-color, #121212));&quot;&gt;CloudWatch / Prometheus Alerting&lt;br&gt;&lt;/span&gt;&lt;span style=&quot;color: light-dark(rgb(8, 8, 8), rgb(0, 0, 0)); background-color: light-dark(#ffffff, var(--ge-dark-color, #121212));&quot;&gt;Inspection Console • Redrive to Inbound&lt;/span&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="60" width="220" x="918" y="230" as="geometry" />
        </mxCell>
        <mxCell id="arr-in-schema" edge="1" parent="1" source="in-pipe" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="gate-schema">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-schema-invalid" edge="1" parent="1" source="gate-schema" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="q-invalid" value="[No] Malformed">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-schema-worker" edge="1" parent="1" source="gate-schema" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="worker-box" value="[Yes] Valid">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-worker-retry" edge="1" parent="1" source="worker-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="gate-retry" value="Transient Failure">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-retry-backoff" edge="1" parent="1" source="gate-retry" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="pipe-delay" value="[Yes] k &amp;lt; k_max">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-backoff-worker" edge="1" parent="1" source="pipe-delay" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.2;dashed=1;endArrow=block;endFill=1;" target="worker-box">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="475" y="260" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="arr-retry-dlq" edge="1" parent="1" source="gate-retry" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="dlq-box" value="[No] Budget Exhausted">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-dlq-redrive" edge="1" parent="1" source="dlq-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;curveFitting=1;jiggle=1.2;strokeColor=#0F172A;strokeWidth=1.5;endArrow=block;endFill=1;" target="redrive-box">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

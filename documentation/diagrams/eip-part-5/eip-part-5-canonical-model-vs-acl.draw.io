<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-5-canonical-model-vs-acl" name="Canonical Model vs Anti-Corruption Layer">
    <mxGraphModel dx="1400" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="720" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Title Banner -->
        <mxCell id="main-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="660" width="1320" x="40" y="30" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="DATA INTEROPERABILITY ARCHETYPES: CANONICAL DATA MODEL (FALLACY) VS. BOUNDED CONTEXT ACLS" vertex="1">
          <mxGeometry height="25" width="1050" x="65" y="40" as="geometry" />
        </mxCell>

        <!-- LEFT PANEL: CANONICAL DATA MODEL -->
        <mxCell id="left-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="470" width="620" x="65" y="75" as="geometry" />
        </mxCell>
        <mxCell id="left-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#DC2626;fontFamily=Comic Sans MS;" value="A. THE CANONICAL DATA MODEL (ENTERPRISE MONOLITHIC COUPLING)" vertex="1">
          <mxGeometry height="20" width="550" x="85" y="85" as="geometry" />
        </mxCell>

        <!-- Central Enterprise Schema Hub -->
        <mxCell id="cdm-hub" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FEE2E2;strokeColor=#DC2626;strokeWidth=2;fontColor=#991B1B;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Universal Enterprise Model&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#7F1D1D&quot;&gt;Monolithic 400-Field CustomerDTO&lt;br&gt;&lt;b&gt;Committee Bottleneck&lt;/b&gt;&lt;br&gt;All teams bound to single schema&lt;/font&gt;" vertex="1">
          <mxGeometry height="140" width="260" x="245" y="150" as="geometry" />
        </mxCell>

        <!-- Peripheral Services tight coupling -->
        <mxCell id="cdm-svc1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Billing Service&lt;/b&gt;&lt;br&gt;Forces CustomerDTO" vertex="1">
          <mxGeometry height="50" width="130" x="85" y="125" as="geometry" />
        </mxCell>
        <mxCell id="cdm-svc2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Shipping Service&lt;/b&gt;&lt;br&gt;Forces CustomerDTO" vertex="1">
          <mxGeometry height="50" width="130" x="85" y="240" as="geometry" />
        </mxCell>
        <mxCell id="cdm-svc3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Fraud Engine&lt;/b&gt;&lt;br&gt;Forces CustomerDTO" vertex="1">
          <mxGeometry height="50" width="130" x="85" y="355" as="geometry" />
        </mxCell>

        <!-- Connecting Lines showing coupling -->
        <mxCell id="arr-cdm-1" edge="1" parent="1" source="cdm-svc1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.5;endArrow=block;endFill=1;" target="cdm-hub">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-cdm-2" edge="1" parent="1" source="cdm-svc2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.5;endArrow=block;endFill=1;" target="cdm-hub">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="arr-cdm-3" edge="1" parent="1" source="cdm-svc3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.5;endArrow=block;endFill=1;" target="cdm-hub">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- CDM Consequences Box -->
        <mxCell id="cdm-props" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#334155;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" value="&lt;b style=&quot;color:#DC2626;font-size:11px;&quot;&gt;Canonical Model Pathologies:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Organizational Gridlock&lt;/b&gt;: Any field change triggers multi-team review loops.&lt;br&gt;&amp;bull; &lt;b&gt;Lowest Common Denominator&lt;/b&gt;: Model loses semantic richness.&lt;br&gt;&amp;bull; &lt;b&gt;Distributed Monolith&lt;/b&gt;: Upstream releases break downstream compile-time types." vertex="1">
          <mxGeometry height="85" width="580" x="85" y="440" as="geometry" />
        </mxCell>

        <!-- RIGHT PANEL: BOUNDED CONTEXTS & ACL -->
        <mxCell id="right-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="470" width="650" x="710" y="75" as="geometry" />
        </mxCell>
        <mxCell id="right-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#16A34A;fontFamily=Comic Sans MS;" value="B. DOMAIN BOUNDED CONTEXTS &amp;amp; ANTI-CORRUPTION LAYERS" vertex="1">
          <mxGeometry height="20" width="550" x="730" y="85" as="geometry" />
        </mxCell>

        <!-- Bounded Context A: Order -->
        <mxCell id="bc-order" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Order Context&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;PurchaseOrder Aggregate&lt;br&gt;Emits: &lt;b&gt;OrderPlacedEvent&lt;/b&gt;&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="220" x="730" y="130" as="geometry" />
        </mxCell>

        <!-- Anti-Corruption Layer Gateway -->
        <mxCell id="acl-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#DCFCE7;strokeColor=#16A34A;strokeWidth=1.8;fontColor=#166534;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Anti-Corruption Layer (ACL)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#14532D&quot;&gt;Translates external wire contract&lt;br&gt;Isolates internal core domain&lt;br&gt;Prevents upstream semantic leak&lt;/font&gt;" vertex="1">
          <mxGeometry height="140" width="210" x="1000" y="190" as="geometry" />
        </mxCell>

        <!-- Arrow Order -> ACL -->
        <mxCell id="arr-order-acl" edge="1" parent="1" source="bc-order" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.5;endArrow=block;endFill=1;" target="acl-box">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Bounded Context B: Billing -->
        <mxCell id="bc-billing" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;Billing Context&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Internal &lt;b&gt;InvoiceRecord&lt;/b&gt;&lt;br&gt;Pure domain model unpolluted&lt;/font&gt;" vertex="1">
          <mxGeometry height="65" width="220" x="730" y="270" as="geometry" />
        </mxCell>

        <!-- Arrow ACL -> Billing -->
        <mxCell id="arr-acl-billing" edge="1" parent="1" source="acl-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.5;endArrow=block;endFill=1;" target="bc-billing">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Bounded Context Properties Box -->
        <mxCell id="bc-props" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#334155;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" value="&lt;b style=&quot;color:#16A34A;font-size:11px;&quot;&gt;Bounded Context Advantages:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Autonomous Evolution&lt;/b&gt;: Each service changes its internal model independently.&lt;br&gt;&amp;bull; &lt;b&gt;Semantic Precision&lt;/b&gt;: Billing models money; Shipping models dimensions; no compromise.&lt;br&gt;&amp;bull; &lt;b&gt;Zero Blast Radius&lt;/b&gt;: Upstream contract changes are absorbed inside the ACL translation boundary." vertex="1">
          <mxGeometry height="85" width="610" x="730" y="440" as="geometry" />
        </mxCell>

        <!-- BOTTOM DECISION RULE SHADED BOX adhering to standard -->
        <mxCell id="bot-rule-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;arcSize=4;" value="&lt;b&gt;Architectural Synthesis:&lt;/b&gt; Reject the illusion of a monolithic enterprise-wide Canonical Data Model. Standardize only on &lt;b&gt;transport envelopes&lt;/b&gt; (CloudEvents headers), while using &lt;b&gt;Anti-Corruption Layers&lt;/b&gt; to map payloads between autonomous Domain Bounded Contexts." vertex="1">
          <mxGeometry height="60" width="1270" x="65" y="560" as="geometry" />
        </mxCell>

        <!-- Footer -->
        <mxCell id="footer-text" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="EIP Part V: Message Transformation and Data Interoperability &amp;bull; wiki.eiakoji.me" vertex="1">
          <mxGeometry height="20" width="1320" x="40" y="635" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
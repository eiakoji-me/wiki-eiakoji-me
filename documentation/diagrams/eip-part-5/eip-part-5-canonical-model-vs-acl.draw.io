<mxfile host="65bd71144e">
    <diagram id="eip-part-5-canonical-model-vs-acl" name="Canonical Model vs Anti-Corruption Layer">
        <mxGraphModel dx="1856" dy="607" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="720" background="#FFFFFF" math="0" shadow="0">
            <root>
                <mxCell id="0"/>
                <mxCell id="1" parent="0"/>
                <mxCell id="main-container" value="" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" parent="1" vertex="1">
                    <mxGeometry x="40" y="30" width="1320" height="660" as="geometry"/>
                </mxCell>
                <mxCell id="main-title" value="DATA INTEROPERABILITY ARCHETYPES: CANONICAL DATA MODEL (FALLACY) VS. BOUNDED CONTEXT ACLS" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" parent="1" vertex="1">
                    <mxGeometry x="65" y="40" width="1050" height="25" as="geometry"/>
                </mxCell>
                <mxCell id="left-panel" value="" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=4;" parent="1" vertex="1">
                    <mxGeometry x="65" y="75" width="620" height="470" as="geometry"/>
                </mxCell>
                <mxCell id="left-title" value="A. THE CANONICAL DATA MODEL (ENTERPRISE MONOLITHIC COUPLING)" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#DC2626;fontFamily=Comic Sans MS;" parent="1" vertex="1">
                    <mxGeometry x="85" y="85" width="550" height="20" as="geometry"/>
                </mxCell>
                <mxCell id="cdm-hub" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Universal Enterprise Model&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#7F1D1D&quot;&gt;Monolithic 400-Field CustomerDTO&lt;br&gt;&lt;b&gt;Committee Bottleneck&lt;/b&gt;&lt;br&gt;All teams bound to single schema&lt;/font&gt;" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FEE2E2;strokeColor=#DC2626;strokeWidth=2;fontColor=#991B1B;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" parent="1" vertex="1">
                    <mxGeometry x="245" y="150" width="260" height="140" as="geometry"/>
                </mxCell>
                <mxCell id="cdm-svc1" value="&lt;b&gt;Billing Service&lt;/b&gt;&lt;br&gt;Forces CustomerDTO" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" parent="1" vertex="1">
                    <mxGeometry x="85" y="125" width="130" height="50" as="geometry"/>
                </mxCell>
                <mxCell id="cdm-svc2" value="&lt;b&gt;Shipping Service&lt;/b&gt;&lt;br&gt;Forces CustomerDTO" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" parent="1" vertex="1">
                    <mxGeometry x="85" y="240" width="130" height="50" as="geometry"/>
                </mxCell>
                <mxCell id="cdm-svc3" value="&lt;b&gt;Fraud Engine&lt;/b&gt;&lt;br&gt;Forces CustomerDTO" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" parent="1" vertex="1">
                    <mxGeometry x="85" y="355" width="130" height="50" as="geometry"/>
                </mxCell>
                <mxCell id="arr-cdm-1" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.5;endArrow=block;endFill=1;" parent="1" source="cdm-svc1" target="cdm-hub" edge="1">
                    <mxGeometry relative="1" as="geometry"/>
                </mxCell>
                <mxCell id="arr-cdm-2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.5;endArrow=block;endFill=1;" parent="1" source="cdm-svc2" target="cdm-hub" edge="1">
                    <mxGeometry relative="1" as="geometry"/>
                </mxCell>
                <mxCell id="arr-cdm-3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.5;endArrow=block;endFill=1;" parent="1" source="cdm-svc3" target="cdm-hub" edge="1">
                    <mxGeometry relative="1" as="geometry"/>
                </mxCell>
                <mxCell id="cdm-props" value="&lt;b style=&quot;color:#DC2626;font-size:11px;&quot;&gt;Canonical Model Pathologies:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Organizational Gridlock&lt;/b&gt;: Any field change triggers multi-team review loops.&lt;br&gt;&amp;bull; &lt;b&gt;Lowest Common Denominator&lt;/b&gt;: Model loses semantic richness.&lt;br&gt;&amp;bull; &lt;b&gt;Distributed Monolith&lt;/b&gt;: Upstream releases break downstream compile-time types." style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#334155;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" parent="1" vertex="1">
                    <mxGeometry x="85" y="440" width="580" height="85" as="geometry"/>
                </mxCell>
                <mxCell id="right-panel" value="" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=4;" parent="1" vertex="1">
                    <mxGeometry x="710" y="75" width="630" height="470" as="geometry"/>
                </mxCell>
                <mxCell id="right-title" value="B. DOMAIN BOUNDED CONTEXTS &amp;amp; ANTI-CORRUPTION LAYERS" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#16A34A;fontFamily=Comic Sans MS;" parent="1" vertex="1">
                    <mxGeometry x="730" y="85" width="550" height="20" as="geometry"/>
                </mxCell>
                <mxCell id="bc-order" value="&lt;b&gt;Order Context&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;PurchaseOrder Aggregate&lt;br&gt;Emits: &lt;b&gt;OrderPlacedEvent&lt;/b&gt;&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" parent="1" vertex="1">
                    <mxGeometry x="730" y="130" width="220" height="65" as="geometry"/>
                </mxCell>
                <mxCell id="acl-box" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Anti-Corruption Layer (ACL)&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#14532D&quot;&gt;Translates external wire contract&lt;br&gt;Isolates internal core domain&lt;br&gt;Prevents upstream semantic leak&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#DCFCE7;strokeColor=#16A34A;strokeWidth=1.8;fontColor=#166534;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" parent="1" vertex="1">
                    <mxGeometry x="1000" y="190" width="210" height="140" as="geometry"/>
                </mxCell>
                <mxCell id="arr-order-acl" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.5;endArrow=block;endFill=1;" parent="1" source="bc-order" target="acl-box" edge="1">
                    <mxGeometry relative="1" as="geometry"/>
                </mxCell>
                <mxCell id="bc-billing" value="&lt;b&gt;Billing Context&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Internal &lt;b&gt;InvoiceRecord&lt;/b&gt;&lt;br&gt;Pure domain model unpolluted&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" parent="1" vertex="1">
                    <mxGeometry x="730" y="270" width="220" height="65" as="geometry"/>
                </mxCell>
                <mxCell id="arr-acl-billing" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.5;endArrow=block;endFill=1;" parent="1" source="acl-box" target="bc-billing" edge="1">
                    <mxGeometry relative="1" as="geometry"/>
                </mxCell>
                <mxCell id="bc-props" value="&lt;b style=&quot;color:#16A34A;font-size:11px;&quot;&gt;Bounded Context Advantages:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Autonomous Evolution&lt;/b&gt;: Each service changes its internal model independently.&lt;br&gt;&amp;bull; &lt;b&gt;Semantic Precision&lt;/b&gt;: Billing models money; Shipping models dimensions; no compromise.&lt;br&gt;&amp;bull; &lt;b&gt;Zero Blast Radius&lt;/b&gt;: Upstream contract changes are absorbed inside the ACL translation boundary." style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#334155;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" parent="1" vertex="1">
                    <mxGeometry x="730" y="440" width="590" height="85" as="geometry"/>
                </mxCell>
                <mxCell id="bot-rule-box" value="&lt;b&gt;Architectural Synthesis:&lt;/b&gt; Reject the illusion of a monolithic enterprise-wide Canonical Data Model. Standardize only on &lt;b&gt;transport envelopes&lt;/b&gt; (CloudEvents headers), while using &lt;b&gt;Anti-Corruption Layers&lt;/b&gt; to map payloads between autonomous Domain Bounded Contexts." style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;arcSize=4;" parent="1" vertex="1">
                    <mxGeometry x="65" y="560" width="1270" height="60" as="geometry"/>
                </mxCell>
                <mxCell id="footer-text" value="EIP Part V: Message Transformation and Data Interoperability &amp;bull; wiki.eiakoji.me" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" parent="1" vertex="1">
                    <mxGeometry x="40" y="635" width="1320" height="20" as="geometry"/>
                </mxCell>
            </root>
        </mxGraphModel>
    </diagram>
</mxfile>
<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-1-hero-monochrome" name="EIP Part I Hero Foundations">
    <mxGraphModel dx="1140" dy="586" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="900" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="pres-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="135" width="1440" x="80" y="50" as="geometry" />
        </mxCell>
        <mxCell id="pres-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. ENTERPRISE APPLICATION LANDSCAPE (HETEROGENEOUS CLIENTS &amp;amp; PRODUCERS)" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="60" as="geometry" />
        </mxCell>
        <mxCell id="pres-box-1" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Enterprise Core &amp;amp; Legacy ERP&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Transactional databases · Scheduled batch exports · High-value record locks&lt;/font&gt;" vertex="1">
          <mxGeometry height="72" width="430" x="105" y="92" as="geometry" />
        </mxCell>
        <mxCell id="pres-box-2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Cloud-Native Microservices&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;REST &amp;amp; gRPC endpoints · High-frequency client traffic · Ephemeral containers&lt;/font&gt;" vertex="1">
          <mxGeometry height="72" width="430" x="585" y="92" as="geometry" />
        </mxCell>
        <mxCell id="pres-box-3" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;External B2B &amp;amp; Third Parties&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Partner webhooks · Ingestion feeds · Uncontrolled remote latency &amp;amp; outages&lt;/font&gt;" vertex="1">
          <mxGeometry height="72" width="430" x="1065" y="92" as="geometry" />
        </mxCell>
        <mxCell id="arr-pres-divide" edge="1" parent="1" source="pres-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="divide-container" value="Dispatches Integration Workflows ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="divide-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=6;" value="" vertex="1">
          <mxGeometry height="295" width="1440" x="80" y="225" as="geometry" />
        </mxCell>
        <mxCell id="divide-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. THE INTEGRATION &amp;amp; COUPLING DIVIDE" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="235" as="geometry" />
        </mxCell>
        <mxCell id="pathA-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FEF2F2;strokeColor=#DC2626;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="235" width="670" x="105" y="265" as="geometry" />
        </mxCell>
        <mxCell id="pathA-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#991B1B;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="PATH A: TIGHT DISTRIBUTED COUPLING (SYNCHRONOUS RPC &amp;amp; SHARED DB)" vertex="1">
          <mxGeometry height="22" width="630" x="125" y="275" as="geometry" />
        </mxCell>
        <mxCell id="pathA-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#1E293B;fontFamily=Comic Sans MS;spacingLeft=10;" value="&lt;b&gt;• Temporal Lockstep&lt;/b&gt;: Caller and callee must be available and executing simultaneously&lt;br&gt;&lt;b&gt;• Spatial Dependency&lt;/b&gt;: Caller must hardcode physical IP, host, and port network addresses&lt;br&gt;&lt;b&gt;• Schema Entanglement&lt;/b&gt;: Shared tables and DB locks create cascading deadlock contention&lt;br&gt;&lt;b&gt;• Failure Cascades&lt;/b&gt;: Downstream latency spikes exhaust caller thread pools (Little&#39;s Law)&lt;br&gt;&lt;font color=&quot;#B91C1C&quot;&gt;&lt;b&gt;[!] Architectural Consequence&lt;/b&gt;: Outages in any downstream service trigger total system failure&lt;/font&gt;" vertex="1">
          <mxGeometry height="180" width="630" x="125" y="305" as="geometry" />
        </mxCell>
        <mxCell id="pathB-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F0FDF4;strokeColor=#16A34A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="235" width="670" x="825" y="265" as="geometry" />
        </mxCell>
        <mxCell id="pathB-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#166534;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="PATH B: DECOUPLED ENTERPRISE MESSAGING BACKBONE (CHANNELS &amp;amp; PIPES)" vertex="1">
          <mxGeometry height="22" width="630" x="845" y="275" as="geometry" />
        </mxCell>
        <mxCell id="pathB-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#1E293B;fontFamily=Comic Sans MS;spacingLeft=10;" value="&lt;b&gt;• Temporal Decoupling&lt;/b&gt;: Store-and-forward channel buffers isolate producers from consumers&lt;br&gt;&lt;b&gt;• Spatial Independence&lt;/b&gt;: Messages route to logical channel names, not server host addresses&lt;br&gt;&lt;b&gt;• Contract Isolation&lt;/b&gt;: Typed envelopes hide internal databases behind explicit event schemas&lt;br&gt;&lt;b&gt;• Elastic Traffic Smoothing&lt;/b&gt;: Transient arrival spikes absorb safely into durable queues&lt;br&gt;&lt;font color=&quot;#15803D&quot;&gt;&lt;b&gt;[✓] Architectural Consequence&lt;/b&gt;: Systems degrade gracefully; zero cascading worker thread pileups&lt;/font&gt;" vertex="1">
          <mxGeometry height="180" width="630" x="845" y="305" as="geometry" />
        </mxCell>
        <mxCell id="arr-divide-highway" edge="1" parent="1" source="pathB-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="highway-container" value="Feeds Decoupled Integration Stream ➔">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1160" y="540" />
              <mxPoint x="800" y="540" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="highway-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="290" width="1440" x="80" y="560" as="geometry" />
        </mxCell>
        <mxCell id="highway-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="3. THE PIPES-AND-FILTERS INTEGRATION HIGHWAY" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="570" as="geometry" />
        </mxCell>
        <mxCell id="pipe-inbound" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Inbound Channel&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Point-to-Point Queue&lt;br&gt;Durable WAL disk buffer&lt;/font&gt;" vertex="1">
          <mxGeometry height="85" width="220" x="105" y="605" as="geometry" />
        </mxCell>
        <mxCell id="pipe-filter" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Composable Filter Pipeline&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;[1. Schema Validation &amp;amp; Decrypt] ➔ [2. Content Enricher] ➔ [3. Router]&lt;br&gt;Stateless transformation steps connected by bounded staging pipes&lt;/font&gt;" vertex="1">
          <mxGeometry height="85" width="430" x="415" y="605" as="geometry" />
        </mxCell>
        <mxCell id="arr-inbound-filter" edge="1" parent="1" source="pipe-inbound" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="pipe-filter" value="Dispatches ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="pipe-outbound" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Outbound Topic&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Publish-Subscribe Hub&lt;br&gt;Fan-out event exchange&lt;/font&gt;" vertex="1">
          <mxGeometry height="85" width="220" x="945" y="605" as="geometry" />
        </mxCell>
        <mxCell id="arr-filter-outbound" edge="1" parent="1" source="pipe-filter" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="pipe-outbound" value="Enriched Msg ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="pipe-sinks" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Downstream Sinks&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Core Banking · Event Lake&lt;br&gt;Idempotent consumer groups&lt;/font&gt;" vertex="1">
          <mxGeometry height="85" width="245" x="1245" y="605" as="geometry" />
        </mxCell>
        <mxCell id="arr-outbound-sinks" edge="1" parent="1" source="pipe-outbound" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;" target="pipe-sinks" value="Fan-out ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="pipe-dlq" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FEF2F2;strokeColor=#DC2626;strokeWidth=1.5;dashed=1;dashPattern=4 4;fontColor=#991B1B;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b&gt;Dead-Letter Channel (DLQ)&lt;/b&gt;&lt;br&gt;Traps poison messages after 3 retries" vertex="1">
          <mxGeometry height="60" width="220" x="105" y="730" as="geometry" />
        </mxCell>
        <mxCell id="arr-inbound-dlq" edge="1" parent="1" source="pipe-inbound" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#DC2626;strokeWidth=1.5;dashed=1;endArrow=block;endFill=1;fontColor=#991B1B;fontFamily=Comic Sans MS;fontSize=10;" target="pipe-dlq" value="Poison Msg ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="pipe-summary" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#334155;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=middle;spacingLeft=15;arcSize=6;" value="&lt;b&gt;• Decoupled Invariant&lt;/b&gt;: Each filter executes independently with zero knowledge of upstream sources or downstream targets.&lt;br&gt;&lt;b&gt;• Composable Extensibility&lt;/b&gt;: Additional filters (auditing, encryption, rate-limiting) insert cleanly without modifying business endpoints." vertex="1">
          <mxGeometry height="60" width="1075" x="415" y="730" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

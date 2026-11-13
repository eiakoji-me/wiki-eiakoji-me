<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-5-claim-check-pattern" name="Claim Check Pattern Dynamics">
    <mxGraphModel dx="1400" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="750" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Title Banner -->
        <mxCell id="main-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="680" width="1320" x="40" y="30" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="THE CLAIM CHECK PATTERN: LARGE PAYLOAD OFFLOADING &amp;amp; HYDRATION DYNAMICS" vertex="1">
          <mxGeometry height="25" width="950" x="65" y="40" as="geometry" />
        </mxCell>

        <!-- Producer Box -->
        <mxCell id="producer-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Producer Service&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#DC2626&quot;&gt;&lt;b&gt;Heavy Payload: 50 MB&lt;/b&gt;&lt;/font&gt;&lt;br&gt;(High-Res Medical Scan / Parquet Batch)" vertex="1">
          <mxGeometry height="90" width="220" x="70" y="140" as="geometry" />
        </mxCell>

        <!-- Object Storage Store (Center Top) -->
        <mxCell id="s3-store" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Object Storage Fabric&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;AWS S3 &amp;bull; Google Cloud Storage&lt;br&gt;Key: &lt;b&gt;blobs/2026/scan-9812.dat&lt;/b&gt;&lt;br&gt;Payload: 50,421,980 bytes&lt;br&gt;SHA-256 Digest Barrier&lt;/font&gt;" vertex="1">
          <mxGeometry height="140" width="260" x="530" y="80" as="geometry" />
        </mxCell>

        <!-- Step 1 Arrow: Producer writes to Storage -->
        <mxCell id="arr-step1" edge="1" parent="1" source="producer-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="s3-store" value="1. PUT blob payload (50MB) ➔">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="180" y="110" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Step 2: Storage returns URI & Hash -->
        <mxCell id="arr-step2" edge="1" parent="1" source="s3-store" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.5;dashed=1;endArrow=block;endFill=1;fontColor=#16A34A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="producer-box" value="2. Return URI &amp;amp; SHA-256 ACK">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="480" y="185" />
              <mxPoint x="480" y="185" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Message Broker (Center Bottom) -->
        <mxCell id="broker-box" parent="1" style="shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Enterprise Message Broker&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#16A34A&quot;&gt;&lt;b&gt;Kafka Topic / SQS Queue&lt;/b&gt;&lt;/font&gt;&lt;br&gt;Envelope Size: &lt;b&gt;520 Bytes&lt;/b&gt;&lt;br&gt;Sub-millisecond WAL append&lt;br&gt;Zero JVM GC memory pressure" vertex="1">
          <mxGeometry height="130" width="260" x="530" y="310" as="geometry" />
        </mxCell>

        <!-- Step 3: Producer emits Claim Check Token to Broker -->
        <mxCell id="arr-step3" edge="1" parent="1" source="producer-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="broker-box" value="3. Publish Pointer Message (520B) ➔">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="180" y="375" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Consumer Box (Right Side) -->
        <mxCell id="consumer-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Consumer Worker&lt;/b&gt;&lt;br&gt;Receives Pointer Message&lt;br&gt;Inspects Metadata&lt;br&gt;Fetches Blob &amp;bull; Verifies SHA-256" vertex="1">
          <mxGeometry height="90" width="220" x="1080" y="240" as="geometry" />
        </mxCell>

        <!-- Step 4: Broker delivers Pointer to Consumer -->
        <mxCell id="arr-step4" edge="1" parent="1" source="broker-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="consumer-box" value="4. Deliver Claim Check Token ➔">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="930" y="375" />
              <mxPoint x="930" y="285" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Step 5: Consumer streams payload directly from Storage -->
        <mxCell id="arr-step5" edge="1" parent="1" source="consumer-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#2563EB;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#2563EB;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="s3-store" value="5. GET blob by URI (50MB) ➔">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1190" y="150" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Step 6: Consumer releases Claim Check / Triggers Cleanup -->
        <mxCell id="arr-step6" edge="1" parent="1" source="consumer-box" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#64748B;strokeWidth=1.2;dashed=1;endArrow=block;endFill=1;fontColor=#64748B;fontFamily=Comic Sans MS;fontSize=10;" target="s3-store" value="6. Optional: Release Claim (DELETE or TTL Lifecycle)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1000" y="220" />
              <mxPoint x="830" y="220" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Bottom Shaded Hazard Box adhering to standard -->
        <mxCell id="bottom-hazard-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" value="&lt;b style=&quot;font-size: 11px;&quot;&gt;Operational Failure Modes &amp;amp; Boundary Invariants:&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Orphaned Blob Storage Leak&lt;/b&gt;: If the message token is permanently lost or routed to an unmonitored DLQ, the 50MB payload remains in object storage forever. Mitigate via automated bucket lifecycle retention policies (e.g., delete unreferenced blobs after 7 days).&lt;br&gt;&amp;bull; &lt;b&gt;Read-After-Write Consistency Race&lt;/b&gt;: If the object store exhibits eventual consistency, a fast consumer might attempt GET before the blob has fully replicated, receiving HTTP 404. Modern S3 and GCS guarantee strong read-after-write consistency.&lt;br&gt;&amp;bull; &lt;b&gt;Integrity &amp;amp; Tamper Protection&lt;/b&gt;: Never rely solely on object URIs. The pointer message must carry a cryptographic hash (&lt;b&gt;sha256_digest&lt;/b&gt;) computed at write time to guarantee payload immutability across the hydration boundary." vertex="1">
          <mxGeometry height="150" width="1270" x="65" y="490" as="geometry" />
        </mxCell>

        <!-- Footer -->
        <mxCell id="footer-text" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="EIP Part V: Message Transformation &amp;bull; The Claim Check Pattern &amp;bull; wiki.eiakoji.me" vertex="1">
          <mxGeometry height="20" width="1320" x="40" y="650" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-6-idempotent-receiver-fence" name="Idempotent Receiver and Deduplication Fence">
    <mxGraphModel dx="1400" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="720" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Title Banner -->
        <mxCell id="main-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="660" width="1320" x="40" y="30" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="IDEMPOTENT CONSUMPTION: ATOMIC DEDUPLICATION TABLE &amp;amp; FENCING TOKEN VALIDATION" vertex="1">
          <mxGeometry height="25" width="1050" x="65" y="40" as="geometry" />
        </mxCell>

        <!-- Inbound Message Box -->
        <mxCell id="inbound-msg" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Inbound Message&lt;/b&gt;&lt;br&gt;&lt;b&gt;message_id:&lt;/b&gt; &lt;font color=&quot;#2563EB&quot;&gt;msg-101&lt;/font&gt;&lt;br&gt;&lt;b&gt;fencing_token:&lt;/b&gt; v=42&lt;br&gt;&lt;b&gt;Action:&lt;/b&gt; DebitAccount($150)" vertex="1">
          <mxGeometry height="95" width="180" x="70" y="160" as="geometry" />
        </mxCell>

        <!-- Arrow to Receiver Gate -->
        <mxCell id="arr-in" edge="1" parent="1" source="inbound-msg" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#0F172A;strokeWidth=1.8;endArrow=block;endFill=1;" target="receiver-worker">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- Consumer Worker Process -->
        <mxCell id="receiver-worker" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.8;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Consumer Worker Loop&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#334155&quot;&gt;Opens Database Transaction&lt;br&gt;Step 1: Attempt Dedup Insert&lt;br&gt;Step 2: Check Fencing Token&lt;br&gt;Step 3: Mutate Business State&lt;/font&gt;" vertex="1">
          <mxGeometry height="140" width="200" x="320" y="140" as="geometry" />
        </mxCell>

        <!-- Path 1: First Arrival (Success) -->
        <mxCell id="arr-path1" edge="1" parent="1" source="receiver-worker" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#16A34A;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#16A34A;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="dedup-success" value="First Arrival: Key Inserted ➔">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="420" y="100" />
              <mxPoint x="640" y="100" />
            </Array>
          </mxGeometry>
        </mxCell>

        <mxCell id="dedup-success" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#DCFCE7;strokeColor=#16A34A;strokeWidth=1.5;fontColor=#166534;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;INSERT INTO processed_messages&lt;/b&gt;&lt;br&gt;Key: &lt;b&gt;msg-101&lt;/b&gt; ➔ &lt;b&gt;OK (Row Created)&lt;/b&gt;&lt;br&gt;Fencing Token: 42 &amp;gt; 41 ➔ Valid&lt;br&gt;State: Deduct $150 from balance&lt;br&gt;&lt;b style=&quot;color:#16A34A;&quot;&gt;COMMIT TX &amp;amp; ACK TO BROKER&lt;/b&gt;" vertex="1">
          <mxGeometry height="110" width="280" x="600" y="115" as="geometry" />
        </mxCell>

        <!-- Path 2: Duplicate Arrival (Collision Catch) -->
        <mxCell id="arr-path2" edge="1" parent="1" source="receiver-worker" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;strokeColor=#DC2626;strokeWidth=1.8;endArrow=block;endFill=1;fontColor=#DC2626;fontFamily=Comic Sans MS;fontSize=10;fontStyle=1;" target="dedup-collision" value="Duplicate Arrival: Collision ➔">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="420" y="320" />
              <mxPoint x="640" y="320" />
            </Array>
          </mxGeometry>
        </mxCell>

        <mxCell id="dedup-collision" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FEE2E2;strokeColor=#DC2626;strokeWidth=1.5;fontColor=#991B1B;fontSize=11;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=6;" value="&lt;b&gt;PRIMARY KEY VIOLATION!&lt;/b&gt;&lt;br&gt;Key: &lt;b&gt;msg-101&lt;/b&gt; already exists!&lt;br&gt;&lt;b&gt;Action:&lt;/b&gt; Rollback business mutation&lt;br&gt;Emit &lt;b&gt;ACK&lt;/b&gt; to Broker immediately&lt;br&gt;&lt;b style=&quot;color:#16A34A;&quot;&gt;ZERO DUPLICATE EXECUTION&lt;/b&gt;" vertex="1">
          <mxGeometry height="110" width="280" x="600" y="275" as="geometry" />
        </mxCell>

        <!-- Fencing Token Guard Box (Right Side) -->
        <mxCell id="fencing-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 11px;&quot;&gt;The Fencing Token Defense:&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Problem&lt;/b&gt;: A delayed message with an old state payload arrives out of order after a newer update committed.&lt;br&gt;&amp;bull; &lt;b&gt;Condition&lt;/b&gt;: &lt;font color=&quot;#2563EB&quot;&gt;&lt;b&gt;v_fencing &amp;gt; v_current&lt;/b&gt;&lt;/font&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Stale Packet Action&lt;/b&gt;: If token &amp;le; current, message is dropped without mutating state.&lt;br&gt;&amp;bull; &lt;b&gt;Guarantee&lt;/b&gt;: Protects against Byzantine network reordering." vertex="1">
          <mxGeometry height="180" width="350" x="960" y="160" as="geometry" />
        </mxCell>

        <!-- Bottom Shaded Hazard Box adhering to standard -->
        <mxCell id="bottom-hazard-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=10;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=4;" value="&lt;b style=&quot;font-size: 11px;&quot;&gt;Deduplication Table Sizing &amp;amp; Eviction Invariants:&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Sliding Time Window&lt;/b&gt;: Deduplication tables must retain message IDs only for the maximum expected redelivery window (e.g., 7 days). Retaining IDs indefinitely creates table bloat that degrades index lookup performance.&lt;br&gt;&amp;bull; &lt;b&gt;Partition Partitioning&lt;/b&gt;: In high-throughput systems (&amp;gt;50,000 msgs/sec), partition the deduplication table by hash(message_id) or date range to maintain b-tree indexes entirely within RAM.&lt;br&gt;&amp;bull; &lt;b&gt;Atomic Scope&lt;/b&gt;: Deduplication token check and business logic state mutation must share the exact same database transaction. Checking dedup in Redis and updating PostgreSQL in separate calls re-introduces the dual-write race." vertex="1">
          <mxGeometry height="160" width="1270" x="65" y="480" as="geometry" />
        </mxCell>

        <!-- Footer -->
        <mxCell id="footer-text" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="EIP Part VI: Messaging Endpoints and Reliable Processing &amp;bull; wiki.eiakoji.me" vertex="1">
          <mxGeometry height="20" width="1320" x="40" y="650" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
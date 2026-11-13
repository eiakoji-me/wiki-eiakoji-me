<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-3-message-envelope" name="Message Anatomy: Classic EIP vs CloudEvents Envelope">
    <mxGraphModel dx="1200" dy="700" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="450" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- MAIN CONTAINER -->
        <mxCell id="main-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="380" width="1120" x="40" y="30" as="geometry" />
        </mxCell>
        <mxCell id="main-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=0.5;" value="ANATOMY OF AN ENTERPRISE MESSAGE: CLASSIC EIP ENVELOPE VS. CLOUDEVENTS v1.0" vertex="1">
          <mxGeometry height="22" width="900" x="60" y="40" as="geometry" />
        </mxCell>

        <!-- PANEL A: CLASSIC EIP ENVELOPE -->
        <mxCell id="p1-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="510" x="65" y="75" as="geometry" />
        </mxCell>
        <mxCell id="p1-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="CLASSIC EIP MESSAGE ENVELOPE (HOHPE &amp;amp; WOOLF)" vertex="1">
          <mxGeometry height="20" width="480" x="80" y="85" as="geometry" />
        </mxCell>

        <!-- Header Segment -->
        <mxCell id="p1-hdr-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=left;spacingLeft=10;" value="&lt;b style=&quot;font-size:11px;&quot;&gt;Message Headers (Routing &amp;amp; Infrastructure Metadata):&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Message ID:&lt;/b&gt; Unique message identifier (UUID)&lt;br&gt;&amp;bull; &lt;b&gt;Correlation ID:&lt;/b&gt; Associates reply with initiating request&lt;br&gt;&amp;bull; &lt;b&gt;Return Address:&lt;/b&gt; Callback channel name (&lt;i&gt;reply-to&lt;/i&gt;)&lt;br&gt;&amp;bull; &lt;b&gt;Sequence Identifier:&lt;/b&gt; Part index, total count, stream offset&lt;br&gt;&amp;bull; &lt;b&gt;Expiration (TTL):&lt;/b&gt; Epoch expiration timestamp&lt;br&gt;&amp;bull; &lt;b&gt;Format Indicator:&lt;/b&gt; MIME type, schema identifier" vertex="1">
          <mxGeometry height="115" width="480" x="80" y="110" as="geometry" />
        </mxCell>

        <!-- Payload Segment -->
        <mxCell id="p1-payload-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=left;spacingLeft=10;" value="&lt;b style=&quot;font-size:11px;&quot;&gt;Message Body / Payload (Domain Business Content):&lt;/b&gt;&lt;br&gt;&amp;bull; Uninterpreted byte array, serialized XML, or JSON payload&lt;br&gt;&amp;bull; Mediators inspect headers without deserializing the body (zero-copy routing)" vertex="1">
          <mxGeometry height="55" width="480" x="80" y="235" as="geometry" />
        </mxCell>

        <mxCell id="p1-summary" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#475569;fontFamily=Comic Sans MS;" value="&lt;b&gt;Key Rule:&lt;/b&gt; Infrastructure reads headers; business logic reads the body." vertex="1">
          <mxGeometry height="20" width="480" x="80" y="305" as="geometry" />
        </mxCell>

        <!-- PANEL B: CLOUDEVENTS v1.0 & BROKER WIRE PROTOCOL -->
        <mxCell id="p2-panel" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="550" x="590" y="75" as="geometry" />
        </mxCell>
        <mxCell id="p2-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="MODERN CLOUDEVENTS v1.0 &amp;amp; BROKER WIRE PROTOCOL" vertex="1">
          <mxGeometry height="20" width="520" x="605" y="85" as="geometry" />
        </mxCell>

        <!-- CloudEvents Attributes -->
        <mxCell id="p2-ce-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#F1F5F9;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=left;spacingLeft=10;" value="&lt;b style=&quot;font-size:11px;&quot;&gt;CloudEvents Required &amp;amp; Optional Context Attributes:&lt;/b&gt;&lt;br&gt;&amp;bull; &lt;b&gt;id:&lt;/b&gt; Unique event ID &amp;bull; &lt;b&gt;source:&lt;/b&gt; URI reference of emitter&lt;br&gt;&amp;bull; &lt;b&gt;specversion:&lt;/b&gt; &quot;1.0&quot; &amp;bull; &lt;b&gt;type:&lt;/b&gt; Domain event schema name&lt;br&gt;&amp;bull; &lt;b&gt;datacontenttype:&lt;/b&gt; &quot;application/avro&quot; or &quot;application/json&quot;&lt;br&gt;&amp;bull; &lt;b&gt;dataschema:&lt;/b&gt; URL to Avro/Protobuf schema definition in registry&lt;br&gt;&amp;bull; &lt;b&gt;traceparent:&lt;/b&gt; W3C distributed tracing context propagation header" vertex="1">
          <mxGeometry height="115" width="520" x="605" y="110" as="geometry" />
        </mxCell>

        <!-- CloudEvents Data -->
        <mxCell id="p2-data-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.2;fontColor=#0F172A;fontSize=10;fontFamily=Comic Sans MS;align=left;spacingLeft=10;" value="&lt;b style=&quot;font-size:11px;&quot;&gt;data / data_base64 (Domain State):&lt;/b&gt;&lt;br&gt;&amp;bull; Strongly-typed schema validated against Confluent/Apicurio Registry&lt;br&gt;&amp;bull; Enforces backward/forward binary compatibility across microservices" vertex="1">
          <mxGeometry height="55" width="520" x="605" y="235" as="geometry" />
        </mxCell>

        <mxCell id="p2-summary" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#475569;fontFamily=Comic Sans MS;" value="&lt;b&gt;Standardization:&lt;/b&gt; Supported natively by CNCF, Kafka, Knative, AWS EventBridge." vertex="1">
          <mxGeometry height="20" width="520" x="605" y="305" as="geometry" />
        </mxCell>

        <!-- FOOTER INVARIANT NOTE -->
        <mxCell id="main-footer" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=10;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;Architectural Boundary:&lt;/b&gt; By isolating infrastructure routing headers from business payloads, message brokers remain high-throughput zero-copy conduits without schema dependencies." vertex="1">
          <mxGeometry height="22" width="1080" x="65" y="365" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

<mxfile host="Electron" agent="Antigravity">
  <diagram id="eip-part-5-hero-monochrome" name="EIP Part V Hero Message Transformation">
    <mxGraphModel dx="1600" dy="900" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1600" pageHeight="920" background="#FFFFFF" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- TIER 1: INGRESS NORMALIZATION & FORMAT TRANSLATION -->
        <mxCell id="tier1-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="140" width="1440" x="80" y="40" as="geometry" />
        </mxCell>
        <mxCell id="tier1-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="1. INGRESS NORMALIZATION &amp;amp; ANTI-CORRUPTION TRANSLATION" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="48" as="geometry" />
        </mxCell>

        <!-- Tier 1 Components -->
        <mxCell id="t1-normalizer" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Normalizer / ACL&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Maps disparate vendor schemas &amp;bull; Anti-Corruption Layer&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="105" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-translator" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Message Translator&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Translates wire formats (JSON &amp;bull; Avro &amp;bull; Protobuf DTO)&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="580" y="78" as="geometry" />
        </mxCell>
        <mxCell id="t1-wrapper" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=12;fontFamily=Comic Sans MS;align=center;verticalAlign=middle;arcSize=8;" value="&lt;b style=&quot;font-size: 13px;&quot;&gt;Envelope Wrapper&lt;/b&gt;&lt;br&gt;&lt;font color=&quot;#475569&quot;&gt;Encapsulates domain object &amp;bull; Injects tenant &amp;amp; trace headers&lt;/font&gt;" vertex="1">
          <mxGeometry height="75" width="450" x="1055" y="78" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 1 -> 2 -->
        <mxCell id="arr-tier1-tier2" edge="1" parent="1" source="tier1-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier2-container" value="Normalized Payloads Streamed to Content Hydration &amp;amp; Optimization ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 2: CONTENT HYDRATION, FILTERING & CLAIM CHECK -->
        <mxCell id="tier2-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=2;dashed=1;dashPattern=6 4;arcSize=6;" value="" vertex="1">
          <mxGeometry height="330" width="1440" x="80" y="225" as="geometry" />
        </mxCell>
        <mxCell id="tier2-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="2. CONTENT ENRICHMENT, PRIVACY FILTERING &amp;amp; CLAIM CHECK STORAGE" vertex="1">
          <mxGeometry height="22" width="800" x="105" y="235" as="geometry" />
        </mxCell>

        <!-- PANEL A: CONTENT ENRICHER -->
        <mxCell id="p2a-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="105" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2a-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="A. CONTENT ENRICHER (HYDRATION CONDUIT)" vertex="1">
          <mxGeometry height="20" width="420" x="120" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2a-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Mechanic:&lt;/b&gt; Enriches lightweight event with reference data.&lt;br&gt;&lt;b&gt;Data Source:&lt;/b&gt; Queries Redis cache, SQL read-replica, or microservice.&lt;br&gt;&lt;b&gt;Output:&lt;/b&gt; Self-contained event ready for downstream evaluation." vertex="1">
          <mxGeometry height="65" width="420" x="120" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2a-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Latency Penalty&lt;/b&gt;: External synchronous query blocks stream pipeline.&lt;br&gt;&lt;b&gt;• Failure Mode&lt;/b&gt;: Cache miss / database timeout requires circuit breaker.&lt;br&gt;&lt;b&gt;• Temporal Hazard&lt;/b&gt;: Hydrated state might diverge from event creation time.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: Flink AsyncFunction, Kafka Streams KTable join." vertex="1">
          <mxGeometry height="95" width="420" x="120" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL B: CONTENT FILTER -->
        <mxCell id="p2b-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="575" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2b-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="B. CONTENT FILTER (PII &amp;amp; SENSITIVITY STRIPPING)" vertex="1">
          <mxGeometry height="20" width="420" x="590" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2b-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Mechanic:&lt;/b&gt; Strips non-essential, sensitive, or high-cardinality fields.&lt;br&gt;&lt;b&gt;Purpose:&lt;/b&gt; Enforces GDPR / PCI-DSS boundaries before broadcast.&lt;br&gt;&lt;b&gt;Output:&lt;/b&gt; Minimized payload reducing broker network saturation." vertex="1">
          <mxGeometry height="65" width="420" x="590" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2b-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Data Minimization&lt;/b&gt;: Removes SSNs, credit card tokens, raw passwords.&lt;br&gt;&lt;b&gt;• Egress Enforcement&lt;/b&gt;: Applied at trust domain boundaries.&lt;br&gt;&lt;b&gt;• Performance Benefit&lt;/b&gt;: Smaller serialization footprint speeds broker disk fsync.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: MapStruct projection, Jackson custom view serializer." vertex="1">
          <mxGeometry height="95" width="420" x="590" y="380" as="geometry" />
        </mxCell>

        <!-- PANEL C: CLAIM CHECK -->
        <mxCell id="p2c-box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#F8FAFC;strokeColor=#0F172A;strokeWidth=1.8;arcSize=6;" value="" vertex="1">
          <mxGeometry height="270" width="450" x="1045" y="265" as="geometry" />
        </mxCell>
        <mxCell id="p2c-header" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=12;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;" value="C. CLAIM CHECK (LARGE PAYLOAD OFFLOADING)" vertex="1">
          <mxGeometry height="20" width="420" x="1060" y="275" as="geometry" />
        </mxCell>
        <mxCell id="p2c-body" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;" value="&lt;b&gt;Mechanic:&lt;/b&gt; Large binary payload (&amp;gt;1MB) persisted to Object Store.&lt;br&gt;&lt;b&gt;Pointer Message:&lt;/b&gt; Lightweight token with URI, SHA-256 &amp;amp; TTL sent to broker.&lt;br&gt;&lt;b&gt;Consumer Action:&lt;/b&gt; Hydrates blob directly from storage on demand." vertex="1">
          <mxGeometry height="65" width="420" x="1060" y="305" as="geometry" />
        </mxCell>
        <mxCell id="p2c-bullets" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=11;fontColor=#334155;fontFamily=Comic Sans MS;" value="&lt;b&gt;• Broker Protection&lt;/b&gt;: Eliminates broker JVM heap pressure and GC pause spikes.&lt;br&gt;&lt;b&gt;• Lifecycle Hazard&lt;/b&gt;: Orphaned blobs in S3/GCS if consumer crashes or message drops.&lt;br&gt;&lt;b&gt;• Consistency Guarantee&lt;/b&gt;: Strong read-after-write consistency required in blob store.&lt;br&gt;&lt;b&gt;• Realization&lt;/b&gt;: AWS S3 / Google Cloud Storage + SQS / Kafka pointer token." vertex="1">
          <mxGeometry height="95" width="420" x="1060" y="380" as="geometry" />
        </mxCell>

        <!-- CONNECTOR 2 -> 3 -->
        <mxCell id="arr-tier2-tier3" edge="1" parent="1" source="tier2-container" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;sketch=1;curveFitting=1;jiggle=1.5;strokeColor=#0F172A;strokeWidth=2;endArrow=block;endFill=1;fontColor=#0F172A;fontFamily=Comic Sans MS;fontSize=11;fontStyle=1;" target="tier3-container" value="Evaluated Against Enterprise Interoperability Architecture ➔">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- TIER 3: CANONICAL DATA MODEL VS BOUNDED CONTEXTS -->
        <mxCell id="tier3-container" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.5;fillColor=#FAFAFA;strokeColor=#0F172A;strokeWidth=2;arcSize=6;" value="" vertex="1">
          <mxGeometry height="260" width="1440" x="80" y="600" as="geometry" />
        </mxCell>
        <mxCell id="tier3-title" parent="1" style="text;html=1;align=left;verticalAlign=middle;fontSize=13;fontStyle=1;fontColor=#0F172A;fontFamily=Comic Sans MS;letterSpacing=1;" value="3. THE CANONICAL DATA MODEL FALLACY VS. DOMAIN BOUNDED CONTEXTS" vertex="1">
          <mxGeometry height="22" width="900" x="105" y="610" as="geometry" />
        </mxCell>

        <!-- Left Model Box -->
        <mxCell id="t3-canonical" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Canonical Data Model (Enterprise-Wide Fallacy)&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Premise&lt;/b&gt;: Single unified schema defining all enterprise business concepts.&lt;br&gt;&amp;bull; &lt;b&gt;Bottleneck&lt;/b&gt;: Cross-departmental committee approval required for every schema change.&lt;br&gt;&amp;bull; &lt;b&gt;Failure Mode&lt;/b&gt;: Massive schema bloat; lowest common denominator representation.&lt;br&gt;&amp;bull; &lt;b&gt;Historical Fate&lt;/b&gt;: High failure rate in large-scale enterprise integration initiatives." vertex="1">
          <mxGeometry height="135" width="450" x="105" y="640" as="geometry" />
        </mxCell>

        <!-- Center Model Box -->
        <mxCell id="t3-bounded-context" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#FFFFFF;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#0F172A;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Bounded Contexts &amp;amp; Anti-Corruption Layers (DDD)&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Premise&lt;/b&gt;: Each subsystem defines autonomous local models tailored to its domain.&lt;br&gt;&amp;bull; &lt;b&gt;Translation&lt;/b&gt;: Explicit Anti-Corruption Layer (ACL) translates boundary contracts.&lt;br&gt;&amp;bull; &lt;b&gt;Resilience&lt;/b&gt;: Upstream schema changes are absorbed at the translation perimeter.&lt;br&gt;&amp;bull; &lt;b&gt;Scalability&lt;/b&gt;: Independent team deployment velocity with zero global coupling." vertex="1">
          <mxGeometry height="135" width="450" x="575" y="640" as="geometry" />
        </mxCell>

        <!-- Shaded Invariant Rectangle adhering to standard -->
        <mxCell id="t3-shaded-invariants" parent="1" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;curveFitting=1;jiggle=1.2;fillColor=#E2E8F0;strokeColor=#0F172A;strokeWidth=1.5;fontColor=#000000;labelBackgroundColor=#FFFFFF;fontSize=11;fontFamily=Comic Sans MS;align=left;verticalAlign=top;arcSize=6;" value="&lt;b style=&quot;font-size: 12px;&quot;&gt;Enterprise Architectural Invariants&lt;/b&gt;&lt;br&gt;&lt;br&gt;&amp;bull; &lt;b&gt;Payload Budgeting&lt;/b&gt;: Broker messages must remain under 256KB to avoid JVM GC stalls.&lt;br&gt;&amp;bull; &lt;b&gt;Integrity Hashing&lt;/b&gt;: Claim check tokens must include cryptographic digests (SHA-256).&lt;br&gt;&amp;bull; &lt;b&gt;Schema Compatibility&lt;/b&gt;: Wire schemas must enforce backward &amp;amp; forward compatibility." vertex="1">
          <mxGeometry height="135" width="450" x="1045" y="640" as="geometry" />
        </mxCell>

        <!-- Summary Footer -->
        <mxCell id="footer-text" parent="1" style="text;html=1;align=center;verticalAlign=middle;fontSize=11;fontColor=#64748B;fontFamily=Comic Sans MS;" value="Gregor Hohpe &amp;amp; Bobby Woolf &amp;bull; Enterprise Integration Patterns: Part V Message Transformation &amp;amp; Interoperability" vertex="1">
          <mxGeometry height="20" width="1440" x="80" y="790" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
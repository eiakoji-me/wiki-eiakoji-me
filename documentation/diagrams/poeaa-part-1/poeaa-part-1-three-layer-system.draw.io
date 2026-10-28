<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="app.diagrams.net" agent="Antigravity" version="24.0.0" type="device">
  <diagram id="poeaa-part-1-three-layer" name="Three-Layer Architecture">
    <mxGraphModel dx="1200" dy="700" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="700" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Canvas Background -->
        <mxCell id="bg" value="" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=none;" vertex="1" parent="1">
          <mxGeometry x="0" y="0" width="1200" height="700" as="geometry" />
        </mxCell>

        <!-- Header -->
        <mxCell id="title" value="The Three-Layer Architecture: Strict Unidirectional Dependency" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=22;" vertex="1" parent="1">
          <mxGeometry x="80" y="25" width="1040" height="35" as="geometry" />
        </mxCell>
        <mxCell id="subtitle" value="Unidirectional Flow: Presentation Layer ➔ Domain Layer ➔ Data Source Layer (Zero Inward Coupling)" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#475569;fontSize=14;" vertex="1" parent="1">
          <mxGeometry x="80" y="60" width="1040" height="25" as="geometry" />
        </mxCell>

        <!-- LAYER 1: Presentation Layer -->
        <mxCell id="layer1" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=2;arcSize=4;" vertex="1" parent="1">
          <mxGeometry x="80" y="95" width="1040" height="130" as="geometry" />
        </mxCell>

        <mxCell id="layer1_title" value="&lt;b style=&quot;font-size:16px; color:#1d4ed8;&quot;&gt;1. Presentation Layer&lt;/b&gt; &amp;nbsp;&lt;span style=&quot;font-size:12px; color:#2563eb;&quot;&gt;Handles transport protocols, user interaction, DTO conversion, and response serialization&lt;/span&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="100" y="105" width="1000" height="25" as="geometry" />
        </mxCell>

        <mxCell id="l1_b1" value="&lt;b style=&quot;color:#1e40af;&quot;&gt;HTTP / REST Controllers&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#3b82f6;&quot;&gt;Parses route params &amp;amp; body&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#93c5fd;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="105" y="140" width="230" height="65" as="geometry" />
        </mxCell>

        <mxCell id="l1_b2" value="&lt;b style=&quot;color:#1e40af;&quot;&gt;GraphQL Resolvers&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#3b82f6;&quot;&gt;Query / Mutation dispatch&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#93c5fd;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="360" y="140" width="230" height="65" as="geometry" />
        </mxCell>

        <mxCell id="l1_b3" value="&lt;b style=&quot;color:#1e40af;&quot;&gt;Webhook / CLI Handlers&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#3b82f6;&quot;&gt;Ingests external event payloads&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#93c5fd;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="615" y="140" width="230" height="65" as="geometry" />
        </mxCell>

        <mxCell id="l1_b4" value="&lt;b style=&quot;color:#1e40af;&quot;&gt;DTO Serialization&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#3b82f6;&quot;&gt;Maps domain models to JSON&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#93c5fd;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="870" y="140" width="230" height="65" as="geometry" />
        </mxCell>

        <!-- Downward Connector 1 -->
        <mxCell id="arrow1" value="depends on / dispatches domain commands ↓" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#2563eb;strokeWidth=2.5;fontColor=#1d4ed8;fontSize=12;fontStyle=1;" edge="1" parent="1" source="layer1" target="layer2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- LAYER 2: Domain Layer (The Core) -->
        <mxCell id="layer2" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#059669;strokeWidth=2.5;arcSize=4;" vertex="1" parent="1">
          <mxGeometry x="80" y="270" width="1040" height="150" as="geometry" />
        </mxCell>

        <mxCell id="layer2_title" value="&lt;b style=&quot;font-size:17px; color:#047857;&quot;&gt;2. Domain Layer (The Intellectual Heart)&lt;/b&gt; &amp;nbsp;&lt;span style=&quot;font-size:12px; color:#059669;&quot;&gt;Encapsulates business rules, invariants, and algorithms — completely independent of DB or transport&lt;/span&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="100" y="280" width="1000" height="25" as="geometry" />
        </mxCell>

        <mxCell id="l2_b1" value="&lt;b style=&quot;color:#065f46;&quot;&gt;Service Layer&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Coordinates workflows, sets tx boundaries, and coordinates entities&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#34d399;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="105" y="315" width="230" height="85" as="geometry" />
        </mxCell>

        <mxCell id="l2_b2" value="&lt;b style=&quot;color:#065f46;&quot;&gt;Rich Domain Entities&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Maintains mutable private state and protects business invariants&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#34d399;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="360" y="315" width="230" height="85" as="geometry" />
        </mxCell>

        <mxCell id="l2_b3" value="&lt;b style=&quot;color:#065f46;&quot;&gt;Value Objects&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Immutable, self-validating concepts (Money, BillingPeriod)&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#34d399;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="615" y="315" width="230" height="85" as="geometry" />
        </mxCell>

        <mxCell id="l2_b4" value="&lt;b style=&quot;color:#065f46;&quot;&gt;Domain Services&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Pure business algorithms spanning multiple entities&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#34d399;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="870" y="315" width="230" height="85" as="geometry" />
        </mxCell>

        <!-- Downward Connector 2 -->
        <mxCell id="arrow2" value="invokes storage interfaces / gateway abstractions ↓" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#059669;strokeWidth=2.5;fontColor=#047857;fontSize=12;fontStyle=1;" edge="1" parent="1" source="layer2" target="layer3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- LAYER 3: Data Source Layer -->
        <mxCell id="layer3" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#faf5ff;strokeColor=#a855f7;strokeWidth=2;arcSize=4;" vertex="1" parent="1">
          <mxGeometry x="80" y="465" width="1040" height="130" as="geometry" />
        </mxCell>

        <mxCell id="layer3_title" value="&lt;b style=&quot;font-size:16px; color:#7e22ce;&quot;&gt;3. Data Source Layer&lt;/b&gt; &amp;nbsp;&lt;span style=&quot;font-size:12px; color:#9333ea;&quot;&gt;Manages interactions with databases, messaging queues, filesystems, and external services&lt;/span&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="100" y="475" width="1000" height="25" as="geometry" />
        </mxCell>

        <mxCell id="l3_b1" value="&lt;b style=&quot;color:#6b21a8;&quot;&gt;Relational Databases&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#a855f7;&quot;&gt;PostgreSQL, MySQL, SQLite&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#d8b4fe;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="105" y="510" width="230" height="65" as="geometry" />
        </mxCell>

        <mxCell id="l3_b2" value="&lt;b style=&quot;color:#6b21a8;&quot;&gt;Repositories &amp;amp; Mappers&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#a855f7;&quot;&gt;Data Mapper / Table Gateways&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#d8b4fe;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="360" y="510" width="230" height="65" as="geometry" />
        </mxCell>

        <mxCell id="l3_b3" value="&lt;b style=&quot;color:#6b21a8;&quot;&gt;Payment &amp;amp; External APIs&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#a855f7;&quot;&gt;Stripe, SendGrid, Auth0 clients&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#d8b4fe;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="615" y="510" width="230" height="65" as="geometry" />
        </mxCell>

        <mxCell id="l3_b4" value="&lt;b style=&quot;color:#6b21a8;&quot;&gt;Message Queues &amp;amp; Events&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#a855f7;&quot;&gt;RabbitMQ, Kafka, Pub/Sub&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#d8b4fe;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="870" y="510" width="230" height="65" as="geometry" />
        </mxCell>

        <!-- Non-Negotiable Invariant Banner -->
        <mxCell id="rule_banner" value="&lt;b style=&quot;color:#b91c1c;&quot;&gt;The Invariant of Directionality:&lt;/b&gt; &lt;span style=&quot;color:#991b1b;&quot;&gt;Lower layers NEVER depend on upper layers. The Domain Layer is completely decoupled from HTTP frameworks, request lifecycles, and relational database schemas.&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fef2f2;strokeColor=#ef4444;strokeWidth=1.5;align=center;verticalAlign=middle;arcSize=6;fontSize=12;" vertex="1" parent="1">
          <mxGeometry x="80" y="620" width="1040" height="45" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
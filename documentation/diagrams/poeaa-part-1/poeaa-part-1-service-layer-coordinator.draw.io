<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="app.diagrams.net" agent="Antigravity" version="24.0.0" type="device">
  <diagram id="poeaa-part-1-service-layer" name="Service Layer Coordinator">
    <mxGraphModel dx="1200" dy="750" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="750" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Canvas Background -->
        <mxCell id="bg" value="" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=none;" vertex="1" parent="1">
          <mxGeometry x="0" y="0" width="1200" height="750" as="geometry" />
        </mxCell>

        <!-- Presentation Layer Caller -->
        <mxCell id="client_caller" value="&lt;b style=&quot;font-size:15px; color:#1d4ed8;&quot;&gt;Presentation Layer (HTTP Controller / GraphQL Resolver)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#2563eb;&quot;&gt;Receives client request: upgradeSubscription(customerId, newPlanId)&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=2;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="320" y="30" width="560" height="65" as="geometry" />
        </mxCell>

        <!-- Downward Arrow to Service Layer -->
        <mxCell id="caller_arrow" value="invokes use-case workflow ↓" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#2563eb;strokeWidth=2.5;fontColor=#1d4ed8;fontSize=12;fontStyle=1;" edge="1" parent="1" source="client_caller" target="service_layer">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>

        <!-- SERVICE LAYER CONTAINER -->
        <mxCell id="service_layer" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#059669;strokeWidth=2.5;arcSize=4;" vertex="1" parent="1">
          <mxGeometry x="80" y="140" width="1040" height="280" as="geometry" />
        </mxCell>

        <mxCell id="sl_title" value="&lt;b style=&quot;font-size:18px; color:#047857;&quot;&gt;Service Layer Boundary: SubscriptionBillingService&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:12px; color:#059669;&quot;&gt;Establishes available operations, transaction boundaries, and coordinates domain logic with infrastructure&lt;/span&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="105" y="150" width="990" height="35" as="geometry" />
        </mxCell>

        <!-- Responsibility 1 -->
        <mxCell id="sl_r1" value="&lt;b style=&quot;color:#065f46;&quot;&gt;1. Transaction Boundary&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Manages Unit of Work, ACID commits, and rollback on failure&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#34d399;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="105" y="195" width="225" height="85" as="geometry" />
        </mxCell>

        <!-- Responsibility 2 -->
        <mxCell id="sl_r2" value="&lt;b style=&quot;color:#065f46;&quot;&gt;2. Security &amp;amp; Policy&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Verifies caller permissions and multi-tenant tenant isolation&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#34d399;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="355" y="195" width="225" height="85" as="geometry" />
        </mxCell>

        <!-- Responsibility 3 -->
        <mxCell id="sl_r3" value="&lt;b style=&quot;color:#065f46;&quot;&gt;3. Workflow Orchestration&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Retrieves aggregate, delegates math, coordinates payment&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#34d399;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="605" y="195" width="225" height="85" as="geometry" />
        </mxCell>

        <!-- Responsibility 4 -->
        <mxCell id="sl_r4" value="&lt;b style=&quot;color:#065f46;&quot;&gt;4. Domain Event Publishing&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;Dispatches SubscriptionUpgraded event to message bus&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#34d399;strokeWidth=1.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="855" y="195" width="240" height="85" as="geometry" />
        </mxCell>

        <!-- Golden Rule Callout inside Service Layer -->
        <mxCell id="sl_golden_rule" value="&lt;b style=&quot;color:#065f46;&quot;&gt;The Golden Rule of the Service Layer:&lt;/b&gt; &lt;span style=&quot;color:#047857;&quot;&gt;The Service Layer coordinates the conversation; it NEVER calculates business math. Financial proration, discount logic, and invariant assertions belong exclusively inside Domain Entities and Value Objects.&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f0fdf4;strokeColor=#10b981;strokeWidth=1.5;strokeDasharray=4 2;arcSize=6;fontSize=12;" vertex="1" parent="1">
          <mxGeometry x="105" y="300" width="990" height="50" as="geometry" />
        </mxCell>

        <mxCell id="sl_rule_subtext" value="Anemic Model Anti-Pattern Check: If you find Math.max() or proration calculations here, your domain logic has bled into the coordinator!" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#b45309;fontSize=11;fontStyle=2;" vertex="1" parent="1">
          <mxGeometry x="105" y="365" width="990" height="25" as="geometry" />
        </mxCell>

        <!-- LEFT TARGET: Rich Domain Entities (Pure Business Logic) -->
        <mxCell id="domain_model_target" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f0fdf4;strokeColor=#16a34a;strokeWidth=2;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="80" y="470" width="500" height="175" as="geometry" />
        </mxCell>

        <mxCell id="dmt_title" value="&lt;b style=&quot;font-size:16px; color:#15803d;&quot;&gt;Rich Domain Entities &amp;amp; Value Objects&lt;/b&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="100" y="480" width="460" height="25" as="geometry" />
        </mxCell>

        <mxCell id="dmt_desc" value="&lt;div style=&quot;text-align:left; font-size:12px; color:#166534; line-height:1.4;&quot;&gt;• &lt;b&gt;subscription.applyPlanUpgrade(newPlan, date)&lt;/b&gt;&lt;br&gt;• &lt;b&gt;Money.subtract()&lt;/b&gt; &amp;amp; &lt;b&gt;Money.multiply()&lt;/b&gt; currency safety&lt;br&gt;• &lt;b&gt;BillingPeriod.calculateProrationRatio()&lt;/b&gt;&lt;br&gt;• Enforces invariants (non-negative, active status)&lt;br&gt;&lt;span style=&quot;color:#15803d; font-weight:bold;&quot;&gt;✓ Zero I/O, pure in-memory calculation, 100% testable&lt;/span&gt;&lt;/div&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#86efac;strokeWidth=1;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="100" y="515" width="460" height="115" as="geometry" />
        </mxCell>

        <!-- Downward Arrow from Service to Domain Model -->
        <mxCell id="arrow_to_domain" value="delegates business decisions ↓" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#16a34a;strokeWidth=2.5;fontColor=#15803d;fontSize=12;fontStyle=1;" edge="1" parent="1" source="service_layer" target="domain_model_target">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="330" y="445" />
              <mxPoint x="330" y="445" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- RIGHT TARGET: Repositories & External Gateways (I/O & Persistence) -->
        <mxCell id="infra_target" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#faf5ff;strokeColor=#a855f7;strokeWidth=2;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="620" y="470" width="500" height="175" as="geometry" />
        </mxCell>

        <mxCell id="infrat_title" value="&lt;b style=&quot;font-size:16px; color:#7e22ce;&quot;&gt;Repositories &amp;amp; Infrastructure Gateways&lt;/b&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="1">
          <mxGeometry x="640" y="480" width="460" height="25" as="geometry" />
        </mxCell>

        <mxCell id="infrat_desc" value="&lt;div style=&quot;text-align:left; font-size:12px; color:#6b21a8; line-height:1.4;&quot;&gt;• &lt;b&gt;subscriptionRepo.findById(id)&lt;/b&gt; loads aggregate&lt;br&gt;• &lt;b&gt;paymentGateway.charge(customerId, netAmount)&lt;/b&gt;&lt;br&gt;• &lt;b&gt;subscriptionRepo.save(subscription)&lt;/b&gt; persists state&lt;br&gt;• Dispatches HTTP calls and database SQL transactions&lt;br&gt;&lt;span style=&quot;color:#7e22ce; font-weight:bold;&quot;&gt;✓ Handles all side-effects, failures, and network I/O&lt;/span&gt;&lt;/div&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#d8b4fe;strokeWidth=1;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="640" y="515" width="460" height="115" as="geometry" />
        </mxCell>

        <!-- Downward Arrow from Service to Infrastructure -->
        <mxCell id="arrow_to_infra" value="executes I/O &amp;amp; persistence ↓" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#9333ea;strokeWidth=2.5;fontColor=#7e22ce;fontSize=12;fontStyle=1;" edge="1" parent="1" source="service_layer" target="infra_target">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="870" y="445" />
              <mxPoint x="870" y="445" />
            </Array>
          </mxGeometry>
        </mxCell>

        <!-- Bottom Warning Alert Banner -->
        <mxCell id="anemic_banner" value="&lt;b style=&quot;color:#92400e;&quot;&gt;Architectural Safeguard against Anemic Domain Models:&lt;/b&gt; &lt;span style=&quot;color:#78350f;&quot;&gt;Entities must never be passive data bags manipulated by bloated procedural services. Keep entity state private and mutate state only via expressive domain methods.&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fffbeb;strokeColor=#f59e0b;strokeWidth=1.5;align=center;verticalAlign=middle;arcSize=6;fontSize=12;" vertex="1" parent="1">
          <mxGeometry x="80" y="670" width="1040" height="45" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
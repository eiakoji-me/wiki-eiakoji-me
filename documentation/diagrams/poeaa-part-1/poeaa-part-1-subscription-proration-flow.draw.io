<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="app.diagrams.net" agent="Antigravity" version="24.0.0" type="device">
  <diagram id="poeaa-part-1-proration-flow" name="Subscription Proration Workflow">
    <mxGraphModel dx="1400" dy="850" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="850" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Canvas Background -->
        <mxCell id="bg" value="" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=none;" vertex="1" parent="1">
          <mxGeometry x="0" y="0" width="1400" height="850" as="geometry" />
        </mxCell>

        <!-- Header -->
        <mxCell id="title" value="Hands-On Architecture: Enterprise SaaS Subscription &amp;amp; Proration Engine" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=22;" vertex="1" parent="1">
          <mxGeometry x="60" y="25" width="1280" height="35" as="geometry" />
        </mxCell>
        <mxCell id="subtitle" value="Interaction flow: Presentation Controller ➔ Service Layer ➔ Domain Aggregate ➔ Value Objects ➔ Infrastructure Gateways" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#475569;fontSize=14;" vertex="1" parent="1">
          <mxGeometry x="60" y="60" width="1280" height="25" as="geometry" />
        </mxCell>

        <!-- PARTICIPANT HEADERS -->
        <!-- P1: Client / Presentation -->
        <mxCell id="p1" value="&lt;b style=&quot;font-size:14px; color:#1d4ed8;&quot;&gt;Presentation&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#3b82f6;&quot;&gt;HTTP / GraphQL&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=2;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="60" y="95" width="220" height="55" as="geometry" />
        </mxCell>

        <!-- P2: Service Layer Coordinator -->
        <mxCell id="p2" value="&lt;b style=&quot;font-size:14px; color:#047857;&quot;&gt;Service Layer&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#059669;&quot;&gt;SubscriptionBillingService&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#059669;strokeWidth=2.5;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="325" y="95" width="230" height="55" as="geometry" />
        </mxCell>

        <!-- P3: Aggregate Root -->
        <mxCell id="p3" value="&lt;b style=&quot;font-size:14px; color:#15803d;&quot;&gt;Domain Aggregate&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#16a34a;&quot;&gt;Subscription Entity&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f0fdf4;strokeColor=#16a34a;strokeWidth=2;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="600" y="95" width="210" height="55" as="geometry" />
        </mxCell>

        <!-- P4: Value Objects -->
        <mxCell id="p4" value="&lt;b style=&quot;font-size:14px; color:#b45309;&quot;&gt;Value Objects&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#d97706;&quot;&gt;Money &amp;amp; BillingPeriod&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fffbeb;strokeColor=#f59e0b;strokeWidth=2;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="855" y="95" width="210" height="55" as="geometry" />
        </mxCell>

        <!-- P5: Gateways & Repos -->
        <mxCell id="p5" value="&lt;b style=&quot;font-size:14px; color:#7e22ce;&quot;&gt;Data Source &amp;amp; APIs&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#9333ea;&quot;&gt;Repository &amp;amp; Stripe Gateway&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#faf5ff;strokeColor=#a855f7;strokeWidth=2;arcSize=6;" vertex="1" parent="1">
          <mxGeometry x="1110" y="95" width="230" height="55" as="geometry" />
        </mxCell>

        <!-- SWIMLANE LIFELINES (Vertical dashed lines) -->
        <mxCell id="line1" value="" style="endArrow=none;dashed=1;html=1;dashPattern=1 4;strokeWidth=1.5;strokeColor=#cbd5e1;" edge="1" parent="1" source="p1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="170" y="150" as="sourcePoint" />
            <mxPoint x="170" y="740" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="line2" value="" style="endArrow=none;dashed=1;html=1;dashPattern=1 4;strokeWidth=1.5;strokeColor=#cbd5e1;" edge="1" parent="1" source="p2">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="440" y="150" as="sourcePoint" />
            <mxPoint x="440" y="740" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="line3" value="" style="endArrow=none;dashed=1;html=1;dashPattern=1 4;strokeWidth=1.5;strokeColor=#cbd5e1;" edge="1" parent="1" source="p3">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="705" y="150" as="sourcePoint" />
            <mxPoint x="705" y="740" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="line4" value="" style="endArrow=none;dashed=1;html=1;dashPattern=1 4;strokeWidth=1.5;strokeColor=#cbd5e1;" edge="1" parent="1" source="p4">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="960" y="150" as="sourcePoint" />
            <mxPoint x="960" y="740" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="line5" value="" style="endArrow=none;dashed=1;html=1;dashPattern=1 4;strokeWidth=1.5;strokeColor=#cbd5e1;" edge="1" parent="1" source="p5">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="1225" y="150" as="sourcePoint" />
            <mxPoint x="1225" y="740" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- STEP 1: Presentation to Service -->
        <mxCell id="step1_arrow" value="1. upgradeSubscription(customerId, newPlanId)" style="endArrow=block;html=1;strokeColor=#2563eb;strokeWidth=2;fontColor=#1d4ed8;fontSize=11;fontStyle=1;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="170" y="190" as="sourcePoint" />
            <mxPoint x="440" y="190" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- STEP 2: Service to Repo: findById -->
        <mxCell id="step2_arrow" value="2. repository.findById(subscriptionId)" style="endArrow=block;html=1;strokeColor=#9333ea;strokeWidth=2;fontColor=#7e22ce;fontSize=11;fontStyle=1;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="440" y="240" as="sourcePoint" />
            <mxPoint x="1225" y="240" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- STEP 3: Repo returns hydrated aggregate -->
        <mxCell id="step3_arrow" value="3. returns hydrated Subscription aggregate" style="endArrow=block;dashed=1;html=1;strokeColor=#9333ea;strokeWidth=1.5;fontColor=#7e22ce;fontSize=11;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="1225" y="280" as="sourcePoint" />
            <mxPoint x="440" y="280" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- STEP 4: Service delegates to Aggregate -->
        <mxCell id="step4_arrow" value="4. subscription.applyPlanUpgrade(newPlan, date)" style="endArrow=block;html=1;strokeColor=#16a34a;strokeWidth=2.5;fontColor=#15803d;fontSize=12;fontStyle=1;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="440" y="335" as="sourcePoint" />
            <mxPoint x="705" y="335" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- HIGHLIGHT BOX AROUND DOMAIN PURE MATH -->
        <mxCell id="domain_math_box" value="" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#10b981;strokeWidth=2;strokeDasharray=4 2;arcSize=4;" vertex="1" parent="1">
          <mxGeometry x="640" y="370" width="380" height="150" as="geometry" />
        </mxCell>
        <mxCell id="dmb_title" value="&lt;b style=&quot;color:#047857;&quot;&gt;Pure In-Memory Domain Invariants (Zero I/O)&lt;/b&gt;" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=top;whiteSpace=wrap;rounded=0;fontSize=11;" vertex="1" parent="1">
          <mxGeometry x="650" y="375" width="360" height="20" as="geometry" />
        </mxCell>

        <!-- STEP 5: Aggregate calls BillingPeriod -->
        <mxCell id="step5_arrow" value="5. calculateProrationRatio(effectiveDate)" style="endArrow=block;html=1;strokeColor=#d97706;strokeWidth=1.5;fontColor=#b45309;fontSize=11;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="705" y="415" as="sourcePoint" />
            <mxPoint x="960" y="415" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- STEP 6: Aggregate calls Money arithmetic -->
        <mxCell id="step6_arrow" value="6. Money.multiply(ratio) &amp;amp; Money.subtract()" style="endArrow=block;html=1;strokeColor=#d97706;strokeWidth=1.5;fontColor=#b45309;fontSize=11;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="705" y="465" as="sourcePoint" />
            <mxPoint x="960" y="465" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <mxCell id="step6_ret" value="returns computed ProrationCredit { credit, charge, netDue }" style="endArrow=block;dashed=1;html=1;strokeColor=#16a34a;strokeWidth=1.5;fontColor=#15803d;fontSize=11;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="960" y="495" as="sourcePoint" />
            <mxPoint x="705" y="495" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- STEP 7: Aggregate returns result to Service -->
        <mxCell id="step7_arrow" value="7. returns proration result (updates _currentPlan)" style="endArrow=block;dashed=1;html=1;strokeColor=#16a34a;strokeWidth=2;fontColor=#15803d;fontSize=11;fontStyle=1;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="705" y="540" as="sourcePoint" />
            <mxPoint x="440" y="540" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- STEP 8: Service calls Payment Gateway if netDue > 0 -->
        <mxCell id="step8_arrow" value="8. paymentGateway.charge(customerId, netDue)" style="endArrow=block;html=1;strokeColor=#9333ea;strokeWidth=2;fontColor=#7e22ce;fontSize=11;fontStyle=1;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="440" y="590" as="sourcePoint" />
            <mxPoint x="1225" y="590" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- STEP 9: Service calls Repo to save updated aggregate -->
        <mxCell id="step9_arrow" value="9. repository.save(subscription) [Commits Transaction]" style="endArrow=block;html=1;strokeColor=#9333ea;strokeWidth=2;fontColor=#7e22ce;fontSize=11;fontStyle=1;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="440" y="640" as="sourcePoint" />
            <mxPoint x="1225" y="640" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- STEP 10: Service responds to Presentation -->
        <mxCell id="step10_arrow" value="10. return { transactionId, proration }" style="endArrow=block;dashed=1;html=1;strokeColor=#2563eb;strokeWidth=2;fontColor=#1d4ed8;fontSize=11;fontStyle=1;endFill=1;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="440" y="695" as="sourcePoint" />
            <mxPoint x="170" y="695" as="targetPoint" />
          </mxGeometry>
        </mxCell>

        <!-- SUMMARY CALLOUT BANNER -->
        <mxCell id="flow_summary" value="&lt;b style=&quot;color:#047857;&quot;&gt;Architectural Separation Demonstrated:&lt;/b&gt; &lt;span style=&quot;color:#065f46;&quot;&gt;The Service Layer orchestrates steps 1, 2, 8, 9, 10 (handling I/O, network calls, persistence, and transactions). The business rules and financial math (steps 5, 6, 7) occur purely in memory within the Domain Model without database mocks or framework dependencies.&lt;/span&gt;" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#059669;strokeWidth=1.5;align=center;verticalAlign=middle;arcSize=6;fontSize=12;" vertex="1" parent="1">
          <mxGeometry x="60" y="760" width="1280" height="50" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
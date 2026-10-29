<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="Electron" agent="Antigravity">
  <diagram id="poeaa-part-2-order-allocation" name="Order Fulfillment Architecture">
    <mxGraphModel dx="1400" dy="850" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1400" pageHeight="850" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />

        <!-- Canvas Background -->
        <mxCell id="bg" parent="1" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=none;" value="" vertex="1">
          <mxGeometry height="850" width="1400" as="geometry" />
        </mxCell>

        <!-- Header -->
        <mxCell id="title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#0f172a;fontStyle=1;fontSize=22;" value="Production Architecture: High-Throughput Order Fulfillment &amp;amp; Warehouse Allocation" vertex="1">
          <mxGeometry height="35" width="1240" x="80" y="25" as="geometry" />
        </mxCell>
        <mxCell id="subtitle" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor=#475569;fontSize=14;" value="Enforcing zero-oversell invariants via Rich Domain Models, Unit of Work, and Data Mappers with Optimistic Locking" vertex="1">
          <mxGeometry height="25" width="1240" x="80" y="60" as="geometry" />
        </mxCell>

        <!-- LAYER 1: Presentation & Command Dispatch -->
        <mxCell id="l1_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#eff6ff;strokeColor=#3b82f6;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="110" width="1240" x="80" y="95" as="geometry" />
        </mxCell>
        <mxCell id="l1_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;fontColor=#1d4ed8;fontStyle=1;fontSize=14;" value="1. Presentation Layer &amp;amp; Command Dispatch" vertex="1">
          <mxGeometry height="25" width="1200" x="100" y="105" as="geometry" />
        </mxCell>
        <mxCell id="l1_ctrl" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#93c5fd;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#1e40af;&quot;&gt;HTTP OrderFulfillmentController&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#3b82f6;&quot;&gt;POST /api/v1/orders/:id/allocate&lt;br&gt;Validates HTTP payload &amp;amp; parses &lt;i&gt;AllocateOrderCommand&lt;/i&gt;&lt;/span&gt;" vertex="1">
          <mxGeometry height="60" width="580" x="100" y="135" as="geometry" />
        </mxCell>
        <mxCell id="l1_queue" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#93c5fd;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#1e40af;&quot;&gt;Event / Webhook Consumer&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#3b82f6;&quot;&gt;Ingests &lt;i&gt;OrderPlacedEvent&lt;/i&gt; from Kafka / SQS stream&lt;br&gt;Idempotency key check before dispatching&lt;/span&gt;" vertex="1">
          <mxGeometry height="60" width="580" x="720" y="135" as="geometry" />
        </mxCell>

        <!-- LAYER 2: Service Layer & Unit of Work Coordinator -->
        <mxCell id="l2_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f5f3ff;strokeColor=#8b5cf6;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="135" width="1240" x="80" y="235" as="geometry" />
        </mxCell>
        <mxCell id="l2_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;fontColor=#5b21b6;fontStyle=1;fontSize=14;" value="2. Service Layer Coordinator (Transaction &amp;amp; UoW Boundary)" vertex="1">
          <mxGeometry height="25" width="1200" x="100" y="245" as="geometry" />
        </mxCell>
        <mxCell id="l2_service" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#c4b5fd;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#5b21b6; font-size:13px;&quot;&gt;OrderAllocationCoordinatorService&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#6d28d9;&quot;&gt;1. Opens &lt;i&gt;UnitOfWork.run(async (uow) =&gt; { ... })&lt;/i&gt;&lt;br&gt;2. Loads Order &amp;amp; WarehouseStock aggregates via Repositories&lt;br&gt;3. Invokes pure domain allocation method: &lt;i&gt;order.allocateFrom(stocks)&lt;/i&gt;&lt;br&gt;4. Coordinates transaction commit &amp;amp; dispatches &lt;i&gt;OrderAllocatedEvent&lt;/i&gt;&lt;/span&gt;" vertex="1">
          <mxGeometry height="85" width="1200" x="100" y="275" as="geometry" />
        </mxCell>

        <!-- LAYER 3: Domain Core (In-Memory Aggregates) -->
        <mxCell id="l3_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ecfdf5;strokeColor=#10b981;strokeWidth=2.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="190" width="1240" x="80" y="395" as="geometry" />
        </mxCell>
        <mxCell id="l3_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;fontColor=#065f46;fontStyle=1;fontSize=14;" value="3. Domain Layer: Pure Business Logic &amp;amp; Self-Protecting Invariants" vertex="1">
          <mxGeometry height="25" width="1200" x="100" y="405" as="geometry" />
        </mxCell>
        <mxCell id="l3_order" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#6ee7b7;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46; font-size:13px;&quot;&gt;Aggregate: Order&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;• &lt;i&gt;status: OrderStatus (PENDING ➔ ALLOCATED)&lt;/i&gt;&lt;br&gt;• &lt;i&gt;items: ReadonlyArray&amp;lt;OrderItem&amp;gt;&lt;/i&gt;&lt;br&gt;• &lt;i&gt;version: number (Optimistic Concurrency)&lt;/i&gt;&lt;br&gt;&lt;b&gt;Method:&lt;/b&gt; &lt;i&gt;allocate(allocations: AllocationPlan)&lt;/i&gt;&lt;/span&gt;" vertex="1">
          <mxGeometry height="130" width="370" x="100" y="440" as="geometry" />
        </mxCell>
        <mxCell id="l3_stock" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#6ee7b7;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46; font-size:13px;&quot;&gt;Aggregate: WarehouseStock&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;• &lt;i&gt;warehouseId: WarehouseId (Value Object)&lt;/i&gt;&lt;br&gt;• &lt;i&gt;sku: SkuCode (Value Object)&lt;/i&gt;&lt;br&gt;• &lt;i&gt;quantityAvailable: NonNegativeQuantity&lt;/i&gt;&lt;br&gt;• &lt;i&gt;quantityReserved: NonNegativeQuantity&lt;/i&gt;&lt;br&gt;&lt;b&gt;Method:&lt;/b&gt; &lt;i&gt;reserveStock(qty: Quantity): Result&lt;/i&gt;&lt;/span&gt;" vertex="1">
          <mxGeometry height="130" width="390" x="505" y="440" as="geometry" />
        </mxCell>
        <mxCell id="l3_policy" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#6ee7b7;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#065f46; font-size:13px;&quot;&gt;Domain Service: AllocationPolicy&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#047857;&quot;&gt;• Evaluates geographic proximity &amp;amp; latency&lt;br&gt;• Splits orders across multiple warehouses if needed&lt;br&gt;• Enforces business rule: Zero oversell under concurrent requests&lt;/span&gt;" vertex="1">
          <mxGeometry height="130" width="385" x="930" y="440" as="geometry" />
        </mxCell>

        <!-- LAYER 4: Persistence Boundary: Repositories & Data Mappers -->
        <mxCell id="l4_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#fffbeb;strokeColor=#f59e0b;strokeWidth=2;arcSize=4;" value="" vertex="1">
          <mxGeometry height="110" width="1240" x="80" y="610" as="geometry" />
        </mxCell>
        <mxCell id="l4_title" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=left;verticalAlign=middle;fontColor=#92400e;fontStyle=1;fontSize=14;" value="4. Persistence Layer: Repositories &amp;amp; Data Mappers" vertex="1">
          <mxGeometry height="25" width="1200" x="100" y="620" as="geometry" />
        </mxCell>
        <mxCell id="l4_order_repo" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#fde68a;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#92400e;&quot;&gt;OrderRepository &amp;amp; OrderDataMapper&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#78350f;&quot;&gt;Checks Identity Map ➔ queries &lt;i&gt;orders&lt;/i&gt; &amp;amp; &lt;i&gt;order_items&lt;/i&gt; tables ➔ registers clean entity in UoW&lt;/span&gt;" vertex="1">
          <mxGeometry height="55" width="580" x="100" y="650" as="geometry" />
        </mxCell>
        <mxCell id="l4_stock_repo" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#ffffff;strokeColor=#fde68a;strokeWidth=1.5;arcSize=6;" value="&lt;b style=&quot;color:#92400e;&quot;&gt;WarehouseStockRepository &amp;amp; StockDataMapper&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#78350f;&quot;&gt;Loads stock balance ➔ registers in UoW ➔ prepares batched UPDATE with version token check&lt;/span&gt;" vertex="1">
          <mxGeometry height="55" width="580" x="720" y="650" as="geometry" />
        </mxCell>

        <!-- LAYER 5: Relational Database -->
        <mxCell id="l5_box" parent="1" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#f8fafc;strokeColor=#64748b;strokeWidth=1.5;arcSize=4;" value="" vertex="1">
          <mxGeometry height="90" width="1240" x="80" y="740" as="geometry" />
        </mxCell>
        <mxCell id="l5_db" parent="1" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontColor:#334155;fontSize=12;" value="&lt;b style=&quot;font-size:13px; color:#0f172a;&quot;&gt;5. Relational Database (PostgreSQL / CockroachDB)&lt;/b&gt;&lt;br&gt;&lt;span style=&quot;font-size:11px; color:#475569;&quot;&gt;&lt;b&gt;Atomic Commit:&lt;/b&gt; &lt;i&gt;UPDATE warehouse_stocks SET qty_available = qty_available - 5, version = version + 1 WHERE id = $id AND version = $v;&lt;/i&gt;&lt;br&gt;Optimistic concurrency rejects conflicting concurrent writes instantly without deadlocks or table-level locks.&lt;/span&gt;" vertex="1">
          <mxGeometry height="70" width="1200" x="100" y="750" as="geometry" />
        </mxCell>

      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
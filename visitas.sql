-- -------------------------
--Visita: Resumen de pedidos
-- -------------------------

CREATE VIEW Visita_pedidos AS 
SELECT
     p.id AS pedido_id,
     p.fecha,
     c.nombre AS cliente,
     e.nombre AS empleado,
     p.total
FROM pedido pizza_id
INNER JOIN cliente c ON c.id = p.cliente_id
INNER JOIN empleado e ON e.id = p.empleado_id;

-- -----------------------------------
--Visita: detalle completo de pedidos
-- -----------------------------------

CREATE VIEW visita_detalle_pedidos AS
SELECT
     p.id AS pedido_id,
     c.nombre AS cliente,
     pi.nombre AS pizza,
     d.cantidad,
     d.subtotal
FROM pedido p 
JOIN cliente c ON c.id = p.cliente_id
JOIN detale_pedido d ON d.pedido_id p.id
JOIN pizza pi ON pi.id = d.pedido_id;
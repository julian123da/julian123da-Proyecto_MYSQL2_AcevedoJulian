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

-- ------------------------------
-- Nueva visita
-- ------------------------------

CREATE VIEW vista_pedidos_cliente AS
SELECT 
    c.nombre AS cliente,
    COUNT(p.id) AS total_pedidos,
    SUM(p.total) AS total_gastado
FROM cliente c
JOIN pedido p ON p.cliente_id = c.id
GROUP BY c.id;

CREATE VIEW vista_repartidores AS
SELECT 
    r.nombre AS repartidor,
    COUNT(d.id) AS entregas_realizadas,
    AVG(TIMESTAMPDIFF(MINUTE,d.hora_salida,d.hora_entrega)) AS tiempo_promedio,
    r.zona
FROM repartidor r
JOIN domicilio d ON d.repartidor_id = r.id
GROUP BY r.id;

CREATE VIEW vista_stock_bajo AS
SELECT i.nombre, s.cantidad_actual, s.cantidad_minima
FROM stock_ingredientes s
JOIN ingrediente i ON i.id = s.ingrediente_id
WHERE s.cantidad_actual < s.cantidad_minima;

-- ---------------------------
-- Otras visitas
-- -------------------------

CREATE OR REPLACE VIEW vista_detalle_pedidos AS
SELECT 
    dp.id AS id_detalle,
    p.id AS id_pedido,
    cli.nombre AS cliente,
    piz.nombre AS pizza,
    dp.cantidad,
    piz.precio,
    (dp.cantidad * piz.precio) AS subtotal
FROM detalle_pedido dp
JOIN pedido p ON dp.pedido_id = p.id
JOIN cliente cli ON p.cliente_id = cli.id
JOIN pizza piz ON dp.pizza_id = piz.id;


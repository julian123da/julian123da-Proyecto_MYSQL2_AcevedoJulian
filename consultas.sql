-- ------------------
--Pizzas vendidas
-- ------------------
delimiter //
create procedure pizza_vendida()
begin
SELECT
    pi.nombre,
    SUM(d.cantidad) AS total_vendido
FROM detalle_pedido d
JOIN pizza pi ON pi.id = d.pizza_id
GROUP BY pi.nombre
ORDER BY total_vendido DESC;

end//
delimiter ;

-- -------------------------
--Pedidos por cliente
-- -------------------------

SELECT
    c.nombre,
    COUNT(p.id) AS pedidos
FROM pedido p
JOIN cliente c ON c.id = p.cliente_id
GROUP BY c.nombre;


-- ---------------------------------------
--Clientes que gastaron más de un monto
-- ---------------------------------------

SELECT
    c.nombre,
    SUM(p.total) AS total_gastado
FROM pedido p
JOIN cliente c ON p.cliente_id = c.id
GROUP BY c.nombre
HAVING total_gastado > 50000;

-- ----------------------------------------
--Busqueda de pizzas por nombre especial
-- ----------------------------------------

SELECT *
FROM pizza
WHERE nombre LIKE '%pollo%';

-- ------------------------------
--Nueva consultas sobre pedidos 
-- ------------------------------

SELECT c.nombre, COUNT(p.id) AS pedidos
FROM cliente c
JOIN pedido p ON p.cliente_id = c.id
WHERE MONTH(p.fecha) = MONTH(CURDATE())
GROUP BY c.id
HAVING pedidos > 5;

SELECT r.nombre, COUNT(d.id) AS total_entregas, AVG(TIMESTAMPDIFF(MINUTE,d.hora_salida,d.hora_entrega)) AS tiempo_promedio
FROM repartidor r
JOIN domicilio d ON d.repartidor_id = r.id
GROUP BY r.id;

SELECT i.nombre, s.cantidad_actual, s.cantidad_minima
FROM stock_ingredientes s
JOIN ingrediente i ON i.id = s.ingrediente_id
WHERE s.cantidad_actual < s.cantidad_minima;
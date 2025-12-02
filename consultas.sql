-- ------------------
--Pizzas vendidas
-- ------------------

SELECT
    pi.nombre,
    SUM(d.cantidad) AS total_vendido
FROM detale_pedido d
JOIN pizza pi ON pi.id = d.pizza_id
GROUP BY pi.nombre
ORDER BY total_vendido DESC;

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
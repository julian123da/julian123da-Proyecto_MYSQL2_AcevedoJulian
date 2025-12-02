-- --------------------------------------------------
--Trigger: Calcular subtotal antes de insetar detalle
-- --------------------------------------------------

DELIMITER //
CREATE TRIGGER trg_calcular_subtotal
BEFORE INSERT ON detale_pedido
FOR EACH NOW
BEGIN
    DECLARE precio_p DECIMAL(10,2);

    SELECT precio INTO precio_p
    FROM pizza
    WHERE id = NEW.pizza_id;

    SET NEW.subtotal = precio_p * NEW.cantidad;
END//
DELIMITER

-- ------------------------------------
--Trigger: Actualizar total del pedido
-- ------------------------------------

DELIMITER //
CREATE TRIGGER trg_actualizar_total
AFTER INSERT ON detale_pedido
FOR EACH ROW
BEGIN
    UPDATE pedido
    SET total = (SELECT SUM(subtotal) FROM detalle_pedido WHERE pedido_id = NEW.pedido_id)
    WHERE id = NEW.pedido_id;
END//
DELIMITER ;
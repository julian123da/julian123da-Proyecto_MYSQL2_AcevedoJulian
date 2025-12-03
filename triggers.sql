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

-- -----------------------------------------
--Trigger: Actualizar stock de ingredientes
-- -----------------------------------------

DELIMITER //
CREATE TRIGGER trg_actualizar_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE stock_ingredientes s
    JOIN pizza_ingrediente pi ON pi.pizza_id = NEW.pizza_id
    SET s.cantidad_actual = s.cantidad_actual - NEW.cantidad
    WHERE s.ingrediente_id = pi.ingrediente_id;
END//
DELIMITER ;


-- -----------------------------------------
--Trigger: Registrar historial de precios 
-- -----------------------------------------

DELIMITER //
CREATE TRIGGER trg_historial_precios
AFTER UPDATE ON pizza
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO historial_precios(pizza_id, precio_antiguo, precio_nuevo)
        VALUES (OLD.id, OLD.precio, NEW.precio);
    END IF;
END//
DELIMITER ;


-- -----------------------------------------
--Trigger: Marcar repartidor disponible
-- -----------------------------------------

DELIMITER //
CREATE TRIGGER trg_repartidor_disponible
AFTER UPDATE ON domicilio
FOR EACH ROW
BEGIN
    IF NEW.hora_entrega IS NOT NULL THEN
        UPDATE repartidor
        SET estado = 'disponible'
        WHERE id = NEW.repartidor_id;
    END IF;
END//
DELIMITER ;

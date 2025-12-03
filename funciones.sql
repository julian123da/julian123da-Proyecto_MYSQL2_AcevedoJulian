-- ---------------------
--Funcion: total_pedido
-- ---------------------

DELIMITER //
CREATE FUCTION total_pedido(p_id INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE resultado DECIMAL(10,2);

    SELECT SUM(subtotal)
    INTO resultado
    FROM detale_pedido
    WHERE pedido_id = p_id;

    RETURN resultado;
END//
DELIMITER;

-- -------------------------------------------------------
--Funcion: total_pedido_completo (subtotal + envio + IVA)
-- -------------------------------------------------------

DELIMITER //
CREATE FUNCTION total_pedido_completo(p_id INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE subtotal DECIMAL(10,2);
    DECLARE costo_envio DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    SELECT SUM(subtotal) INTO subtotal
    FROM detalle_pedido
    WHERE pedido_id = p_id;

    SELECT costo_envio INTO costo_envio
    FROM domicilio
    WHERE pedido_id = p_id;

    SET total = subtotal + IFNULL(costo_envio,0) * 1.19;

    RETURN total;
END//
DELIMITER ;
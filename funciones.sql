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
/*
    Trigger para cuando haces un pedido:
    1. Te compruebe que los platos pertenecen al establecimiento de ese pedido.
    2. En la tabla pedido_plato pille la cantidad de ingredientes que llevan todos los platos.
    3. Y lo restamos al stock del establecimiento. (Comprobamos si hay suficiente stock para el pedido)
    4. Poner precio del pedido que es la suma de los platos
    5. Calcular la rebaja (???)
*/

DROP TRIGGER IF EXISTS actualizacionStockCuandoCobro;

DELIMITER $$

CREATE TRIGGER actualizacionStockCuandoCobro
BEFORE INSERT 
ON Cobro FOR EACH ROW
BEGIN
    DECLARE numeroEstablecimientos integer;
    DROP TEMPORARY TABLE IF EXISTS platosDelPedido;
    DROP TEMPORARY TABLE IF EXISTS platosYEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS platosEnEstablecimiento;

    CREATE TEMPORARY TABLE IF NOT EXISTS platosDelPedido AS (SELECT ID_Plato FROM Pedido WHERE ID_Pedido = NEW.ID_Pedido);
    CREATE TEMPORARY TABLE IF NOT EXISTS platosYEstablecimiento AS (SELECT p.ID_Plato, ID_Establecimiento FROM platosDelPedido AS p JOIN establecimiento_plato AS e ON p.ID_plato = e.ID_Plato);
    CREATE TEMPORARY TABLE IF NOT EXISTS platosEnEstablecimiento AS (SELECT ID_Plato FROM platosYEstablecimiento WHERE ID_Establecimiento = NEW.Nombre_Establecimiento); /* El conjunto A */
    SELECT COUNT(*) INTO numeroEstablecimientos FROM platosYEstablecimiento WHERE ID_Plato NOT IN (SELECT ID_Plato FROM platosEnEstablecimiento); /* Que NO esté en A */

    IF (numeroEstablecimientos > 0) THEN
        signal sqlstate '45000' set message_text = 'Error un plato no se encuentra en el establecimiento';
    ELSE
        signal sqlstate '45000' set message_text = 'BIEN';
    END IF;
    DROP TEMPORARY TABLE IF EXISTS platosDelPedido;
    DROP TEMPORARY TABLE IF EXISTS platosYEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS platosEnEstablecimiento;

   -- DROP TEMPORARY TABLE IF EXISTS platosDelPedido;

    /* 2. En la tabla pedido_plato pille la cantidad de ingredientes que llevan todos los platos. */

END$$
DELIMITER ;
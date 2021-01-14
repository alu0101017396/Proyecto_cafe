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
    DECLARE siHayIngredientesNegativos integer;

    /* 1. Te compruebe que los platos pertenecen al establecimiento de ese pedido. */
    DROP TEMPORARY TABLE IF EXISTS platosDelPedido;
    DROP TEMPORARY TABLE IF EXISTS platosYEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS platosEnEstablecimiento;

    CREATE TEMPORARY TABLE IF NOT EXISTS platosDelPedido AS (SELECT ID_Plato, Cantidad FROM Pedido WHERE ID_Pedido = NEW.ID_Pedido);
    CREATE TEMPORARY TABLE IF NOT EXISTS platosYEstablecimiento AS (SELECT p.ID_Plato, ID_Establecimiento FROM platosDelPedido AS p JOIN establecimiento_plato AS e ON p.ID_plato = e.ID_Plato);
    CREATE TEMPORARY TABLE IF NOT EXISTS platosEnEstablecimiento AS (SELECT ID_Plato FROM platosYEstablecimiento WHERE ID_Establecimiento = NEW.Nombre_Establecimiento); /* El conjunto A */
    SELECT COUNT(*) INTO numeroEstablecimientos FROM platosYEstablecimiento WHERE ID_Plato NOT IN (SELECT ID_Plato FROM platosEnEstablecimiento); /* Que NO esté en A */

    IF (numeroEstablecimientos > 0) THEN
        signal sqlstate '45000' set message_text = 'Error un plato no se encuentra en el establecimiento';
    END IF;

    DROP TEMPORARY TABLE IF EXISTS platosYEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS platosEnEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS ingredientesPlatoPedido;
    DROP TEMPORARY TABLE IF EXISTS ingredientesYCantidadesPedido;

    /* 2. En la tabla pedido pille la cantidad de ingredientes que llevan todos los platos. */
    CREATE TEMPORARY TABLE IF NOT EXISTS ingredientesPlatoPedido AS (SELECT * FROM platosDelPedido AS pdp JOIN Plato_Ingrediente AS pingr ON pdp.ID_Plato = pingr.ID_Plato);
    -- DEBUG --
    CREATE TEMPORARY TABLE IF NOT EXISTS ingredientesYCantidadesPedido AS (SELECT pi.ID_Ingrediente, (pdp.Cantidad * pi.Cantidad) AS Cantidad FROM platosDelPedido AS pdp JOIN Plato_Ingrediente AS pi ON pdp.ID_Plato = pi.ID_Plato);
    /* 3. Y lo restamos al stock del establecimiento. (Comprobamos si hay suficiente stock para el pedido) */

    SELECT COUNT(*) INTO siHayIngredientesNegativos FROM Stock AS s JOIN ingredientesYCantidadesPedido AS icp ON s.ID_Ingrediente_stock = icp.ID_Ingrediente WHERE NEW.Nombre_Establecimiento = s.Nombre_Establecimiento_stock AND ((s.Cantidad - icp.Cantidad) < 0);
    IF (siHayIngredientesNegativos > 0) THEN
        signal sqlstate '45000' set message_text = 'Error, no hay suficientes ingredientes en el establecimiento para los platos del pedido';
    ELSE
        signal sqlstate '45000' set message_text = 'BIEN';
    END IF;
    -- Si funciona bien, pues actualizamos el Stock
END$$
DELIMITER ;
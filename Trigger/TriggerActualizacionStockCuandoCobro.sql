/*
    Trigger para cuando haces un pedido:
    1. Te compruebe que los platos pertenecen al establecimiento de ese pedido.
    2. En la tabla pedido_plato pille la cantidad de ingredientes que llevan todos los platos.
    3. Y lo restamos al stock del establecimiento. (Comprobamos si hay suficiente stock para el pedido)
    4. Poner precio del pedido que es la suma de los platos
    5. Calcular la rebaja (???) (Comprobar si el otro Trigger lo hace correctamente)
*/

DROP TRIGGER IF EXISTS actualizacionStockCuandoCobro;

DELIMITER $$

CREATE TRIGGER actualizacionStockCuandoCobro
BEFORE INSERT 
ON Cobro FOR EACH ROW
BEGIN
    DECLARE numeroEstablecimientos integer;
    DECLARE numeroPlatosEnEstablecimiento integer;
    DECLARE numeroPlatosDelPedido integer;
    DECLARE siHayIngredientesNegativos integer;
    DECLARE precioTotal float;

    -- El tipo de pedido ha de ser "Local" o "Domicilio":
    IF NEW.Tipo != "Local"  AND NEW.Tipo != "Domicilio" THEN
         signal sqlstate '45000' set message_text = 'El tipo de un pedido solo puede ser Local o Domicilio';
    END IF;

    /* 1. Te compruebe que los platos pertenecen al establecimiento de ese pedido. */
    -- Dicho de otra forma, que el plato del pedido, pertenezca al plato del establecimiento.

    DROP TEMPORARY TABLE IF EXISTS platosDelPedido;
    DROP TEMPORARY TABLE IF EXISTS platosYEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS platosEnEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS ingredientesYCantidadesPedido;

    CREATE TEMPORARY TABLE IF NOT EXISTS platosDelPedido AS (SELECT ID_Plato, Cantidad FROM Pedido WHERE ID_Pedido = NEW.ID_Pedido);
    CREATE TEMPORARY TABLE IF NOT EXISTS platosYEstablecimiento AS (SELECT p.ID_Plato, ID_Establecimiento FROM platosDelPedido AS p JOIN Establecimiento_Plato AS e ON p.ID_plato = e.ID_Plato);
    CREATE TEMPORARY TABLE IF NOT EXISTS platosEnEstablecimiento AS (SELECT ID_Plato FROM platosYEstablecimiento WHERE ID_Establecimiento = NEW.Nombre_Establecimiento); /* El conjunto A */
    SELECT COUNT(*) INTO numeroEstablecimientos FROM platosYEstablecimiento WHERE ID_Plato NOT IN (SELECT ID_Plato FROM platosEnEstablecimiento); /* Que NO esté en A */

    SELECT COUNT(DISTINCT(ep.ID_Plato)) INTO numeroPlatosEnEstablecimiento FROM Establecimiento_Plato AS ep JOIN platosDelPedido AS pd ON ep.ID_Plato = pd.ID_Plato; 
    SELECT COUNT(DISTINCT(ID_Plato)) INTO numeroPlatosDelPedido FROM platosDelPedido;

    IF (numeroEstablecimientos > 0 || numeroPlatosEnEstablecimiento != numeroPlatosDelPedido) THEN
        signal sqlstate '45000' set message_text = 'Error un plato no se encuentra en el establecimiento o no hay asociado un plato a ningún establecimiento';
    END IF;

    /* 2. En la tabla pedido pille la cantidad de ingredientes que llevan todos los platos. */
    CREATE TEMPORARY TABLE IF NOT EXISTS ingredientesYCantidadesPedido AS (SELECT pi.ID_Ingrediente AS ID_Ingrediente, SUM(pdp.Cantidad * pi.Cantidad) AS CantidadTotal 
        FROM platosDelPedido AS pdp JOIN Plato_Ingrediente AS pi ON pdp.ID_Plato = pi.ID_Plato GROUP BY ID_Ingrediente);
    
    /* 3. Y lo restamos al stock del establecimiento. (Comprobamos si hay suficiente stock para el pedido) */

    SELECT COUNT(*) INTO siHayIngredientesNegativos FROM Stock AS s JOIN ingredientesYCantidadesPedido AS icp ON s.ID_Ingrediente_stock = icp.ID_Ingrediente 
        WHERE NEW.Nombre_Establecimiento = s.Nombre_Establecimiento_stock AND ((s.Cantidad - icp.CantidadTotal) < 0);
    IF (siHayIngredientesNegativos > 0) THEN
        signal sqlstate '45000' set message_text = 'Error, no hay suficientes ingredientes en el establecimiento para los platos del pedido';
    END IF;

    -- Si funciona bien, pues actualizamos el Stock

    UPDATE Stock AS s, ingredientesYCantidadesPedido AS icp SET s.Cantidad = s.Cantidad - icp.CantidadTotal WHERE s.ID_Ingrediente_stock = icp.ID_Ingrediente;

    /* 4. Poner precio del pedido que es la suma de los platos */
    SELECT SUM(p.precio * pp.Cantidad) INTO precioTotal FROM platosDelPedido AS pp JOIN Plato AS p ON pp.ID_Plato = p.ID;
    SET NEW.Precio = precioTotal;

    DROP TEMPORARY TABLE IF EXISTS platosDelPedido;
    DROP TEMPORARY TABLE IF EXISTS platosYEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS platosEnEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS ingredientesYCantidadesPedido;

END$$
DELIMITER ;
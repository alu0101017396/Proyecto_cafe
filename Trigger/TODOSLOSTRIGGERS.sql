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

    DECLARE id_tarjeta_cliente integer;
    DECLARE puntosEuros double;
    DECLARE puntosCliente double;
    DECLARE nuevoRebajado double;

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

    -- Actualizamos el precio del producto con los puntos, y añadimos los nuevos puntos de la compra

    SELECT ID_Tarjeta INTO id_tarjeta_cliente FROM Cliente WHERE DNI = NEW.ID_Cliente;
    SELECT Puntos INTO puntosCliente FROM Tarjeta_de_puntos WHERE ID = id_tarjeta_cliente;
    SET puntosEuros = puntosCliente / 10; /* Convertir puntos del cliente en euros */

    IF (puntosEuros > NEW.Precio)
        THEN
        SET puntosEuros = puntosEuros - NEW.Precio;
        SET nuevoRebajado = 0;
        ELSE
        SET nuevoRebajado = NEW.Precio - puntosEuros;
        SET puntosEuros = 0;
    END IF;

    SET puntosCliente = (puntosEuros * 10) + NEW.Precio; /* Añadimos los nuevos puntos del nuevo producto */
    UPDATE Tarjeta_de_puntos SET Puntos = puntosCliente WHERE id = id_tarjeta_cliente;
    SET NEW.Rebajado = nuevoRebajado;

    DROP TEMPORARY TABLE IF EXISTS platosDelPedido;
    DROP TEMPORARY TABLE IF EXISTS platosYEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS platosEnEstablecimiento;
    DROP TEMPORARY TABLE IF EXISTS ingredientesYCantidadesPedido;

END$$
DELIMITER ;

DROP TRIGGER IF EXISTS anadirCompra;

DELIMITER $$

CREATE TRIGGER anadirCompra
AFTER INSERT 
ON Compras FOR EACH ROW
BEGIN

  DECLARE quantity integer;

  IF NEW.Tipo = 'S' THEN /* S = Stock */
    SELECT Cantidad INTO quantity FROM Stock WHERE Nombre_establecimiento_stock = NEW.Nombre_est && ID_Ingrediente_stock = NEW.Item;
    IF (quantity != '' OR quantity = 0) THEN
        SET quantity = quantity + NEW.Cantidad;
        UPDATE Stock SET Cantidad = quantity WHERE Nombre_establecimiento_stock = NEW.Nombre_est && ID_Ingrediente_stock = NEW.Item;
      ELSE
        INSERT INTO Stock VALUES (NEW.Nombre_est, NEW.Item, NEW.Cantidad);
    END IF;
  ELSE /* No comprobamos si es I, ya que eso lo hace otro Trigger*/
    SELECT Cantidad INTO quantity FROM Inventario WHERE Nombre_establecimiento_Inventario = NEW.Nombre_est && Id_objeto = NEW.Item;
    IF (quantity != '' OR quantity = 0) THEN
        SET quantity = quantity + NEW.Cantidad;
        UPDATE Inventario SET Cantidad = quantity WHERE Nombre_establecimiento_Inventario = NEW.Nombre_est && Id_objeto = NEW.Item;
      ELSE
        INSERT INTO Inventario (Nombre_Establecimiento_Inventario, Id_objeto, Cantidad) VALUES (NEW.Nombre_est, NEW.Item, NEW.Cantidad);
    END IF;
  END IF;

END$$
DELIMITER ;

-- Triggers Database cafe
-- La fecha de nacimiento de un Cliente ha de ser superior a 1900, e inferior a la fecha actual:
DROP TRIGGER IF EXISTS fecha_cliente;

DELIMITER //

CREATE TRIGGER fecha_cliente BEFORE INSERT ON Cliente FOR EACH ROW
BEGIN
    IF YEAR(NEW.Fecha_de_nacimiento) < 1900 THEN
         signal sqlstate '45000' set message_text = 'Una persona no puede tener ese año de nacimiento';
    END IF;
END //

DELIMITER ;

-- La valoración de las opiniones de usuario ha de estar entre 1 y 5:
DROP TRIGGER IF EXISTS comprobacion_valoracion;

DELIMITER //

CREATE TRIGGER comprobacion_valoracion BEFORE INSERT ON Opinion FOR EACH ROW
BEGIN
    IF NEW.Valoracion < 1  OR NEW.Valoracion > 5 THEN
         signal sqlstate '45000' set message_text = 'Una valoracion tiene que estar entre 1 y 5 puntos';
    END IF;
END //

DELIMITER ;

-- Los ingredientes solo pueden tener alérgenos recogidos en el reglamento europeo. Los cuales son 14 alérgenos:
DROP TRIGGER IF EXISTS comprobar_alergeno_ingrediente;

DELIMITER //

CREATE TRIGGER comprobar_alergeno_ingrediente BEFORE INSERT ON Ingredientes FOR EACH ROW
BEGIN
    IF NEW.Alergeno != "Pescado"  AND NEW.Alergeno != "Frutos_secos" AND NEW.Alergeno != "Lacteos"
       AND NEW.Alergeno != "Moluscos" AND NEW.Alergeno != "Gluten" AND NEW.Alergeno != "Crustaceos"
       AND NEW.Alergeno != "Huevos" AND NEW.Alergeno != "Cacahuetes" AND NEW.Alergeno != "Soja"
       AND NEW.Alergeno != "Apio" AND NEW.Alergeno != "Mostaza" AND NEW.Alergeno != "Sesamo"
       AND NEW.Alergeno != "Altramuz" AND NEW.Alergeno != "Sulfitos" THEN
         signal sqlstate '45000' set message_text = 'Error al introducir el Alergeno de los ingredientes';
    END IF;
END //

DELIMITER ;

-- El tipo de ingrediente de un plato tiene que ser lácteo, verdura, carne, etc:
DROP TRIGGER IF EXISTS comprobar_tipo_ingredientes;

DELIMITER //

CREATE TRIGGER comprobar_tipo_ingredientes BEFORE INSERT ON Ingredientes FOR EACH ROW
BEGIN
    IF NEW.Tipo != "Bebida"  AND NEW.Tipo != "Constructor" AND NEW.Tipo != "Harinas"
       AND NEW.Tipo != "Verdura" AND NEW.Tipo != "Lacteo" AND NEW.Tipo != "Carnes"
       AND NEW.Tipo != "Salsa" AND NEW.Tipo != "Pasta" AND NEW.Tipo != "Tuberculo"
       AND NEW.Tipo != "Cafe" AND NEW.Tipo != "Te" AND NEW.Tipo != "Cereal"
       AND NEW.Tipo != "Frutas" AND NEW.Tipo != "Frutos_secos"
       AND NEW.Tipo != "Aceites" AND NEW.Tipo != "Hortalizas" THEN
         signal sqlstate '45000' set message_text = 'Error al introducir el tipo de los ingredientes';
    END IF;
END //

DELIMITER ;

-- El tipo de personal solo puede ser "Camarero", "Cocinero" o "Gerente":
DROP TRIGGER IF EXISTS comprobar_puestos;

DELIMITER //

CREATE TRIGGER comprobar_puestos BEFORE INSERT ON Personal FOR EACH ROW
BEGIN
    IF NEW.Tipo != "Camarero"  AND NEW.Tipo != "Cocinero" AND NEW.Tipo != "Gerente" THEN
         signal sqlstate '45000' set message_text = 'Error al introducir el Alergeno de los ingredientes';
    END IF;
END //

DELIMITER ;

-- El precio de un plato no puede ser 0 o menor a este
DROP TRIGGER IF EXISTS precio_plato;

DELIMITER //

CREATE TRIGGER precio_plato BEFORE INSERT ON Plato FOR EACH ROW
BEGIN
    IF NEW.Precio <= 0 THEN
         signal sqlstate '45000' set message_text = 'Error, el precio de un plato no puede ser igual o menor a 0';
    END IF;
END //

DELIMITER ;

DROP TRIGGER IF EXISTS verificarTipoCompra;

DELIMITER $$

CREATE TRIGGER verificarTipoCompra
BEFORE INSERT 
ON Compras FOR EACH ROW
BEGIN

  IF NEW.Tipo != 'S' &&  NEW.Tipo != 'I' THEN /* S = Stock, I = Inventario */
    signal sqlstate '45000' set message_text = 'Error, el tipo de compra solo puede ser \"S\" (Stock) o \"I\" (Inventario)';
  END IF;

END$$
DELIMITER ;
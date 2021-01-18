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
DROP TRIGGER IF EXISTS actualizarPrecioProducto;

DELIMITER $$

CREATE TRIGGER actualizarPrecioProducto
AFTER INSERT 
ON Cobro FOR EACH ROW
BEGIN
  DECLARE id_tarjeta_cliente integer;
  DECLARE puntosEuros double;
  DECLARE puntosCliente double;
  DECLARE nuevoRebajado double;

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
  UPDATE Cobro SET Rebajado = nuevoRebajado WHERE ID = NEW.ID;
END$$
DELIMITER ;
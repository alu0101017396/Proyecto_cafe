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
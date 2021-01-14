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
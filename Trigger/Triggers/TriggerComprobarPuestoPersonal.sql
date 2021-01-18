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
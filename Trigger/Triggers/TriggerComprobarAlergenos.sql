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
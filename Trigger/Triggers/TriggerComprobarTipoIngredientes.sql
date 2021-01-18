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
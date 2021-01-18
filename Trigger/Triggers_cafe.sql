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
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
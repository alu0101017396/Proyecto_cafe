-- Triggers Database cafe
-- La fecha de nacimiento de un Cliente ha de ser superior a 1900, e inferior a la fecha actual:
DROP TRIGGER IF EXISTS fecha_cliente;

DELIMITER //

CREATE TRIGGER fecha_cliente BEFORE INSERT ON Cliente FOR EACH ROW
BEGIN
    DECLARE añomaximo integer;
    SELECT YEAR(CURRENT_DATE) INTO añomaximo;
    IF YEAR(NEW.Fecha_de_nacimiento) < 1900  || YEAR(NEW.Fecha_de_nacimiento) > (añomaximo - 14) THEN
         signal sqlstate '45000' set message_text = 'Una persona no puede tener ese año de nacimiento';
    END IF;
END //

DELIMITER ;

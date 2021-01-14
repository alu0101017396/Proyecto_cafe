  -- MySQL Script generated by MySQL Workbench
  -- Sun Jan 10 17:04:18 2021
  -- Model: New Model    Version: 1.0
  -- MySQL Workbench Forward Engineering

  SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
  SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
  SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

  -- -----------------------------------------------------
  -- Schema cafe
  -- -----------------------------------------------------

  -- -----------------------------------------------------
  -- Schema cafe
  -- -----------------------------------------------------
  CREATE SCHEMA IF NOT EXISTS `cafe` DEFAULT CHARACTER SET utf8 ;
  USE `cafe` ;

  -- -----------------------------------------------------
  -- Table `cafe`.`Tarjeta_de_puntos`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Tarjeta_de_puntos` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Tarjeta_de_puntos` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Puntos` INT NOT NULL,
    PRIMARY KEY (`ID`))
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Cliente`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Cliente` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Cliente` (
    `DNI` VARCHAR(9) NOT NULL,
    `Nombre` VARCHAR(45) NOT NULL,
    `Telefono` INT NULL,
    `Direccion` VARCHAR(45) NULL,
    `Fecha_de_nacimiento` DATE NULL,
    `Descuento` DOUBLE NOT NULL,
    `ID_Tarjeta` INT NULL,
    PRIMARY KEY (`DNI`),
    CONSTRAINT `ID_Tarjeta`
      FOREIGN KEY (`ID_Tarjeta`)
      REFERENCES `cafe`.`Tarjeta_de_puntos` (`ID`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Plato`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Plato` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Plato` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(45) NOT NULL,
    `Precio` DOUBLE NOT NULL,
    `Alergenos` VARCHAR(45) NULL,
    PRIMARY KEY (`ID`))
  ;





  -- -----------------------------------------------------
  -- Table `cafe`.`Ingredientes`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Ingredientes` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Ingredientes` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(45) NOT NULL,
    `Alergeno` VARCHAR(45) NULL,
    `Tipo` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`ID`))
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Personal`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Personal` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Personal` (
    `DNI` VARCHAR(9) NOT NULL,
    `Nombre` VARCHAR(45) NOT NULL,
    `Tarjeta_electronico` INT NOT NULL,
    `Telefono` INT(9) NULL,
    `Fecha_de_nacimiento` DATE NOT NULL,
    `Tipo` VARCHAR(45) NOT NULL,
    `Hora_entrada` TIME NOT NULL,
    `Hora_salida` TIME NOT NULL,
    PRIMARY KEY (`DNI`))
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Establecimiento`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Establecimiento` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Establecimiento` (
    `Nombre` VARCHAR(30) NOT NULL,
    `Gerente` VARCHAR(9) NOT NULL,
    `Direccion` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`Nombre`),
    CONSTRAINT `Gerente_fk`
      FOREIGN KEY (`Gerente`)
      REFERENCES `cafe`.`Personal` (`DNI`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Pedido`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Pedido` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Pedido` (
    `ID_Plato` INT NOT NULL,
    `ID_Pedido` INT NOT NULL AUTO_INCREMENT,
    `Cantidad` INT NOT NULL,
    PRIMARY KEY (`ID_Pedido`, `ID_Plato`),
    CONSTRAINT `ID_Plato_pedido_fk`
      FOREIGN KEY (`ID_Plato`)
      REFERENCES `cafe`.`Plato` (`ID`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);


  -- -----------------------------------------------------
  -- Table `cafe`.`Cobro`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Cobro` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Cobro` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Tipo` VARCHAR(20) NOT NULL,
    `Precio` FLOAT NOT NULL,
    `Rebajado` FLOAT NULL,
    `ID_Cliente` VARCHAR(9) NULL,
    `Nombre_Establecimiento` VARCHAR(30) NOT NULL,
    `ID_Pedido` INT NOT NULL,
    PRIMARY KEY (`ID`),
    CONSTRAINT `ID_Cliente`
      FOREIGN KEY (`ID_Cliente`)
      REFERENCES `cafe`.`Cliente` (`DNI`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `Nombre_establecimiento_pedido`
      FOREIGN KEY (`Nombre_Establecimiento`)
      REFERENCES `cafe`.`Establecimiento` (`Nombre`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `ID_Pedido_Cobro_fk`
      FOREIGN KEY (`ID_Pedido`)
      REFERENCES `cafe`.`Pedido` (`ID_Pedido`)
      ON DELETE CASCADE
      ON UPDATE CASCADE);
  -- -----------------------------------------------------
  -- Table `cafe`.`Plato-Ingrediente`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Plato_Ingrediente` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Plato_Ingrediente` (
    `ID_Plato` INT NOT NULL,
    `ID_Ingrediente` INT NOT NULL,
    PRIMARY KEY (`ID_Plato`,`ID_Ingrediente`),
    CONSTRAINT `ID_Plato_fk`
      FOREIGN KEY (`ID_Plato`)
      REFERENCES `cafe`.`Plato` (`ID`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    CONSTRAINT `ID_Ingrediente`
      FOREIGN KEY (`ID_Ingrediente`)
      REFERENCES `cafe`.`Ingredientes` (`ID`)
      ON DELETE CASCADE
      ON UPDATE CASCADE)
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Establecimiento-Plato`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Establecimiento_Plato` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Establecimiento_Plato` (
    `ID_Establecimiento` VARCHAR(30) NOT NULL,
    `ID_Plato` INT NOT NULL,
    PRIMARY KEY (`ID_Establecimiento`,`ID_Plato`),
    CONSTRAINT `ID_Establecimiento`
      FOREIGN KEY (`ID_Establecimiento`)
      REFERENCES `cafe`.`Establecimiento` (`Nombre`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    CONSTRAINT `ID_Plato_est`
      FOREIGN KEY (`ID_Plato`)
      REFERENCES `cafe`.`Plato` (`ID`)
      ON DELETE CASCADE
      ON UPDATE CASCADE)
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Establecimiento-Personal`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Establecimiento_Personal` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Establecimiento_Personal` (
    `Nombre_Establecimiento` VARCHAR(30) NOT NULL,
    `ID_Personal` VARCHAR(9) NOT NULL,
    PRIMARY KEY (`Nombre_Establecimiento`,`ID_Personal`),
    CONSTRAINT `Nombre_Establecimiento`
      FOREIGN KEY (`Nombre_Establecimiento`)
      REFERENCES `cafe`.`Establecimiento` (`Nombre`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    CONSTRAINT `ID_Personal`
      FOREIGN KEY (`ID_Personal`)
      REFERENCES `cafe`.`Personal` (`DNI`)
      ON DELETE CASCADE
      ON UPDATE CASCADE)
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Reclamaciones`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Reclamaciones` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Reclamaciones` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Comentario_reclamacion` VARCHAR(45) NULL,
    `Nombre_Establecimiento` VARCHAR(30) NOT NULL,
    `ID_Cliente_r` VARCHAR(9) NOT NULL,
    `Encargado` VARCHAR(9) NOT NULL,
    PRIMARY KEY (`ID`),
    CONSTRAINT `ID_Cliente_rec`
      FOREIGN KEY (`ID_Cliente_r`)
      REFERENCES `cafe`.`Cliente` (`DNI`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    CONSTRAINT `ID_Establecimiento_rec`
      FOREIGN KEY (`Nombre_Establecimiento`)
      REFERENCES `cafe`.`Establecimiento` (`Nombre`)
      ON DELETE CASCADE
      ON UPDATE CASCADE)
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Opinion`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Opinion` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Opinion` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Comentario_opinion` VARCHAR(45) NULL,
    `Nombre_Establecimiento` VARCHAR(30) NOT NULL,
    `ID_Cliente_o` VARCHAR(9) NOT NULL,
    `Valoracion` INT NOT NULL,
    PRIMARY KEY (`ID`),
    CONSTRAINT `ID_Cliente_opinion`
      FOREIGN KEY (`ID_Cliente_o`)
      REFERENCES `cafe`.`Cliente` (`DNI`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    CONSTRAINT `ID_Establecimiento_opinion`
      FOREIGN KEY (`Nombre_Establecimiento`)
      REFERENCES `cafe`.`Establecimiento` (`Nombre`)
      ON DELETE CASCADE
      ON UPDATE CASCADE)
  ;


  -- -----------------------------------------------------
  -- Table `cafe`.`Stock`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Stock` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Stock` (
    `Nombre_Establecimiento_stock` VARCHAR(30) NOT NULL,
    `ID_Ingrediente_stock` INT NOT NULL,
    `Cantidad` INT NULL,
    UNIQUE INDEX `index4` (`Nombre_Establecimiento_stock`, `ID_Ingrediente_stock`),
    CONSTRAINT `Nombre_Establecimiento_Stock`
      FOREIGN KEY (`Nombre_Establecimiento_stock`)
      REFERENCES `cafe`.`Establecimiento` (`Nombre`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `ID_Ingrediente_Stock`
      FOREIGN KEY (`ID_Ingrediente_stock`)
      REFERENCES `cafe`.`Ingredientes` (`ID`)
      ON DELETE CASCADE
      ON UPDATE CASCADE);

  -- -----------------------------------------------------
  -- Table `cafe`.`Objeto`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Objeto` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Objeto` (
    `idObjeto` INT NOT NULL AUTO_INCREMENT,
    `Nombre` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`idObjeto`));


  -- -----------------------------------------------------
  -- Table `cafe`.`Inventario`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Inventario` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Inventario` (
    `Id_Inv` INT NOT NULL AUTO_INCREMENT,
    `Nombre_Establecimiento_Inventario` VARCHAR(30) NOT NULL,
    `Id_objeto` INT NOT NULL,
    `Cantidad` INT NULL,
    PRIMARY KEY (`Id_Inv`),
    CONSTRAINT `Nombre_Establecimiento_Stock0`
      FOREIGN KEY (`Nombre_Establecimiento_Inventario`)
      REFERENCES `cafe`.`Establecimiento` (`Nombre`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    CONSTRAINT `ID_Objeto_fk`
      FOREIGN KEY (`Id_objeto`)
      REFERENCES `cafe`.`Objeto` (`idObjeto`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);


  -- -----------------------------------------------------
  -- Table `cafe`.`Compras`
  -- -----------------------------------------------------
  DROP TABLE IF EXISTS `cafe`.`Compras` ;

  CREATE TABLE IF NOT EXISTS `cafe`.`Compras` (
    `idCompras` INT NOT NULL AUTO_INCREMENT,
    `Item` INT NOT NULL,
    `Tipo` VARCHAR(1) NOT NULL,
    `Cantidad` INT NOT NULL,
    `Nombre_est` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`idCompras`),
    CONSTRAINT `nombre_Compras_fk`
      FOREIGN KEY (`Nombre_est`)
      REFERENCES `cafe`.`Establecimiento` (`Nombre`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION);




  SET SQL_MODE=@OLD_SQL_MODE;
  SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
  SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
  
  
  

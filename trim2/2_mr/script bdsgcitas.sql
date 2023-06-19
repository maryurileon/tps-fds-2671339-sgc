-- MySQL Script generated by MySQL Workbench
-- Mon Jun 19 13:17:02 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bdsgcitas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdsgcitas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdsgcitas` DEFAULT CHARACTER SET utf8mb4 ;
USE `bdsgcitas` ;

-- -----------------------------------------------------
-- Table `bdsgcitas`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`roles` (
  `IdRol` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`IdRol`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`usuarios` (
  `id_usuarios` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre_usuarios` VARCHAR(100) NOT NULL,
  `Apellido_usuarios` VARCHAR(100) NOT NULL,
  `IdRol` INT(11) NULL DEFAULT NULL,
  `contraseña` VARCHAR(100) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_usuarios`),
  INDEX `fk_id_usuarios` (`IdRol` ASC) VISIBLE,
  CONSTRAINT `fk_id_usuarios`
    FOREIGN KEY (`IdRol`)
    REFERENCES `bdsgcitas`.`roles` (`IdRol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`administrador` (
  `id_administrador` INT(11) NOT NULL AUTO_INCREMENT,
  `id_usuarios` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_administrador`),
  INDEX `fk_id_administrador` (`id_usuarios` ASC) VISIBLE,
  CONSTRAINT `fk_id_administrador`
    FOREIGN KEY (`id_usuarios`)
    REFERENCES `bdsgcitas`.`usuarios` (`id_usuarios`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`empleado` (
  `id_empleado` INT(11) NOT NULL AUTO_INCREMENT,
  `id_usuarios` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `fk_id_empleado` (`id_usuarios` ASC) VISIBLE,
  CONSTRAINT `fk_id_empleado`
    FOREIGN KEY (`id_usuarios`)
    REFERENCES `bdsgcitas`.`usuarios` (`id_usuarios`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`cliente` (
  `id_cliente` INT(11) NOT NULL AUTO_INCREMENT,
  `id_usuarios` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_id_cliente` (`id_usuarios` ASC) VISIBLE,
  CONSTRAINT `fk_id_cliente`
    FOREIGN KEY (`id_usuarios`)
    REFERENCES `bdsgcitas`.`usuarios` (`id_usuarios`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`citas` (
  `id_citas` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_citas` DATETIME NOT NULL,
  `id_cliente` INT(11) NULL DEFAULT NULL,
  `id_empleado` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_citas`),
  INDEX `fk_id_citas` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_citas_empleados3` (`id_empleado` ASC) VISIBLE,
  CONSTRAINT `fk_citas_empleados3`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `bdsgcitas`.`empleado` (`id_empleado`),
  CONSTRAINT `fk_id_citas`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `bdsgcitas`.`cliente` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`pedidos` (
  `id_pedidos` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_pedidos` DATETIME NOT NULL,
  `id_cliente` INT(11) NULL DEFAULT NULL,
  `id_servicios` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_pedidos`),
  INDEX `fk_id_pedidos` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_id_pedidos2` (`id_servicios` ASC) VISIBLE,
  CONSTRAINT `fk_id_pedidos`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `bdsgcitas`.`cliente` (`id_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`factura` (
  `id_factura` INT(11) NOT NULL AUTO_INCREMENT,
  `totalprecio_factura` DECIMAL(11,2) NOT NULL,
  `totalproductos_factura` INT(11) NOT NULL,
  `id_pedidos` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `fk_id_factura5` (`id_pedidos` ASC) VISIBLE,
  CONSTRAINT `fk_id_factura5`
    FOREIGN KEY (`id_pedidos`)
    REFERENCES `bdsgcitas`.`pedidos` (`id_pedidos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`comisión`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`comisión` (
  `id_pagos` INT(11) NOT NULL AUTO_INCREMENT,
  `comisiones` DECIMAL(11,2) NOT NULL,
  `id_administrador` INT(11) NULL DEFAULT NULL,
  `id_factura` INT(11) NULL DEFAULT NULL,
  `id_empleado` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_pagos`),
  INDEX `fk_id_pagos` (`id_administrador` ASC) VISIBLE,
  INDEX `fk_id_pago` (`id_factura` ASC) VISIBLE,
  INDEX `fk_id_pagos3` (`id_empleado` ASC) VISIBLE,
  CONSTRAINT `fk_id_pago`
    FOREIGN KEY (`id_factura`)
    REFERENCES `bdsgcitas`.`factura` (`id_factura`),
  CONSTRAINT `fk_id_pagos`
    FOREIGN KEY (`id_administrador`)
    REFERENCES `bdsgcitas`.`administrador` (`id_administrador`),
  CONSTRAINT `fk_id_pagos3`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `bdsgcitas`.`empleado` (`id_empleado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`productos` (
  `id_productos` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre_productos` VARCHAR(100) NOT NULL,
  `unidades_productos` INT(11) NOT NULL,
  `precio_productos` DECIMAL(11,2) NOT NULL,
  `id_administrador` INT(11) NULL DEFAULT NULL,
  `id_pedidos` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_productos`),
  INDEX `fk_id_productos` (`id_administrador` ASC) VISIBLE,
  INDEX `fk_id_productos2` (`id_pedidos` ASC) VISIBLE,
  CONSTRAINT `fk_id_productos`
    FOREIGN KEY (`id_administrador`)
    REFERENCES `bdsgcitas`.`administrador` (`id_administrador`),
  CONSTRAINT `fk_id_productos2`
    FOREIGN KEY (`id_pedidos`)
    REFERENCES `bdsgcitas`.`pedidos` (`id_pedidos`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`salario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`salario` (
  `IdSalario` INT(11) NOT NULL AUTO_INCREMENT,
  `id_empleado` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`IdSalario`),
  INDEX `fk_id_salario` (`id_empleado` ASC) VISIBLE,
  CONSTRAINT `fk_id_salario`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `bdsgcitas`.`empleado` (`id_empleado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bdsgcitas`.`servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdsgcitas`.`servicios` (
  `id_servicios` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre_servicios` VARCHAR(100) NOT NULL,
  `precio_servicios` DECIMAL(11,2) NOT NULL,
  `id_citas` INT(11) NULL DEFAULT NULL,
  `id_pedidos` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_servicios`),
  INDEX `fk_id_servicios` (`id_citas` ASC) VISIBLE,
  INDEX `fk_id_pedidos5` (`id_pedidos` ASC) VISIBLE,
  CONSTRAINT `fk_id_pedidos5`
    FOREIGN KEY (`id_pedidos`)
    REFERENCES `bdsgcitas`.`pedidos` (`id_pedidos`),
  CONSTRAINT `fk_id_servicios`
    FOREIGN KEY (`id_citas`)
    REFERENCES `bdsgcitas`.`citas` (`id_citas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

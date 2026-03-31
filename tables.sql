-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Restaurante
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Restaurante
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Restaurante` DEFAULT CHARACTER SET utf8 ;
USE `Restaurante` ;

-- -----------------------------------------------------
-- Table `Restaurante`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurante`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(45) NULL,
  `nome` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurante`.`Atendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurante`.`Atendente` (
  `idAtendente` INT NOT NULL,
  `idSenior` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `salario` VARCHAR(45) NULL,
  PRIMARY KEY (`idAtendente`),
  INDEX `fk_Atendente_Atendente_idx` (`idSenior` ASC) VISIBLE,
  CONSTRAINT `fk_Atendente_Atendente`
    FOREIGN KEY (`idSenior`)
    REFERENCES `Restaurante`.`Atendente` (`idAtendente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurante`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurante`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `dataInicio` TIME NULL,
  `dataFim` TIME NULL,
  `duracao` INT GENERATED ALWAYS AS (TIMESTAMPDIFF(SECOND,dataInicio,dataFim)) STORED,
  `Atendente_idAtendente` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Atendente1_idx` (`Atendente_idAtendente` ASC) VISIBLE,
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Atendente1`
    FOREIGN KEY (`Atendente_idAtendente`)
    REFERENCES `Restaurante`.`Atendente` (`idAtendente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Restaurante`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurante`.`Pratos/Bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurante`.`Pratos/Bebidas` (
  `idPratosBebidas` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `preco` DOUBLE NOT NULL,
  PRIMARY KEY (`idPratosBebidas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurante`.`TelefoneAtendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurante`.`TelefoneAtendente` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `Atendente_idAtendente` INT NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTelefone`, `Atendente_idAtendente`),
  INDEX `fk_TelefoneAtendente_Atendente1_idx` (`Atendente_idAtendente` ASC) VISIBLE,
  CONSTRAINT `fk_TelefoneAtendente_Atendente1`
    FOREIGN KEY (`Atendente_idAtendente`)
    REFERENCES `Restaurante`.`Atendente` (`idAtendente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurante`.`Mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurante`.`Mesa` (
  `idMesa` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idMesa`, `Cliente_idCliente`),
  INDEX `fk_Mesa_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Mesa_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Restaurante`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Restaurante`.`itens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Restaurante`.`itens` (
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `Pratos/Bebidas_idPratosBebidas` INT NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Pedido_Cliente_idCliente`, `Pratos/Bebidas_idPratosBebidas`),
  INDEX `fk_Pedido_has_Pratos/Bebidas_Pratos/Bebidas1_idx` (`Pratos/Bebidas_idPratosBebidas` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Pratos/Bebidas_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Pratos/Bebidas_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Restaurante`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Pratos/Bebidas_Pratos/Bebidas1`
    FOREIGN KEY (`Pratos/Bebidas_idPratosBebidas`)
    REFERENCES `Restaurante`.`Pratos/Bebidas` (`idPratosBebidas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

alter table atendente add constraint ck_matricula check (idAtendente between 100 and 999); 

alter table mesa add constraint ck_mesa check(idMesa between 10 and 99); 

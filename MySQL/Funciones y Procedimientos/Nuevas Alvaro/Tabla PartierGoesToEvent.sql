-- -----------------------------------------------------
-- Table `where2nightdev`.`PartierGoesToEvent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`PartierGoesToEvent` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`PartierGoesToEvent` (
  `idPartier` INT(11) NOT NULL,
  `idEvent` INT(11) NOT NULL,
  PRIMARY KEY (`idPartier`, `idEvent`),
  INDEX `fk_partier_has_event_event1_idx` (`idEvent` ASC),
  INDEX `fk_partier_has_event_partier1_idx` (`idPartier` ASC)
 
ENGINE = InnoDB;

USE `Where2NightDev` ;
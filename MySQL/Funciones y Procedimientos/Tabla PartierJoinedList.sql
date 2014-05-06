-- -----------------------------------------------------
-- Table `where2nightdev`.`PartierJoinedList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`PartierJoinedList` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`PartierJoinedList` (
  `idPartier` INT(11) NOT NULL,
  `idList` INT(11) NOT NULL,
  PRIMARY KEY (`idPartier`, `idList`),
  INDEX `fk_partier_has_list_list1_idx` (`idList` ASC),
  INDEX `fk_partier_has_list_partier1_idx` (`idPartier` ASC)
 
ENGINE = InnoDB;

USE `Where2NightDev` ;
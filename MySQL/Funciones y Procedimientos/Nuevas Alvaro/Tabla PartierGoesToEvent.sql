-- -----------------------------------------------------
-- Table `where2nightdev`.`PartierGoesToEvent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `where2nightdev`.`PartierGoesToEvent` ;

CREATE TABLE IF NOT EXISTS `where2nightdev`.`PartierGoesToEvent` (
  `idPartier` INT(11) NOT NULL,
  `idEvent` INT(11) NOT NULL,
  PRIMARY KEY (`idPartier`, `idEvent`),
  INDEX `fk_partier_has_event_event1_idx` (`idEvent` ASC),
  INDEX `fk_partier_has_event_partier1_idx` (`idPartier` ASC),
  CONSTRAINT `fk_partier_has_event_partier1`
    FOREIGN KEY (`idPartier`)
    REFERENCES `where2nightdev`.`partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partier_has_event_event1`
    FOREIGN KEY (`idEvent`)
    REFERENCES `where2nightdev`.`event` (`idEvent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `where2nightdev` ;
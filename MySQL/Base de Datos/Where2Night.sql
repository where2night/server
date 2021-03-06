SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Where2Night` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Where2Night` ;

-- -----------------------------------------------------
-- Table `Where2Night`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`User` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`User` (
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(25) NOT NULL,
  `type` INT NULL COMMENT '0 - facebook\n1 - google\n-1 - registrado',
  `token` VARCHAR(45) NULL,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`Profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`Profile` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`Profile` (
  `idProfile` INT NOT NULL AUTO_INCREMENT,
  `type` INT NULL COMMENT 'type: \n0 - partier\n1 - pub\n-1 - dj',
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idProfile`),
  INDEX `fk_Profile_User_idx` (`email` ASC),
  CONSTRAINT `fk_Profile_User`
    FOREIGN KEY (`email`)
    REFERENCES `Where2Night`.`User` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`Partier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`Partier` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`Partier` (
  `idPartier` INT NOT NULL AUTO_INCREMENT,
  `idProfile` INT NOT NULL,
  `picture` VARCHAR(100) NULL,
  `name` VARCHAR(20) NULL,
  `surnames` VARCHAR(45) NULL,
  `birthdate` DATE NULL,
  `gender` TINYINT(1) NULL,
  `music` VARCHAR(20) NULL,
  `civil_state` VARCHAR(20) NULL,
  `city` VARCHAR(20) NULL,
  `drink` VARCHAR(20) NULL,
  `about` VARCHAR(200) NULL,
  `facebook` VARCHAR(50) NULL,
  `twitter` VARCHAR(15) NULL,
  `instagram` VARCHAR(30) NULL,
  `picture_p` TINYINT(1) NOT NULL DEFAULT 1,
  `name_p` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `surname_p` TINYINT(1) NOT NULL DEFAULT 1,
  `birthdate_p` TINYINT(1) NOT NULL DEFAULT 1,
  `gender_p` TINYINT(1) NOT NULL DEFAULT 1,
  `music_p` TINYINT(1) NOT NULL DEFAULT 1,
  `civil_state_p` TINYINT(1) NOT NULL DEFAULT 1,
  `city_p` TINYINT(1) NOT NULL DEFAULT 1,
  `drink_p` TINYINT(1) NOT NULL DEFAULT 1,
  `about_p` TINYINT(1) NOT NULL DEFAULT 1,
  `facebook_p` TINYINT(1) NOT NULL DEFAULT 1,
  `twitter_p` TINYINT(1) NOT NULL DEFAULT 1,
  `instagram_p` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idPartier`),
  INDEX `fk_Partier_Profile1_idx` (`idProfile` ASC),
  CONSTRAINT `fk_Partier_Profile1`
    FOREIGN KEY (`idProfile`)
    REFERENCES `Where2Night`.`Profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`Pub`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`Pub` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`Pub` (
  `idPub` INT NOT NULL AUTO_INCREMENT,
  `idProfile` INT NOT NULL,
  `companyNameLocal` VARCHAR(50) NOT NULL, 
  `localName` VARCHAR(20) NOT NULL,
  `cif` VARCHAR(9) NOT NULL,
  `poblationLocal` VARCHAR(20) NOT NULL,
  `cpLocal` INT (5) NOT NULL,
  `telephoneLocal` INT NOT NULL,
  `street` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0-Calle \n1-Avda \n2-Plaza ',
  `streetNameLocal` VARCHAR(50) NOT NULL,
  `streetNumberLocal` VARCHAR(50) NOT NULL,
  ---- COMPLEMENTS ----
  `music` VARCHAR(20) NULL,
  `entryPrice` INT NULL,
  `drinkPrice` INT NULL,
  `openingHours` TIME(2) NULL,
  `closeHours` TIME(2) NULL,
  `picture` VARCHAR(100) NULL,
  `about` VARCHAR(200) NULL,
  `facebook` VARCHAR(50) NULL,
  `twitter` VARCHAR(15) NULL,
  `instagram` VARCHAR(30) NULL,
  ---- PRIVACY ----
  `music_p` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `entryPrice_p` TINYINT(1) NOT NULL DEFAULT 1,
  `drinkPrice_p` TINYINT(1) NOT NULL DEFAULT 1,
  `openingHours_p` TINYINT(1) NOT NULL DEFAULT 1,
  `closeHours_p` TINYINT(1) NOT NULL DEFAULT 1,
  `picture_p` TINYINT(1) NOT NULL DEFAULT 1,
  `about_p` TINYINT(1) NOT NULL DEFAULT 1,
  `facebook_p` TINYINT(1) NOT NULL DEFAULT 1,
  `twitter_p` TINYINT(1) NOT NULL DEFAULT 1,
  `instagram_p` TINYINT(1) NOT NULL DEFAULT 1,


  PRIMARY KEY (`idPub`),
  INDEX `fk_Pub_Profile1_idx` (`idProfile` ASC),
  CONSTRAINT `fk_Pub_Profile1`
    FOREIGN KEY (`idProfile`)
    REFERENCES `Where2Night`.`Profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`DJ`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`DJ` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`DJ` (
  `idDJ` INT NOT NULL AUTO_INCREMENT,
  `idProfile` INT NOT NULL,
  
  `nameDJ`VARCHAR (30) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `telephoneDJ` INT NOT NULL,
  `gender` TINYINT(1) NULL,
  `birthdate` DATE NULL,
  `picture` VARCHAR(100) NULL,
  `music` VARCHAR(20) NULL,
  `about` VARCHAR(200) NULL,
  
  --PRIVACY--
  `birthdate_p` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `gender_p` TINYINT(1) NOT NULL DEFAULT 1,
  `music_p` TINYINT(1) NOT NULL DEFAULT 1,
  `about_p` TINYINT(1) NOT NULL DEFAULT 1,

  PRIMARY KEY (`idDJ`),
  INDEX `fk_DJ_Profile1_idx` (`idProfile` ASC),
  CONSTRAINT `fk_DJ_Profile1`
    FOREIGN KEY (`idProfile`)
    REFERENCES `Where2Night`.`Profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`Fotos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`Fotos` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`Fotos` (
  `idFoto` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NULL,
  `idProfile` INT NOT NULL,
  PRIMARY KEY (`idFoto`),
  INDEX `fk_Fotos_Profile1_idx` (`idProfile` ASC),
  CONSTRAINT `fk_Fotos_Profile1`
    FOREIGN KEY (`idProfile`)
    REFERENCES `Where2Night`.`Profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`Event` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`Event` (
  `idEvent` INT NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(200) NULL,
  `idDJ` INT NULL,
  `idPub` INT NULL,
  PRIMARY KEY (`idEvent`),
  INDEX `fk_Event_DJ1_idx` (`idDJ` ASC),
  INDEX `fk_Event_Pub1_idx` (`idPub` ASC),
  CONSTRAINT `fk_Event_DJ1`
    FOREIGN KEY (`idDJ`)
    REFERENCES `Where2Night`.`DJ` (`idDJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Pub1`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2Night`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`Friends`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`Friends` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`Friends` (
  `idPartier1` INT NOT NULL,
  `idPartier2` INT NOT NULL,
  PRIMARY KEY (`idPartier1`, `idPartier2`),
  INDEX `fk_Partier_has_Partier_Partier2_idx` (`idPartier2` ASC),
  INDEX `fk_Partier_has_Partier_Partier1_idx` (`idPartier1` ASC),
  CONSTRAINT `fk_Partier_has_Partier_Partier1`
    FOREIGN KEY (`idPartier1`)
    REFERENCES `Where2Night`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_Partier_Partier2`
    FOREIGN KEY (`idPartier2`)
    REFERENCES `Where2Night`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`PartierFollowsDJ`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`PartierFollowsDJ` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`PartierFollowsDJ` (
  `idPartier` INT NOT NULL,
  `idDJ` INT NOT NULL,
  PRIMARY KEY (`idPartier`, `idDJ`),
  INDEX `fk_Partier_has_DJ_DJ1_idx` (`idDJ` ASC),
  INDEX `fk_Partier_has_DJ_Partier1_idx` (`idPartier` ASC),
  CONSTRAINT `fk_Partier_has_DJ_Partier1`
    FOREIGN KEY (`idPartier`)
    REFERENCES `Where2Night`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_DJ_DJ1`
    FOREIGN KEY (`idDJ`)
    REFERENCES `Where2Night`.`DJ` (`idDJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`PartierFollowsPub`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`PartierFollowsPub` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`PartierFollowsPub` (
  `idPartier` INT NOT NULL,
  `idPub` INT NOT NULL,
  PRIMARY KEY (`idPartier`, `idPub`),
  INDEX `fk_Partier_has_Pub_Pub1_idx` (`idPub` ASC),
  INDEX `fk_Partier_has_Pub_Partier1_idx` (`idPartier` ASC),
  CONSTRAINT `fk_Partier_has_Pub_Partier1`
    FOREIGN KEY (`idPartier`)
    REFERENCES `Where2Night`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_Pub_Pub1`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2Night`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`Works`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`Works` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`Works` (
  `idDJ` INT NOT NULL,
  `idPub` INT NOT NULL,
  PRIMARY KEY (`idDJ`, `idPub`),
  INDEX `fk_DJ_has_Pub_Pub1_idx` (`idPub` ASC),
  INDEX `fk_DJ_has_Pub_DJ1_idx` (`idDJ` ASC),
  CONSTRAINT `fk_DJ_has_Pub_DJ1`
    FOREIGN KEY (`idDJ`)
    REFERENCES `Where2Night`.`DJ` (`idDJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DJ_has_Pub_Pub1`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2Night`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`PartierIsInPub`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`PartierIsInPub` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`PartierIsInPub` (
  `idPartier` INT NOT NULL,
  `idPub` INT NOT NULL,
  `inside` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idPartier`, `idPub`),
  INDEX `fk_Partier_has_Pub_Pub2_idx` (`idPub` ASC),
  INDEX `fk_Partier_has_Pub_Partier2_idx` (`idPartier` ASC),
  CONSTRAINT `fk_Partier_has_Pub_Partier2`
    FOREIGN KEY (`idPartier`)
    REFERENCES `Where2Night`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_Pub_Pub2`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2Night`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`List`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`List` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`List` (
  `idList` INT NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(200) NULL,
  `idPub` INT NULL,
  PRIMARY KEY (`idList`),
  INDEX `fk_List_Pub1_idx` (`idPub` ASC),
  CONSTRAINT `fk_List_Pub1`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2Night`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`PartierJoinedList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`PartierJoinedList` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`PartierJoinedList` (
  `idPartier` INT NOT NULL,
  `idList` INT NOT NULL,
  `text` VARCHAR(200) NULL,
  PRIMARY KEY (`idPartier`, `idList`),
  INDEX `fk_Partier_has_List_List1_idx` (`idList` ASC),
  INDEX `fk_Partier_has_List_Partier1_idx` (`idPartier` ASC),
  CONSTRAINT `fk_Partier_has_List_Partier1`
    FOREIGN KEY (`idPartier`)
    REFERENCES `Where2Night`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_List_List1`
    FOREIGN KEY (`idList`)
    REFERENCES `Where2Night`.`List` (`idList`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- --------------------------------------------------------
-- Table `Where2Night`. `Messages`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `Messages`;
CREATE TABLE IF NOT EXISTS `Messages` (
  `idPartier1` int(11) NOT NULL,
  `idPartier2` int(11) NOT NULL,
  `message` varchar(1000)  DEFAULT NOT NULL,
  `sentTime` timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (`idPartier1`,`idPartier2`),
  KEY `fk_Partier_has_Partier_Partier2_idx` (`idPartier2`),
  KEY `fk_Partier_has_Partier_Partier1_idx` (`idPartier1`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;







SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


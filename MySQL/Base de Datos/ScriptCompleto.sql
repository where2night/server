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
-- Table `Where2Night`.`Lists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`Lists` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`Lists` (
  `idLists` INT NOT NULL,
  `idPub` INT NOT NULL,
  PRIMARY KEY (`idLists`),
  INDEX `fk_Lists_Pub1_idx` (`idPub` ASC),
  CONSTRAINT `fk_Lists_Pub1`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2Night`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2Night`.`PartierIsInLists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2Night`.`PartierIsInLists` ;

CREATE TABLE IF NOT EXISTS `Where2Night`.`PartierIsInLists` (
  `idPartier` INT NOT NULL,
  `idLists` INT NOT NULL,
  PRIMARY KEY (`idPartier`, `idLists`),
  INDEX `fk_Partier_has_Lists_Lists1_idx` (`idLists` ASC),
  INDEX `fk_Partier_has_Lists_Partier1_idx` (`idPartier` ASC),
  CONSTRAINT `fk_Partier_has_Lists_Partier1`
    FOREIGN KEY (`idPartier`)
    REFERENCES `Where2Night`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_Lists_Lists1`
    FOREIGN KEY (`idLists`)
    REFERENCES `Where2Night`.`Lists` (`idLists`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


----------------------------------FUNCIONES Y PROCEDIMIENTOS----------------------------------

DELIMITER //

CREATE PROCEDURE deleteToken(IN email VARCHAR(50))
BEGIN
		UPDATE `User` u
		SET u.token= NULL
		WHERE u.email = email;

	END//

DELIMITER ;

DELIMITER //
 
 CREATE FUNCTION getIdProfile(usr VARCHAR(50)) RETURNS INT
    BEGIN
		RETURN (SELECT p.idProfile
				FROM `Profile` p
				WHERE (p.email = usr));
	END//
    
DELIMITER ;

DELIMITER //
 
 CREATE PROCEDURE getPartierData(IN idProfile INT)
    BEGIN
		SELECT p.picture, p.`name`, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about 
		FROM `Profile` pr, `Partier` p
		WHERE (pr.idProfile = idProfile);
	END//
    
DELIMITER ;

DELIMITER //

CREATE PROCEDURE insertNormalUser(email VARCHAR(50), pass VARCHAR(25))
    BEGIN
		INSERT INTO `User`
		VALUES (email,pass,-1,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END//
    
DELIMITER ;

DELIMITER //

CREATE PROCEDURE insertFacebookUser(email VARCHAR(50))
    BEGIN
		INSERT INTO `User`
		VALUES (email,NULL,0,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END//
    
DELIMITER ;

DELIMITER //

CREATE PROCEDURE insertGoogleUser(email VARCHAR(50))
    BEGIN
		INSERT INTO `User`
		VALUES (email,NULL,1,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END//
    
DELIMITER ;
	
DELIMITER //
 
 CREATE FUNCTION passOK(usr VARCHAR(50), pass VARCHAR(25)) RETURNS BOOLEAN
    BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.`password` = pass AND u.`type` = -1) = 1);
	END//
    
DELIMITER ;

DELIMITER //
 
 CREATE PROCEDURE setPartierData(IN idProfile INT, IN picture VARCHAR(100), IN `name`VARCHAR(20), IN surnames VARCHAR(45), IN birthdate DATE, IN gender BOOL, IN music VARCHAR(20), IN civil_state VARCHAR(20), IN city VARCHAR(20), IN drink VARCHAR(20), IN about VARCHAR(200))
    BEGIN
		UPDATE Partier p
		SET p.picture = picture, p.`name` = `name`, p.surnames = surnames, p.birthdate = birthdate, p.gender = gender, p.music = music, p.civil_state = civil_state, p.city = city, p.drink = drink, p.about = about 
		WHERE (p.idProfile = idProfile);
	END//
    
DELIMITER ;

DELIMITER //
 
 CREATE FUNCTION tokenEquals(usr VARCHAR(50), tkn VARCHAR(45)) RETURNS BOOLEAN
    BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.token = tkn) = 1);
	END//
    
DELIMITER ;

DELIMITER //

CREATE PROCEDURE updateToken(IN email VARCHAR(50), IN tkn VARCHAR(45))
BEGIN
		UPDATE `User` u
		SET u.token= tkn
		WHERE u.email = email;

	END//

DELIMITER ;

 DELIMITER //
 
 CREATE FUNCTION userExists(usr VARCHAR(50)) RETURNS BOOLEAN
    BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE u.email = usr) = 1);
	END//
    
DELIMITER ;

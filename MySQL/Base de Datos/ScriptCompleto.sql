SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Where2NightDev` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Where2NightDev` ;

-- -----------------------------------------------------
-- Table `Where2NightDev`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`User` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`User` (
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(80) NULL,
  `type` INT NULL COMMENT '0 - facebook\n1 - google\n-1 - registrado',
  `token` VARCHAR(45) NULL,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`Profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`Profile` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`Profile` (
  `idProfile` INT NOT NULL AUTO_INCREMENT,
  `type` INT NULL COMMENT 'type: \n0 - partier\n1 - pub\n-1 - dj',
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idProfile`),
  INDEX `fk_Profile_User_idx` (`email` ASC),
  CONSTRAINT `fk_Profile_User`
    FOREIGN KEY (`email`)
    REFERENCES `Where2NightDev`.`User` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`Partier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`Partier` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`Partier` (
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
    REFERENCES `Where2NightDev`.`Profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`Pub`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`Pub` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`Pub` (
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
  `latitude` INT NULL,
  `longitude` INT NULL,
  
  `music` VARCHAR(20) NULL,
  `entryPrice` INT NULL,
  `drinkPrice` INT NULL,
  `openingHours` TIME NULL,
  `closeHours` TIME NULL,
  `picture` VARCHAR(100) NULL,
  `about` VARCHAR(200) NULL,
  
  `music_p` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `entryPrice_p` TINYINT(1) NOT NULL DEFAULT 1,
  `drinkPrice_p` TINYINT(1) NOT NULL DEFAULT 1,
  `openingHours_p` TINYINT(1) NOT NULL DEFAULT 1,
  `closeHours_p` TINYINT(1) NOT NULL DEFAULT 1,
  `picture_p` TINYINT(1) NOT NULL DEFAULT 1,
  `about_p` TINYINT(1) NOT NULL DEFAULT 1,


  PRIMARY KEY (`idPub`),
  INDEX `fk_Pub_Profile1_idx` (`idProfile` ASC),
  CONSTRAINT `fk_Pub_Profile1`
    FOREIGN KEY (`idProfile`)
    REFERENCES `Where2NightDev`.`Profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`DJ`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`DJ` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`DJ` (
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
  
  
  `birthdate_p` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `gender_p` TINYINT(1) NOT NULL DEFAULT 1,
  `music_p` TINYINT(1) NOT NULL DEFAULT 1,
  `about_p` TINYINT(1) NOT NULL DEFAULT 1,

  PRIMARY KEY (`idDJ`),
  INDEX `fk_DJ_Profile1_idx` (`idProfile` ASC),
  CONSTRAINT `fk_DJ_Profile1`
    FOREIGN KEY (`idProfile`)
    REFERENCES `Where2NightDev`.`Profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`Fotos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`Fotos` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`Fotos` (
  `idFoto` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NULL,
  `idProfile` INT NOT NULL,
  PRIMARY KEY (`idFoto`),
  INDEX `fk_Fotos_Profile1_idx` (`idProfile` ASC),
  CONSTRAINT `fk_Fotos_Profile1`
    FOREIGN KEY (`idProfile`)
    REFERENCES `Where2NightDev`.`Profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`Event` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`Event` (
  `idEvent` INT NOT NULL AUTO_INCREMENT,
  `title`VARCHAR (50) NULL,
  `text` VARCHAR(200) NULL,
  `date`DATE NULL,
  `type` INT NULL COMMENT 'type:\n1 - pub\n-1 - dj',
  `startHour` TIME NULL,
  `closeHour`TIME NULL,
  `idDJ` INT NULL,
  `idPub` INT NULL,
  `picture`VARCHAR(100) NULL,

  PRIMARY KEY (`idEvent`),
  INDEX `fk_Event_DJ1_idx` (`idDJ` ASC),
  INDEX `fk_Event_Pub1_idx` (`idPub` ASC),
  CONSTRAINT `fk_Event_DJ1`
    FOREIGN KEY (`idDJ`)
    REFERENCES `Where2NightDev`.`DJ` (`idDJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_Pub1`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2NightDev`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`Friends`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`Friends` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`Friends` (
  `idPartier1` INT NOT NULL,
  `idPartier2` INT NOT NULL,
  PRIMARY KEY (`idPartier1`, `idPartier2`),
  INDEX `fk_Partier_has_Partier_Partier2_idx` (`idPartier2` ASC),
  INDEX `fk_Partier_has_Partier_Partier1_idx` (`idPartier1` ASC),
  CONSTRAINT `fk_Partier_has_Partier_Partier1`
    FOREIGN KEY (`idPartier1`)
    REFERENCES `Where2NightDev`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_Partier_Partier2`
    FOREIGN KEY (`idPartier2`)
    REFERENCES `Where2NightDev`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`PartierFollowsDJ`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`PartierFollowsDJ` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`PartierFollowsDJ` (
  `idPartier` INT NOT NULL,
  `idDJ` INT NOT NULL,
  PRIMARY KEY (`idPartier`, `idDJ`),
  INDEX `fk_Partier_has_DJ_DJ1_idx` (`idDJ` ASC),
  INDEX `fk_Partier_has_DJ_Partier1_idx` (`idPartier` ASC),
  CONSTRAINT `fk_Partier_has_DJ_Partier1`
    FOREIGN KEY (`idPartier`)
    REFERENCES `Where2NightDev`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_DJ_DJ1`
    FOREIGN KEY (`idDJ`)
    REFERENCES `Where2NightDev`.`DJ` (`idDJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`PartierFollowsPub`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`PartierFollowsPub` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`PartierFollowsPub` (
  `idPartier` INT NOT NULL,
  `idPub` INT NOT NULL,
  PRIMARY KEY (`idPartier`, `idPub`),
  INDEX `fk_Partier_has_Pub_Pub1_idx` (`idPub` ASC),
  INDEX `fk_Partier_has_Pub_Partier1_idx` (`idPartier` ASC),
  CONSTRAINT `fk_Partier_has_Pub_Partier1`
    FOREIGN KEY (`idPartier`)
    REFERENCES `Where2NightDev`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_Pub_Pub1`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2NightDev`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`Works`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`Works` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`Works` (
  `idDJ` INT NOT NULL,
  `idPub` INT NOT NULL,
  PRIMARY KEY (`idDJ`, `idPub`),
  INDEX `fk_DJ_has_Pub_Pub1_idx` (`idPub` ASC),
  INDEX `fk_DJ_has_Pub_DJ1_idx` (`idDJ` ASC),
  CONSTRAINT `fk_DJ_has_Pub_DJ1`
    FOREIGN KEY (`idDJ`)
    REFERENCES `Where2NightDev`.`DJ` (`idDJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DJ_has_Pub_Pub1`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2NightDev`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`PartierIsInPub`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`PartierIsInPub` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`PartierIsInPub` (
  `idPartier` INT NOT NULL,
  `idPub` INT NOT NULL,
  `inside` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idPartier`, `idPub`),
  INDEX `fk_Partier_has_Pub_Pub2_idx` (`idPub` ASC),
  INDEX `fk_Partier_has_Pub_Partier2_idx` (`idPartier` ASC),
  CONSTRAINT `fk_Partier_has_Pub_Partier2`
    FOREIGN KEY (`idPartier`)
    REFERENCES `Where2NightDev`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_Pub_Pub2`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2NightDev`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`Lists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`Lists` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`Lists` (
  `idLists` INT NOT NULL,
  `idPub` INT NOT NULL,
  PRIMARY KEY (`idLists`),
  INDEX `fk_Lists_Pub1_idx` (`idPub` ASC),
  CONSTRAINT `fk_Lists_Pub1`
    FOREIGN KEY (`idPub`)
    REFERENCES `Where2NightDev`.`Pub` (`idPub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Where2NightDev`.`PartierIsInLists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Where2NightDev`.`PartierIsInLists` ;

CREATE TABLE IF NOT EXISTS `Where2NightDev`.`PartierIsInLists` (
  `idPartier` INT NOT NULL,
  `idLists` INT NOT NULL,
  PRIMARY KEY (`idPartier`, `idLists`),
  INDEX `fk_Partier_has_Lists_Lists1_idx` (`idLists` ASC),
  INDEX `fk_Partier_has_Lists_Partier1_idx` (`idPartier` ASC),
  CONSTRAINT `fk_Partier_has_Lists_Partier1`
    FOREIGN KEY (`idPartier`)
    REFERENCES `Where2NightDev`.`Partier` (`idPartier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partier_has_Lists_Lists1`
    FOREIGN KEY (`idLists`)
    REFERENCES `Where2NightDev`.`Lists` (`idLists`)
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
 
 CREATE PROCEDURE getDJData(IN idProfile INT)
    BEGIN
    SELECT p.nameDJ, p.name, p.surname, p.telephoneDJ, p.gender, p.birthdate,p.picture, p.music,p.about 
    FROM `Profile` pr, `DJ` p
    WHERE (pr.idProfile = idProfile);
  END//
    
DELIMITER ;

DELIMITER //
 
 CREATE PROCEDURE getLocalData(IN idProfile INT)
    BEGIN
    SELECT p.companyNameLocal, p.localName, p.cif, p.poblationLocal, p.cpLocal, p.telephoneLocal, p.street, p.streetNameLocal, p.streetNumberLocal, p.music, p.entryPrice , p.drinkPrice, p.openingHours, p.closeHours, p.picture, p.about 
    FROM `Profile` pr, `Pub` p
    WHERE (pr.idProfile = idProfile);
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
 
 CREATE FUNCTION getTypeProfile(idProfile INT) RETURNS INT
    BEGIN
    RETURN (SELECT p.type
        FROM `Profile` p
        WHERE (p.idProfile = idProfile));
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

CREATE PROCEDURE insertDJUser(email VARCHAR(50), pass VARCHAR(80))
    BEGIN
    INSERT INTO `User`
    VALUES (email,pass,-1,NULL);

    INSERT INTO `Profile` (`type`,`email`)
    VALUES (-1,email);

    INSERT INTO `DJ` (`idProfile`)
          SELECT p.idProfile
          FROM `Profile` p
          WHERE p.email = email;

  END//
    
    DELIMITER ;

DELIMITER //

CREATE PROCEDURE insertNormalUser(email VARCHAR(50), pass VARCHAR(80))
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
    VALUES (email,0,0,NULL);

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

CREATE PROCEDURE insertPubUser(email VARCHAR(50), pass VARCHAR(80))
    BEGIN
    INSERT INTO `User`
    VALUES (email,pass,-1,NULL);

    INSERT INTO `Profile` (`type`,`email`)
    VALUES (1,email);

    INSERT INTO `Pub` (`idProfile`)
          SELECT p.idProfile
          FROM `Profile` p
          WHERE p.email = email;

  END//
    
DELIMITER ;

DELIMITER //

CREATE PROCEDURE insertToken(IN email VARCHAR(50), IN tkn VARCHAR(45))
BEGIN
    UPDATE `User` u
    SET u.token= tkn
    WHERE u.email = email;

  END//

DELIMITER ;

DELIMITER //
 
 CREATE FUNCTION loginSucceed(usr VARCHAR(50), pass VARCHAR(80)) RETURNS BOOLEAN
    BEGIN
    RETURN (CASE 0 WHEN ((SELECT Count(*)
        FROM `User` u
        WHERE (u.email = usr) AND u.`password` = pass AND u.`type` = -1)) 
      THEN 0    
      ELSE (SELECT idProfile 
          FROM `Profile` p 
          WHERE p.email = usr) END);
  END//
    
DELIMITER ;


DELIMITER //

CREATE FUNCTION loginSuccessFB(email VARCHAR(50)) RETURNS BOOLEAN
BEGIN
    RETURN (CASE 0 WHEN ((SELECT Count(*)
        FROM `User` u
        WHERE (u.email = usr) AND u.`type` = 0)) 
      THEN 0    
      ELSE (SELECT idProfile 
          FROM `Profile` p 
          WHERE p.email = usr) END);
  END//


DELIMITER ;


DELIMITER //

CREATE FUNCTION loginSuccessGP(email VARCHAR(50)) RETURNS BOOLEAN
BEGIN
    RETURN (CASE 0 WHEN ((SELECT Count(*)
        FROM `User` u
        WHERE (u.email = usr) AND u.`type` = 1)) 
      THEN 0    
      ELSE (SELECT idProfile 
          FROM `Profile` p 
          WHERE p.email = usr) END);
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
 
 CREATE PROCEDURE setDJData(IN idProfile INT, IN nameDJ VARCHAR (30) ,IN name VARCHAR(20) ,IN surname VARCHAR(45),
  IN telephoneDJ INT ,IN gender TINYINT(1) ,IN birthdate DATE ,
  IN picture VARCHAR(100) ,IN music VARCHAR(20) ,IN about VARCHAR(200))

    BEGIN
    UPDATE DJ p
    SET 
      p.nameDJ = nameDJ,  
      p.name = name,
      p.surname = surname,
      p.telephoneDJ = telephoneDJ,
      p.gender = gender,
      p.birthdate = birthdate,
      p.picture = picture,
      p.music = music,
      p.about = about
      
    WHERE (p.idProfile = idProfile);
  END//
    
DELIMITER ;

DELIMITER //
 
 CREATE PROCEDURE setLocalData(IN idProfile INT,IN companyNameLocal VARCHAR(50), 
  IN localName VARCHAR(20),IN cif VARCHAR(9),IN poblationLocal VARCHAR(20),
  IN cpLocal INT (5),IN telephoneLocal INT,IN street TINYINT(1),
  IN streetNameLocal VARCHAR(50),IN streetNumberLocal VARCHAR(50),
    IN music VARCHAR(20),IN entryPrice INT,IN drinkPrice INT,IN openingHours TIME,
    IN closeHours TIME,IN picture VARCHAR(100),IN about VARCHAR(200))

    BEGIN
    UPDATE Pub p
    SET 
      P.companyNameLocal = companyNameLocal, 
      P.localName= localName,
      P.cif= cif,
      P.poblationLocal= poblationLocal,
      P.cpLocal= cpLocal,
      P.telephoneLocal= telephoneLocal,
      P.street= street,
      P.streetNameLocal= streetNameLocal,
      P.streetNumberLocal= streetNumberLocal,
      P.music= music,
      P.entryPrice= entryPrice,
      P.drinkPrice= drinkPrice,
      P.openingHours= openingHours,
      P.closeHours=  closeHours,
      P.picture= picture,
      P.about= about  
    
    WHERE (p.idProfile = idProfile);
  END//
    
DELIMITER ;

DELIMITER //
 
 CREATE PROCEDURE setPartierData(IN idProfile INT, IN picture VARCHAR(100), IN `name`VARCHAR(20), IN surnames VARCHAR(45), IN birthdate DATE, IN gender BOOL, IN music VARCHAR(20), IN civil_state VARCHAR(20), IN city VARCHAR(20), IN drink VARCHAR(20), IN about VARCHAR(200))
    BEGIN
		UPDATE Partier p
		SET p.picture = picture, p.name = name, p.surnames = surnames, p.birthdate = birthdate, p.gender = gender, p.music = music, p.civil_state = civil_state, p.city = city, p.drink = drink, p.about = about 
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
 
 CREATE FUNCTION tokenOK(idUsr INT, tkn VARCHAR(45)) RETURNS BOOLEAN
    BEGIN
    RETURN ((SELECT Count(*)
        FROM `User` u, `Profile` p
        WHERE p.email = u.email AND p.idProfile = idUsr AND u.token = tkn) = 1);
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

DELIMITER //
 
 CREATE FUNCTION setEvent(typePL INT,title VARCHAR (50),about VARCHAR(200),dateEv DATE,startHour TIME,closeHour TIME,id INT) RETURNS INT
    BEGIN
      INSERT INTO `Event` (`title`, `text`, `date`,`type`, `startHour`, `closeHour`)
    VALUES (title,about,dateEv,typePL,startHour,closeHour);

        UPDATE Event e
        SET
            e.idDJ = id
        WHERE(e.type = -1);

        UPDATE Event e
        SET
            e.idPub = id
        WHERE (e.type = 1);

            

  RETURN (SELECT p.idEvent
    FROM `Event`p);
  END//
    
DELIMITER ;

DELIMITER //
 
 CREATE FUNCTION getPubId(idProfile INT) RETURNS INT
    BEGIN
    RETURN (SELECT p.idPub
        FROM `Pub` p
        WHERE (p.idProfile = idProfile));
  END//
    
DELIMITER ;
DELIMITER //
 
 CREATE FUNCTION getDjId(idProfile INT) RETURNS INT
    BEGIN
    RETURN (SELECT p.idDj
        FROM `DJ` p
        WHERE (p.idProfile = idProfile));
  END//
    
DELIMITER ;

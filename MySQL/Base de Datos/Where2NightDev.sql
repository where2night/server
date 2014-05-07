-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 07-04-2014 a las 23:16:50
-- Versión del servidor: 5.1.70-cll
-- Versión de PHP: 5.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `Where2NightDev`
--
CREATE DATABASE IF NOT EXISTS `Where2NightDev` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `Where2NightDev`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `deleteEvent`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteEvent`(IN idEvent1 INT(11),IN idProfile1 INT(11))
BEGIN
		DELETE FROM  `Event`
		WHERE (idEvent = idEvent1 AND idProfileCreator = idProfile1);

	END$$

DROP PROCEDURE IF EXISTS `deleteToken`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteToken`(IN email VARCHAR(50))
BEGIN
    UPDATE `User` u
    SET u.token= NULL
    WHERE u.email = email;

  END$$

DROP PROCEDURE IF EXISTS `DJFollowers`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `DJFollowers`(idProfileDJ INT)
BEGIN
		(SELECT p.idProfile
        FROM `PartierFollowsDJ` pf, `DJ` d, `Partier` p 
        WHERE (d.idProfile = idProfileDJ) AND (d.idDJ = pf.idDJ) AND (pf.idPartier = p.idPartier));
  END$$

DROP PROCEDURE IF EXISTS `dontGoToEvent`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `dontGoToEvent`(IN `idProfileUser` INT(11), IN `idEventD` INT(11))
BEGIN
		
		DELETE FROM `PartierGoesToEvent`
		WHERE (idProfileUser = idPartier
				AND idEvent = idEventD);		
  END$$

DROP PROCEDURE IF EXISTS `dontGoToPub`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `dontGoToPub`(IN `idProfileUser` INT(11), IN `idProfilePub` INT(11))
BEGIN
		
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfilePub);

		DELETE FROM `PartierGoToPub` 
		WHERE (idPub=idP AND idPartier=idU);

		
  END$$

DROP PROCEDURE IF EXISTS `EventAssistants`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `EventAssistants`(idEvent INT)
BEGIN
		(SELECT p.idProfile
        FROM `PartierGoesToEvent` pg, `Partier` p 
        WHERE (pg.idPartier = p.idPartier) AND (pg.idEvent = idEvent));
  END$$

DROP PROCEDURE IF EXISTS `eventsUser`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `eventsUser`(IN `idProfile` INT(11))
BEGIN
				SELECT e.idEvent, e.idProfileCreator, e.title, e.text, e.date, e.startHour, e.closeHour
				FROM `Event` e, `PartierGoesToEvent` pg
				WHERE (e.idEvent = pg.idEvent and pg.idPartier= idProfile)
				ORDER BY e.date ASC;
	END$$

DROP PROCEDURE IF EXISTS `followDJ`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `followDJ`(IN `idProfileDJ` INT, IN `idProfileUser` INT)
BEGIN

		DECLARE idD int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idD = (SELECT d.idDJ
					FROM `DJ` d
					WHERE d.idProfile = idProfileDJ);

		INSERT INTO `PartierFollowsDJ` VALUES (idU,idD);
		
  END$$

DROP PROCEDURE IF EXISTS `followPub`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `followPub`(IN `idProfilePub` INT, IN `idProfileUser` INT)
BEGIN
		
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfilePub);

		INSERT INTO `PartierFollowsPub` VALUES (idU,idP);

		
  END$$

DROP PROCEDURE IF EXISTS `getDJData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `getDJData`(IN `idProfile` INT)
BEGIN
    SELECT p.nameDJ, p.name, p.surname, p.telephoneDJ, p.gender, p.birthdate,p.picture, p.music,p.about 
    FROM `Profile` pr, `DJ` p
    WHERE (pr.idProfile = idProfile) AND (pr.idProfile = p.idProfile);
  END$$

DROP PROCEDURE IF EXISTS `getDjs`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `getDjs`()
BEGIN
				SELECT d.idProfile, d.nameDJ, d.picture, d.music
				FROM `DJ` d 
				ORDER BY d.nameDJ ASC;
	END$$

DROP PROCEDURE IF EXISTS `getEventData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `getEventData`(IN idEvent INT(11),IN idProfile INT(11))
BEGIN
		SELECT p.title, p.text, p.date, p.startHour, p.closeHour, p.createdTime
		FROM `Event` p
		WHERE (p.idEvent = idEvent AND p.idProfileCreator = idProfile);
	END$$

DROP PROCEDURE IF EXISTS `getEvents`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `getEvents`(IN `idProfile` INT(11))
BEGIN
				SELECT *
				FROM `Event`  
				WHERE (idProfileCreator = idProfile)
				ORDER BY createdTime DESC;
	END$$

DROP PROCEDURE IF EXISTS `getLocalData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `getLocalData`(IN `idProfile` INT)
BEGIN
    SELECT p.companyNameLocal, p.localName, p.cif, p.poblationLocal, p.cpLocal, p.telephoneLocal, p.street, p.streetNameLocal, p.streetNumberLocal, p.latitude, p.longitude, p.music, p.entryPrice , p.drinkPrice, p.openingHours, p.closeHours, p.picture, p.about 
    FROM `Profile` pr, `Pub` p
    WHERE (pr.idProfile = idProfile) AND (pr.idProfile = p.idProfile);
  END$$

DROP PROCEDURE IF EXISTS `getLocals`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `getLocals`()
BEGIN
				SELECT d.idProfile, d.localName, d.telephoneLocal, d.street, d.streetNameLocal, d.streetNumberLocal, d.latitude, d.longitude, d.picture
				FROM `Pub` d 
				ORDER BY d.localName ASC;
	END$$

DROP PROCEDURE IF EXISTS `getPartierData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `getPartierData`(IN `idProfile` INT)
BEGIN
		SELECT p.picture, p.`name`, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about 
		FROM `Profile` pr, `Partier` p
		WHERE (pr.idProfile = idProfile) AND (pr.idProfile = p.idProfile);
	END$$

DROP PROCEDURE IF EXISTS `goToEvent`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `goToEvent`(IN `idEvent` INT, IN `idProfileUser` INT)
BEGIN
		
		INSERT INTO `PartierGoesToEvent` VALUES (idProfileUser,idEvent);

		
  END$$

DROP PROCEDURE IF EXISTS `goToPub`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `goToPub`(idProfilePub INT, idProfileUser INT)
BEGIN
		
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfilePub);

		INSERT INTO `PartierGoToPub` VALUES (idU,idP);

		
  END$$

DROP PROCEDURE IF EXISTS `insertDJUser`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertDJUser`(IN `email` VARCHAR(50), IN `pass` VARCHAR(80))
BEGIN
    INSERT INTO `User`
    VALUES (email,pass,-1,NULL,NULL);

    INSERT INTO `Profile` (`type`,`email`)
    VALUES (-1,email);

    INSERT INTO `DJ` (`idProfile`)
          SELECT p.idProfile
          FROM `Profile` p
          WHERE p.email = email;

  END$$

DROP PROCEDURE IF EXISTS `insertFacebookUser`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertFacebookUser`(IN `email` VARCHAR(50))
BEGIN
    INSERT INTO `User`
    VALUES (email,0,0,NULL,NULL);

    INSERT INTO `Profile` (`type`,`email`)
    VALUES (0,email);

    INSERT INTO `Partier` (`idProfile`)
          SELECT p.idProfile
          FROM `Profile` p
          WHERE p.email = email;

  END$$

DROP PROCEDURE IF EXISTS `insertGoogleUser`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertGoogleUser`(IN `email` VARCHAR(50))
BEGIN
		INSERT INTO `User`
		VALUES (email,NULL,1,NULL,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END$$

DROP PROCEDURE IF EXISTS `insertNormalUser`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertNormalUser`(IN `email` VARCHAR(50), IN `pass` VARCHAR(80))
BEGIN
		INSERT INTO `User`
		VALUES (email,pass,-1,NULL,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END$$

DROP PROCEDURE IF EXISTS `insertPubUser`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertPubUser`(IN `email` VARCHAR(50), IN `pass` VARCHAR(80))
BEGIN
    INSERT INTO `User`
    VALUES (email,pass,-1,NULL,NULL);

    INSERT INTO `Profile` (`type`,`email`)
    VALUES (1,email);

    INSERT INTO `Pub` (`idProfile`)
          SELECT p.idProfile
          FROM `Profile` p
          WHERE p.email = email;

  END$$

DROP PROCEDURE IF EXISTS `insertToken`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertToken`(IN email VARCHAR(50), IN tkn VARCHAR(45))
BEGIN
    UPDATE `User` u
    SET u.token= tkn
    WHERE u.email = email;

  END$$

DROP PROCEDURE IF EXISTS `PubFollowers`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `PubFollowers`(idProfilePub INT)
BEGIN
		(SELECT p.idProfile
        FROM `PartierFollowsPub` pf, `Pub` d, `Partier` p 
        WHERE (d.idProfile = idProfilePub) AND (d.idPub = pf.idPub) AND (pf.idPartier = p.idPartier));
  END$$

DROP PROCEDURE IF EXISTS `setDJData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `setDJData`(IN `idProfile` INT, IN `nameDJ` VARCHAR(30), IN `name` VARCHAR(20), IN `surname` VARCHAR(45), IN `telephoneDJ` INT, IN `gender` TINYINT(1), IN `birthdate` DATE, IN `picture` VARCHAR(100), IN `music` VARCHAR(20), IN `about` VARCHAR(400))
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
  END$$

DROP PROCEDURE IF EXISTS `setEvent`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `setEvent`(idProf INT(11),title VARCHAR (40),about VARCHAR(200),dateEv DATE,startHour TIME,closeHour TIME)
BEGIN
      INSERT INTO `Event` (`idProfileCreator`,`title`,`text`,`date`,`startHour`,`closeHour`)
      VALUES (idProf,title,about,dateEv,startHour,closeHour);
   END$$

DROP PROCEDURE IF EXISTS `setEventData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `setEventData`(IN idProfile INT(11),IN idEvent INT(11),IN title VARCHAR(40),IN about VARCHAR(200),IN dateE DATE,IN startHour TIME,IN closeHour TIME)
BEGIN
		UPDATE Event p
		SET 
			P.title = title, 
 			P.text = about,
  			P.date = dateE,
      		p.startHour =startHour,
      		p.closeHour =closeHour	
		
		WHERE (p.idEvent = idEvent AND p.idProfileCreator = idProfile);
	END$$

DROP PROCEDURE IF EXISTS `setLocalData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `setLocalData`(IN `idProfile` INT, IN `companyNameLocal` VARCHAR(50), IN `localName` VARCHAR(20), IN `cif` VARCHAR(9), IN `poblationLocal` VARCHAR(20), IN `cpLocal` INT(5), IN `telephoneLocal` INT, IN `street` TINYINT(1), IN `streetNameLocal` VARCHAR(50), IN `streetNumberLocal` VARCHAR(50), IN `latitude` VARCHAR(11), IN `longitude` VARCHAR(11), IN `music` VARCHAR(20), IN `entryPrice` INT, IN `drinkPrice` INT, IN `openingHours` TIME, IN `closeHours` TIME, IN `picture` VARCHAR(100), IN `about` VARCHAR(200))
BEGIN
    UPDATE Pub p
    SET 
      p.companyNameLocal = companyNameLocal, 
      p.localName= localName,
      p.cif= cif,
      p.poblationLocal= poblationLocal,
      p.cpLocal= cpLocal,
      p.telephoneLocal= telephoneLocal,
      p.street= street,
      p.streetNameLocal= streetNameLocal,
      p.streetNumberLocal= streetNumberLocal,
	  p.latitude = latitude,
	  p.longitude = longitude,
      p.music= music,
      p.entryPrice= entryPrice,
      p.drinkPrice= drinkPrice,
      p.openingHours= openingHours,
      p.closeHours=  closeHours,
      p.picture= picture,
      p.about= about 

    
    WHERE (p.idProfile = idProfile);
  END$$

DROP PROCEDURE IF EXISTS `setPartierData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `setPartierData`(IN idProfile INT, IN picture VARCHAR(100), IN `name`VARCHAR(20), IN surnames VARCHAR(45), IN birthdate DATE, IN gender BOOL, IN music VARCHAR(20), IN civil_state VARCHAR(20), IN city VARCHAR(20), IN drink VARCHAR(20), IN about VARCHAR(200))
BEGIN
		UPDATE Partier p
		SET p.picture = picture, p.name = name, p.surnames = surnames, p.birthdate = birthdate, p.gender = gender, p.music = music, p.civil_state = civil_state, p.city = city, p.drink = drink, p.about = about 
		WHERE (p.idProfile = idProfile);
	END$$

DROP PROCEDURE IF EXISTS `unFollowDJ`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `unFollowDJ`(IN `idProfileDJ` INT, IN `idProfileUser` INT)
    NO SQL
BEGIN


		DECLARE idD int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idD = (SELECT d.idDJ
					FROM `DJ` d
					WHERE d.idProfile = idProfileDJ);
	
DELETE FROM  `PartierFollowsDJ`
		WHERE (idPartier = idU AND idDJ = idD);
		
  END$$

DROP PROCEDURE IF EXISTS `unFollowPub`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `unFollowPub`(IN `idProfilePub` INT, IN `idProfileUser` INT)
    NO SQL
BEGIN				
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfilePub);

DELETE FROM  `PartierFollowsPub`
		WHERE (idPartier = idU AND idPub= idP);
END$$

DROP PROCEDURE IF EXISTS `updateToken`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `updateToken`(IN email VARCHAR(50), IN tkn VARCHAR(45))
BEGIN
		UPDATE `User` u
		SET u.token= tkn
		WHERE u.email = email;

	END$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `getIdProfile`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `getIdProfile`(usr VARCHAR(50)) RETURNS int(11)
BEGIN
		RETURN (SELECT p.idProfile
				FROM `Profile` p
				WHERE (p.email = usr));
	END$$

DROP FUNCTION IF EXISTS `getTypeProfile`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `getTypeProfile`(idProfile INT) RETURNS int(11)
BEGIN
    RETURN (SELECT p.type
        FROM `Profile` p
        WHERE (p.idProfile = idProfile));
  END$$

DROP FUNCTION IF EXISTS `howManyFollowsDJ`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `howManyFollowsDJ`(idProfileDJ INT) RETURNS int(11)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsDJ` pf, `DJ` d 
        WHERE ((idProfileDJ = d.idProfile) AND (d.idDJ = pf.idDJ))) ;
  END$$

DROP FUNCTION IF EXISTS `howManyFollowsPub`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `howManyFollowsPub`(idProfilePub INT) RETURNS int(11)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsPub` pf, `Pub` p 
        WHERE ((idProfilePub = p.idProfile) AND (p.idPub = pf.idPub))) ;
  END$$

DROP FUNCTION IF EXISTS `howManyGoesToEvent`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `howManyGoesToEvent`(idEvent INT) RETURNS int(11)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoesToEvent` pg  
        WHERE (idEvent = pg.idEvent)) ;
  END$$

DROP FUNCTION IF EXISTS `insertToken`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `insertToken`(`email` VARCHAR(50), `tkn` VARCHAR(45)) RETURNS int(11)
    NO SQL
BEGIN

    UPDATE `User` u
    SET u.token= tkn
    WHERE u.email = email ;
    

    RETURN (SELECT p.type
				FROM `Profile` p
				WHERE (p.email = email));
  
  END$$

DROP FUNCTION IF EXISTS `insertTokenMobile`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `insertTokenMobile`(`email` VARCHAR(50), `tkn` VARCHAR(45)) RETURNS int(1)
    NO SQL
BEGIN

    UPDATE `User` u
    SET u.tokenMobile= tkn
    WHERE u.email = email ;
    

    RETURN (SELECT p.type
				FROM `Profile` p
				WHERE (p.email = email));
  
  END$$

DROP FUNCTION IF EXISTS `loginSucceed`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `loginSucceed`(usr VARCHAR(50), pass VARCHAR(80)) RETURNS tinyint(1)
BEGIN
    RETURN (CASE 0 WHEN ((SELECT Count(*)
        FROM `User` u
        WHERE (u.email = usr) AND u.`password` = pass AND u.`type` = -1)) 
      THEN 0    
      ELSE (SELECT idProfile 
          FROM `Profile` p 
          WHERE p.email = usr) END);
  END$$

DROP FUNCTION IF EXISTS `loginSuccessFB`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `loginSuccessFB`(`email` VARCHAR(50)) RETURNS tinyint(1)
BEGIN
    RETURN (CASE 0 WHEN ((SELECT Count(*)
        FROM `User` u
        WHERE (u.email = email) AND u.`type` = 0)) 
      THEN 0    
      ELSE (SELECT idProfile 
          FROM `Profile` p 
          WHERE p.email = email) END);
  END$$

DROP FUNCTION IF EXISTS `loginSuccessGP`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `loginSuccessGP`(`email` VARCHAR(50)) RETURNS tinyint(1)
BEGIN
    RETURN (CASE 0 WHEN ((SELECT Count(*)
        FROM `User` u
        WHERE (u.email = email) AND u.`type` = 1)) 
      THEN 0    
      ELSE (SELECT idProfile 
          FROM `Profile` p 
          WHERE p.email = email) END);
  END$$

DROP FUNCTION IF EXISTS `passOK`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `passOK`(`usr` VARCHAR(50), `pass` VARCHAR(80)) RETURNS tinyint(1)
BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.`password` = pass AND u.`type` = -1) = 1);
	END$$

DROP FUNCTION IF EXISTS `tokenEquals`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `tokenEquals`(usr VARCHAR(50), tkn VARCHAR(45)) RETURNS tinyint(1)
BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.token = tkn) = 1);
	END$$

DROP FUNCTION IF EXISTS `tokenOK`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `tokenOK`(`idUsr` INT, `tkn` VARCHAR(45)) RETURNS tinyint(1)
BEGIN
    RETURN ((SELECT Count(*)
        FROM `User` u, `Profile` p
        WHERE (p.email = u.email AND p.idProfile = idUsr AND u.token = tkn)or (p.email = u.email AND p.idProfile = idUsr AND u.tokenMobile = tkn)  ) = 1);
  END$$

DROP FUNCTION IF EXISTS `userExists`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `userExists`(usr VARCHAR(50)) RETURNS tinyint(1)
BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE u.email = usr) = 1);
	END$$

DROP FUNCTION IF EXISTS `userFollowsDJ`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `userFollowsDJ`(`idProfileDJ` INT, `idProfileP` INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsDJ` pf, `Partier` p, `DJ` d 
        WHERE ((idProfileP = p.idProfile) AND (d.idProfile = idProfileDJ) AND (pf.idPartier = p.idPartier) AND (pf.idDJ = d.idDJ)) = 1);
  END$$

DROP FUNCTION IF EXISTS `userFollowsPub`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `userFollowsPub`(`idProfilePub` INT, `idProfileP` INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsPub` pf, `Partier` p, `Pub` d 
        WHERE (
                (idProfileP = p.idProfile) AND 
                (d.idProfile = idProfilePub) AND 
                (pf.idPartier = p.idPartier) AND (pf.idPub = d.idPub)
        		)= 1);
 END$$

DROP FUNCTION IF EXISTS `userGoesToEvent`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `userGoesToEvent`(idProfileP INT, idEvent INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoesToEvent` pg, `Partier` p 
        WHERE ((idProfileP = p.idProfile) AND (pg.idPartier = p.idPartier) AND (pg.idEvent = idEvent)) = 1);
  END$$

DROP FUNCTION IF EXISTS `userGoesToPub`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `userGoesToPub`(idProfileP INT, idProfilePub INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoToPub` pf, `Partier` p, `Pub` d 
        WHERE ((idProfileP = p.idProfile) AND (d.idProfile = idProfilePub) AND (pf.idPartier = p.idPartier) AND (pf.idPub = d.idPub)) = 1);
  END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DJ`
--

DROP TABLE IF EXISTS `DJ`;
CREATE TABLE IF NOT EXISTS `DJ` (
  `idDJ` int(11) NOT NULL AUTO_INCREMENT,
  `idProfile` int(11) NOT NULL,
  `nameDJ` varchar(30) NOT NULL,
  `name` varchar(20) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `telephoneDJ` int(11) NOT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `picture` varchar(100) NOT NULL,
  `music` varchar(20) DEFAULT NULL,
  `about` varchar(400) NOT NULL,
  `birthdate_p` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `gender_p` tinyint(1) NOT NULL DEFAULT '1',
  `music_p` tinyint(1) NOT NULL DEFAULT '1',
  `about_p` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idDJ`),
  KEY `fk_DJ_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Event`
--

DROP TABLE IF EXISTS `Event`;
CREATE TABLE IF NOT EXISTS `Event` (
  `idEvent` int(11) NOT NULL AUTO_INCREMENT,
  `idProfileCreator` int(11) NOT NULL,
  `title` varchar(40) NOT NULL,
  `text` varchar(200) DEFAULT NULL,
  `date` date NOT NULL,
  `startHour` time NOT NULL,
  `closeHour` time NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEvent`),
  KEY `fk_Event_idProfile1_idx` (`idProfileCreator`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Fotos`
--

DROP TABLE IF EXISTS `Fotos`;
CREATE TABLE IF NOT EXISTS `Fotos` (
  `idFoto` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(45) DEFAULT NULL,
  `idProfile` int(11) NOT NULL,
  PRIMARY KEY (`idFoto`),
  KEY `fk_Fotos_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Friends`
--

DROP TABLE IF EXISTS `Friends`;
CREATE TABLE IF NOT EXISTS `Friends` (
  `idPartier1` int(11) NOT NULL,
  `idPartier2` int(11) NOT NULL,
  `mode` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idPartier1`,`idPartier2`),
  KEY `fk_Partier_has_Partier_Partier2_idx` (`idPartier2`),
  KEY `fk_Partier_has_Partier_Partier1_idx` (`idPartier1`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Lists`
--

DROP TABLE IF EXISTS `Lists`;
CREATE TABLE IF NOT EXISTS `Lists` (
  `idLists` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  PRIMARY KEY (`idLists`),
  KEY `fk_Lists_Pub1_idx` (`idPub`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Partier`
--

DROP TABLE IF EXISTS `Partier`;
CREATE TABLE IF NOT EXISTS `Partier` (
  `idPartier` int(11) NOT NULL AUTO_INCREMENT,
  `idProfile` int(11) NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `surnames` varchar(45) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `music` varchar(20) DEFAULT NULL,
  `civil_state` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `drink` varchar(20) DEFAULT NULL,
  `about` varchar(200) DEFAULT NULL,
  `facebook` VARCHAR(50) NULL,
  `twitter` VARCHAR(15) NULL,
  `instagram` VARCHAR(30) NULL,
  `picture_p` tinyint(1) NOT NULL DEFAULT '1',
  `name_p` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `surname_p` tinyint(1) NOT NULL DEFAULT '1',
  `birthdate_p` tinyint(1) NOT NULL DEFAULT '1',
  `gender_p` tinyint(1) NOT NULL DEFAULT '1',
  `music_p` tinyint(1) NOT NULL DEFAULT '1',
  `civil_state_p` tinyint(1) NOT NULL DEFAULT '1',
  `city_p` tinyint(1) NOT NULL DEFAULT '1',
  `drink_p` tinyint(1) NOT NULL DEFAULT '1',
  `about_p` tinyint(1) NOT NULL DEFAULT '1',
  `facebook_p` TINYINT(1) NOT NULL DEFAULT 1,
  `twitter_p` TINYINT(1) NOT NULL DEFAULT 1,
  `instagram_p` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idPartier`),
  KEY `fk_Partier_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierFollowsDJ`
--

DROP TABLE IF EXISTS `PartierFollowsDJ`;
CREATE TABLE IF NOT EXISTS `PartierFollowsDJ` (
  `idPartier` int(11) NOT NULL,
  `idDJ` int(11) NOT NULL,
  PRIMARY KEY (`idPartier`,`idDJ`),
  KEY `fk_Partier_has_DJ_DJ1_idx` (`idDJ`),
  KEY `fk_Partier_has_DJ_Partier1_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierFollowsPub`
--

DROP TABLE IF EXISTS `PartierFollowsPub`;
CREATE TABLE IF NOT EXISTS `PartierFollowsPub` (
  `idPartier` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  PRIMARY KEY (`idPartier`,`idPub`),
  KEY `fk_Partier_has_Pub_Pub1_idx` (`idPub`),
  KEY `fk_Partier_has_Pub_Partier1_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierGoesToEvent`
--

DROP TABLE IF EXISTS `PartierGoesToEvent`;
CREATE TABLE IF NOT EXISTS `PartierGoesToEvent` (
  `idPartier` int(11) NOT NULL,
  `idEvent` int(11) NOT NULL,
  PRIMARY KEY (`idPartier`,`idEvent`),
  KEY `fk_partier_has_event_event1_idx` (`idEvent`),
  KEY `fk_partier_has_event_partier1_idx` (`idPartier`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierGoToPub`
--

DROP TABLE IF EXISTS `PartierGoToPub`;
CREATE TABLE IF NOT EXISTS `PartierGoToPub` (
  `idPartier` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  PRIMARY KEY (`idPartier`,`idPub`),
  KEY `fk_Partier_has_Pub_Pub1_idx` (`idPub`),
  KEY `fk_Partier_has_Pub_Partier1_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierIsInLists`
--

DROP TABLE IF EXISTS `PartierIsInLists`;
CREATE TABLE IF NOT EXISTS `PartierIsInLists` (
  `idPartier` int(11) NOT NULL,
  `idLists` int(11) NOT NULL,
  PRIMARY KEY (`idPartier`,`idLists`),
  KEY `fk_Partier_has_Lists_Lists1_idx` (`idLists`),
  KEY `fk_Partier_has_Lists_Partier1_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierIsInPub`
--

DROP TABLE IF EXISTS `PartierIsInPub`;
CREATE TABLE IF NOT EXISTS `PartierIsInPub` (
  `idPartier` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  `inside` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPartier`,`idPub`),
  KEY `fk_Partier_has_Pub_Pub2_idx` (`idPub`),
  KEY `fk_Partier_has_Pub_Partier2_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Profile`
--

DROP TABLE IF EXISTS `Profile`;
CREATE TABLE IF NOT EXISTS `Profile` (
  `idProfile` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT 'type: \n0 - partier\n1 - pub\n-1 - dj',
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`idProfile`),
  KEY `fk_Profile_User_idx` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=77 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Pub`
--

DROP TABLE IF EXISTS `Pub`;
CREATE TABLE IF NOT EXISTS `Pub` (
  `idPub` int(11) NOT NULL AUTO_INCREMENT,
  `idProfile` int(11) NOT NULL,
  `companyNameLocal` varchar(50) NOT NULL,
  `localName` varchar(20) NOT NULL,
  `cif` varchar(9) NOT NULL,
  `poblationLocal` varchar(20) NOT NULL,
  `cpLocal` int(5) NOT NULL,
  `telephoneLocal` int(11) NOT NULL,
  `street` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-Calle \n1-Avda \n2-Plaza ',
  `streetNameLocal` varchar(50) NOT NULL,
  `streetNumberLocal` varchar(50) NOT NULL,
  `latitude` varchar(11) DEFAULT NULL,
  `longitude` varchar(11) DEFAULT NULL,
  `music` varchar(20) DEFAULT NULL,
  `entryPrice` int(11) DEFAULT NULL,
  `drinkPrice` int(11) DEFAULT NULL,
  `openingHours` time DEFAULT NULL,
  `closeHours` time DEFAULT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `about` varchar(200) DEFAULT NULL,
  `facebook` VARCHAR(50) NULL,
  `twitter` VARCHAR(15) NULL,
  `instagram` VARCHAR(30) NULL,
  `music_p` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `entryPrice_p` tinyint(1) NOT NULL DEFAULT '1',
  `drinkPrice_p` tinyint(1) NOT NULL DEFAULT '1',
  `openingHours_p` tinyint(1) NOT NULL DEFAULT '1',
  `closeHours_p` tinyint(1) NOT NULL DEFAULT '1',
  `picture_p` tinyint(1) NOT NULL DEFAULT '1',
  `about_p` tinyint(1) NOT NULL DEFAULT '1',
  `facebook_p` TINYINT(1) NOT NULL DEFAULT 1,
  `twitter_p` TINYINT(1) NOT NULL DEFAULT 1,
  `instagram_p` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idPub`),
  KEY `fk_Pub_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User`
--

DROP TABLE IF EXISTS `User`;
CREATE TABLE IF NOT EXISTS `User` (
  `email` varchar(50) NOT NULL,
  `password` varchar(80) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '0 - facebook\n1 - google\n-1 - registrado',
  `token` varchar(45) DEFAULT NULL,
  `tokenMobile` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Works`
--

DROP TABLE IF EXISTS `Works`;
CREATE TABLE IF NOT EXISTS `Works` (
  `idDJ` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  PRIMARY KEY (`idDJ`,`idPub`),
  KEY `fk_DJ_has_Pub_Pub1_idx` (`idPub`),
  KEY `fk_DJ_has_Pub_DJ1_idx` (`idDJ`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `DJ`
--
ALTER TABLE `DJ`
  ADD CONSTRAINT `fk_DJ_Profile1` FOREIGN KEY (`idProfile`) REFERENCES `Profile` (`idProfile`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Fotos`
--
ALTER TABLE `Fotos`
  ADD CONSTRAINT `fk_Fotos_Profile1` FOREIGN KEY (`idProfile`) REFERENCES `Profile` (`idProfile`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Friends`
--
ALTER TABLE `Friends`
  ADD CONSTRAINT `fk_Partier_has_Partier_Partier1` FOREIGN KEY (`idPartier1`) REFERENCES `Partier` (`idPartier`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_Partier_Partier2` FOREIGN KEY (`idPartier2`) REFERENCES `Partier` (`idPartier`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Lists`
--
ALTER TABLE `Lists`
  ADD CONSTRAINT `fk_Lists_Pub1` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Partier`
--
ALTER TABLE `Partier`
  ADD CONSTRAINT `fk_Partier_Profile1` FOREIGN KEY (`idProfile`) REFERENCES `Profile` (`idProfile`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `PartierFollowsDJ`
--
ALTER TABLE `PartierFollowsDJ`
  ADD CONSTRAINT `fk_Partier_has_DJ_Partier1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_DJ_DJ1` FOREIGN KEY (`idDJ`) REFERENCES `DJ` (`idDJ`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `PartierFollowsPub`
--
ALTER TABLE `PartierFollowsPub`
  ADD CONSTRAINT `fk_Partier_has_Pub_Partier1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_Pub_Pub1` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `PartierIsInLists`
--
ALTER TABLE `PartierIsInLists`
  ADD CONSTRAINT `fk_Partier_has_Lists_Partier1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_Lists_Lists1` FOREIGN KEY (`idLists`) REFERENCES `Lists` (`idLists`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `PartierIsInPub`
--
ALTER TABLE `PartierIsInPub`
  ADD CONSTRAINT `fk_Partier_has_Pub_Partier2` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_Pub_Pub2` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Profile`
--
ALTER TABLE `Profile`
  ADD CONSTRAINT `fk_Profile_User` FOREIGN KEY (`email`) REFERENCES `User` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Pub`
--
ALTER TABLE `Pub`
  ADD CONSTRAINT `fk_Pub_Profile1` FOREIGN KEY (`idProfile`) REFERENCES `Profile` (`idProfile`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Works`
--
ALTER TABLE `Works`
  ADD CONSTRAINT `fk_DJ_has_Pub_DJ1` FOREIGN KEY (`idDJ`) REFERENCES `DJ` (`idDJ`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DJ_has_Pub_Pub1` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

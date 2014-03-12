-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 12-03-2014 a las 18:41:47
-- Versión del servidor: 5.1.70-cll
-- Versión de PHP: 5.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `Where2Night`
--
CREATE DATABASE IF NOT EXISTS `Where2Night` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `Where2Night`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `deleteToken`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteToken`(IN email VARCHAR(50))
BEGIN
		UPDATE `User` u
		SET u.token= NULL
		WHERE u.email = email;

	END$$

DROP PROCEDURE IF EXISTS `getPartierData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `getPartierData`(IN `email` VARCHAR(50) CHARSET latin1)
BEGIN
		SELECT pr.idProfile, p.picture, p.`name`, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about 
		FROM `Profile` pr, `Partier` p
		WHERE (pr.email = email) AND(pr.idProfile = p.idProfile);
	END$$

DROP PROCEDURE IF EXISTS `insertFacebookUser`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertFacebookUser`(email VARCHAR(50))
BEGIN
		INSERT INTO `User`
		VALUES (email,0,0,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END$$

DROP PROCEDURE IF EXISTS `insertGoogleUser`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertGoogleUser`(email VARCHAR(50))
BEGIN
		INSERT INTO `User`
		VALUES (email,0,1,NULL);

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
		VALUES (email,pass,-1,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END$$

DROP PROCEDURE IF EXISTS `insertToken`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertToken`(IN `email` VARCHAR(50), IN `tkn` VARCHAR(45))
BEGIN
		UPDATE `User` u
		SET u.token= tkn
		WHERE u.email = email;

	END$$

DROP PROCEDURE IF EXISTS `setPartierData`$$
CREATE DEFINER=`where2`@`localhost` PROCEDURE `setPartierData`(IN `idProfile` INT, IN `picture` VARCHAR(100), IN `name` VARCHAR(20), IN `surnames` VARCHAR(45), IN `birthdate` DATE, IN `gender` INT, IN `music` VARCHAR(20), IN `civil_state` VARCHAR(20), IN `city` VARCHAR(20), IN `drink` VARCHAR(20), IN `about` VARCHAR(200))
BEGIN
		UPDATE Partier p
		SET p.picture = picture, p.`name` = `name`, p.surnames = surnames, p.birthdate = birthdate, p.gender = gender, p.music = music, p.civil_state = civil_state, p.city = city, p.drink = drink, p.about = about 
		WHERE (p.idProfile = idProfile);
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

DROP FUNCTION IF EXISTS `loginSucceed`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `loginSucceed`(`usr` VARCHAR(50), `pass` VARCHAR(80)) RETURNS tinyint(1)
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

DROP FUNCTION IF EXISTS `tokenEquals`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `tokenEquals`(usr VARCHAR(50), tkn VARCHAR(45)) RETURNS tinyint(1)
BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.token = tkn) = 1);
	END$$

DROP FUNCTION IF EXISTS `userExists`$$
CREATE DEFINER=`where2`@`localhost` FUNCTION `userExists`(usr VARCHAR(50)) RETURNS tinyint(1)
BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE u.email = usr) = 1);
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
  PRIMARY KEY (`idDJ`),
  KEY `fk_DJ_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Event`
--

DROP TABLE IF EXISTS `Event`;
CREATE TABLE IF NOT EXISTS `Event` (
  `idEvent` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(200) DEFAULT NULL,
  `idDJ` int(11) DEFAULT NULL,
  `idPub` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEvent`),
  KEY `fk_Event_DJ1_idx` (`idDJ`),
  KEY `fk_Event_Pub1_idx` (`idPub`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
  PRIMARY KEY (`idPartier1`,`idPartier2`),
  KEY `fk_Partier_has_Partier_Partier2_idx` (`idPartier2`),
  KEY `fk_Partier_has_Partier_Partier1_idx` (`idPartier1`)
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
  PRIMARY KEY (`idPartier`),
  KEY `fk_Partier_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=108 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=108 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Pub`
--

DROP TABLE IF EXISTS `Pub`;
CREATE TABLE IF NOT EXISTS `Pub` (
  `idPub` int(11) NOT NULL AUTO_INCREMENT,
  `idProfile` int(11) NOT NULL,
  PRIMARY KEY (`idPub`),
  KEY `fk_Pub_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User`
--

DROP TABLE IF EXISTS `User`;
CREATE TABLE IF NOT EXISTS `User` (
  `email` varchar(50) NOT NULL,
  `password` varchar(80) NOT NULL,
  `type` int(11) DEFAULT NULL COMMENT '0 - facebook\n1 - google\n-1 - registrado',
  `token` varchar(45) DEFAULT NULL,
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
-- Filtros para la tabla `Event`
--
ALTER TABLE `Event`
  ADD CONSTRAINT `fk_Event_DJ1` FOREIGN KEY (`idDJ`) REFERENCES `DJ` (`idDJ`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Event_Pub1` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUserPass`(IN idProfile INT,IN `pass` VARCHAR(80))
BEGIN
		UPDATE `User` u, `Profile` p
		SET u.password = pass 
		WHERE (u.email = p.email AND p.idProfile=idProfile);
	END
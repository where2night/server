DELIMITER $$
CREATE PROCEDURE `dontGoToPub`(idProfilePub INT, idProfileUser INT)
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
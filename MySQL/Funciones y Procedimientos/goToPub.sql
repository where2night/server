DELIMITER $$
CREATE PROCEDURE `goToPub`(idProfilePub INT, idProfileUser INT)
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

    DELIMITER ;
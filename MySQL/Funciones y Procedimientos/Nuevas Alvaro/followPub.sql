DELIMITER $$
CREATE PROCEDURE `followPub`(idProfilePub INT, idProfileUser INT)
BEGIN
		
		
		SET @idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET @idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfilePub);

		INSERT INTO `PartierFollowsPub` VALUES (@idU,@idP);

		
  END$$
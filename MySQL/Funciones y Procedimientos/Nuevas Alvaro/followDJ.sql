DELIMITER $$
CREATE PROCEDURE `followDJ`(idProfileDJ INT, idProfileUser INT)
BEGIN
		
		
		SET @idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET @idD = (SELECT d.idDJ
					FROM `DJ` d
					WHERE d.idProfile = idProfileDJ);

		INSERT INTO `PartierFollowsDJ` VALUES (@idU,@idD);

		
  END$$
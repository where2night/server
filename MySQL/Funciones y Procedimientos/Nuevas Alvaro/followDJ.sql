DELIMITER //
CREATE PROCEDURE `followDJ`(idProfileDJ INT, idProfileUser INT)
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
		
  END
  DELIMITER;
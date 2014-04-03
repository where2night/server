DELIMITER //
CREATE PROCEDURE `followPartier`(idPartier INT, idProfileUser INT)
BEGIN

		DECLARE idD int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idD = (SELECT d.idDJ
					FROM `Partier` d
					WHERE d.idProfile = idPartier);

		INSERT INTO `Friends` VALUES (idU,idD);
		
  END
  DELIMITER;
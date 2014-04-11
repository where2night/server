DELIMITER $$
CREATE PROCEDURE `followPartier`(idProfile INT, idPartier INT, mode TINYINT(1))
BEGIN

		DECLARE idD int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);

		SET idD = (SELECT d.Partier
					FROM `Partier` d
					WHERE d.idProfile = idPartier);
		

		INSERT INTO `Friends` VALUES (idU,idD,null,mode);
		
  END$$
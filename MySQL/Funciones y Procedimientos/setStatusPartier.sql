DELIMITER //
 
 CREATE PROCEDURE setStatusPartier(IN idProfile INT(11),IN estado VARCHAR(140))

     BEGIN
    	DECLARE idP int(11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);

		UPDATE Partier p
		SET 
			p.status = estado
		
		WHERE (p.idProfile = idProfile);

		INSERT INTO `PartierStatus` (`idPartier`,`status`)
		VALUES (idP,estado);
	END//
DELIMITER ;
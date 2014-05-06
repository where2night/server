DELIMITER //
 
 CREATE PROCEDURE setModePartier(IN idProfile INT(11),IN modo TINYINT(1))

    BEGIN
    	DECLARE idP int(11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);

		UPDATE Partier p
		SET 
			p.mode = modo
		
		WHERE (p.idProfile = idProfile);

		INSERT INTO `PartierMode` (`idPartier`,`mode`)
		VALUES (idP,modo);
	END//
    
DELIMITER ;
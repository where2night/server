DELIMITER //
 
 CREATE PROCEDURE setModePartier(IN idProfile INT(11),IN mode TINYINT(1))

    BEGIN
		UPDATE Partier p
		SET 
			p.mode = mode
		
		WHERE (p.idProfile = idProfile);
	END//
    
DELIMITER ;
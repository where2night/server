DELIMITER //
 
 CREATE PROCEDURE acceptFriend(IN idProfileP1 INT(11),IN idProfileP2 INT(11))
	BEGIN
    DECLARE idP int (11);
    DECLARE idP1 int (11);

	SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP1);

	SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP2);
    
		UPDATE Friends f
		SET 
			f.mode = '1'
		WHERE ((f.idPartier1 = idP AND f.idPartier2 = idP1)OR(f.idPartier1 = idP1 AND f.idPartier2 = idP));
	END//
    
DELIMITER ;
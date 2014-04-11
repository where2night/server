DELIMITER //
 
 CREATE PROCEDURE setStatusPartier(IN idPartier1 INT(11),IN idPartier2 INT(11),IN mode TINYINT(1))

    BEGIN
		UPDATE Friends f
		SET 
			f.mode = mode
		
		
		WHERE ((f.idPartier1 = idPartier1 AND f.idPartier2 = idPartier2)OR(f.idPartier1 = idPartier2 AND f.idPartier2 = idPartier1));
	END//
    
DELIMITER ;
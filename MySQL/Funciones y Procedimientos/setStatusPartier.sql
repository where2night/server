DELIMITER //
 
 CREATE PROCEDURE setStatusPartier(IN idProfile INT(11),IN status TINYINT(1))

    BEGIN
		UPDATE Partier p
		SET 
			p.status = status
		
		WHERE (p.idProfile = idProfile);
	END//
    
DELIMITER ;
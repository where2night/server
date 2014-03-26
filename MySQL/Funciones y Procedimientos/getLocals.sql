DELIMITER //
 
 CREATE PROCEDURE getLocals()
    BEGIN
				SELECT idPub
				FROM `Pub` ;
	END//
    
DELIMITER ;
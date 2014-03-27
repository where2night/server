DELIMITER //
 
 CREATE PROCEDURE getLocals()
    BEGIN
				SELECT d.idProfile, d.localName, d.latitude, d.longitude, d.picture
				FROM `Pub` d 
				ORDER BY d.localName ASC;
	END//
    
DELIMITER ;
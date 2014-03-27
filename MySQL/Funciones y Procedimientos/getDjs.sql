DELIMITER //
 
 CREATE PROCEDURE getDjs()
    BEGIN
				SELECT d.idProfile, d.nameDJ, d.picture, d.music
				FROM `DJ` d 
				ORDER BY d.nameDJ ASC;
	END//
    
DELIMITER ;
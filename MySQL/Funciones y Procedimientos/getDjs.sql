DELIMITER //
 
 CREATE PROCEDURE getDjs()
    BEGIN
				SELECT d.idDj, d.nameDJ, d.picture
				FROM `DJ` d 
				ORDER BY d.nameDJ ASC;
	END//
    
DELIMITER ;
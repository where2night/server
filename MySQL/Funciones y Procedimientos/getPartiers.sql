DELIMITER //
 
 CREATE PROCEDURE getPartiers()
    BEGIN
				SELECT *
				FROM `Partier` d 
				ORDER BY d.name ASC, d.surnames ASC;
	END//
    
DELIMITER ;
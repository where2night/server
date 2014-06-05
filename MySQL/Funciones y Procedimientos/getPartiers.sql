DELIMITER //
 
 CREATE PROCEDURE getPartiers()
    BEGIN
				SELECT *
				FROM `Partier` d 
				ORDER BY  d.surnames ASC, d.name ASC;
	END//
    
DELIMITER ;
DELIMITER //
 
 CREATE PROCEDURE getEvents(idProfile INT(11))
    BEGIN
				SELECT *
				FROM `Event` d 
				WHERE (d.idProfileCreator = idProfile)
				ORDER BY d.createdTime DESC;
	END//
    
DELIMITER ;
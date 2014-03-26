DELIMITER //
 
 CREATE PROCEDURE getEvents(idProfile INT(11))
    BEGIN
				SELECT idEvent
				FROM `Event` 
				WHERE (idProfileCreator = idProfile);
	END//
    
DELIMITER ;
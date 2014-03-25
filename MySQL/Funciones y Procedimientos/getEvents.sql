DELIMITER //
 
 CREATE FUNCTION getEvents(idProfile INT(11)) RETURN INT
    BEGIN
		RETURN (SELECT p.idEvent
				FROM `Event` p
				WHERE (p.idProfileCreator = idProfile));
	END//
    
DELIMITER ;
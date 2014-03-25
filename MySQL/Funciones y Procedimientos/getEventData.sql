DELIMITER //
 
 CREATE PROCEDURE getEventData(IN idEvent INT(11),IN idProfile INT(11))
    BEGIN
		SELECT p.title, p.text, p.date, p.startHour, p.closeHour, p.createdTime
		FROM `Event` p
		WHERE (p.idEvent = idEvent AND p.idProfileCreator = idProfile);
	END//
    
DELIMITER ;
DELIMITER //

CREATE PROCEDURE deleteEvent(IN idEvent INT(11),IN idProfile INT(11))
BEGIN
		DELETE FROM  `Event` p
		WHERE (p.idEvent = idEvent AND p.idProfile = idProfile);

	END//

DELIMITER ;
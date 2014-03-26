DELIMITER //

CREATE PROCEDURE deleteEvent(IN idEvent1 INT(11),IN idProfile1 INT(11))
BEGIN
		DELETE FROM  `Event`
		WHERE (idEvent = idEvent1 AND idProfileCreator = idProfile1);

	END//

DELIMITER ;
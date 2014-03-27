DELIMITER //
 
 CREATE PROCEDURE eventsUser(IN idProfile INT(11))
    BEGIN
				SELECT e.idEvent, e.idProfileCreator
				FROM `Event` e, `PartierGoesToEvent` pg
				WHERE (e.idEvent = pg.idEvent and pg.idPartier= idProfile)
				ORDER BY e.closeHour ASC;
	END//
    
DELIMITER ;
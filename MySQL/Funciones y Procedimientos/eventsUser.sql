DELIMITER //
 
 CREATE PROCEDURE eventsUser(IN idProfile INT(11))
  BEGIN
				SELECT e.idEvent, e.idProfileCreator, e.title, e.text, e.date, e.startHour, e.closeHour
				FROM `Event` e, `PartierGoesToEvent` pg
				WHERE (e.idEvent = pg.idEvent and pg.idPartier= idProfile)
				ORDER BY e.date ASC;
	END
    
DELIMITER ;
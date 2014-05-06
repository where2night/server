DELIMITER //
 
 CREATE PROCEDURE eventsUser(IN idProfile INT(11))
  BEGIN
				SELECT e.idEvent, e.idProfileCreator, e.title, e.text, e.date, e.startHour, e.closeHour
				FROM `Event` e, `PartierGoesToEvent` pg, `Partier` p
				WHERE (e.idEvent = pg.idEvent and p.idProfile = idProfile and pg.idPartier= p.idPartier)
				ORDER BY e.date ASC;
	END
    
DELIMITER ;
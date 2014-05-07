DELIMITER //
 
 CREATE PROCEDURE listsUser(IN idProfile INT(11))
  BEGIN
				DECLARE idP int (11);

				SET idP = (SELECT p.idPartier
						FROM `Partier` p
						WHERE p.idProfile = idProfileP);	
		

				SELECT e.idList, e.idPub, e.title, e.text, e.date, e.startHour, e.closeHour
				FROM `List` e, `PartierJoinedList` pg
				WHERE (e.idList = pg.idlist and pg.idPartier= idP)
				ORDER BY e.date ASC;
	END//
    
DELIMITER ;
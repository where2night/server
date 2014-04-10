DELIMITER //
 
 CREATE PROCEDURE listsUser(IN idProfile INT(11))
  BEGIN
				SELECT e.idList, e.idPub, e.title, e.text, e.date, e.startHour, e.closeHour
				FROM `List` e, `PartierJoinedList` pg
				WHERE (e.idList = pg.idlist and pg.idPartier= idProfile)
				ORDER BY e.date ASC;
	END
    
DELIMITER ;
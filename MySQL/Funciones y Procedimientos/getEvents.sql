DELIMITER //
 
 CREATE PROCEDURE getEvents(idProfile INT(11),idPub INT(11))
    BEGIN
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idPub);

		select EL.idEvent, EL.idProfileCreator, EL.title, EL.text, EL.date, EL.startHour, EL.closeHour, EL.createdTime, PGTE.idPartier AS GOES 	
		from
		(
            SELECT e.idEvent, e.idProfileCreator, e.title, e.text, e.date, e.startHour, e.closeHour, e.createdTime
				FROM `Event` e 
				WHERE (e.idProfileCreator = idP)
         ) EL LEFT JOIN
			`PartierGoesToEvent` PGTE ON( PGTE.idPartier = idU
										AND PGTE.idEvent = EL.idEvent )
			
		ORDER BY EL.createdTime DESC;
	END
    
DELIMITER ;
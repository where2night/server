DELIMITER //
 
 CREATE PROCEDURE getLists(idProfile INT(11),idPub INT(11))
    BEGIN
    	DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idPub);
				
				SELECT EL.idLists,EL.title,EL.about,EL.createdTime,EL.date,EL.startHour,EL.dateClose,EL.maxGuest,EL.closeHour, PGTE.idPartier AS GOES
				FROM 
				(
					SELECT d.idLists,d.title,d.about,d.createdTime,d.date,d.startHour,d.closeHour
					FROM `Lists` d 
					WHERE ( d.idPub = idP)
				) EL LEFT JOIN
					`PartierIsInList` PGTE ON( PGTE.idPartier = idU
												AND PGTE.idLists=EL.idLists)

				ORDER BY EL.createdTime DESC;
	END//
    
DELIMITER ;
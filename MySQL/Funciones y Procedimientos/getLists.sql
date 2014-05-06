DELIMITER //
 
 CREATE PROCEDURE getLists(idProfile INT(11))
    BEGIN
				SELECT d.idLists,d.title,d.about,d.createdTime,d.date,d.startHour,d.closeHour
				FROM `Lists` d ,`Pub` pb
				WHERE (pb.idProfile = idProfile and d.idPub=pb.idPub)
				ORDER BY d.createdTime DESC;
	END//
    
DELIMITER ;
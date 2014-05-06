DELIMITER //
 
 CREATE PROCEDURE getListData(IN idList INT(11),IN idProfile INT(11))
    BEGIN
		DECLARE idP int(11);
   
   		 SET idP = (SELECT pb.idPub
					FROM `Pub` pb
					WHERE pb.idProfile = idProfile);
		SELECT p.title, p.about, p.date, p.startHour, p.closeHour, p.createdTime
		FROM `Lists` p
		WHERE (p.idLists = idList AND p.idPub = idP);
	END//
    
DELIMITER ;
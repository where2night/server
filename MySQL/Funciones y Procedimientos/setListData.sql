DELIMITER //
 
 CREATE PROCEDURE setListData(IN idProfile INT(11),IN idList INT(11),IN title VARCHAR(40),IN about VARCHAR(200),IN dateL DATE,IN startHour TIME,IN closeHour TIME)

    BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);
		
		
		UPDATE Lists p
		SET 
			p.title = title, 
 			p.about = about,
  			p.date = dateL,
      		p.startHour =startHour,
      		p.closeHour =closeHour	
		
		WHERE (p.idLists = idList AND p.idPub = idP);
	END//
    
DELIMITER ;
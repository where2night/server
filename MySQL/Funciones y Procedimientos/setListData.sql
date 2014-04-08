DELIMITER //
 
 CREATE PROCEDURE setListData(IN idProfile INT(11),IN idList INT(11),IN title VARCHAR(40),IN about VARCHAR(200),IN dateL DATE,IN startHour TIME,IN closeHour TIME)

    BEGIN
		UPDATE List p
		SET 
			P.title = title, 
 			P.text = about,
  			P.date = dateL,
      		p.startHour =startHour,
      		p.closeHour =closeHour	
		
		WHERE (p.idList = idList AND p.idPub = idProfile);
	END//
    
DELIMITER ;
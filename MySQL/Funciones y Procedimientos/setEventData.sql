DELIMITER //
 
 CREATE PROCEDURE setEventData(IN idProfile INT(11),IN idEvent INT(11),IN title VARCHAR(40),IN about VARCHAR(200),IN dateE DATE,IN startHour TIME,IN closeHour TIME)

    BEGIN
		UPDATE Event p
		SET 
			P.title = title, 
 			P.text = about,
  		P.date = dateE,
      p.startHour =startHour,
      p.closeHour =closeHour	
		
		WHERE (p.idEvent = idEvent AND p.idProfileCreator = idProfile);
	END//
    
DELIMITER ;
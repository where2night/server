DELIMITER //
 
 CREATE PROCEDURE playTrack(IN idProfile INT(11),IN idTrack INT(11))

    BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);
		
		
		UPDATE PlayLists pl
		SET 
			pl.playing = 0;	
		
		UPDATE PlayLists pl
		SET 
			pl.playing = 1	
		
		WHERE (pl.idTrack = idTrack AND pl.idPub = idP);
		
	END//
    
DELIMITER ;
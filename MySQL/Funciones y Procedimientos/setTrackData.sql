DELIMITER //
 
 CREATE PROCEDURE setTrackData(IN idProfile INT(11),IN idTrack INT(11),IN name VARCHAR(40),IN artist VARCHAR(40))

    BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);
		
		
		UPDATE PlayLists pl
		SET 
			pl.trackName = name, 
 			pl.trackArtist = artist
 
		
		WHERE (pl.idTrack = idTrack AND pl.idPub = idP);
	END//
    
DELIMITER ;
DELIMITER //
 
 CREATE PROCEDURE restartPlaylist(IN idProfile INT(11))

    BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);
		
		
		UPDATE PlayLists pl
		SET 
			pl.playing = 0,
			pl.votes=0	
		WHERE (pl.idPub = idP);

		DELETE FROM `PartierVoteTrack`
		WHERE(idPub=idP);
		
	END//
    
DELIMITER ;
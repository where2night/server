DELIMITER //
 
 CREATE PROCEDURE getTrackData(IN idProfile INT(11),IN idTrack INT(11))
    BEGIN
		DECLARE idP int(11);
   
   		 SET idP = (SELECT pb.idPub
					FROM `Pub` pb
					WHERE pb.idProfile = idProfile);
		SELECT p.trackName, p.trackArtist, p.createdTime
		FROM `PlayLists` p
		WHERE (p.idTrack = idTrack AND p.idPub = idP);
	END//
    
DELIMITER ;
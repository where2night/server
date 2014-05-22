DELIMITER //

CREATE PROCEDURE deleteTrack(IN idProfile INT(11),IN idTrack1 INT(11))
BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);		
		
		DELETE FROM `PartierVoteTrack`
		WHERE (idTrack = idTrack1 AND idPub = idP);
		DELETE FROM  `PlayLists` 
		WHERE (idTrack = idTrack1 AND idPub = idP);
	END//

DELIMITER ;
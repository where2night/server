DELIMITER //

CREATE PROCEDURE deleteVote(IN idProfile INT(11),IN idPub1 INT(11),IN idTrack1 INT(11))
BEGIN
			DECLARE idPa int(11);
		DECLARE idPu int(11);
   
    	SET idPa = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);	
   
    	SET idPu = (SELECT pb.idPub
					FROM `Pub` pb
					WHERE pb.idProfile = idPub1);		
		
		DELETE FROM `PartierVoteTrack`
		WHERE (idTrack = idTrack1 AND idPartier=idPa AND idPub = idPu);
		
		UPDATE PlayLists pl
		SET 
			pl.votes = pl.votes-1
		
		WHERE (pl.idTrack = idTrack1 AND pl.idPub = idPu);
		
	END//

DELIMITER ;
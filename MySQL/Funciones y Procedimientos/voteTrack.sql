DELIMITER //
 
 CREATE PROCEDURE voteTrack(IN idProfile INT(11),IN idPub INT(11),IN idTrack INT(11))
	BEGIN
    DECLARE idPa int (11);
    DECLARE idPu int (11);

	SET idPa = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);

	SET idPu = (SELECT pb.idPub
					FROM `Pub` pb
					WHERE pb.idProfile = idPub);
    
		UPDATE PlayLists pl
		SET 
			pl.votes = pl.votes + 1
		WHERE (pl.idTrack = idTrack AND pl.idPub = idPu);

		INSERT INTO `PartierVoteTrack` (`idTrack`,`idPartier`,`idPub`)
      	VALUES (idTrack,idPa,idPu);
	END//
    
DELIMITER ;
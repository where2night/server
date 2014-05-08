DELIMITER $$
CREATE PROCEDURE `myTracksIn`(IN idProfile INT(11), IN idPub INT(11))
BEGIN
		DECLARE idPa int (11);
		DECLARE idPu int (11);

		SET idPa = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);	
		SET idPu = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idPub);	
		
		SELECT pv.idTrack
        FROM `PartierVoteTrack` pv
        WHERE ( pv.idPartier=idPa and pv.idPub=idPu);


  END$$
DELIMITER //
 
 CREATE PROCEDURE getPlayList(idProfile INT(11),idPub INT(11))
    BEGIN
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idPub);

				SELECT EL.idTrack,EL.trackName,EL.trackArtist,EL.createdTime,EL.votes,EL.playing,V.idPartier AS VOTE
				FROM
				(
				SELECT d.idTrack,d.trackName,d.trackArtist,d.createdTime,d.votes,d.playing
				FROM `PlayLists` d 
				WHERE (d.idPub=idP)
				) EL LEFT JOIN
					`PartierVoteTrack` V ON (V.idPartier=idU
											AND V.idTrack=EL.idTrack)

				ORDER BY EL.votes DESC, EL.trackArtist ASC;
	END//
    
DELIMITER ;
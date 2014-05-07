DELIMITER //
 
 CREATE PROCEDURE getPlayList(idProfile INT(11))
    BEGIN
				SELECT d.idTrack,d.trackName,d.trackArtist,d.createdTime,d.votes,d.playing
				FROM `PlayLists` d ,`Pub` pb
				WHERE (pb.idProfile = idProfile and d.idPub=pb.idPub)
				ORDER BY d.votes DESC, d.trackArtist ASC;
	END//
    
DELIMITER ;
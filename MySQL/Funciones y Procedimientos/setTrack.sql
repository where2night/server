DELIMITER //
 
 CREATE PROCEDURE setTrack(idProf INT(11),name VARCHAR (40),artist VARCHAR(40))
    BEGIN
      DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProf);
		INSERT INTO `PlayLists` (`idPub`,`trackName`,`trackArtist`,`votes`,`playing`)
      VALUES (idP,name,artist,0,0);
   END//
    
DELIMITER ;
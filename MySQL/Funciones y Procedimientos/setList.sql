DELIMITER //
 
 CREATE PROCEDURE setList(idProf INT(11),title VARCHAR (40),about VARCHAR(200),dateL DATE,startHour TIME,closeHour TIME)
    BEGIN
      DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProf);
		INSERT INTO `Lists` (`idPub`,`title`,`about`,`date`,`startHour`,`closeHour`)
      VALUES (idP,title,about,dateL,startHour,closeHour);
   END//
    
DELIMITER ;
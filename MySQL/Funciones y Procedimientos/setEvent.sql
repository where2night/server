DELIMITER //
 
 CREATE PROCEDURE setEvent(idProf INT(11),title VARCHAR (40),about VARCHAR(200),dateEv DATE,startHour TIME,closeHour TIME)
    BEGIN
      INSERT INTO `Event` (`idProfileCreator`,`title`,`text`,`date`,`startHour`,`closeHour`)
      VALUES (idProf,title,about,dateEv,startHour,closeHour);
   END//
    
DELIMITER ;
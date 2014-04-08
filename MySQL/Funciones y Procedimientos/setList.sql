DELIMITER //
 
 CREATE PROCEDURE setList(idProf INT(11),title VARCHAR (40),about VARCHAR(200),dateL DATE,startHour TIME,closeHour TIME)
    BEGIN
      INSERT INTO `List` (`idPub`,`title`,`text`,`date`,`startHour`,`closeHour`)
      VALUES (idProf,title,about,dateL,startHour,closeHour);
   END//
    
DELIMITER ;
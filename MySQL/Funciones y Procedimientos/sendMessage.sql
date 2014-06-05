DELIMITER //
 
 CREATE PROCEDURE sendMessage(idProf1 INT(11),idProf2 INT(11),message VARCHAR (1000))
    BEGIN
     DECLARE idP1 int (11);
	 DECLARE idP2 int (11);
	 DECLARE idMes int (11);

		SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProf1);



		SET idP2 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProf2);		

		INSERT INTO `Messages` (`message`)
      VALUES (message);


		SET idMes = (SELECT max(m.idMessage)
					FROM `Messages` m
					);


      INSERT INTO `MessagesStatus` (`idMessage`,`idPartier1`,`idPartier2`,`mode`)
      VALUES (idMes,idP1,idP2,0);
      INSERT INTO `MessagesStatus` (`idMessage`,`idPartier1`,`idPartier2`,`mode`)
      VALUES (idMes,idP2,idP1,1);
   END//
    
DELIMITER ;
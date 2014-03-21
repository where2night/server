DELIMITER //
 
 CREATE FUNCTION setEvent(typePL INT,title VARCHAR (50),about VARCHAR(200),dateEv DATE,startHour TIME,closeHour TIME,id INT) RETURNS INT
    BEGIN
      INSERT INTO `Event` (`title`, `text`, `date`,`type`, `startHour`, `closeHour`)
    VALUES (title,about,dateEv,typePL,startHour,closeHour);

        UPDATE Event e
        SET
            e.idDJ = id
        WHERE(e.type = -1);

        UPDATE Event e
        SET
            e.idPub = id
        WHERE (e.type = 1);

            

  RETURN (SELECT p.idEvent
    FROM `Event`p);
  END//
    
DELIMITER ;
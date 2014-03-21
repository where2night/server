DELIMITER //
 
 CREATE FUNCTION setEvent(type INT,title VARCHAR (50),about VARCHAR(200),dateEv DATE,startHour TIME,closeHour TIME,id INT) RETURNS INT
    BEGIN
      INSERT INTO `Event` (`title`, `text`, `date`, `startHour`, `closeHour`)
    VALUES (title,about,dateEv,startHour,closeHour);

        UPDATE Event e
        SET
            e.idDJ = id
        WHERE(type = -1);

        UPDATE Event e
        SET
            e.idPub = id
        WHERE (type = 1);

            

  RETURN (SELECT p.idEvent
    FROM `Event`p);
  END//
    
DELIMITER ;
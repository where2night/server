DELIMITER //
 
 CREATE PROCEDURE `localsUser`(IN idProfile INT(11))
  BEGIN
				SELECT pb.idProfile
				FROM `Pub` pb, `PartierFollwsPub` pg, `Partier` p
				WHERE (pb.idPub = pg.idPub and p.idProfile = idProfile and pg.idPartier= p.idPartier)
				ORDER BY pb.localName ASC;
	END//
    
DELIMITER ;
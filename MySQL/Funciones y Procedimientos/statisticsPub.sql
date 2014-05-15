DELIMITER //
 
 CREATE PROCEDURE statisticsPub(idProfile INT(11))
    BEGIN
		DECLARE idP int(11);
		
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfile);

  		SELECT p.idPartier,p.picture, p.name, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about,p.mode,p.status				
        FROM `PartierGoToPub` PGTP, `Partier` p
        WHERE (PGTP.idPub = idP and PGTP.idPartier=p.idPartier)
     
		ORDER BY p.name ASC, p.surnames ASC;
	END//
    
DELIMITER ;
DELIMITER //
 
 CREATE PROCEDURE statisticsPub(idProfile INT(11))
    BEGIN
		DECLARE idP int(11);
		
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfile);

  		SELECT p.idProfile,p.picture, p.name, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about,p.mode,p.status,"0" AS modeP,"" AS num				
        FROM `PartierGoToPub` PGTP, `Partier` p
        WHERE (PGTP.idPub = idP and PGTP.idPartier=p.idPartier)
		
UNION ALL
		SELECT pa.idProfile,pa.picture, pa.name, pa.surnames, pa.birthdate, pa.gender, pa.music, pa.civil_state, pa.city, pa.drink, pa.about,pa.mode,pa.status,"1" AS modeP	,PIIP.num AS num			
        FROM `HowManyCheckIn` PIIP, `Partier` pa
        WHERE (PIIP.idPub = idP and PIIP.idPartier=pa.idPartier)
       
	
		ORDER BY modeP ASC,num DESC, name ASC, surnames ASC;
		   
	END//
    
DELIMITER ;
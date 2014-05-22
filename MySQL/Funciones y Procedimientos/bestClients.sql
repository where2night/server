DELIMITER //
CREATE PROCEDURE `bestClients`(idProfile INT) 
BEGIN
     	DECLARE idU int(11);

		SET idU = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);

		SELECT Count(*),p.idProfile,p.picture, p.name, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about,p.mode,p.status,"0" AS modeP
     	FROM `PartierIsInPub` PIIB, `Partier` p
     	WHERE (PIIB.idPub=idU and p.idPartier=PIIB.idPartier)
     	GROUP BY  p.idPartier;

     	
  END//
  DELIMITER ;
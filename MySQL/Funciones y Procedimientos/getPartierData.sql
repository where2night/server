DELIMITER //
 
 CREATE PROCEDURE getPartierData(IN idProfile INT)
    BEGIN
		SELECT p.picture, p.name, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about,p.mode,p.status
		FROM `Profile` pr, `Partier` p
		WHERE (pr.idProfile = idProfile);
	END//
    
DELIMITER ;
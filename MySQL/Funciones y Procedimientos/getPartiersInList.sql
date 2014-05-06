DELIMITER //
 
 CREATE PROCEDURE getPartiersInList(IN idList INT(11))
    BEGIN
		SELECT p.picture, p.name, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about,p.mode,p.status
		FROM `PartierIsInLists` pl, `Partier` p
		WHERE (pl.idLists = idList AND pl.idPartier=p.idPartier);
	END//
    
DELIMITER ;
DELIMITER //
 
 CREATE PROCEDURE getPartierData(IN idProfile INT)
    BEGIN
		SELECT p.nameDJ, p.name, p.surname, p.telephoneDJ, p.gender, p.birthdate,p.picture, p.music,p.about 
		FROM `Profile` pr, `DJ` p
		WHERE (pr.idProfile = idProfile);
	END//
    
DELIMITER ;
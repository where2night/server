DELIMITER //
 
 CREATE PROCEDURE getLocalData(IN idProfile INT)
    BEGIN
		SELECT p.companyNameLocal, p.localName, p.cif, p.poblationLocal, p.cpLocal, p.telephoneLocal, p.street, p.streetNameLocal, p.streetNumberLocal, p.music, p.entryPrice , p.drinkPrice, p.openingHours, p.closeHours, p.picture, p.about, p.facebook,p.twitter,p.instagram
		FROM `Profile` pr, `Pub` p
		WHERE (pr.idProfile = idProfile);
	END//
    
DELIMITER ;
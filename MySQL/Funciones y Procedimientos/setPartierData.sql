DELIMITER //
 
 CREATE PROCEDURE setPartierData(IN idProfile INT, IN picture VARCHAR(100), IN `name`VARCHAR(20), IN surnames VARCHAR(45), IN birthdate DATE, IN gender BOOL, IN music VARCHAR(20), IN civil_state VARCHAR(20), IN city VARCHAR(20), IN drink VARCHAR(20), IN about VARCHAR(200), IN facebook VARCHAR(50), IN twitter VARCHAR(15), IN instagram VARCHAR(30))
    BEGIN
		UPDATE Partier p
		SET p.picture = picture, 
		p.name = name,
		p.surnames = surnames, 
		p.birthdate = birthdate,
		p.gender = gender, 
		p.music = music,
		p.civil_state = civil_state,
		p.city = city,
		p.drink = drink,
		p.about = about,
		p.facebook = facebook,
        p.twitter = twitter,
        p.instagram = instagram


		WHERE (p.idProfile = idProfile);
	END//
    
DELIMITER ;
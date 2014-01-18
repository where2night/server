DELIMITER //

CREATE PROCEDURE insertGoogleUser(email VARCHAR(50))
    BEGIN
		INSERT INTO `User`
		VALUES (email,NULL,1,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END//
    
    DELIMITER ;
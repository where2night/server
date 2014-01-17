DELIMITER //

CREATE PROCEDURE insertNormalUser(email VARCHAR(50), pass VARCHAR(25))
    BEGIN
		INSERT INTO `User`
		VALUES (email,pass,-1,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END//
    
    DELIMITER ;
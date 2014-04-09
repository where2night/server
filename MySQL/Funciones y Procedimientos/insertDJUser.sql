DELIMITER //

CREATE PROCEDURE insertDJUser(email VARCHAR(50), pass VARCHAR(25))
    BEGIN
		INSERT INTO `User`
		VALUES (email,pass,-1,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (-1,email);

		INSERT INTO `DJ` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END//
    
    DELIMITER ;
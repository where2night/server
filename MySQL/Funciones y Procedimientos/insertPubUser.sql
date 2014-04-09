DELIMITER //

CREATE PROCEDURE insertPubUser(email VARCHAR(50), pass VARCHAR(50))
    BEGIN
		INSERT INTO `User`
		VALUES (email,pass,-1,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (1,email);

		INSERT INTO `Pub` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END//
    
    DELIMITER ;
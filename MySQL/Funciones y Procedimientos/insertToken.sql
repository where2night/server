DELIMITER //

CREATE PROCEDURE insertToken(IN email VARCHAR(50), IN tkn VARCHAR(45))
BEGIN
		UPDATE `User` u
		SET u.token= tkn
		WHERE u.email = email;

	END//

DELIMITER ;
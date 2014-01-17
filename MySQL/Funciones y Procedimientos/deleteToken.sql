DELIMITER //

CREATE PROCEDURE deleteToken(IN email VARCHAR(50))
BEGIN
		UPDATE `User` u
		SET u.token= NULL
		WHERE u.email = email;

	END//

DELIMITER ;
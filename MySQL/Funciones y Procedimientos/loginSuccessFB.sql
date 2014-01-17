
DELIMITER //

CREATE FUNCTION loginSuccessFB(email VARCHAR(50)) 
RETURNS BOOLEAN
BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = email) AND u.`type` = 0) = 1);
	END//


DELIMITER ;
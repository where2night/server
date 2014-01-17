 DELIMITER //
 
 CREATE FUNCTION userExists(usr VARCHAR(50)) RETURNS BOOLEAN
    BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE u.email = usr) = 1);
	END//
    
DELIMITER ;
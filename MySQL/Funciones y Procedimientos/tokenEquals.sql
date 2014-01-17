DELIMITER //
 
 CREATE FUNCTION tokenEquals(usr VARCHAR(50), tkn VARCHAR(45)) RETURNS BOOLEAN
    BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.token = tkn) = 1);
	END//
    
DELIMITER ;
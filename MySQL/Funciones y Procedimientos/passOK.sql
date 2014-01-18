DELIMITER //
 
 CREATE FUNCTION passOK(usr VARCHAR(50), pass VARCHAR(25)) RETURNS BOOLEAN
    BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.`password` = pass AND u.`type` = -1) = 1);
	END//
    
DELIMITER ;
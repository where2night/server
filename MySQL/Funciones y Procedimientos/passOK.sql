DELIMITER //
 
 CREATE FUNCTION passOK(usr VARCHAR(50), pass VARCHAR(25)) RETURNS BOOLEAN
    BEGIN
		RETURN (CASE 0 WHEN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.`password` = pass AND u.`type` = -1)) 
			THEN 0 		
			ELSE (SELECT idProfile 
					FROM `Profile` p 
					WHERE p.email = usr) END);
	END//
    
DELIMITER ;
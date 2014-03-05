DELIMITER //
 
 CREATE FUNCTION getTypeProfile(usr VARCHAR(50)) RETURNS INT
    BEGIN
		RETURN (SELECT p.type
				FROM `Profile` p
				WHERE (p.email = usr));
	END//
    
DELIMITER ;
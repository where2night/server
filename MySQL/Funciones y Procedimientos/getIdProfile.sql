DELIMITER //
 
 CREATE FUNCTION getIdProfile(usr VARCHAR(50)) RETURNS INT
    BEGIN
		RETURN (SELECT p.idProfile
				FROM `Profile` p
				WHERE (p.email = usr));
	END//
    
DELIMITER ;
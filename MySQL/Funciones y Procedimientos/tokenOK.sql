 DELIMITER //
 
 CREATE FUNCTION tokenOK(idUsr INT, tkn VARCHAR(45)) RETURNS BOOLEAN
    BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u, `Profile` p
				WHERE p.email = u.email AND p.idProfile = idUsr AND u.token = tkn) = 1);
	END//
    
DELIMITER ;
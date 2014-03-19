DELIMITER //
 
 CREATE FUNCTION getTypeProfile(IN idProfile INT) RETURNS INT
    BEGIN
    RETURN (SELECT p.type
        FROM `Profile` p
        WHERE (p.idProfile = idProfile));
  END//
    
DELIMITER ;
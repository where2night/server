DELIMITER //
 
 CREATE FUNCTION getIdProfilePub(idPub INT) RETURNS INT
    BEGIN
    RETURN (SELECT p.idProfile
        FROM `Pub` p
        WHERE (p.idPub = idPub));
  END//
    
DELIMITER ;
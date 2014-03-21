DELIMITER //
 
 CREATE FUNCTION getPubId(idProfile INT) RETURNS INT
    BEGIN
    RETURN (SELECT p.idPub
        FROM `Pub` p
        WHERE (p.idProfile = idProfile));
  END//
    
DELIMITER ;
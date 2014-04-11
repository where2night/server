DELIMITER //
 
 CREATE FUNCTION getIdPartier(idProfile INT) RETURNS INT
    BEGIN
    RETURN (SELECT p.idPartier
        FROM `Partier` p
        WHERE (p.idProfile = idProfile));
  END//
    
DELIMITER ;
DELIMITER //
 
 CREATE FUNCTION getDjId(idProfile INT) RETURNS INT
    BEGIN
    RETURN (SELECT p.idDj
        FROM `DJ` p
        WHERE (p.idProfile = idProfile));
  END//
    
DELIMITER ;
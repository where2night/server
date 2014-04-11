DELIMITER //
 
 CREATE FUNCTION getModeFollow(idPartier1 INT(11), idPartier2 INT(11)) RETURNS INT
    BEGIN
    RETURN (SELECT f.mode
        FROM `Friends` 
        WHERE ((f.idPartier1 = idPartier1 AND f.idPartier2=idPartier2) OR (f.idPartier1 = idPartier2 AND f.idPartier2=idPartier1));
  END//
    
DELIMITER ;
DELIMITER $$
 
 CREATE FUNCTION getModeFollow(idProfile1 INT(11), idProfile2 INT(11)) RETURNS INT
    BEGIN
    DECLARE idP1 int(11);
    DECLARE idP2 int(11);
    SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile1);
	SET idP2 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile2);

    RETURN (SELECT f.mode
        FROM `Friends` f
        WHERE ((f.idPartier1 = idP1 AND f.idPartier2=idP2) OR (f.idPartier1 = idP2 AND f.idPartier2=idP1)));
  
  END$$
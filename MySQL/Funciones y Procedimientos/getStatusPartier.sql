DELIMITER $$
 
 CREATE PROCEDURE getStatusPartier(idProfile1 INT(11))
    BEGIN 
 	DECLARE idP1 int(11);
   
    SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile1);

        SELECT pm.status
        FROM `PartierStatus` pm
        WHERE (pm.idPartier = idP1)
        ORDER BY pm.createdTime DESC
		LIMIT 0,1;
END$$
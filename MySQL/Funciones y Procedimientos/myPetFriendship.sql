DELIMITER $$
CREATE PROCEDURE `myPetFriendship`(idProfileP INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		
		SELECT p.idProfile
        FROM `Partier` p, `Friends` f
        WHERE (( (f.idPartier1 = idP)  AND (p.idPartier = f.idPartier2) ) and (f.mode=0));


  END$$
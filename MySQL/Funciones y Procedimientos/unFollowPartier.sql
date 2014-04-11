DELIMITER$$
CREATE PROCEDURE `unFollowPartier`(idPartier INT, idProfileUser INT)
BEGIN				
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPartier
					FROM `Partier` pu
					WHERE pu.idProfile = idPartier);

DELETE FROM  `Friends`
		WHERE ((idPartier1 = idU AND idPartier2= idP) OR (idPartier1 = idP AND idPartier2= idU));
END$$
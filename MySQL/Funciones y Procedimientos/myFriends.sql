DELIMITER $$
CREATE PROCEDURE `myFriends`(idPartier INT)
BEGIN
		(SELECT p.idProfile
        FROM `Partier` p, `Friends` f
        WHERE ( ( (f.idPartier1 = idPartier)  AND (p.idPartier = f.idPartier2) ) OR 
        	( (f.idPartier2 = idPartier)  AND (p.idPartier = f.idPartier1) )));

        

  END$$
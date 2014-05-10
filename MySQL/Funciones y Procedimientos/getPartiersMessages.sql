DELIMITER $$
CREATE PROCEDURE `getPartiersMessages`(idProfileP INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		


        SELECT DISTINCT p.idProfile
        FROM  `MessagesStatus` ms, `Partier` p
        WHERE (ms.idPartier1 = idP ) and (ms.idPartier2=p.idPartier) ;


  END$$

  DELIMITER ;
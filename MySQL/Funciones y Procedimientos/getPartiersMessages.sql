DELIMITER $$
CREATE PROCEDURE `getPartiersMessages`(idProfileP INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		


        SELECT DISTINCT ms.idPartier2
        FROM  `MessagesStatus` ms
        WHERE (ms.idPartier1 = idP ) ;


  END$$

  DELIMITER ;
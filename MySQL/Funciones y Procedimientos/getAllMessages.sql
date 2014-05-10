DELIMITER $$
CREATE PROCEDURE `getAllMessages`(idProfileP INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		


        SELECT m.message, m.createdTime, p.idProfile, ms.mode
        FROM `Messages` m, `MessagesStatus` ms, `Partier` p
        WHERE (ms.idPartier1 = idP ) and (ms.idMessage = m.idMessage) and (p.idPartier=  ms.idPartier2) ;


  END$$

  DELIMITER ;
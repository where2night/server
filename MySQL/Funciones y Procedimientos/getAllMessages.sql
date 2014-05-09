DELIMITER $$
CREATE PROCEDURE `getAllMessages`(idProfileP INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		


        SELECT m.message, m.createdTime, ms.idPartier2, ms.mode
        FROM `Messages` m, `MessagesStatus` ms
        WHERE (ms.idPartier1 = idP ) and (ms.idMessage = m.idMessage) ;


  END$$

  DELIMITER ;
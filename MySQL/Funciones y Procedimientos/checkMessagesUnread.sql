DELIMITER $$
CREATE PROCEDURE `checkMessagesUnread`(idProfileP INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		


        SELECT DISTINCT p.idProfile, p.name, p.surnames
        FROM  `MessagesStatus` ms, `Partier` p
        WHERE (ms.idPartier1 = idP ) and (ms.mode=1) and (p.idPartier=ms.idPartier2) ;


  END$$

  DELIMITER ;
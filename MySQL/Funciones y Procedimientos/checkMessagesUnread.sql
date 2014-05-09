DELIMITER $$
CREATE PROCEDURE `checkMessagesUnread`(idProfileP INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		


        SELECT  ms.idPartier2
        FROM  `MessagesStatus` ms
        WHERE (ms.idPartier1 = idP ) and ms.mode=1 ;


  END$$

  DELIMITER ;
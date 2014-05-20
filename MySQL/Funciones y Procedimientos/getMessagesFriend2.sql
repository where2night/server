DELIMITER $$
CREATE PROCEDURE `getMessagesFriend2`(idProfileP1 INT, idProfileP2 INT)
BEGIN
		DECLARE idP1 int (11);
		DECLARE idP2 int (11);

		SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP1);	

		SET idP2 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP2);	
		
       	SELECT m.message, m.createdTime, ms.mode
        FROM `Messages` m, `MessagesStatus` ms
        WHERE (ms.idPartier1 = idP1 and ms.idPartier2 = idP2) and (ms.idMessage = m.idMessage) ;


  END$$

  DELIMITER ;
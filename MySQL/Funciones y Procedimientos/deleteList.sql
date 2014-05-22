DELIMITER //

CREATE PROCEDURE deleteList(IN idList1 INT(11),IN idProfile INT(11))
BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);		
		
		DELETE FROM `PartierIsInLists`
		WHERE(idLists=idList1);
		DELETE FROM  `Lists` 
		WHERE (idLists = idList1 AND idPub = idP);
	END//

DELIMITER ;
DELIMITER $$
CREATE PROCEDURE `deleteOfList`(idList INT, idProfile INT)
BEGIN
	 DECLARE idP int (11);

	SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);
		
		DELETE FROM `PartierIsInLists`
		WHERE (idPartier = idP
				AND idLists = idList);	
  END$$
  
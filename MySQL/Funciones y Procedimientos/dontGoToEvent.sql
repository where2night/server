DELIMITER $$
CREATE PROCEDURE `dontGoToEvent`(idProfilePub INT, idProfileUser INT)
BEGIN
		
		DELETE FROM `PartierGoesToEvent`
		WHERE (idProfileUser = idPartier
				AND idEvent = idEventD);		
  END$$
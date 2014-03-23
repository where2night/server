DELIMITER $$
CREATE PROCEDURE `goToEvent`(idEvent INT, idProfileUser INT)
BEGIN
		
		
		SET @idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		INSERT INTO `PartierGoesToEvent` VALUES (@idU,idEvent);

		
  END$$
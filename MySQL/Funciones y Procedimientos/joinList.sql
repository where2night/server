DELIMITER $$
CREATE PROCEDURE `joinList`(idList INT, idProfileUser INT)
BEGIN
		
		
		SET @idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		INSERT INTO `PartierJoinedList` VALUES (@idU,idList);

		
  END$$
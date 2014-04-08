DELIMITER $$
CREATE PROCEDURE `JoinedList`(idList INT)
BEGIN
		(SELECT p.idProfile
        FROM `PartierJoinedList` pg, `Partier` p 
        WHERE (pg.idPartier = p.idPartier) AND (pg.idList = idList));
  END$$
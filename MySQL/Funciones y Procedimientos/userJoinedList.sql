DELIMITER $$
CREATE FUNCTION `userJoinedList`(idProfileP INT, idList INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierJoinedList` pg, `Partier` p 
        WHERE ((idProfileP = p.idProfile) AND (pg.idPartier = p.idPartier) AND (pg.idList = idList)) = 1);
  END$$
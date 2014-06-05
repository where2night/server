DELIMITER $$
CREATE FUNCTION `userJoinedList`(idProfile INT, idList INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierIsInList` pg, `Partier` p 
        WHERE ((p.idProfile=idProfile) AND (pg.idPartier = p.idPartier) AND (pg.idList = idList)) = 1)s;
  END$$
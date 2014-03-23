DELIMITER $$
CREATE FUNCTION `userGoesToEvent`(idProfileP INT, idEvent INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoesToEvent` pg, `Partier` p 
        WHERE ((idProfileP = p.idProfile) AND (pg.idPartier = p.idPartier) AND (pg.idEvent = idEvent)) = 1);
  END$$
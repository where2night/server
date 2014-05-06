DELIMITER $$
CREATE FUNCTION `howManyJoinedList`(idList INT) RETURNS INT
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierJoinedList` pg  
        WHERE (idList = pg.idList)) ;
  END$$
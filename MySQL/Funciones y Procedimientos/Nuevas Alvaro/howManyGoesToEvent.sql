DELIMITER $$
CREATE FUNCTION `howManyGoesToEvent`(idEvent INT) RETURNS INT
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoesToEvent` pg  
        WHERE (idEvent = pg.idEvent)) ;
  END$$
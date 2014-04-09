DELIMITER $$
CREATE FUNCTION `howManyFollowsDJ`(idProfileDJ INT) RETURNS INT
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsDJ` pf, `DJ` d 
        WHERE ((idProfileDJ = d.idProfile) AND (d.idDJ = pf.idDJ))) ;
  END$$
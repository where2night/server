DELIMITER $$
CREATE FUNCTION `howManyFollowsPub`(idProfilePub INT) RETURNS INT
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsPub` pf, `Pub` p 
        WHERE ((idProfilePub = p.idProfile) AND (p.idPub = pf.idPub))) ;
  END$$
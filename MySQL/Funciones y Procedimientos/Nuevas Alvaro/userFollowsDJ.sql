DELIMITER $$
CREATE FUNCTION `userFollowsDJ`(idProfileP INT, idProfileDJ INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsDJ` pf, `Partier` p, `DJ` d 
        WHERE ((idProfileP = p.idProfile) AND (d.idProfile = idProfileDJ) AND (pf.idPartier = p.idPartier) AND (pf.idDJ = d.idDJ)) = 1);
  END$$
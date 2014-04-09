DELIMITER $$
CREATE FUNCTION `userGoesToPub`(idProfileP INT, idProfilePub INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoToPub` pf, `Partier` p, `Pub` d 
        WHERE ((idProfileP = p.idProfile) AND (d.idProfile = idProfilePub) AND (pf.idPartier = p.idPartier) AND (pf.idPub = d.idPub)) = 1);
  END$$
DELIMITER $$
CREATE PROCEDURE `DJFollowers`(idProfileDJ INT)
BEGIN
		(SELECT p.idProfile
        FROM `PartierFollowsDJ` pf, `DJ` d, `Partier` p 
        WHERE (d.idProfile = idProfileDJ) AND (d.idDJ = pf.idDJ) AND (pf.idPartier = p.idPartier));
  END$$
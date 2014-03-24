DELIMITER $$
CREATE PROCEDURE `PubFollowers`(idProfilePub INT)
BEGIN
		(SELECT p.idProfile
        FROM `PartierFollowsPub` pf, `Pub` d, `Partier` p 
        WHERE (d.idProfile = idProfilePub) AND (d.idPub = pf.idPub) AND (pf.idPartier = p.idPartier));
  END$$
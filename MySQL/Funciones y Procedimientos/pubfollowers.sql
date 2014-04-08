DELIMITER //
 
 CREATE PROCEDURE pubFollowers(idProfilePub INT(11))
  BEGIN
		SELECT *
        FROM `PartierFollowsPub` pf, `Pub` d, `Partier` p 
        WHERE ((d.idProfile = idProfilePub) AND (d.idPub = pf.idPub) AND (pf.idPartier = p.idPartier));
END
    
DELIMITER ;
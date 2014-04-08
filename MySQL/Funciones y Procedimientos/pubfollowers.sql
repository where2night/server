DELIMITER //
 
 CREATE PROCEDURE pubfollowers(idProfile INT(11))
    BEGIN
				SELECT d.idPartier
				FROM `PartierFollowsPub` d 
				WHERE (d.idPub = idProfile);
	END//
    
DELIMITER ;
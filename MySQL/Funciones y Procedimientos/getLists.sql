DELIMITER //
 
 CREATE PROCEDURE getLists(idProfile INT(11))
    BEGIN
				SELECT *
				FROM `List` d 
				WHERE (d.idPub = idProfile)
				ORDER BY d.createdTime DESC;
	END//
    
DELIMITER ;
DELIMITER //
 
 CREATE PROCEDURE getListData(IN idList INT(11),IN idProfile INT(11))
    BEGIN
		SELECT p.title, p.text, p.date, p.startHour, p.closeHour, p.createdTime
		FROM `List` p
		WHERE (p.idList = idList AND p.idPub = idProfile);
	END//
    
DELIMITER ;
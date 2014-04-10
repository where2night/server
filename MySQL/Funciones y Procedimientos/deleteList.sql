DELIMITER //

CREATE PROCEDURE deleteList(IN idList1 INT(11),IN idProfile1 INT(11))
BEGIN
		DELETE FROM  `List`
		WHERE (idList = idList1 AND idPub = idProfile1);

	END//

DELIMITER ;
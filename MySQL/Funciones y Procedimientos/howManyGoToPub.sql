DELIMITER $$
CREATE FUNCTION `howManyGoToPub`(idProfilePub INT) RETURNS INT
BEGIN
    DECLARE idP int(11);

	SET idP = (SELECT pu.idPub
				FROM `Pub` pu
				WHERE pu.idProfile = idProfilePub);



    RETURN (SELECT Count(*)
        FROM `PartierGoToPub` p  
        WHERE (idP = p.idPub)) ;
  END$$

    DELIMITER ;
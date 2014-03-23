DELIMITER $$
CREATE PROCEDURE `EventAssistants`(idEvent INT)
BEGIN
		(SELECT p.idProfile
        FROM `PartierGoesToEvent` pg, `Partier` p 
        WHERE (pg.idPartier = p.idPartier) AND (pg.idEvent = idEvent));
  END$$
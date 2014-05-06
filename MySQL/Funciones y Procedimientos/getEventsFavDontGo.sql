DELIMITER $$
CREATE PROCEDURE `getEventsFavDontGo`(idProfile INT)
BEGIN
		SELECT DISTINCT e.idEvent, e.idProfileCreator, e.title, e.text, e.date, e.startHour, e.closeHour,pb.streetNameLocal,pb.streetNumberLocal,pb.street,pb.poblationLocal
        FROM `Event` e, `PartierFollowsPub` pf, `PartierGoesToEvent` pg, `Partier` p, `Pub`pb
        WHERE (pb.idPub=e.idProfileCreator and p.idProfile=idProfile and p.idPartier=pf.idPartier and pf.idPub=e.idProfileCreator and 
               (e.idEvent NOT IN (SELECT ev.idEvent
                                    FROM `Event` ev, `PartierGoesToEvent` pgv, `Partier` pv
									WHERE (ev.idEvent = pgv.idEvent and pv.idProfile = idProfile and pgv.idPartier= pv.idPartier)
				)) )
		ORDER BY e.date ASC;

          END$$
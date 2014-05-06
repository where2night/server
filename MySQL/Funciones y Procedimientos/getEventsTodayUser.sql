-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getEventsTodayUser`(IN `idProfileUser` INT)
BEGIN 
DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		
			SELECT idU , P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, E.idEvent, E.title, E.text, E.date, E.startHour, E.closeHour, PGTE.createdTime
			FROM    `Partier` PF,  `Event` E, `PartierGoesToEvent` PGTE, `Pub` P
			WHERE		 PF.idPartier = idU
			AND PGTE.idEvent = E.idEvent
			AND PGTE.idPartier = idU
			AND E.idProfileCreator = P.idPub
			AND E.date = CURRENT_Date 
             ORDER BY E.startHour asc;
													
  END
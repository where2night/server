DELIMITER //
CREATE PROCEDURE `getNews`(IN idProfileUser INT)
BEGIN
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SELECT PLE.localName, PLE.picture, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour, PLE.createdTime,  "1" AS 
		TYPE , PGTE.idPartier AS GOES
		FROM (
			SELECT P.localName, P.picture, e.idEvent, e.title, e.text, e.date, e.startHour, e.closeHour, e.createdTime,  "1" AS 
			TYPE 
			FROM  `PartierFollowsPub` PFP,  `Event` e,  `Pub` P
			WHERE PFP.idPartier = idU
			AND e.idProfileCreator = PFP.idPub
			AND P.idPub = PFP.idPub
			)PLE
			LEFT JOIN  `PartierGoesToEvent` PGTE ON ( PGTE.idPartier = idU
													AND PGTE.idEvent = PLE.idEvent );
													
  END
 DELIMITER;
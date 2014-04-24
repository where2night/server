DELIMITER //
CREATE PROCEDURE `myNews`(IN idProfileUser INT)
BEGIN
	DECLARE idP int (11);
	SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);
		select * from
		(
			(SELECT PGTE.idPartier,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,"0" as idPartierFriend, "0" as name, "0" as surnames,"0" as mode,"0" as status, PLE.createdTime,  "1" AS 
		TYPE , PGTE.idPartier AS GOES
		FROM (
			SELECT P.idProfile, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, e.idEvent, e.title, e.text, e.date, e.startHour, e.closeHour, e.createdTime,  "1" AS 
			TYPE 
			FROM  `PartierFollowsPub` PFP,  `Event` e,  `Pub` P
			WHERE PFP.idPartier = idU
			AND e.idProfileCreator = PFP.idPub
			AND P.idPub = PFP.idPub
			)PLE
			LEFT JOIN  `PartierGoesToEvent` PGTE ON ( PGTE.idPartier = idU
													AND PGTE.idEvent = PLE.idEvent )) 
UNION ALL
													
													
		(SELECT F.idPartier1 as idPartier,P.idProfile as idProfileLocal, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, "0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour, "0" as closeHour, PF.idPartier as idPartierFriend, PF.name, PF.surnames,"0" as mode,"0" as status,  PFP.createdTime, "4" AS TYPE, NULL AS GOES
			FROM  `Friends` F,  `PartierFollowsPub` PFP,  `Pub` P,  `Partier` PF
			WHERE F.idPartier1 = idU
			AND F.mode = 1
			AND PFP.idPartier = F.idPartier2
			AND PF.idPartier = F.idPartier2
			AND PFP.idPub = P.idPub) 
			
UNION ALL

		(SELECT F.idPartier1 AS idPartier,"0",  "0",  "0",  "0",  "0",  "0", "0" as idEvent,  "0" AS title,  "0" AS text,  "0" AS date,  "0" AS startHour,  "0" AS closeHour, P.idPartier AS idPartierFriend, P.name, P.surnames, PM.mode,"0" as status, PM.createdTime,  "3" AS TYPE , NULL AS GOES
			FROM  `Friends` F,  `Partier` P,  `PartierMode` PM
			WHERE F.idPartier1 = idU
			AND F.mode =1
			AND P.idPartier = F.idPartier2
			AND F.idPartier2 = PM.idPartier)
			
UNION ALL

		(SELECT F.idPartier1 AS idPartier,"0",  "0",  "0",  "0",  "0",  "0", "0" as idEvent,  "0" AS title,  "0" AS text,  "0" AS date,  "0" AS startHour,  "0" AS closeHour, P.idPartier AS idPartierFriend, P.name, P.surnames,"0" as mode, PS.status, PS.createdTime,  "2" AS TYPE , NULL AS GOES
			FROM  `Friends` F,  `Partier` P,  `PartierStatus` PS
			WHERE F.idPartier1 = idU
			AND F.mode = 1
			AND P.idPartier = F.idPartier2
			AND F.idPartier2 = PS.idPartier)
			
UNION ALL

(SELECT PLE.idPartier,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE , PGTE.idPartier AS GOES	
		
		FROM(
			SELECT F.idPartier1 AS idPartier, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, E.idEvent, E.title, E.text, E.date, E.startHour, E.closeHour,  PF.idPartier AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PGTE.createdTime,  "5" AS TYPE , PGTE.idPartier AS GOES
			FROM  `Friends` F,  `Partier` PF,  `Event` E, `PartierGoesToEvent` PGTE, `Pub` P
			WHERE F.idPartier1 = idU
			AND F.mode = 1
			AND PF.idPartier = F.idPartier2
			AND F.idPartier2 = PGTE.idPartier
			AND PGTE.idEvent = E.idEvent
			AND E.idProfileCreator = P.idPub) PLE
			LEFT JOIN  `PartierGoesToEvent` PGTE ON ( PGTE.idPartier = idU
													AND PGTE.idEvent = PLE.idEvent )) ) T
													
			ORDER BY T.createdTime desc
													
  END
 DELIMITER;
 
 

			
			

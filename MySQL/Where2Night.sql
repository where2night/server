-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 05-06-2014 a las 16:44:59
-- Versión del servidor: 5.1.70-cll
-- Versión de PHP: 5.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `Where2NightDev`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`where2`@`localhost` PROCEDURE `acceptFriend`(IN `idProfileP1` INT(11), IN `idProfileP2` INT(11))
BEGIN
    DECLARE idP int (11);
    DECLARE idP1 int (11);

	SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP1);

	SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP2);
    
		UPDATE Friends f
		SET 
			f.mode = '1'
		WHERE ((f.idPartier1 = idP AND f.idPartier2 = idP1)OR(f.idPartier1 = idP1 AND f.idPartier2 = idP));
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `checkIn`(IN `idProfilePartier` INT, IN `idProfileLocal` INT, IN `in` INT)
    NO SQL
BEGIN
		DECLARE idU int(11);

		DECLARE idP int(11);
		
		
		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfilePartier);

		SET idP = (SELECT a.idPub
					FROM `Pub` a
					WHERE a.idProfile = idProfileLocal);

	INSERT INTO `PartierIsInPub` (`idPartier`,`idPub`, `inside`) VALUES (`idU`,`idP`,`in`);

	



		
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `checkMessagesUnread`(IN `idProfileP` INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		


        SELECT DISTINCT  p.idProfile, p.name, p.surnames
        FROM  `MessagesStatus` ms, `Partier` p
        WHERE (ms.idPartier1 = idP ) and (ms.mode=1) and (p.idPartier=ms.idPartier2) ;

  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteAllPartier`(IN `idProf` INT)
BEGIN
	 DECLARE idP int (11);
	 DECLARE email2 varchar (50);

	SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProf);

	SET email2 = (SELECT p.email
					FROM `Profile` p
					WHERE p.idProfile = idProf);
		
		
        DELETE FROM `Fotos`
		WHERE (idProfile = idProf);	

        DELETE FROM `Friends`
		WHERE (idPartier1 = idP or idPartier2=idP);	

		DELETE FROM `HowManyCheckIn` 
		WHERE (idPartier = idP);	

    
     /*   DELETE FROM `Messages` 
		WHERE (select idMessage 
			   from 'MessagesStatus' ms
               where (ms.idPartier1 = idP or ms.idPartier2=idP))= idMessage;	*/
        

        DELETE FROM `MessagesStatus` 
		WHERE (idPartier1 = idP or idPartier2=idP);	
        
        DELETE FROM `Partier` 
		WHERE (idPartier = idP);	

		DELETE FROM `PartierFollowsPub` 
		WHERE (idPartier = idP);	
        
    /*  DELETE FROM `PartierGoesToEvent` 
		WHERE (idPartier = idP);

		DELETE FROM `PartierGoToPub` 
		WHERE (idPartier = idP);

		DELETE FROM `PartierIsInLists` 
		WHERE (idPartier = idP);	
  
        DELETE FROM `PartierIsInPub` 
		WHERE (idPartier = idP);
        DELETE FROM `PartierMode` 
		WHERE (idPartier = idP);	
 
        DELETE FROM `PartierStatus` 
		WHERE (idPartier = idP);	

        DELETE FROM `PartierVoteTrack` 
		WHERE (idPartier = idP);	 */


        DELETE FROM `Profile` 
		WHERE (idProfile = idProf);

        DELETE FROM `User`
		WHERE (email = email2);  


  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteAllPub`(IN `idProf` INT)
BEGIN
	 DECLARE idP int (11);
	 DECLARE email2 varchar (50);

	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProf);

	SET email2 = (SELECT p.email
					FROM `Profile` p
					WHERE p.idProfile = idProf);


		
        DELETE FROM `Event`
		WHERE (idProfileCreator = idP);

        DELETE FROM `Fotos` 
		WHERE (idProfile = idProf);	

		DELETE FROM `HowManyCheckIn` 
		WHERE (idPub = idP);	
   
        DELETE FROM `Lists` 
		WHERE (idPub = idP);	

		DELETE FROM `LocalPhotos` 
		WHERE (idLocal = idProf);

		DELETE FROM `PartierFollowsPub`
		WHERE (idPub = idP);	
        
		DELETE FROM `PartierGoToPub` 
		WHERE (idPub = idP);
  
        DELETE FROM `PartierIsInPub` 
		WHERE (idPub = idP);	

        DELETE FROM `PartierVoteTrack` 
		WHERE (idPub = idP);

		DELETE FROM `PlayList` 
		WHERE (idPub = idP);	

		DELETE FROM `Pub`
		WHERE (idPub = idP);

        DELETE FROM `Profile`
		WHERE (idProfile = idProf);

        DELETE FROM `User`
		WHERE (email = email2);  


  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteEvent`(IN `idEv` INT(11), IN `idProf` INT(11))
BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProf);

		DELETE FROM `PartierGoesToEvent`
		WHERE (idEvent = idEv);

		DELETE FROM  `Event`
		WHERE (idProfileCreator=idP and idEvent=idEv);

	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteList`(IN `idList1` INT(11), IN `idProfile` INT(11))
BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);		

		DELETE FROM `PartierIsInLists`
		WHERE(idLists=idList1);
		DELETE FROM  `Lists` 
		WHERE (idLists = idList1 AND idPub = idP);

	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteOfList`(idList INT, idProfile INT)
BEGIN
	 DECLARE idP int (11);

	SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);
		
		DELETE FROM `PartierIsInLists`
		WHERE (idPartier = idP
				AND idLists = idList);		
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `deletePhotoLocal`(IN `idLocal` INT(11), IN `Photo` INT(11))
    NO SQL
BEGIN

		DECLARE idP int(11);
		

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idLocal);

		DELETE FROM `Where2NightDev`.`LocalPhotos` 
			WHERE `LocalPhotos`.`idPhoto` = Photo and `LocalPhotos`.`idLocal`  = idP;


	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteToken`(IN email VARCHAR(50))
BEGIN
    UPDATE `User` u
    SET u.token= NULL
    WHERE u.email = email;

  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteTrack`(IN `idProfile` INT(11), IN `idTrack1` INT(11))
BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);		
		
		DELETE FROM `PartierVoteTrack`
		WHERE(idTrack=idTrack1 and idPub=idP);
		DELETE FROM  `PlayList` 
		WHERE (idTrack = idTrack1 AND idPub = idP);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `deleteVote`(IN `idProfile` INT(11), IN `idPub1` INT(11), IN `idTrack1` INT(11))
BEGIN
		DECLARE idPa int(11);
		DECLARE idPu int(11);
   
    	SET idPa = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);	
   
    	SET idPu = (SELECT pb.idPub
					FROM `Pub` pb
					WHERE pb.idProfile = idPub1);		
		
		DELETE FROM `PartierVoteTrack`
		WHERE (idTrack = idTrack1 AND idPartier=idPa AND idPub = idPu);
		
		UPDATE PlayList pl
		SET 
			pl.votes = pl.votes-1
		
		WHERE (pl.idTrack = idTrack1 AND pl.idPub = idPu);
end$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `DJFollowers`(idProfileDJ INT)
BEGIN
		(SELECT p.idProfile
        FROM `PartierFollowsDJ` pf, `DJ` d, `Partier` p 
        WHERE (d.idProfile = idProfileDJ) AND (d.idDJ = pf.idDJ) AND (pf.idPartier = p.idPartier));
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `dontGoToEvent`(IN `idProfileUser` INT(11), IN `idEventD` INT(11))
BEGIN
		DECLARE idP int(11);
		DECLARE idPub int(11);
		DECLARE d date;
		
		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);
		SET idPub = (SELECT e.idProfileCreator
					FROM `Event` e
					WHERE e.idEvent = idEventD);
		SET d = (SELECT e.date
					FROM `Event` e
					WHERE e.idEvent = idEventD);

		
		DELETE FROM `PartierGoesToEvent`
		WHERE ( idPartier = idP
				AND idEvent = idEventD);
				
				
		DELETE FROM `PartierGoToPub`
		WHERE ( idPartier = idP
				AND idPub = idPub AND assistdate= d);
				
				
END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `dontGoToPub`(IN `idProfileUser` INT(11), IN `idProfilePub` INT(11), IN `d` DATE)
BEGIN
		
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfilePub);

					
		DELETE FROM `PartierGoToPub` 
		WHERE (idPub=idP AND idPartier=idU AND assistDate= d);

		
	
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `EventAssistants`(idEvent INT)
BEGIN
		(SELECT p.idProfile
        FROM `PartierGoesToEvent` pg, `Partier` p 
        WHERE (pg.idPartier = p.idPartier) AND (pg.idEvent = idEvent));
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `eventsUser`(IN `idProfile` INT(11))
BEGIN
				

				SELECT e.idEvent, e.idProfileCreator, e.title, e.text, e.date, e.startHour, e.closeHour,e.createdTime,pb.streetNameLocal,pb.streetNumberLocal,pb.street,pb.poblationLocal
				FROM `Event` e, `PartierGoesToEvent` pg, `Partier` p,`Pub` pb
				WHERE (pb.idPub=e.idProfileCreator and e.idEvent = pg.idEvent and p.idProfile=idProfile and pg.idPartier= p.idPartier)
				ORDER BY e.date ASC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `followDJ`(IN `idProfileDJ` INT, IN `idProfileUser` INT)
BEGIN

		DECLARE idD int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idD = (SELECT d.idDJ
					FROM `DJ` d
					WHERE d.idProfile = idProfileDJ);

		INSERT INTO `PartierFollowsDJ` VALUES (idU,idD);
		
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `followPartier`(IN `idProfile` INT, IN `idPartier` INT)
BEGIN

		DECLARE idD int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);

		SET idD = (SELECT d.idPartier
					FROM `Partier` d
					WHERE d.idProfile = idPartier);
		

		INSERT INTO `Friends`(`idPartier1`,`idPartier2`,`mode`) 
				VALUES (idU,idD,0), (idD,idU,4);
		
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `followPub`(IN `idProfilePub` INT, IN `idProfileUser` INT)
BEGIN
		
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfilePub);

		INSERT INTO `PartierFollowsPub` VALUES (idU,idP,null);

		
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `friendship`(IN `idProfileP` INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		
		SELECT p.idProfile
        FROM `Partier` p, `Friends` f
        WHERE ((( (f.idPartier1 = idP)  AND (p.idPartier = f.idPartier2) )) and (f.mode=4));


  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getAllMessages`(IN `idProfileP` INT)
BEGIN
		
DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		


      SELECT m.message, m.createdTime, pa.idProfile, ms.mode
        FROM `Messages` m, `MessagesStatus` ms, `Partier` pa
        WHERE ((ms.idPartier1 = idP ) and (m.idMessage = ms.idMessage) and (pa.idPartier=  ms.idPartier2))
		ORDER BY  pa.idProfile ASC,m.createdTime ASC;
END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getDJData`(IN `idProfile` INT)
BEGIN
    SELECT p.nameDJ, p.name, p.surname, p.telephoneDJ, p.gender, p.birthdate,p.picture, p.music,p.about 
    FROM `Profile` pr, `DJ` p
    WHERE (pr.idProfile = idProfile) AND (pr.idProfile = p.idProfile);
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getDjs`()
BEGIN
				SELECT d.idProfile, d.nameDJ, d.picture, d.music
				FROM `DJ` d 
				ORDER BY d.nameDJ ASC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getEventData`(IN `idEvent` INT(11), IN `idProfile` INT(11))
BEGIN

		DECLARE idP int(11);
		

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfile);
		
		SELECT p.title, p.text, p.date, p.startHour, p.closeHour, p.createdTime
		FROM `Event` p
		WHERE (p.idEvent = idEvent AND p.idProfileCreator = idP);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getEvents`(IN `idProfile` INT(11), IN `idPub` INT(11))
BEGIN
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idPub);

		select EL.idEvent, EL.idProfileCreator, EL.title, EL.text, EL.date, EL.startHour, EL.closeHour, EL.createdTime, PGTE.idPartier AS GOES 	
		from
		(
            SELECT e.idEvent, e.idProfileCreator, e.title, e.text, e.date, e.startHour, e.closeHour, e.createdTime
				FROM `Event` e 
				WHERE (e.idProfileCreator = idP)
         ) EL LEFT JOIN
			`PartierGoesToEvent` PGTE ON( PGTE.idPartier = idU
										AND PGTE.idEvent = EL.idEvent )
			
		ORDER BY EL.createdTime DESC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getEventsFavDontGo`(IN `idProfile` INT)
BEGIN 
		SELECT DISTINCT e.idEvent, e.idProfileCreator, e.title, e.text, e.date, e.startHour,e.createdTime, e.closeHour,pb.streetNameLocal,pb.streetNumberLocal,pb.street,pb.poblationLocal
        FROM `Event` e, `PartierFollowsPub` pf, `PartierGoesToEvent` pg, `Partier` p, `Pub`pb
        WHERE (pb.idPub=e.idProfileCreator and p.idProfile=idProfile and p.idPartier=pf.idPartier and pf.idPub=e.idProfileCreator and 
               (e.idEvent NOT IN (SELECT ev.idEvent
                                    FROM `Event` ev, `PartierGoesToEvent` pgv, `Partier` pv
									WHERE (ev.idEvent = pgv.idEvent and pv.idProfile = idProfile and pgv.idPartier= pv.idPartier)
				)) )
		ORDER BY e.date ASC;

          END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getEventsTodayUser`(IN `idProfileUser` INT)
    NO SQL
BEGIN 
DECLARE idU int(11);
DECLARE idP int(11);
DECLARE idE int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		
			SET idP=(SELECT p.idPub FROM `PartierGoToPub` p 
				where 
						p.idPartier=idU and 
						p.assistdate = CURRENT_Date 
				ORDER BY p.assistDate asc LIMIT 1);

				
		select P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal,P.latitude,P.longitude
		FROM `Pub` P
		where P.idPub = idP;
													
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getListData`(IN `idList` INT(11), IN `idProfile` INT(11))
BEGIN
		DECLARE idP int(11);
   
   		 SET idP = (SELECT pb.idPub
					FROM `Pub` pb
					WHERE pb.idProfile = idProfile);
		SELECT p.title, p.about, p.date, p.startHour, p.closeHour, p.dateClose, p.maxGuest, p.createdTime
		FROM `Lists` p
		WHERE (p.idLists = idList AND p.idPub = idP);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getLists`(IN `idProfile` INT(11), IN `idPub` INT(11))
BEGIN
    	DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idPub);
				
				SELECT EL.idLists,EL.title,EL.about,EL.dateClose,EL.maxGuest,EL.createdTime,EL.date,EL.startHour,EL.closeHour,PGTE.idPartier AS GOES
				FROM 
				(
					SELECT d.idLists,d.title,d.about,d.createdTime,d.date,d.startHour,d.closeHour,d.dateClose,d.maxGuest
					FROM `Lists` d 
					WHERE ( d.idPub = idP)
				) EL 
				LEFT JOIN
					`PartierIsInLists` PGTE ON( PGTE.idPartier = idU
												AND PGTE.idLists=EL.idLists)

				ORDER BY EL.createdTime DESC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getLocalData`(IN `idProfile` INT)
BEGIN
    SELECT p.companyNameLocal, p.localName, p.cif, p.poblationLocal, p.cpLocal, p.telephoneLocal, p.street, p.streetNameLocal, p.streetNumberLocal, p.latitude, p.longitude, p.music, p.entryPrice , p.drinkPrice, p.openingHours, p.closeHours, p.picture, p.about, p.facebook, p.twitter, p.instagram,p.createdTime 
    FROM `Profile` pr, `Pub` p
    WHERE (pr.idProfile = idProfile) AND (pr.idProfile = p.idProfile);
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getLocalPhotos`(IN `idProfile` INT(11))
    NO SQL
BEGIN
		DECLARE idP int(11);
		
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfile);
				
		SELECT *
				FROM `LocalPhotos`  
				WHERE (idLocal = idP)
				ORDER BY createdTime DESC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getLocals`()
BEGIN
				SELECT d.idProfile, d.localName, d.telephoneLocal, d.street, d.streetNameLocal, d.streetNumberLocal, d.latitude, d.longitude, d.picture
				FROM `Pub` d 
				ORDER BY d.localName ASC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getMessagesFriend`(IN `idProfileP1` INT, IN `idProfileP2` INT)
BEGIN
		DECLARE idP1 int (11);
		DECLARE idP2 int (11);

		SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP1);	

		SET idP2 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP2);	
		
        UPDATE MessagesStatus ms
		SET ms.mode = 2
		WHERE (((ms.idPartier1 = idP1) and (ms.idPartier2 = idP2))and (ms.mode=1));	



		SELECT   m.message, m.createdTime, ms.mode
        FROM `Messages` m, `MessagesStatus` ms
        WHERE (ms.idPartier1 = idP1 and ms.idPartier2 = idP2) and (ms.idMessage = m.idMessage) ;

        


  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getMessagesFriend2`(idProfileP1 INT, idProfileP2 INT)
BEGIN
		DECLARE idP1 int (11);
		DECLARE idP2 int (11);

		SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP1);	

		SET idP2 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP2);	
		
       	SELECT m.message, m.createdTime, ms.mode
        FROM `Messages` m, `MessagesStatus` ms
        WHERE (ms.idPartier1 = idP1 and ms.idPartier2 = idP2) and (ms.idMessage = m.idMessage) ;


  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getModePartier`(IN `idProfile1` INT(11))
BEGIN
    DECLARE idP1 int(11);
   
    SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile1);

        SELECT pm.mode
        FROM `PartierMode` pm
        WHERE (pm.idPartier = idP1)
        ORDER BY pm.createdTime DESC
		LIMIT 0,1;
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getNews`(IN `idProfileUser` INT)
BEGIN 
		DECLARE idU int(11);
		
		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

select * from(
    
    
(SELECT PGTE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,"0" as dateClose,"0" as maxGuest ,"0" as idPartierFriend, "0" as name, "0" as surnames,"0" as mode,"0" as status, PLE.createdTime,  "1" AS TYPE , "0" as assistdate,"0" as inside,PGTE.idPartier AS GOES
 FROM (
			SELECT P.idProfile,P.idPub as idPub, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, e.idEvent, e.title, e.text, e.date, e.startHour, e.closeHour, e.createdTime,  "1" AS 
			TYPE 
			FROM  `PartierFollowsPub` PFP,  `Event` e,  `Pub` P
			WHERE PFP.idPartier = idU
			AND e.idProfileCreator = PFP.idPub
			AND P.idPub = PFP.idPub
			)PLE
LEFT JOIN  `PartierGoesToEvent` PGTE ON ( PGTE.idPartier = idU
													AND PGTE.idEvent = PLE.idEvent )) 
UNION ALL
													
													
		(SELECT F.idPartier1 as idPartier,P.idPub as idPub,P.idProfile as idProfileLocal, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, "0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour, "0" as closeHour,"0" as dateClose,"0" as maxGuest , PF.idProfile as idPartierFriend, PF.name, PF.surnames,"0" as mode,"0" as status,  PFP.createdTime, "4" AS TYPE,"0" as assistdate,"0" as inside, NULL AS GOES
			FROM  `Friends` F,  `PartierFollowsPub` PFP,  `Pub` P,  `Partier` PF
			WHERE F.idPartier1 = idU
			AND F.mode = 1
			AND PFP.idPartier = F.idPartier2
			AND PF.idPartier = F.idPartier2
			AND PFP.idPub = P.idPub) 
			
UNION ALL

		(SELECT F.idPartier1 AS idPartier,"0","0",  "0", P.picture ,  "0",  "0",  "0", "0" as idEvent,  "0" AS title,  "0" AS text,  "0" AS date,  "0" AS startHour,  "0" AS closeHour,"0" as dateClose,"0" as maxGuest , P.idProfile AS idPartierFriend, P.name, P.surnames, PM.mode,"0" as status, PM.createdTime,  "3" AS TYPE , "0" as assistdate,"0" as inside,NULL AS GOES
			FROM  `Friends` F,  `Partier` P,  `PartierMode` PM
			WHERE F.idPartier1 = idU
			AND F.mode =1
			AND P.idPartier = F.idPartier2
			AND F.idPartier2 = PM.idPartier)
			
UNION ALL

		(SELECT F.idPartier1 AS idPartier,"0","0",  "0",  P.picture,  "0",  "0",  "0", "0" as idEvent,  "0" AS title,  "0" AS text,  "0" AS date,  "0" AS startHour,  "0" AS closeHour,"0" as dateClose,"0" as maxGuest , P.idProfile AS idPartierFriend, P.name, P.surnames,"0" as mode, PS.status, PS.createdTime,  "2" AS TYPE , "0" as assistdate,"0" as inside,NULL AS GOES
			FROM  `Friends` F,  `Partier` P,  `PartierStatus` PS
			WHERE F.idPartier1 = idU
			AND F.mode = 1
			AND P.idPartier = F.idPartier2
			AND F.idPartier2 = PS.idPartier)
			
UNION ALL

(SELECT PLE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,"0" as dateClose,"0" as maxGuest ,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE ,"0" as assistdate,"0" as inside, PGTE.idPartier AS GOES	
		
		FROM(
			SELECT F.idPartier1 AS idPartier,P.idPub as idPub, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, E.idEvent, E.title, E.text, E.date, E.startHour, E.closeHour,  PF.idProfile AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PGTE.createdTime,  "5" AS TYPE ,"0" as assistdate,"0" as inside, PGTE.idPartier AS GOES
			FROM  `Friends` F,  `Partier` PF,  `Event` E, `PartierGoesToEvent` PGTE, `Pub` P
			WHERE F.idPartier1 = idU
			AND F.mode = 1
			AND PF.idPartier = F.idPartier2
			AND F.idPartier2 = PGTE.idPartier
			AND PGTE.idEvent = E.idEvent
			AND E.idProfileCreator = P.idPub) PLE
			LEFT JOIN  `PartierGoesToEvent` PGTE ON ( PGTE.idPartier = idU
													AND PGTE.idEvent = PLE.idEvent )) 
													
UNION ALL													
   (SELECT PLE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,"0" as dateClose,"0" as maxGuest ,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE ,PLE.assistdate,"0" as inside, PGP.idPartier AS GOES	
		
		FROM(
			SELECT  idU AS idPartier,PGP.idPub, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal,"0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour,"0" as closeHour,  PF.idProfile AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PGP.createdTime,  "6" AS TYPE ,PGP.assistdate, "0" as inside
			FROM  `Friends` F, `Pub` P, `Partier` PF, `PartierGoToPub` PGP
			WHERE 
            F.idPartier1 = idU
			AND F.mode = 1
			AND PF.idPartier = F.idPartier2
			AND PGP.idPub = P.idPub
			AND PGP.idPartier = F.idPartier2

			
			) PLE
			LEFT JOIN  `PartierGoToPub` PGP ON  (PGP.idPartier = idU         
                                                     AND PGP.idPub = PLE.idPub 
														AND PGP.assistdate=PLE.assistdate))	
UNION ALL	
(SELECT idU as idPartier,P.idPub as idPub,P.idProfile as idProfileLocal, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, "0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour, "0" as closeHour,"0" as dateClose,"0" as maxGuest , PD.idProfile as idPartierFriend, PD.name, PD.surnames,"0" as mode,"0" as status,  PIP.createdTime, "7" AS TYPE,"0" as assistdate ,PIP.inside, NULL AS GOES
			FROM   `Friends` F,`PartierIsInPub` PIP,  `Pub` P , `Partier` PD
			WHERE  F.idPartier1 =idU
			AND F.mode = 1
			
			AND PIP.idPartier =F.idPartier2
			AND PIP.idPub = P.idPub
			 AND PD.idPartier=F.idPartier2
			) 
UNION ALL
 (SELECT PLE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,PLE.dateClose,PLE.maxGuest ,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE ,PLE.assistdate,"0" as inside, PIIL.idPartier AS GOES	
		
		FROM(
			SELECT  idU AS idPartier,P.idPub, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal,L.idLists as idEvent, L.title, L.about as text, L.date, L.startHour,L.closeHour,L.dateClose,L.maxGuest,  PF.idProfile AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PIL.createdTime, "8" AS TYPE ,"0" as assistdate, "0" as inside
			FROM  `Friends` F,`Pub` P, `Partier` PF, `PartierIsInLists` PIL,`Lists` L
			WHERE 
			F.idPartier1 =idU
			AND F.mode = 1 AND
            PIL.idPartier=F.idPartier2 AND
			PF.idPartier= PIL.idPartier AND
			L.idLists = PIL.idLists AND
			L.idPub=P.idPub 
			
			) PLE
			LEFT JOIN  `PartierIsInLists` PIIL ON  (PIIL.idPartier = idU         
                                                     AND PIIL.idLists = PLE.idEvent )	)	
UNION ALL		
(SELECT "0" as idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,PLE.dateClose,PLE.maxGuest, "0" as idPartierFriend, "0" as name, "0" as surnames,"0" as mode,"0" as status, PLE.createdTime,  "9" AS TYPE , "0" as assistdate,"0" as inside,PIIL.idPartier AS GOES
 FROM (
			SELECT P.idProfile,P.idPub as idPub, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, L.idLists as idEvent, L.title, L.about as text, L.date, L.startHour,L.closeHour,L.createdTime,L.dateClose,L.maxGuest,  "9" as TYPE 
			FROM  `PartierFollowsPub` PFP,  `Lists` L,  `Pub` P
			WHERE PFP.idPartier = idU
			AND L.idPub = PFP.idPub
			AND P.idPub = PFP.idPub
			)PLE
			LEFT JOIN  `PartierIsInLists` PIIL ON  (PIIL.idPartier = idU       
                                                     AND PIIL.idLists = PLE.idEvent )	)	
													
UNION ALL
(SELECT idU as idPartier,P.idPub as idPub,P.idProfile as idProfileLocal, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, "0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour, "0" as closeHour,"0" as dateClose,"0" as maxGuest, PD.idProfile as idPartierFriend, PD.name, PD.surnames,"0" as mode,"0" as status,  PFP.createdTime, "14" AS TYPE,"0" as assistdate ,"0" as inside, NULL AS GOES
			FROM   `PartierFollowsPub` PFP,  `Pub` P , `Partier` PD
			WHERE PFP.idPartier = idU
			AND PFP.idPub = P.idPub
			 AND PD.idPartier=idU
			) 


UNION ALL

		(SELECT idU AS idPartier,"0","0",  "0",  P.picture,  "0",  "0",  "0", "0" as idEvent,  "0" AS title,  "0" AS text,  "0" AS date,  "0" AS startHour,  "0" AS closeHour,"0" as dateClose,"0" as maxGuest, P.idProfile AS idPartierFriend, P.name, P.surnames, PM.mode,"0" as status, PM.createdTime,  "13" AS TYPE ,"0" as assistdate ,"0" as inside, NULL AS GOES
			FROM   `Partier` P,  `PartierMode` PM
			WHERE PM.idPartier = idU
			AND P.idPartier= idU)

UNION ALL

		(SELECT idU AS idPartier,"0","0",  "0", P.picture,  "0",  "0",  "0", "0" as idEvent,  "0" AS title,  "0" AS text,  "0" AS date,  "0" AS startHour,  "0" AS closeHour,"0" as dateClose,"0" as maxGuest, P.idProfile AS idPartierFriend, P.name, P.surnames,"0" as mode, PS.status, PS.createdTime,  "12" AS TYPE ,"0" as assistdate ,"0" as inside, NULL AS GOES
			FROM  `Partier` P,  `PartierStatus` PS
			WHERE 
		    P.idPartier = idU
			AND PS.idPartier = idU)
UNION ALL
            (SELECT PLE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,"0" as dateClose,"0" as maxGuest,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE ,PLE.assistdate,"0" as inside, PGTE.idPartier AS GOES	
		
		FROM(
			SELECT idU AS idPartier,P.idPub, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, E.idEvent, E.title, E.text, E.date, E.startHour, E.closeHour,  PF.idProfile AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PGTE.createdTime,  "15" AS TYPE,"0" as assistdate,"0" as inside
			FROM `Event` E, `PartierGoesToEvent` PGTE, `Pub` P, `Partier` PF
			WHERE 
            PGTE.idPartier = idU
            AND PF.idPartier = idU
			AND PGTE.idEvent = E.idEvent
			AND E.idProfileCreator = P.idPub) PLE
			LEFT JOIN  `PartierGoesToEvent` PGTE ON ( PGTE.idPartier = idU            
                                                     AND PGTE.idEvent = PLE.idEvent ))
													 
UNION ALL	
			

            (SELECT PLE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,"0" as dateClose,"0" as maxGuest,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE ,PLE.assistdate,"0" as inside, PGP.idPartier AS GOES	
		
		FROM(
			SELECT  idU AS idPartier,PGP.idPub, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal,"0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour,"0" as closeHour,  PF.idProfile AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PGP.createdTime,  "16" AS TYPE ,PGP.assistdate, "0" as inside
			FROM  `Pub` P, `Partier` PF, `PartierGoToPub` PGP
			WHERE 
            PGP.idPartier = idU
            AND PF.idPartier = idU
			AND PGP.idPub = P.idPub
			
			) PLE
			LEFT JOIN  `PartierGoToPub` PGP ON  (PGP.idPartier = idU         
                                                     AND PGP.idPub = PLE.idPub 
														AND PGP.assistdate=PLE.assistdate))	

UNION ALL
			(SELECT idU as idPartier,P.idPub as idPub,P.idProfile as idProfileLocal, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, "0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour, "0" as closeHour,"0" as dateClose,"0" as maxGuest, PD.idProfile as idPartierFriend, PD.name, PD.surnames,"0" as mode,"0" as status,  PIP.createdTime, "17" AS TYPE,"0" as assistdate ,PIP.inside, NULL AS GOES
			FROM   `PartierIsInPub` PIP,  `Pub` P , `Partier` PD
			WHERE PIP.idPartier =idU
			AND PIP.idPub = P.idPub
			 AND PD.idPartier=idU
			) 	
UNION ALL
 (SELECT PLE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,PLE.dateClose,PLE.maxGuest,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE ,PLE.assistdate,"0" as inside, PIIL.idPartier AS GOES	
		
		FROM(
			SELECT  idU AS idPartier,P.idPub, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal,L.idLists as idEvent, L.title, L.about as text, L.date, L.startHour,L.closeHour,L.dateClose,L.maxGuest,  PF.idProfile AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PIL.createdTime,  "18" AS TYPE ,"0" as assistdate, "0" as inside
			FROM  `Pub` P, `Partier` PF, `PartierIsInLists` PIL,`Lists` L
			WHERE 
            PIL.idPartier=idU AND
			PF.idPartier= PIL.idPartier AND
			L.idLists = PIL.idLists AND
			L.idPub=P.idPub 
			
			) PLE
			LEFT JOIN  `PartierIsInLists` PIIL ON  (PIIL.idPartier = idU         
                                                     AND PIIL.idLists = PLE.idEvent )	)			




													
													
													
) T

													
			ORDER BY T.createdTime desc;
													
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getNewsUser`(IN `idProfile` INT(11), IN `idPartier` INT(11))
    NO SQL
BEGIN 
		DECLARE idD int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);

		SET idD = (SELECT d.idPartier
					FROM `Partier` d
					WHERE d.idProfile = idPartier);
select * from
		(			
 
												
		(SELECT idU as idPartier,P.idPub as idPub,P.idProfile as idProfileLocal, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, "0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour, "0" as closeHour,"0" as dateClose,"0" as maxGuest, PD.idProfile as idPartierFriend, PD.name, PD.surnames,"0" as mode,"0" as status,  PFP.createdTime, "4" AS TYPE,"0" as assistdate ,"0" as inside, NULL AS GOES
			FROM   `PartierFollowsPub` PFP,  `Pub` P , `Partier` PD
			WHERE PFP.idPartier = idU
			AND PFP.idPub = P.idPub
			 AND PD.idPartier=idU
			) 


UNION ALL

		(SELECT idU AS idPartier,"0","0",  "0",  P.picture,  "0",  "0",  "0", "0" as idEvent,  "0" AS title,  "0" AS text,  "0" AS date,  "0" AS startHour,  "0" AS closeHour,"0" as dateClose,"0" as maxGuest, P.idProfile AS idPartierFriend, P.name, P.surnames, PM.mode,"0" as status, PM.createdTime,  "3" AS TYPE ,"0" as assistdate ,"0" as inside, NULL AS GOES
			FROM   `Partier` P,  `PartierMode` PM
			WHERE PM.idPartier = idU
			AND P.idPartier= idU)

UNION ALL

		(SELECT idU AS idPartier,"0","0",  "0", P.picture,  "0",  "0",  "0", "0" as idEvent,  "0" AS title,  "0" AS text,  "0" AS date,  "0" AS startHour,  "0" AS closeHour,"0" as dateClose,"0" as maxGuest, P.idProfile AS idPartierFriend, P.name, P.surnames,"0" as mode, PS.status, PS.createdTime,  "2" AS TYPE ,"0" as assistdate ,"0" as inside, NULL AS GOES
			FROM  `Partier` P,  `PartierStatus` PS
			WHERE 
		    P.idPartier = idU
			AND PS.idPartier = idU)
UNION ALL
            (SELECT PLE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,"0" as dateClose,"0" as maxGuest,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE ,PLE.assistdate,"0" as inside, PGTE.idPartier AS GOES	
		
		FROM(
			SELECT idU AS idPartier,P.idPub, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, E.idEvent, E.title, E.text, E.date, E.startHour, E.closeHour,  PF.idProfile AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PGTE.createdTime,  "5" AS TYPE,"0" as assistdate,"0" as inside
			FROM `Event` E, `PartierGoesToEvent` PGTE, `Pub` P, `Partier` PF
			WHERE 
            PGTE.idPartier = idU
            AND PF.idPartier = idU
			AND PGTE.idEvent = E.idEvent
			AND E.idProfileCreator = P.idPub) PLE
			LEFT JOIN  `PartierGoesToEvent` PGTE ON ( PGTE.idPartier = idD            
                                                     AND PGTE.idEvent = PLE.idEvent ))
													 
UNION ALL	
			

            (SELECT PLE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,"0" as dateClose,"0" as maxGuest,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE ,PLE.assistdate,"0" as inside, PGP.idPartier AS GOES	
		
		FROM(
			SELECT  idU AS idPartier,PGP.idPub, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal,"0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour,"0" as closeHour,  PF.idProfile AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PGP.createdTime,  "6" AS TYPE ,PGP.assistdate, "0" as inside
			FROM  `Pub` P, `Partier` PF, `PartierGoToPub` PGP
			WHERE 
            PGP.idPartier = idU
            AND PF.idPartier = idU
			AND PGP.idPub = P.idPub
			
			) PLE
			LEFT JOIN  `PartierGoToPub` PGP ON  (PGP.idPartier = idD         
                                                     AND PGP.idPub = PLE.idPub 
														AND PGP.assistdate=PLE.assistdate))	

UNION ALL
			(SELECT idU as idPartier,P.idPub as idPub,P.idProfile as idProfileLocal, P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal, "0" as idEvent, "0" as title, "0" as text, "0" as date, "0" as startHour, "0" as closeHour,"0" as dateClose,"0" as maxGuest, PD.idProfile as idPartierFriend, PD.name, PD.surnames,"0" as mode,"0" as status,  PIP.createdTime, "7" AS TYPE,"0" as assistdate ,PIP.inside, NULL AS GOES
			FROM   `PartierIsInPub` PIP,  `Pub` P , `Partier` PD
			WHERE PIP.idPartier =idU
			AND PIP.idPub = P.idPub
			 AND PD.idPartier=idU
			) 	
UNION ALL
 (SELECT PLE.idPartier,PLE.idPub as idPub,PLE.idProfile as idProfileLocal, PLE.localName, PLE.picture, PLE.street, PLE.streetNameLocal, PLE.streetNumberLocal,PLE.idEvent, PLE.title, PLE.text, PLE.date, PLE.startHour, PLE.closeHour,PLE.dateClose,PLE.maxGuest,PLE.idPartierFriend,PLE.name, PLE.surnames,"0" as mode,"0" as status, PLE.createdTime,  PLE.TYPE ,PLE.assistdate,"0" as inside, PIIL.idPartier AS GOES	
		
		FROM(
			SELECT  idU AS idPartier,P.idPub, P.idProfile,  P.localName, P.picture, P.street, P.streetNameLocal, P.streetNumberLocal,L.idLists as idEvent, L.title, L.about as text, L.date, L.startHour,L.closeHour,L.dateClose,L.maxGuest,  PF.idProfile AS idPartierFriend, PF.name, PF.surnames,"0" as mode, "0" as status, PIL.createdTime,  "8" AS TYPE ,"0" as assistdate, "0" as inside
			FROM  `Pub` P, `Partier` PF, `PartierIsInLists` PIL,`Lists` L
			WHERE 
            PIL.idPartier=idU AND
			PF.idPartier= PIL.idPartier AND
			L.idLists = PIL.idLists AND
			L.idPub=P.idPub 
			
			) PLE
			LEFT JOIN  `PartierIsInLists` PIIL ON  (PIIL.idPartier = idD         
                                                     AND PIIL.idLists = PLE.idEvent )	)			

			
) T
													
			ORDER BY T.createdTime desc;
													
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getPartierData`(IN `idProfile` INT)
BEGIN
		SELECT p.picture, p.`name`, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about,p.mode,p.status,p.facebook,p.twitter,p.instagram,p.createdTime 
		FROM `Profile` pr, `Partier` p
		WHERE (pr.idProfile = idProfile) AND (pr.idProfile = p.idProfile);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getPartiers`()
BEGIN
				SELECT *
				FROM `Partier` d 
				ORDER BY d.name ASC, d.surnames ASC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getPartiersInList`(IN `idList` INT(11))
BEGIN
		SELECT p.idProfile, p.picture, p.name, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about,p.mode,p.status,pl.numGuest
		FROM `PartierIsInLists` pl, `Partier` p
		WHERE (pl.idLists = idList AND pl.idPartier=p.idPartier);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getPartiersMessages`(IN `idProfileP` INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		


        SELECT DISTINCT p.idProfile
        FROM  `MessagesStatus` ms, `Partier` p
        WHERE (ms.idPartier1 = idP ) and (ms.idPartier2=p.idPartier) ;



  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getPlayList`(IN `idProfile` INT(11), IN `idPub` INT(11))
BEGIN
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idPub);

				SELECT EL.idTrack,EL.trackName,EL.trackArtist,EL.createdTime,EL.votes,EL.playing,V.idPartier AS VOTE
				FROM
				(
				SELECT d.idTrack,d.trackName,d.trackArtist,d.createdTime,d.votes,d.playing
				FROM `PlayList` d 
				WHERE (d.idPub=idP)
				) EL LEFT JOIN
					`PartierVoteTrack` V ON (V.idPartier=idU
											AND V.idTrack=EL.idTrack and V.idPub=idP)

				ORDER BY EL.votes DESC, EL.trackArtist ASC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getStatusPartier`(idProfile1 INT(11))
BEGIN 
 	DECLARE idP1 int(11);
   
    SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile1);

        SELECT pm.status
        FROM `PartierStatus` pm
        WHERE (pm.idPartier = idP1)
        ORDER BY pm.createdTime DESC
		LIMIT 0,1;
END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `getTrackData`(IN `idProfile` INT(11), IN `idTrack` INT(11))
BEGIN
		DECLARE idP int(11);
   
   		 SET idP = (SELECT pb.idPub
					FROM `Pub` pb
					WHERE pb.idProfile = idProfile);
		SELECT p.idTrack,p.trackName, p.trackArtist,p.playing, p.createdTime
		FROM `PlayList` p
		WHERE (p.idTrack = idTrack AND p.idPub = idP);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `goToEvent`(IN `idEvent` INT, IN `idProfileUser` INT)
BEGIN
		DECLARE idU int(11);
		DECLARE d date;
		DECLARE idP int(11);
		
		
		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);
	
		INSERT INTO `PartierGoesToEvent` (`idPartier`,`idEvent`)
			VALUES (idU,idEvent);
			
		SET d = (SELECT e.date
					FROM `Event` e
					WHERE e.idEvent = idEvent);

		SET idP = (SELECT e.idProfileCreator
					FROM `Event` e
					WHERE e.idEvent = idEvent);
		INSERT INTO `PartierGoToPub` (	`idPartier`, `idPub`, `assistdate`) VALUES (idU,idP,d);

		select idP;


		
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `goToPub`(IN `idProfilePub` INT, IN `idProfileUser` INT, IN `d` DATE)
BEGIN
		


		DECLARE idP int(11);
		DECLARE idU int(11);
	
		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfilePub);

 INSERT INTO `PartierGoToPub` (	`idPartier`, `idPub`, `assistdate`) 
VALUES (idU,idP,d);
		


		
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `howManyCheckIn`(idProfile INT(11),idPub INT(11))
BEGIN
		DECLARE idP int(11);
		DECLARE idPU int(11);
		
		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);
		SET idPU = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idPub);

		IF ((SELECT Count(*)
			FROM `HowManyCheckIn` HMCI
			WHERE (HMCI.idPub = idPU and HMCI.idPartier=idP))=1)
		THEN
			
				UPDATE HowManyCheckIn hmc
				SET hmc.num = hmc.num + 1
				WHERE (hmc.idPub = idPU and hmc.idPartier=idP);
			
		ELSE
	
			
				INSERT INTO `HowManyCheckIn` (`idPub`,`idPartier`,`num`)
      			VALUES (idPU,idP,1);
      	END IF;
		
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `howManyMessages`(IN `idProfileP` INT(11))
    NO SQL
BEGIN
		
DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		
		SELECT DISTINCT pa.idProfile,pa.name,pa.surnames,pa.picture, COUNT(*) AS NUM
		 FROM  `MessagesStatus` ms, `Partier` pa
		WHERE ((ms.idPartier1 = idP ) and (pa.idPartier=  ms.idPartier2))
		GROUP BY pa.idProfile
		ORDER BY pa.idProfile ASC;

END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertDJUser`(IN `email` VARCHAR(50), IN `pass` VARCHAR(80))
BEGIN
    INSERT INTO `User`
    VALUES (email,pass,-1,NULL,NULL);

    INSERT INTO `Profile` (`type`,`email`)
    VALUES (-1,email);

    INSERT INTO `DJ` (`idProfile`)
          SELECT p.idProfile
          FROM `Profile` p
          WHERE p.email = email;

  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertFacebookUser`(IN `email` VARCHAR(50))
BEGIN
    INSERT INTO `User`
    VALUES (email,0,0,NULL,NULL);

    INSERT INTO `Profile` (`type`,`email`)
    VALUES (0,email);

    INSERT INTO `Partier` (`idProfile`)
          SELECT p.idProfile
          FROM `Profile` p
          WHERE p.email = email;

  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertGoogleUser`(IN `email` VARCHAR(50))
BEGIN
		INSERT INTO `User`
		VALUES (email,NULL,1,NULL,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertNormalUser`(IN `email` VARCHAR(50), IN `pass` VARCHAR(80))
BEGIN
		INSERT INTO `User`
		VALUES (email,pass,-1,NULL,NULL);

		INSERT INTO `Profile` (`type`,`email`)
		VALUES (0,email);

		INSERT INTO `Partier` (`idProfile`)
					SELECT p.idProfile
					FROM `Profile` p
					WHERE p.email = email;

	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `insertPubUser`(IN `email` VARCHAR(80), IN `pass` VARCHAR(80))
BEGIN
    INSERT INTO `User` 
    VALUES (email,pass,-1,NULL,NULL);

    INSERT INTO `Profile` (`type`,`email`)
    VALUES (1,email);

    INSERT INTO `Pub` (`idProfile`)
          SELECT p.idProfile
          FROM `Profile` p
          WHERE p.email = email;

  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `joinList`(IN `idList` INT, IN `idProfileUser` INT, IN `numGuest` INT)
BEGIN
		
		
		SET @idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		INSERT INTO `PartierIsInLists` (`idPartier`,`idLists`,`numGuest`)
		VALUES (@idU,idList,numGuest);

		
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `listsUser`(IN `idProfile` INT(11))
BEGIN
				DECLARE idP int (11);

				SET idP = (SELECT p.idPartier
						FROM `Partier` p
						WHERE p.idProfile = idProfile);	
		

				SELECT e.idLists, e.idPub,pg.numGuest, e.title, e.about, e.date,e.dateClose,e.maxGuest, e.startHour, e.closeHour
				FROM `Lists` e, `PartierIsInLists` pg
				WHERE (e.idLists = pg.idLists and pg.idPartier= idP)
				ORDER BY e.date ASC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `localsUser`(IN `idProfile` INT(11))
BEGIN
				SELECT d.idProfile, d.localName, d.telephoneLocal, d.street, d.streetNameLocal, d.streetNumberLocal, d.latitude, d.longitude, d.picture
				FROM `Pub` d, `PartierFollowsPub` pg, `Partier` p
				WHERE (d.idPub = pg.idPub and p.idProfile = idProfile and pg.idPartier= p.idPartier)
				ORDER BY d.localName ASC;
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `myFriends`(IN `idProfileP` INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		
		SELECT p.idProfile
        FROM `Partier` p, `Friends` f
        WHERE (((f.idPartier1 = idP)and(p.idPartier = f.idPartier2)) and (f.mode=1));

        

  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `myPetFriendship`(idProfileP INT)
BEGIN
		DECLARE idP int (11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileP);	
		
		SELECT p.idProfile
        FROM `Partier` p, `Friends` f
        WHERE (( (f.idPartier1 = idP)  AND (p.idPartier = f.idPartier2) ) and (f.mode=0));


  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `myTracksIn`(IN idProfile INT(11), IN idPub INT(11))
BEGIN
		DECLARE idPa int (11);
		DECLARE idPu int (11);

		SET idPa = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);	
		SET idPu = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idPub);	
		
		SELECT pv.idTrack
        FROM `PartierVoteTrack` pv
        WHERE ( pv.idPartier=idPa and pv.idPub=idPu);


  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `playTrack`(IN `idProfile` INT(11), IN `idTrack` INT(11))
BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);
		
		
		DELETE FROM `PartierVoteTrack`
		WHERE(idPub=idP);
			
		UPDATE PlayList pl
		SET 
			pl.playing = 0
		WHERE(pl.idPub=idP);
		
		
		UPDATE PlayList pl
		SET 
			pl.playing = 1,
			pl.votes = 0
		WHERE (pl.idTrack = idTrack AND pl.idPub = idP);
		
		SELECT pp.idTrack
		FROM `PlayList` pp
		WHERE (pp.idPub=idP);
		
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `pubFollowers`(IN `idProfilePub` INT(11))
    NO SQL
BEGIN
		SELECT p.idProfile
        FROM `PartierFollowsPub` pf, `Pub` d, `Partier` p 
        WHERE ((d.idProfile = idProfilePub) AND (d.idPub = pf.idPub) AND (pf.idPartier = p.idPartier));
END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `restartPlaylist`(IN `idProfile` INT(11))
BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);
		
		DELETE FROM `PartierVoteTrack`
		WHERE(idPub=idP);		

		UPDATE PlayList pl
		SET 
			pl.playing = 0,
			pl.votes=0	
		WHERE (pl.idPub = idP);
	
		
		
		
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `sendMessage`(IN `idProf1` INT(11), IN `idProf2` INT(11), IN `message` VARCHAR(1000))
BEGIN
     DECLARE idP1 int (11);
	 DECLARE idP2 int (11);
	 DECLARE idMes int (11);

		SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProf1);



		SET idP2 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProf2);		

		INSERT INTO `Messages` (`message`)
      VALUES (message);



		SET idMes = (SELECT max(m.idMessage)
					FROM `Messages` m
					);


      INSERT INTO `MessagesStatus` (`idMessage`,`idPartier1`,`idPartier2`,`mode`)
      VALUES (idMes,idP1,idP2,0);
      INSERT INTO `MessagesStatus` (`idMessage`,`idPartier1`,`idPartier2`,`mode`)
      VALUES (idMes,idP2,idP1,1);
   END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setDJData`(IN `idProfile` INT, IN `nameDJ` VARCHAR(30), IN `name` VARCHAR(20), IN `surname` VARCHAR(45), IN `telephoneDJ` INT, IN `gender` TINYINT(1), IN `birthdate` DATE, IN `picture` VARCHAR(100), IN `music` VARCHAR(20), IN `about` VARCHAR(400))
BEGIN
    UPDATE DJ p
    SET 
      p.nameDJ = nameDJ,  
      p.name = name,
      p.surname = surname,
      p.telephoneDJ = telephoneDJ,
      p.gender = gender,
      p.birthdate = birthdate,
      p.picture = picture,
      p.music = music,
      p.about = about
      
    WHERE (p.idProfile = idProfile);
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setEvent`(IN `idProf` INT(11), IN `title` VARCHAR(40), IN `about` VARCHAR(200), IN `dateEv` DATE, IN `startHour` TIME, IN `closeHour` TIME)
BEGIN

	DECLARE idP int(11);
		

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProf);
      INSERT INTO `Event` (`idProfileCreator`,`title`,`text`,`date`,`startHour`,`closeHour`)
      VALUES (idP,title,about,dateEv,startHour,closeHour);
   END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setEventData`(IN `idProfile` INT(11), IN `idEvent` INT(11), IN `title` VARCHAR(40), IN `about` VARCHAR(200), IN `dateE` DATE, IN `startHour` TIME, IN `closeHour` TIME)
BEGIN

		DECLARE idP int(11);
		

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfile);
		UPDATE Event p
		SET 
			P.title = title, 
 			P.text = about,
  			P.date = dateE,
      		p.startHour =startHour,
      		p.closeHour =closeHour	
		
		WHERE (p.idEvent = idEvent AND p.idProfileCreator = idP);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setList`(IN `idProf` INT(11), IN `title` VARCHAR(40), IN `about` VARCHAR(200), IN `dateL` DATE, IN `startHour` TIME, IN `closeHour` TIME, IN `dateClose` DATE, IN `maxGuest` INT(11))
BEGIN
      DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProf);
		INSERT INTO `Lists` (`idPub`,`title`,`about`,`date`,`startHour`,`closeHour`,`dateClose`,`maxGuest`)
      VALUES (idP,title,about,dateL,startHour,closeHour,dateClose,maxGuest);
   END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setListData`(IN `idProfile` INT(11), IN `idList` INT(11), IN `title` VARCHAR(40), IN `about` VARCHAR(200), IN `dateL` DATE, IN `startHour` TIME, IN `closeHour` TIME, IN `dateClose` DATE, IN `maxGuest` INT)
BEGIN
	DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);
		
		
		UPDATE Lists p
		SET 
			p.title = title, 
 			p.about = about,
  			p.date = dateL,
      		p.startHour =startHour,
      		p.closeHour =closeHour,
			p.dateClose=dateClose,
			p.maxGuest=maxGuest
		
		WHERE (p.idLists = idList AND p.idPub = idP);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setLocalData`(IN `idProfile` INT, IN `companyNameLocal` VARCHAR(50), IN `localName` VARCHAR(20), IN `cif` VARCHAR(9), IN `poblationLocal` VARCHAR(20), IN `cpLocal` INT(5), IN `telephoneLocal` INT, IN `street` TINYINT(1), IN `streetNameLocal` VARCHAR(50), IN `streetNumberLocal` VARCHAR(50), IN `latitude` VARCHAR(11), IN `longitude` VARCHAR(11), IN `music` VARCHAR(20), IN `entryPrice` INT, IN `drinkPrice` INT, IN `openingHours` TIME, IN `closeHours` TIME, IN `picture` VARCHAR(100), IN `about` VARCHAR(200), IN `facebook` VARCHAR(100), IN `twitter` VARCHAR(100), IN `instagram` VARCHAR(100))
BEGIN
    UPDATE Pub p
    SET 
      p.companyNameLocal = companyNameLocal, 
      p.localName= localName,
      p.cif= cif,
      p.poblationLocal= poblationLocal,
      p.cpLocal= cpLocal,
      p.telephoneLocal= telephoneLocal,
      p.street= street,
      p.streetNameLocal= streetNameLocal,
      p.streetNumberLocal= streetNumberLocal,
	  p.latitude = latitude,
	  p.longitude = longitude,
      p.music= music,
      p.entryPrice= entryPrice,
      p.drinkPrice= drinkPrice,
      p.openingHours= openingHours,
      p.closeHours=  closeHours,
      p.picture= picture,
      p.about= about,
      p.facebook = facebook,
      p.twitter = twitter,
      p.instagram = instagram
    
    WHERE (p.idProfile = idProfile);
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setModePartier`(IN `idProfile` INT(11), IN `modo` TINYINT(1))
BEGIN
		DECLARE idP int(11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);

		UPDATE Partier p
		SET 
			p.mode = modo
		
		WHERE (p.idProfile = idProfile);

		INSERT INTO `PartierMode` (`idPartier`,`mode`)
		VALUES (idP,modo);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setPartierData`(IN `idProfile` INT, IN `picture` VARCHAR(100), IN `name` VARCHAR(20), IN `surnames` VARCHAR(45), IN `birthdate` DATE, IN `gender` INT, IN `music` VARCHAR(20), IN `civil_state` VARCHAR(20), IN `city` VARCHAR(20), IN `drink` VARCHAR(20), IN `about` VARCHAR(200), IN `facebook` VARCHAR(100), IN `twitter` VARCHAR(100), IN `instagram` VARCHAR(100))
BEGIN
		UPDATE Partier p
		SET p.picture = picture, 
		p.name = name,
		p.surnames = surnames, 
		p.birthdate = birthdate,
		p.gender = gender, 
		p.music = music,
		p.civil_state = civil_state,
		p.city = city,
		p.drink = drink,
		p.about = about,
		p.facebook = facebook,
        p.twitter = twitter,
        p.instagram = instagram


		WHERE (p.idProfile = idProfile);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setStatusPartier`(IN `idProfile` INT(11), IN `estado` VARCHAR(140))
BEGIN
		DECLARE idP int(11);

		SET idP = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);

		UPDATE Partier p
		SET 
			p.status = estado
		
		WHERE (p.idProfile = idProfile);

		INSERT INTO `PartierStatus` (`idPartier`,`status`)
		VALUES (idP,estado);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setTrack`(IN `idProf` INT(11), IN `name` VARCHAR(40), IN `artist` VARCHAR(40))
BEGIN
      DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProf);

		IF((SELECT Count(*)
           FROM `PlayList` pl
           WHERE(pl.idPub=idP and pl.trackName=name and pl.trackArtist=artist))=1)
		
		THEN 
		
			SELECT pl.idTrack,"1" as Error
			FROM `PlayList` pl
           	WHERE(pl.idPub=idP and pl.trackName=name and pl.trackArtist=artist);
		
		ELSE
		
			SELECT "0" as Error;

			INSERT INTO `PlayList` (`idPub`,`trackName`,`trackArtist`,`votes`,`playing`)
      		VALUES (idP,name,artist,0,0);
		
		END IF;
   END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setTrackData`(IN `idProfile` INT(11), IN `idTrack` INT(11), IN `name` VARCHAR(40), IN `artist` VARCHAR(40))
BEGIN
		DECLARE idP int(11);
   
    	SET idP = (SELECT p.idPub
					FROM `Pub` p
					WHERE p.idProfile = idProfile);
		
		
		UPDATE PlayList pl
		SET 
			pl.trackName = name, 
 			pl.trackArtist = artist
 
		
		WHERE (pl.idTrack = idTrack AND pl.idPub = idP);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `setUserPass`(IN `idProfile` INT, IN `pass` VARCHAR(80))
    NO SQL
BEGIN
		UPDATE `User` u, `Profile` p
		SET u.password = pass 
		WHERE (u.email = p.email AND p.idProfile=idProfile);
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `statisticsPub`(IN `idProfile` INT(11))
BEGIN
		DECLARE idP int(11);
		
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfile);

  		SELECT p.idProfile,p.picture, p.name, p.surnames, p.birthdate, p.gender, p.music, p.civil_state, p.city, p.drink, p.about,p.mode,p.status,"0" AS modeP,"" AS num				
        FROM `PartierGoToPub` PGTP, `Partier` p
        WHERE (PGTP.idPub = idP and PGTP.idPartier=p.idPartier)
		
UNION ALL
		SELECT pa.idProfile,pa.picture, pa.name, pa.surnames, pa.birthdate, pa.gender, pa.music, pa.civil_state, pa.city, pa.drink, pa.about,pa.mode,pa.status,"1" AS modeP,Count(*) as num
     	FROM `PartierIsInPub` PIIB, `Partier` pa
     	WHERE (PIIB.idPub=idP and pa.idPartier=PIIB.idPartier)
     	GROUP BY  pa.idPartier
       
	
		ORDER BY modeP ASC,num DESC, name ASC, surnames ASC;
		   
	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `unFollowDJ`(IN `idProfileDJ` INT, IN `idProfileUser` INT)
    NO SQL
BEGIN


		DECLARE idD int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idD = (SELECT d.idDJ
					FROM `DJ` d
					WHERE d.idProfile = idProfileDJ);
	
DELETE FROM  `PartierFollowsDJ`
		WHERE (idPartier = idU AND idDJ = idD);
		
  END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `unFollowPartier`(IN `idPartier` INT, IN `idProfileUser` INT)
BEGIN				
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPartier
					FROM `Partier` pu
					WHERE pu.idProfile = idPartier);

DELETE FROM  `Friends`
		WHERE ((idPartier1 = idU AND idPartier2= idP) OR (idPartier1 = idP AND idPartier2= idU));
END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `unFollowPub`(IN `idProfilePub` INT, IN `idProfileUser` INT)
    NO SQL
BEGIN				
		DECLARE idP int(11);
		DECLARE idU int(11);

		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfileUser);

		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idProfilePub);

DELETE FROM  `PartierFollowsPub`
		WHERE (idPartier = idU AND idPub= idP);
END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `updateToken`(IN email VARCHAR(50), IN tkn VARCHAR(45))
BEGIN
		UPDATE `User` u
		SET u.token= tkn
		WHERE u.email = email;

	END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `uploadPhoto`(IN `idLocal` INT(11), IN `url` VARCHAR(80), IN `title` VARCHAR(80))
    NO SQL
BEGIN

	DECLARE idP int(11);
	DECLARE t timestamp;
		
		SET t = CURRENT_TIMESTAMP;
		SET idP = (SELECT pu.idPub
					FROM `Pub` pu
					WHERE pu.idProfile = idLocal);
      INSERT INTO `LocalPhotos` (idLocal,url,title,createdTime)
      VALUES (`idP`,`url`,`title`, `t`);
	select  idPhoto from `LocalPhotos` l
 where (l.idLocal =idP and l.url=url and l.title=title and l.createdTime=t);

   END$$

CREATE DEFINER=`where2`@`localhost` PROCEDURE `voteTrack`(IN `idProfile` INT(11), IN `idPub` INT(11), IN `idTrack` INT(11))
BEGIN
    DECLARE idPa int (11);
    DECLARE idPu int (11);

	SET idPa = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile);

	SET idPu = (SELECT pb.idPub
					FROM `Pub` pb
					WHERE pb.idProfile = idPub);
    
		UPDATE PlayList pl
		SET 
			pl.votes=pl.votes+1
		WHERE (pl.idTrack = idTrack AND pl.idPub = idPu);

		INSERT INTO `PartierVoteTrack` (`idTrack`,`idPartier`,`idPub`)
      	VALUES (idTrack,idPa,idPu);
	END$$

--
-- Funciones
--
CREATE DEFINER=`where2`@`localhost` FUNCTION `checkPass`(`id` INT(11), `pass` VARCHAR(80)) RETURNS tinyint(4)
    NO SQL
BEGIN
		

 CASE (SELECT u.`type` FROM `User` u, `Profile` p WHERE u.email = p.email  AND p.idProfile =id) 
      WHEN 1 THEN RETURN 1;
      WHEN 0 THEN RETURN 0;
	  WHEN -1 THEN
				    RETURN (CASE 0 WHEN ((SELECT Count(*)
							FROM `User` u, `Profile` p
							WHERE (u.email = p.email) AND u.`password` = pass AND u.`type` = -1 AND p.idProfile =id )) 
						  THEN 2
					ELSE (  -1)	
					    							
			END);
END CASE;
END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `getCheckInProfile`(`idProfilePartier` INT) RETURNS int(11)
    NO SQL
BEGIN
		DECLARE idU int(11);


		
		
		SET idU = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfilePartier);

      return (select a.idProfile from PartierIsInPub p, Pub a 
where DATE(p.createdtime )= CURRENT_Date  and p.inside=1 and p.idPub=a.idPub and p.idPartier=idU ORDER BY p.createdtime desc LIMIT 1);



	
		
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `getIdProfile`(usr VARCHAR(50)) RETURNS int(11)
BEGIN
		RETURN (SELECT p.idProfile
				FROM `Profile` p
				WHERE (p.email = usr));
	END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `getIdProfilePub`(idPub INT) RETURNS int(11)
BEGIN
    RETURN (SELECT p.idProfile
        FROM `Pub` p
        WHERE (p.idPub = idPub));
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `getModeFollow`(`idProfile1` INT(11), `idProfile2` INT(11)) RETURNS tinyint(1)
BEGIN
    DECLARE idP1 int(11);
    DECLARE idP2 int(11);
    SET idP1 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile1);
	SET idP2 = (SELECT p.idPartier
					FROM `Partier` p
					WHERE p.idProfile = idProfile2);

    RETURN (SELECT f.mode
        FROM `Friends` f
        WHERE (f.idPartier1 = idP1 AND f.idPartier2=idP2));
  
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `getTypeProfile`(idProfile INT) RETURNS int(11)
BEGIN
    RETURN (SELECT p.type
        FROM `Profile` p
        WHERE (p.idProfile = idProfile));
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `howManyFollowsDJ`(idProfileDJ INT) RETURNS int(11)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsDJ` pf, `DJ` d 
        WHERE ((idProfileDJ = d.idProfile) AND (d.idDJ = pf.idDJ))) ;
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `howManyFollowsPub`(idProfilePub INT) RETURNS int(11)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsPub` pf, `Pub` p 
        WHERE ((idProfilePub = p.idProfile) AND (p.idPub = pf.idPub))) ;
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `howManyGoesToEvent`(idEvent INT) RETURNS int(11)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoesToEvent` pg  
        WHERE (idEvent = pg.idEvent)) ;
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `howManyGoToPub`(idProfilePub INT) RETURNS int(11)
BEGIN
    DECLARE idP int(11);

	SET idP = (SELECT pu.idPub
				FROM `Pub` pu
				WHERE pu.idProfile = idProfilePub);



    RETURN (SELECT Count(*)
        FROM `PartierGoToPub` p  
        WHERE (idP = p.idPub)) ;
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `insertToken`(`email` VARCHAR(50), `tkn` VARCHAR(45)) RETURNS int(11)
    NO SQL
BEGIN

    UPDATE `User` u
    SET u.token= tkn
    WHERE u.email = email ;
    

    RETURN (SELECT p.type
				FROM `Profile` p
				WHERE (p.email = email));
  
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `insertTokenMobile`(`email` VARCHAR(50), `tkn` VARCHAR(45)) RETURNS int(1)
    NO SQL
BEGIN

    UPDATE `User` u
    SET u.tokenMobile= tkn
    WHERE u.email = email ;
    

    RETURN (SELECT p.type
				FROM `Profile` p
				WHERE (p.email = email));
  
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `loginSucceed`(usr VARCHAR(50), pass VARCHAR(80)) RETURNS tinyint(1)
BEGIN
    RETURN (CASE 0 WHEN ((SELECT Count(*)
        FROM `User` u
        WHERE (u.email = usr) AND u.`password` = pass AND u.`type` = -1)) 
      THEN 0    
      ELSE (SELECT idProfile 
          FROM `Profile` p 
          WHERE p.email = usr) END);
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `loginSuccessFB`(`email` VARCHAR(50)) RETURNS tinyint(1)
BEGIN
    RETURN (CASE 0 WHEN ((SELECT Count(*)
        FROM `User` u
        WHERE (u.email = email) AND u.`type` = 0)) 
      THEN 0    
      ELSE (SELECT idProfile 
          FROM `Profile` p 
          WHERE p.email = email) END);
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `loginSuccessGP`(`email` VARCHAR(50)) RETURNS tinyint(1)
BEGIN
    RETURN (CASE 0 WHEN ((SELECT Count(*)
        FROM `User` u
        WHERE (u.email = email) AND u.`type` = 1)) 
      THEN 0    
      ELSE (SELECT idProfile 
          FROM `Profile` p 
          WHERE p.email = email) END);
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `passOK`(`usr` VARCHAR(50), `pass` VARCHAR(80)) RETURNS tinyint(1)
BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.`password` = pass AND u.`type` = -1) = 1);
	END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `tokenEquals`(usr VARCHAR(50), tkn VARCHAR(45)) RETURNS tinyint(1)
BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE (u.email = usr) AND u.token = tkn) = 1);
	END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `tokenOK`(`idUsr` INT, `tkn` VARCHAR(45)) RETURNS tinyint(1)
BEGIN
    RETURN ((SELECT Count(*)
        FROM `User` u, `Profile` p
        WHERE (p.email = u.email AND p.idProfile = idUsr AND u.token = tkn)or (p.email = u.email AND p.idProfile = idUsr AND u.tokenMobile = tkn)  ) = 1);
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `userExists`(usr VARCHAR(50)) RETURNS tinyint(1)
BEGIN
		RETURN ((SELECT Count(*)
				FROM `User` u
				WHERE u.email = usr) = 1);
	END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `userFollowsDJ`(`idProfileDJ` INT, `idProfileP` INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsDJ` pf, `Partier` p, `DJ` d 
        WHERE ((idProfileP = p.idProfile) AND (d.idProfile = idProfileDJ) AND (pf.idPartier = p.idPartier) AND (pf.idDJ = d.idDJ)) = 1);
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `userFollowsPub`(`idProfilePub` INT, `idProfileP` INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierFollowsPub` pf, `Partier` p, `Pub` d 
        WHERE (
                (idProfileP = p.idProfile) AND 
                (d.idProfile = idProfilePub) AND 
                (pf.idPartier = p.idPartier) AND (pf.idPub = d.idPub)
        		)= 1);
 END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `userGoesToEvent`(idProfileP INT, idEvent INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoesToEvent` pg, `Partier` p 
        WHERE ((idProfileP = p.idProfile) AND (pg.idPartier = p.idPartier) AND (pg.idEvent = idEvent)) = 1);
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `userGoesToPub`(idProfileP INT, idProfilePub INT) RETURNS tinyint(1)
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoToPub` pf, `Partier` p, `Pub` d 
        WHERE ((idProfileP = p.idProfile) AND (d.idProfile = idProfilePub) AND (pf.idPartier = p.idPartier) AND (pf.idPub = d.idPub)) = 1);
  END$$

CREATE DEFINER=`where2`@`localhost` FUNCTION `userGoesToPubDate`(`idProfileP` INT, `idProfilePub` INT, `d` DATE) RETURNS tinyint(1)
    NO SQL
BEGIN
    RETURN (SELECT Count(*)
        FROM `PartierGoToPub` pf, `Partier` p, `Pub` d 
        WHERE ((idProfileP = p.idProfile) AND (d.idProfile = idProfilePub) AND (pf.idPartier = p.idPartier) AND (pf.idPub = d.idPub) AND pf.assistdate=d) = 1);
  END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DJ`
--

CREATE TABLE IF NOT EXISTS `DJ` (
  `idDJ` int(11) NOT NULL AUTO_INCREMENT,
  `idProfile` int(11) NOT NULL,
  `nameDJ` varchar(30) NOT NULL,
  `name` varchar(20) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `telephoneDJ` int(11) NOT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `picture` varchar(100) NOT NULL,
  `music` varchar(20) DEFAULT NULL,
  `about` varchar(400) NOT NULL,
  `birthdate_p` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `gender_p` tinyint(1) NOT NULL DEFAULT '1',
  `music_p` tinyint(1) NOT NULL DEFAULT '1',
  `about_p` tinyint(1) NOT NULL DEFAULT '1',
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDJ`),
  KEY `fk_DJ_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Event`
--

CREATE TABLE IF NOT EXISTS `Event` (
  `idEvent` int(11) NOT NULL AUTO_INCREMENT,
  `idProfileCreator` int(11) NOT NULL,
  `title` varchar(40) NOT NULL,
  `text` varchar(200) DEFAULT NULL,
  `date` date NOT NULL,
  `startHour` time NOT NULL,
  `closeHour` time NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEvent`),
  KEY `fk_Event_idProfile1_idx` (`idProfileCreator`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;


--
-- Estructura de tabla para la tabla `Fotos`
--

CREATE TABLE IF NOT EXISTS `Fotos` (
  `idFoto` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(45) DEFAULT NULL,
  `idProfile` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFoto`),
  KEY `fk_Fotos_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Friends`
--

CREATE TABLE IF NOT EXISTS `Friends` (
  `idPartier1` int(11) NOT NULL,
  `idPartier2` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 petition - 1 friends ',
  PRIMARY KEY (`idPartier1`,`idPartier2`),
  KEY `fk_Partier_has_Partier_Partier2_idx` (`idPartier2`),
  KEY `fk_Partier_has_Partier_Partier1_idx` (`idPartier1`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HowManyCheckIn`
--

CREATE TABLE IF NOT EXISTS `HowManyCheckIn` (
  `idPub` int(11) NOT NULL,
  `idPartier` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPub`,`idPartier`),
  KEY `HowManyCheckIn_ibfk_2` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Lists`
--

CREATE TABLE IF NOT EXISTS `Lists` (
  `idLists` int(11) NOT NULL AUTO_INCREMENT,
  `idPub` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(40) DEFAULT NULL,
  `about` varchar(140) DEFAULT NULL,
  `date` date NOT NULL,
  `startHour` time NOT NULL,
  `closeHour` time NOT NULL,
  `dateClose` date NOT NULL,
  `maxGuest` int(11) DEFAULT NULL,
  PRIMARY KEY (`idLists`),
  KEY `fk_Lists_Pub1_idx` (`idPub`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `LocalPhotos`
--

CREATE TABLE IF NOT EXISTS `LocalPhotos` (
  `idPhoto` int(11) NOT NULL AUTO_INCREMENT,
  `idLocal` int(11) NOT NULL,
  `url` varchar(220) NOT NULL,
  `title` varchar(220) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPhoto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Messages`
--

CREATE TABLE IF NOT EXISTS `Messages` (
  `idMessage` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(1000) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMessage`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=140 ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `MessagesStatus`
--

CREATE TABLE IF NOT EXISTS `MessagesStatus` (
  `idMessage` int(11) NOT NULL,
  `idPartier1` int(11) NOT NULL,
  `idPartier2` int(11) NOT NULL,
  `mode` tinyint(2) NOT NULL,
  PRIMARY KEY (`idMessage`,`idPartier1`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Partier`
--

CREATE TABLE IF NOT EXISTS `Partier` (
  `idPartier` int(11) NOT NULL AUTO_INCREMENT,
  `idProfile` int(11) NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `surnames` varchar(45) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `music` varchar(20) NOT NULL DEFAULT '0',
  `civil_state` varchar(20) NOT NULL DEFAULT '0',
  `city` varchar(20) NOT NULL DEFAULT 'Madrid',
  `drink` varchar(20) NOT NULL DEFAULT '0',
  `about` varchar(200) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `picture_p` tinyint(1) NOT NULL DEFAULT '1',
  `name_p` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `surname_p` tinyint(1) NOT NULL DEFAULT '1',
  `birthdate_p` tinyint(1) NOT NULL DEFAULT '1',
  `gender_p` tinyint(1) NOT NULL DEFAULT '1',
  `music_p` tinyint(1) NOT NULL DEFAULT '1',
  `civil_state_p` tinyint(1) NOT NULL DEFAULT '1',
  `city_p` tinyint(1) NOT NULL DEFAULT '1',
  `drink_p` tinyint(1) NOT NULL DEFAULT '1',
  `about_p` tinyint(1) NOT NULL DEFAULT '1',
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mode` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(140) DEFAULT NULL,
  `facebook_p` tinyint(1) NOT NULL DEFAULT '1',
  `twitter_p` tinyint(1) NOT NULL DEFAULT '1',
  `instagram_p` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idPartier`),
  KEY `fk_Partier_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierFollowsDJ`
--

CREATE TABLE IF NOT EXISTS `PartierFollowsDJ` (
  `idPartier` int(11) NOT NULL,
  `idDJ` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPartier`,`idDJ`),
  KEY `fk_Partier_has_DJ_DJ1_idx` (`idDJ`),
  KEY `fk_Partier_has_DJ_Partier1_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierFollowsPub`
--

CREATE TABLE IF NOT EXISTS `PartierFollowsPub` (
  `idPartier` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPartier`,`idPub`),
  KEY `fk_Partier_has_Pub_Pub1_idx` (`idPub`),
  KEY `fk_Partier_has_Pub_Partier1_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierGoesToEvent`
--

CREATE TABLE IF NOT EXISTS `PartierGoesToEvent` (
  `idPartier` int(11) NOT NULL,
  `idEvent` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPartier`,`idEvent`),
  KEY `PartierGoesToEvent_ibfk_2` (`idEvent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierGoToPub`
--

CREATE TABLE IF NOT EXISTS `PartierGoToPub` (
  `idPartier` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `assistdate` date NOT NULL,
  PRIMARY KEY (`idPartier`,`idPub`,`assistdate`),
  KEY `fk_Partier_has_Pub_Pub1_idx` (`idPub`),
  KEY `fk_Partier_has_Pub_Partier1_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierIsInLists`
--

CREATE TABLE IF NOT EXISTS `PartierIsInLists` (
  `idPartier` int(11) NOT NULL,
  `idLists` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `numGuest` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPartier`,`idLists`),
  KEY `fk_Partier_has_Lists_Lists1_idx` (`idLists`),
  KEY `fk_Partier_has_Lists_Partier1_idx` (`idPartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierIsInPub`
--

CREATE TABLE IF NOT EXISTS `PartierIsInPub` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPartier` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  `inside` tinyint(1) NOT NULL DEFAULT '0',
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_Partier_has_Pub_Pub2_idx` (`idPub`),
  KEY `fk_Partier_has_Pub_Partier2_idx` (`idPartier`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierMode`
--

CREATE TABLE IF NOT EXISTS `PartierMode` (
  `idPartier` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mode` tinyint(1) NOT NULL,
  PRIMARY KEY (`idPartier`,`createdTime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierStatus`
--

CREATE TABLE IF NOT EXISTS `PartierStatus` (
  `idPartier` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(140) NOT NULL,
  PRIMARY KEY (`idPartier`,`createdTime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PartierVoteTrack`
--

CREATE TABLE IF NOT EXISTS `PartierVoteTrack` (
  `idTrack` int(11) NOT NULL,
  `idPartier` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTrack`,`idPartier`,`idPub`),
  KEY `idTrack` (`idTrack`),
  KEY `PartierVoteTrack_ibfk_2` (`idPartier`),
  KEY `PartierVoteTrack_ibfk_3` (`idPub`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PlayList`
--

CREATE TABLE IF NOT EXISTS `PlayList` (
  `idTrack` int(11) NOT NULL AUTO_INCREMENT,
  `idPub` int(11) NOT NULL,
  `trackName` varchar(40) NOT NULL,
  `trackArtist` varchar(40) NOT NULL,
  `votes` int(11) NOT NULL DEFAULT '0',
  `playing` int(11) NOT NULL DEFAULT '0',
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTrack`,`idPub`),
  KEY `PlayList_ibfk_1` (`idPub`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=74 ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Profile`
--

CREATE TABLE IF NOT EXISTS `Profile` (
  `idProfile` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT 'type: \n0 - partier\n1 - pub\n-1 - dj',
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`idProfile`),
  KEY `fk_Profile_User_idx` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Pub`
--

CREATE TABLE IF NOT EXISTS `Pub` (
  `idPub` int(11) NOT NULL AUTO_INCREMENT,
  `idProfile` int(11) NOT NULL,
  `companyNameLocal` varchar(50) NOT NULL,
  `localName` varchar(20) NOT NULL,
  `cif` varchar(9) NOT NULL,
  `poblationLocal` varchar(20) NOT NULL,
  `cpLocal` int(5) NOT NULL,
  `telephoneLocal` int(11) NOT NULL,
  `street` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-Calle \n1-Avda \n2-Plaza ',
  `streetNameLocal` varchar(50) NOT NULL,
  `streetNumberLocal` varchar(50) NOT NULL,
  `latitude` varchar(11) DEFAULT NULL,
  `longitude` varchar(11) DEFAULT NULL,
  `music` varchar(20) DEFAULT '0',
  `entryPrice` int(11) DEFAULT NULL,
  `drinkPrice` int(11) DEFAULT NULL,
  `openingHours` time DEFAULT NULL,
  `closeHours` time DEFAULT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `about` varchar(200) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `music_p` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - publico\n0 - solo amigos\n-1 - privado',
  `entryPrice_p` tinyint(1) NOT NULL DEFAULT '1',
  `drinkPrice_p` tinyint(1) NOT NULL DEFAULT '1',
  `openingHours_p` tinyint(1) NOT NULL DEFAULT '1',
  `closeHours_p` tinyint(1) NOT NULL DEFAULT '1',
  `picture_p` tinyint(1) NOT NULL DEFAULT '1',
  `about_p` tinyint(1) NOT NULL DEFAULT '1',
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `facebook_p` tinyint(1) NOT NULL DEFAULT '1',
  `twitter_p` tinyint(1) NOT NULL DEFAULT '1',
  `instagram_p` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idPub`),
  KEY `fk_Pub_Profile1_idx` (`idProfile`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User`
--

CREATE TABLE IF NOT EXISTS `User` (
  `email` varchar(50) NOT NULL,
  `password` varchar(80) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '0 - facebook\n1 - google\n-1 - registrado',
  `token` varchar(45) DEFAULT NULL,
  `tokenMobile` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Works`
--

CREATE TABLE IF NOT EXISTS `Works` (
  `idDJ` int(11) NOT NULL,
  `idPub` int(11) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDJ`,`idPub`),
  KEY `fk_DJ_has_Pub_Pub1_idx` (`idPub`),
  KEY `fk_DJ_has_Pub_DJ1_idx` (`idDJ`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `DJ`
--
ALTER TABLE `DJ`
  ADD CONSTRAINT `fk_DJ_Profile1` FOREIGN KEY (`idProfile`) REFERENCES `Profile` (`idProfile`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Event`
--
ALTER TABLE `Event`
  ADD CONSTRAINT `Event_ibfk_2` FOREIGN KEY (`idProfileCreator`) REFERENCES `Pub` (`idPub`);

--
-- Filtros para la tabla `Fotos`
--
ALTER TABLE `Fotos`
  ADD CONSTRAINT `fk_Fotos_Profile1` FOREIGN KEY (`idProfile`) REFERENCES `Profile` (`idProfile`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Friends`
--
ALTER TABLE `Friends`
  ADD CONSTRAINT `fk_Partier_has_Partier_Partier2` FOREIGN KEY (`idPartier2`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_Partier_Partier1` FOREIGN KEY (`idPartier1`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `HowManyCheckIn`
--
ALTER TABLE `HowManyCheckIn`
  ADD CONSTRAINT `HowManyCheckIn_ibfk_2` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE,
  ADD CONSTRAINT `HowManyCheckIn_ibfk_1` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Lists`
--
ALTER TABLE `Lists`
  ADD CONSTRAINT `fk_Lists_Pub1` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Partier`
--
ALTER TABLE `Partier`
  ADD CONSTRAINT `fk_Partier_Profile1` FOREIGN KEY (`idProfile`) REFERENCES `Profile` (`idProfile`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `PartierFollowsDJ`
--
ALTER TABLE `PartierFollowsDJ`
  ADD CONSTRAINT `fk_Partier_has_DJ_DJ1` FOREIGN KEY (`idDJ`) REFERENCES `DJ` (`idDJ`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_DJ_Partier1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `PartierFollowsPub`
--
ALTER TABLE `PartierFollowsPub`
  ADD CONSTRAINT `fk_Partier_has_Pub_Pub1` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_Pub_Partier1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `PartierGoesToEvent`
--
ALTER TABLE `PartierGoesToEvent`
  ADD CONSTRAINT `PartierGoesToEvent_ibfk_2` FOREIGN KEY (`idEvent`) REFERENCES `Event` (`idEvent`) ON DELETE CASCADE,
  ADD CONSTRAINT `PartierGoesToEvent_ibfk_1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE;

--
-- Filtros para la tabla `PartierGoToPub`
--
ALTER TABLE `PartierGoToPub`
  ADD CONSTRAINT `PartierGoToPub_ibfk_2` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`),
  ADD CONSTRAINT `PartierGoToPub_ibfk_1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`);

--
-- Filtros para la tabla `PartierIsInLists`
--
ALTER TABLE `PartierIsInLists`
  ADD CONSTRAINT `fk_Partier_has_Lists_Lists1` FOREIGN KEY (`idLists`) REFERENCES `Lists` (`idLists`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_Lists_Partier1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `PartierIsInPub`
--
ALTER TABLE `PartierIsInPub`
  ADD CONSTRAINT `fk_Partier_has_Pub_Pub2` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Partier_has_Pub_Partier2` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `PartierMode`
--
ALTER TABLE `PartierMode`
  ADD CONSTRAINT `PartierMode_ibfk_1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE;

--
-- Filtros para la tabla `PartierStatus`
--
ALTER TABLE `PartierStatus`
  ADD CONSTRAINT `PartierStatus_ibfk_1` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE;

--
-- Filtros para la tabla `PartierVoteTrack`
--
ALTER TABLE `PartierVoteTrack`
  ADD CONSTRAINT `PartierVoteTrack_ibfk_3` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE CASCADE,
  ADD CONSTRAINT `PartierVoteTrack_ibfk_1` FOREIGN KEY (`idTrack`) REFERENCES `PlayList` (`idTrack`) ON DELETE CASCADE,
  ADD CONSTRAINT `PartierVoteTrack_ibfk_2` FOREIGN KEY (`idPartier`) REFERENCES `Partier` (`idPartier`) ON DELETE CASCADE;

--
-- Filtros para la tabla `PlayList`
--
ALTER TABLE `PlayList`
  ADD CONSTRAINT `PlayList_ibfk_1` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Profile`
--
ALTER TABLE `Profile`
  ADD CONSTRAINT `fk_Profile_User` FOREIGN KEY (`email`) REFERENCES `User` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Pub`
--
ALTER TABLE `Pub`
  ADD CONSTRAINT `fk_Pub_Profile1` FOREIGN KEY (`idProfile`) REFERENCES `Profile` (`idProfile`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Works`
--
ALTER TABLE `Works`
  ADD CONSTRAINT `fk_DJ_has_Pub_DJ1` FOREIGN KEY (`idDJ`) REFERENCES `DJ` (`idDJ`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DJ_has_Pub_Pub1` FOREIGN KEY (`idPub`) REFERENCES `Pub` (`idPub`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

DELIMITER $$
CREATE PROCEDURE `deleteAllPub`(idProf INT)
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

		DELETE FROM `HowManyCheckin` 
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
  
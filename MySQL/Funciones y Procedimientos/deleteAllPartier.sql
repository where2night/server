DELIMITER $$
CREATE PROCEDURE `deleteAllPartier`(idProf INT)
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

		DELETE FROM `HowManyCheckin` 
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
        
        DELETE FROM `PartierGoesToEvent` 
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
		WHERE (idPartier = idP);	

        DELETE FROM `Profile` 
		WHERE (idProfile = idProf);

        DELETE FROM `User`
		WHERE (email = email2);  


  END$$
  
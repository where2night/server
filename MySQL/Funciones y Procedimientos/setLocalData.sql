DELIMITER //
 
 CREATE PROCEDURE setLocalData(IN idProfile INT,IN companyNameLocal VARCHAR(50), 
 	IN localName VARCHAR(20),IN cif VARCHAR(9),IN poblationLocal VARCHAR(20),
 	IN cpLocal INT (5),IN telephoneLocal INT,IN street TINYINT(1),
 	IN streetNameLocal VARCHAR(50),IN streetNumberLocal VARCHAR(50),
  	IN music VARCHAR(20),IN entryPrice INT,IN drinkPrice INT,IN openingHours TIME(2),
  	IN closeHours TIME(2),IN picture VARCHAR(100),IN about VARCHAR(200))

    BEGIN
		UPDATE Pub p
		SET 
			P.companyNameLocal = companyNameLocal, 
 			P.localName= localName,
 			P.cif= cif,
 			P.poblationLocal= poblationLocal,
 			P.cpLocal= cpLocal,
 			P.telephoneLocal= telephoneLocal,
  		P.street= street,
  		P.streetNameLocal= streetNameLocal,
  		P.streetNumberLocal= streetNumberLocal,
  		P.music= music,
  		P.entryPrice= entryPrice,
  		P.drinkPrice= drinkPrice,
  		P.openingHours= openingHours,
  		P.closeHours=  closeHours,
  		P.picture= picture,
  		P.about= about	
		
		WHERE (p.idProfile = idProfile);
	END//
    
DELIMITER ;
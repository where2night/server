DELIMITER //
 
 CREATE PROCEDURE howManyCheckIn(idProfile INT(11),idPub INT(11))
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
		
	END//
    
DELIMITER ;
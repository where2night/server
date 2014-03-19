 DELIMITER //
 
 CREATE PROCEDURE setDJData(IN idProfile INT, IN nameDJ VARCHAR (30) ,IN name VARCHAR(20) ,IN surname VARCHAR(45),
  IN telephoneDJ INT ,IN gender TINYINT(1) ,IN birthdate DATE ,
  IN picture VARCHAR(100) ,IN music VARCHAR(20) ,IN about VARCHAR(200))

    BEGIN
    UPDATE DJ p
    SET 
      p.nameDJ = nameDJ,  
      p.name = name ,
      p.surname = surname ,
      p.telephoneDJ = telephoneDJ ,
      p.gender = gender ,
      p.birthdate = birthdate ,
      p.picture = picture ,
      p.music = music ,
      p.about = about
      
    WHERE (p.idProfile = idProfile);
  END//
    
DELIMITER ;
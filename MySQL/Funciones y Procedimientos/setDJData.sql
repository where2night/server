 DELIMITER //
 
 CREATE PROCEDURE setLocalData(IN idProfile INT, IN nameDJ VARCHAR (30) ,IN name VARCHAR(20) ,IN surname VARCHAR(45),
  IN telephoneDJ INT ,IN gender TINYINT(1) ,IN birthdate DATE ,
  IN picture VARCHAR(100) ,IN music VARCHAR(20) ,IN about VARCHAR(200),
  IN birthdate_p TINYINT(1) ,IN gender_p TINYINT(1),IN music_p TINYINT(1),IN about_p TINYINT(1))

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
      p.about = about ,
      p.birthdate_p = birthdate_p ,
      p.gender_p = gender_p , 
      p.music_p = music_p ,
      p.about_p =about_p
      
    
    WHERE (p.idProfile = idProfile);
  END//
    
DELIMITER ;
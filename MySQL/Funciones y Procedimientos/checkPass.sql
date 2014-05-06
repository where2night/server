-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `checkPass`(id INT(11), pass VARCHAR(80)) RETURNS tinyint(1)
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
END
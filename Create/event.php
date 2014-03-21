<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");

	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		  case 'POST':
			if (isset($_POST["idProfile"]) && $_POST["idProfile"] != ""){ 
				$idProfile=$_POST["idProfile"];
				$type = _getTypeProfile($idProfile); 
				$title = $_POST["title"];
  				$text = $_POST["text"];
  				$date = $_POST["date"];
  				$startHour = $_POST["startHour"];
  				$closeHour = $_POST["closeHour"];
  				
  				switch ($type) {
  					case '1': //pub
  						$id = _getPubId($idProfile);
  						break;
  					case '-1':
  						$id = _getDjId($idProfile);
  						break;
  					
  					default:
  						echo "No tiene permisos para crear eventos NO DJ//NO LOCAL";
  						break;
  				}

  				$arr = _insertEvent($type,$title,$text,$date,$startHour,$closeHour,$id);
				$arr['New'] = true;
				echo json_encode($arr);
			}
			
			
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
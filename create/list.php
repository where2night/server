<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];


	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		  case 'POST':
	
			if ($idProfile != ""){
				$type = _getTypeProfile($idProfile); 
				$title = $_POST["title"];
  				$text = $_POST["text"];
  				$date = $_POST["date"];
  				$closedate= $_POST["closeDate"];
  				$maxGuest= $_POST["maxGuest"];
  				$date = _formato_fechasFB($date);
  				$closedate=_formato_fechasFB($closedate);
  				$startHour = $_POST["startHour"];
  				$closeHour = $_POST["closeHour"];
  			
  				switch ($type) {
  					case '0': //partier
						echo "No tiene permisos para crear eventos NO DJ//NO LOCAL";
						$arr['New'] = false;
					break;
 
  					default:
  						$arr = _insertList($idProfile,$title,$text,$date,$startHour,$closeHour,$closedate,$maxGuest);
						$arr['New'] = true;
  					break;
  				}
				echo json_encode($arr);
			}
			
			
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
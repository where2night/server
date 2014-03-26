<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idEvent = $request[0];
	$idProfile = $request[1];
	
	if (isset($_SERVER['REQUEST_METHOD']) ){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if (isset($_POST["idProfile"])){

				$idProfile = $_POST["idProfile"];
				$idEvent = $_POST["idEvent"];
				$title = $_POST["nameDJ"];
  				$text = $_POST["name"];
  				$date = $_POST["surname"];
  				$date = _formato_fechasFB($date);
  				$startHour = $_POST["telephoneDJ"];
  				$closeHour = $_POST["gender"];
  				
				_setEventData($idProfile,$idEvent,$title,$text,$date,$startHour,$closeHour);
				
			}	
				
			break;	

		case 'GET':
				
				$data = _getEventData($idEvent,$idProfile);
				$data['date'] = _formato_fechas($data['date']);	
				echo json_encode($data);
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

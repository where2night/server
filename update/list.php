<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idList = $request[0];
	$idProfile = $request[1];
	
	if (isset($_SERVER['REQUEST_METHOD']) ){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if (isset($_POST["idProfile"])){

				$idProfile = $_POST["idProfile"];
				$idList = $_POST["idList"];
				$title = $_POST["title"];
  				$text = $_POST["text"];
  				$date = $_POST["date"];
  				$date = _formato_fechasFB($date);
  				$startHour = $_POST["startHour"];
  				$closeHour = $_POST["closeHour"];
  				
				_setListData($idProfile,$idList,$title,$text,$date,$startHour,$closeHour);
				
			}	
				
			break;	

		case 'GET':
				
				$data = _getListData($idList,$idProfile);
				$data['date'] = _formato_fechas($data['date']);	
				echo json_encode($data);
			break;
		
		case 'DELETE':
				$data = _deleteList($idList,$idProfile);
				$data['Delete'] = true ;
				echo json_encode($data);
				break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

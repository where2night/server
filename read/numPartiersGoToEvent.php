<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idEvent = $request[2]; //Event

	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile != "" && $idEvent != ""){
					$res= _howManyGoesToEvent($idEvent);			
					echo json_encode($res);

				}
					
			break;
				
		  default:
			break;
		}
	}

?>
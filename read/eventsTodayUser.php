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
			
			case 'GET':
				
				$data = _getEventsTodayUser($idProfile);
				echo json_encode($data);
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}
	else{
	echo json_encode(array('Error' => '1'));
	}

?>
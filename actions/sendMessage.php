<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idReceiver=$request[2];
	$tokenT= _tokenOK($idProfile,$token);
	//If $tokenT is 1 access granted if it is 0 access not granted
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT==1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if ($idProfile != "" && $idReceiver != ""){			
				$message = $_POST["message"]; 
				_sendMessage($idProfile,$idReceiver,$message);
				$aux['send']=true;
			}else{
				$aux['send']=false;
			}	
			echo json_encode($aux);
				
			break;	

		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
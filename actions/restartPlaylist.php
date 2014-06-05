<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$tokenT= _tokenOK($idProfile,$token);

	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT==1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if ($idProfile != ""){
				_restartPlaylist($idProfile);
				$aux['restartPlayList']=true;
				
			}else{
				$aux['restartPlayList']=false;
			}	
			echo json_encode($aux);	
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

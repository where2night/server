<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idTrack = $request[2];
	$tokenT= _tokenOK($idProfile,$token);

	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT==1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if ($idProfile != "" and $idTrack != ""){
  				
				_playTrack($idProfile,$idTrack);
				$aux['playTrack']=true;
				
			}else{
				$aux['playTrack']=false;
			}	
			echo json_encode($aux);	
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

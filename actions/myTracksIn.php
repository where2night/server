<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idPub= $request[2];

	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idPub != ""){
					$aux = _myTracksIn($idProfile,$idPub);
					$aux['myTracksIn']= true;
				}else{
					$aux['myTracksIn']=false;
				}
				echo json_encode($aux);
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
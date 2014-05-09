<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile1 = $request[0];
	$token = $request[1];
	$idProfile2 = $request[2];

	$tokenT= _tokenOK($idProfile1,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile1 != ""){
					$data= _getMessagesFriend($idProfile1,$idProfile2);
				}
				echo json_encode($data);
					
			break;	

		  default: 
			break;
		}
	}

?>
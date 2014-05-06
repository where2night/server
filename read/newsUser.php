<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idPartier=$request[2];
	$page = $request[3];

	$tokenT= _tokenOK($idProfile,$token);
	$MAX_ITEMS = 10;
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile != ""){
					$start = $MAX_ITEMS * $page;
					$data= _getNewsUser($idPartier, $idProfile ,$start);
					echo json_encode($data);

				}
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
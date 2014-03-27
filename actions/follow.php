<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idUser = $request[2];

	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile != "" && $idUser != ""){
					$type = _getTypeProfile($idUser);
					if ($type == -1) { //DJ
						$aux = _followDj($idProfile,$idUser);
						$aux['follow'] = true;
					} elseif ($type == 1) { //Local
						$aux = _followLocal($idProfile,$idUser);
						$aux['follow'] = true;
					} else{
						$aux['follow'] = false;
						echo "FALLO EN FOLLOWDJ ";
					}
					echo json_encode($aux);

				}
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

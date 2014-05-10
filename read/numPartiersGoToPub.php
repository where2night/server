<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idUser = $request[2]; //Pub

	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile != "" && $idUser != ""){
					$type = _getTypeProfile($idUser);
					if ($type == 1) { //Pub
						$res= _howManyGoToPub($idUser);
					} else{
						echo "No es un local.";
					}
					
					echo json_encode($res);

				}
					
			break;
				
		  default:
			break;
		}
	}

?>

<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idPub = $request[2];
	$idTrack = $request[3];

	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {

			case 'POST': //add to List

				if ($idProfile != "" && $idTrack != "" && $idPub != ""){
					$type=_getTypeProfile($idUser);
					if ($type == 0){ //Partier
						$aux = _voteTrack($idProfile,$idPub,$idTrack);
						$aux['vote'] = true;
						$aux['error'] = false;
					}else{
						$aux['error'] = true;
					}


					

				}else{
					$aux['vote']=false;
					$aux['error']=true;
				}
				echo json_encode($aux);
					
			break;
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
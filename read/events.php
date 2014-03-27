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
						$aux=_getDJData($idUser);
						$resaux= array('name'=> $aux['nameDJ'],'pictureC'=> $aux['picture'] );
					} elseif ($type == 1) { //Local
						$aux= _getLocalData($idUser);
						$resaux= array('name'=> $aux['localName'],'pictureC'=> $aux['picture'] );
					} else{
						echo "FALLO EN GETEVENTS LOS EVENTOS NO ESTAN CREADOS POR DJ O LOCAL";
					}
					
					$data= _getEvents($idUser);
					$data=array_merge($resaux,$data);
					echo json_encode($data);

				}
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
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
					if ($type == 1) { //Local
						$aux= _getLocalData($idUser);
						$resaux= array('name'=> $aux['localName'],'pictureC'=> $aux['picture'],'error'=> false );
					} else{
						
					}
					
					$data= _getLists($idProfile,$idUser);
					if($data != null){
						$data=array_merge($resaux,$data);
					}else{
						
						$data=$resaux;
						$data['error']= true;

					}
					
					echo json_encode($data);

				}
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

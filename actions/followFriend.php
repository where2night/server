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
			case 'POST':
				if ($idProfile != "" && $idUser != ""){
					if ($type == 0){ //Partier
						$idProfile = $_POST["idProfile"];
						$idUser = $_POST["idPartier"];
						$mode = _getModeFollow($idProfile,$idUser);
						if($mode == 0){
							$idP1= _getIdPartier($idProfile);
							$idP2= _getIdPartier($idUser);
							$mode=1;
							$aux = _setModeFollowPartier($idP1,$idP2,$mode);
							$aux['follow']=true;
						}else{
							$aux["follow"]=false;
						}

					}else{
						$aux['follow'] = false;
					}
				}
				break;
			case 'GET':
				if ($idProfile != "" && $idUser != ""){
					$type = _getTypeProfile($idUser);
					$mode = 0;
					if ($type == 0){ //Partier
						$aux = _followPartier($idProfile,$idUser,$mode);
						$aux['follow']=true;
					}else{
						$aux['follow'] = false;
					}
					echo json_encode($aux);

				}

		break;	
		
				case 'DELETE':
					if ($idProfile != "" && $idUser != ""){
					$type = _getTypeProfile($idUser);
					if ($type == 0){ //Partier
						 //cancel request friendship
							$aux = _unFollowPartier($idProfile,$idUser);
							$aux['delete'] = true;
					}
					else{
						$aux['delete'] = false;
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

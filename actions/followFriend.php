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
					//$idProfile = $_POST["idProfile"];
					//$idUser = $_POST["idPartier"];
					$type=_getTypeProfile($idUser);
					if ($type == 0){ //Partier	
						$mode = _getModeFollow($idProfile,$idUser);
						if($mode == 4){
							$aux = _acceptFriend($idProfile,$idUser);
							$aux['follow']=true;
						}else{
							$aux['follow']= false; 
						}

					}else{
						$aux['follow'] = false;
					}
				}
				echo json_encode($aux);
				break;
			case 'GET':
				if ($idProfile != "" && $idUser != ""){
					$type = _getTypeProfile($idUser);
					
					if ($type == 0){ //Partier
						$aux = _followPartier($idProfile,$idUser);
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
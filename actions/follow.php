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
					} elseif($type == 0){ //Partier
					
						$a=_followPartier($idProfile,$idUser,0);
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
					if ($type == -1) { //DJ

						$aux = _unFollowDj($idProfile,$idUser);
						$aux['follow'] = true;
					} elseif ($type == 1) { //Local
						$aux = _unFollowLocal($idProfile,$idUser);
						$aux['follow'] = true;
					} elseif ($type == 0){ //Partier
						$aux = _unFollowPartier($idProfile,$idUser);
						$aux['follow'] = true;
					}
					else{
						$aux['follow'] = false;
					}
					echo json_encode($aux);


				}
		 		
		break;
		default:
		//	rest_error($request);  
		break;		

		}

	}else{
						$aux['follow'] = false;
						$aux['info']="token and user are not correct";
						echo json_encode($aux);
						}

?>

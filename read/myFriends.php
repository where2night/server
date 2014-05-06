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
				if ($idProfile != ""){
					$type=_getTypeProfile($idUser);
					if($type == 0){
						//$idPartier = _getIdPartier($idProfile);
						$aux = _getMyFriends($idUser);
						$num= $aux['rows'];
						for ($i=0; $i < $num ; $i++) {
							$idP=$aux[$i]; 
							$idP=$idP['idProfile'];
							
							$aux1[$i]=_getPartierData($idP);
							$aux1[$i]['idProfile']=$idP;
							
							
						}
						$aux1['numFriends']=$num;
						$aux1['myfriends']= true;
					}else{
						$aux1['myfriends']=false;
					}	
					echo json_encode($aux1);

				}
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
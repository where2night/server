<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];

	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile != ""){
					$type=_getTypeProfile($idProfile);
					if($type == 0){
						$idPartier = _getIdPartier($idProfile);
						$aux = _getMyFriends($idPartier);
						$num= $aux['rows'];
						for ($i=0; $i < $num ; $i++) {
							$idP=$aux[$i]['idProfile']; 
							$aux1[$i]=_getDataPartier($idP);
							$aux1[$i]['idProfile']=$idP;
						}
						$aux1['myfriends']= true;
					}else{
						$aux1['myfriends']=false;
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
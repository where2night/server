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
					$type= _getTypeProfile($idProfile);
					if(type == 1){
						$aux = _pubfollowers($idProfile);
						$num = $aux['rows'];
						for ($i=0; $i < $num ; $i++) {
							$idPartier=$aux[$i]; 
							$aux1[$i]= _getPartierData($idPartier);
							$aux1[$i]['idPartier'] = $idPartier;
						}

						$aux1['pubfollowers'] = true;
						
					}else{
						$aux1['pubfollowers'] = false;
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
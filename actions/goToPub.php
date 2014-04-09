<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idLocal = $request[2];

	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile != "" && $idLocal != ""){
					$type = _getTypeProfile($idLocal);
					if ($type == 1) { //pub
						$aux = _goToPub($idProfile,$idLocal);
						$aux['goToPub'] = true;
					}else{
						$aux['goToPub'] = "error";
					
					}
					echo json_encode($aux);

				}
					
			break;
			case 'DELETE':
				if ($idProfile != "" && $idLocal != ""){
						$go= _goesToPub($idProfile,$idLocal);
						echo "go:$0";
						if($go==1){
							$aux= _dontGoToPub($idProfile,$idLocal);
							$aux['goToPub']= false;
						}else{
							$aux['goToPub']="error";
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

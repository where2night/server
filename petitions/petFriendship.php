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

					$data= _getWhoFriend($idProfile);
					$num= $data['rows'];
					for ($i=0; $i < $num ; $i++) { 
						$aux=$data[$i];
						$aux=$aux['idProfile'];
						$aux1[$i]=_getPartierData($aux);
						$aux1[$i]['idProfile']=$aux;

					}
					$aux1['numPetitions']=$num;
					$aux1['friendship']=true;

				}else{
					$aux1['friendship']=false;
				}

				echo json_encode($aux1);
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

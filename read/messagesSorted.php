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
					$aux= _getPartiersMessages($idProfile);
				}
				
				for ($i=0; $i < sizeof($aux) ; $i++) {
							$idP = $aux[$i]['idProfile'];
							$data[$i] = _getMessagesFriend($idProfile,$idP);
	                        $data[$i]['idProfile']=$idP;  
								
						} 


				echo json_encode($data);
					
			break;	

		  default: 
			break;
		}
	}

?>
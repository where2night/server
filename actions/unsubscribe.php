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
		  case 'DELETE':
	
			if ($idProfile != ""){
				$type = _getTypeProfile($idProfile); 
  			
  				switch ($type) {
  					case '0': //partier
  					    $aux= _deleteAllPartier($idProfile);						
						$aux['Baja'] = 'La baja del fiestero se ha realizado correctamente';
					break;

					case '1'://Pub
                        $aux= _deleteAllPub($idProfile);	
                        $aux['Baja'] = 'La baja del pub se ha realizado correctamente';
                        echo 'pub'
					break;
 
  					default:
						$aux['Baja'] = 'No se le puede dar de baja';
  					break;
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
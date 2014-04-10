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
					$aux = _listsUser($idProfile);
					$pos= $aux['rows'];
					for ($i=0; $i < $pos ; $i++) {
						$auxdam=$aux[$i];
						$id=$auxdam['idProfileCreator'];
						
						$type= _getTypeProfile($id); 
						
						if ($type == 1) { //Pub
							$auxdam=_getLocalData($id);
							$name= $auxdam['localName'];
							$aux[$i]['name'] = $name;
						}else{
							echo "ERROR MYLISTS.PHP";
						}
	
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
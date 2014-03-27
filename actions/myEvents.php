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

					$aux = _eventsUser($idProfile);
					for ($i=0; $i < $aux['rows'] ; $i++) {
						$auxdam=$aux[$i];
						$type= _getTypeProfile($aux['idProfileCreator']); 
						if ($type == -1) { //DJ
							$auxdam=_getDJData($aux['idProfileCreator']);
							$auxEnd= array('name' => $auxdam['nameDJ'],'pictureC' => $auxdam['picture']);
						}elseif ($type == 1) { //Pub
							$auxdam=_getLocalData($aux['idProfileCreator']);
							$auxEnd= array('name' => $auxdam['localName'],'pictureC' => $auxdam['picture']);
						}else{
							echo "ERROR MYEVENTS.PHP";
						}
	
						$aux1[$i]=array_merge($auxEnd,$aux[$i]);
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

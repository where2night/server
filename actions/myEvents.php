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
					$pos= $aux['rows'];
					for ($i=0; $i < $pos ; $i++) {
						$auxdam=$aux[$i];
						$id=$auxdam['idProfileCreator'];
						$idPPub= _getIdProfilePub($id);
						$type= _getTypeProfile($idPPub); 
						
						if ($type == -1) { //DJ
							$auxdam=_getDJData($id);
							$name= $auxdam['nameDJ'];
							$picture = $auxdam['picture'];
							$aux[$i]['name'] = $name;
							$aux[$i]['pictureC'] = $picture;
						}elseif ($type == 1) { //Pub
							$auxdam=_getLocalData($idPPub);
							$name= $auxdam['localName'];
							$picture= $auxdam['picture'];
							$aux[$i]['name'] = $name;
							$aux[$i]['pictureC'] = $picture;
							$aux[$i]['idProfile']= $idPPub;
						}else{
							
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
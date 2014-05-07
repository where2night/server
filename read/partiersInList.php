<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idList= $request[2];


	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile != ""){
					$type= _getTypeProfile($idProfile);
					if ($type==1) {//local
						$aux=_getPartiersInList($idList);
						$pos= $aux['rows'];
					for ($i=0; $i < $pos ; $i++) {
						if($aux[$i]['gender']==1){
							$aux[$i]['gender']=male;
						}else {
							$aux[$i]['gender']=female;
						}	
					}
					$aux['getPartiersInList']=true;
					}else{
						$aux['getPartiersInList']=false;
					}
					
				}
				echo json_encode($aux);
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
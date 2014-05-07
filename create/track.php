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
		  case 'POST':
	
			if($idProfile != ""){ 
				
			
				$type = _getTypeProfile($idProfile); 
				$name = $_POST["name"];
  				$artist = $_POST["artist"];
  			
  				switch ($type) {
  					case '0': //partier
						echo "No tiene permisos para crear musica";
						$arr['NewTrack'] = false;
					break;
 
  					default:
  						$arr = _insertTrack($idProfile,$name,$artist);
						$arr['NewTrack'] = true;
  					break;
  				}
				
			}else{
				$arr['NewTrack']=false;
			}
			echo json_encode($arr);
			
			
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
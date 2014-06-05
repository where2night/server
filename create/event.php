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
				$title = $_POST["title"];
  				$text = $_POST["text"];
  				$date = $_POST["date"];
  				$date = _formato_fechasFB($date);
  				$startHour = $_POST["startHour"];
  				$closeHour = $_POST["closeHour"];
  			
  				switch ($type) {
  					case '0': //partier
						echo "No tiene permisos para crear eventos NO DJ//NO LOCAL";
						$arr['New'] = false;
					break;
 
  					default:
  						$arr = _insertEvent($idProfile,$title,$text,$date,$startHour,$closeHour);
						$arr['New'] = true;
  					break;
  				}
				
			}else{
				$arr['error']=true;
			}
			echo json_encode($arr);
			
			
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idTrack= $request[2];
	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if($idProfile != ""){

				$type = _getTypeProfile($idProfile);
				if ($type == 1) { //local
					$name = $_POST["name"];
  					$artist = $_POST["artist"];
  				
					_setTrackData($idProfile,$idTrack,$name,$artist);
					$aux['updateTrack']=true;
					
				}else{
					$aux['updateTrack']=false;
				}
			}
			echo json_encode($aux);	
				
			break;	

		case 'GET':
				if($idTrack != ""){
					$data = _getTrackData($idProfile,$idTrack);
					$data['getTrack']=true;
				}else{
					$data['getTrack']=false;
				}
				echo json_encode($data);
			break;
		
		case 'DELETE':
				if($idTrack != ""){
					$data = _deleteTrack($idProfile,$idTrack);
					$data['DeleteTrack'] = true ;
				}else{
					$data['DeleteTrack']= false;
				}
				echo json_encode($data);
				break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

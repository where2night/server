<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idPartier = $request[0];
	$token = $request[1];
	$tokenT= _tokenOK($idPartier,$token);
	//If $tokenT is 1 access granted if it is 0 access not granted
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT==1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if (isset($_POST["uploading"])){
				$picture = $_POST["picture"];
				$decoded = base64_decode($picture);
				$pictureName =  substr(md5(microtime()),1,8) . ".jpg";
				$pictureUrl = "../../profilesImages/" . $pictureName;
				file_put_contents($pictureUrl ,$decoded);
				$_POST["picture"] = "http://www.where2night.es/profilesImages/" . $pictureName;
			}
			if (isset($_POST["idProfile"])){			
				$idProfile = $_POST["idProfile"];
				$picture = $_POST["picture"]; 
				$name = $_POST["name"]; 
				$surnames = $_POST["surnames"]; 
				$birthdate = $_POST["birthdate"]; 
				$birthdate=_formato_fechasP($birthdate);			
				$gender = $_POST["gender"]; 
				$genderbool=false;
				if($gender == 'male')$genderbool= true;			
				$music = $_POST["music"]; 
				$civil_state = $_POST["civil_state"]; 
				$city = $_POST['city'];
				$drink = $_POST["drink"]; 
				$about = $_POST["about"]; 
				_setPartierData($idProfile,$picture,$name,$surnames,$birthdate,$genderbool,$music,$civil_state,$city,$drink,$about);
				
			}	
				
			break;	

		case 'GET':
				$data = _getPartierData($idPartier);
				if ($data['gender'] == 1) $data['gender'] = male;
				else $data['gender'] = female;
				$data['birthdate'] = _formato_fechas($data['birthdate']);
				echo json_encode($data);
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

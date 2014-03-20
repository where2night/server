<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if (isset($_POST["idProfile"])){			
				$idProfile = $_POST["idProfile"];
				$picture = $_POST["picture"]; 
				$name = $_POST["name"]; 
				$surnames = $_POST["surnames"]; 
				$birthdate = $_POST["birthdate"]; 
				$birthdate=_formato_fechasFB($birthdate);			
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
		
			$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
			$idPartier = $request[0];
			$token = $request[1];
			$tokenT= _tokenOK($idPartier,$token);

			if($tokenT==1){
				$data = _getPartierData($idPartier);
				if ($data['gender'] == 1) $data['gender'] = male;
				else $data['gender'] = female;
				echo json_encode($data);
			}

			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
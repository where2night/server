<?php

/**
* 
*/

	require_once ("db.inc");
	require_once ("utils.inc");
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
			
			_db_connect();
			$query = "call setPartierData('{$idProfile}','{$picture}','{$name}','{$surnames}','{$birthdate}','{$genderbool}','{$music}','{$civil_state}','{$city}','{$drink}','{$about}')";
			_db_query($query);
			
			_db_close();
			$sql = "call getPartierData(\'isma_ibz2@hotmail.com\')";
			
			}			
			break;	
		case 'GET':
		
			
			
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
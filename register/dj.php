<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");

	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		  case 'POST':
			if (isset($_POST["email"]) && $_POST["email"] != ""){ 
			
				$email = $_POST["email"]; 
				$nameDJ = $_POST["nameDJ"];
				$name = $_POST["name"]; 
				$surname = $_POST["surname"]; 
				$telephone= $_POST["telephone"];
				$birthdate = $_POST["birthdate"]; 
				$birthdate=_formato_fechasFB($birthdate);

				$gender = $_POST["gender"]; 
				$genderbool=false;
				if($gender == 'male')$genderbool= true;
				
				$arr = _insertDJUser($email,$nameDJ,$name, $surname,$telephone, $birthdate, $gender);
				$arr['New'] = true;
				echo json_encode($arr);
			}
			
			
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
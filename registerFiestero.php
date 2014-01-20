<?php

	require_once ("db.inc");
	require_once ("utils.inc");

	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		  case 'POST':
			if (isset($_POST["email"]) && $_POST["email"] != ""){ 
			
			$email = $_POST["email"]; 
			$pass = $_POST["pass"];
			$name = $_POST["name"]; 
			$surname = $_POST["surnames"]; 
			$birthdate = $_POST["birthdate"]; 
			$birthdate=_formato_fechasFB($birthdate);
			
			$gender = $_POST["gender"]; 
			$genderbool=false;
			if($gender == 'male')$genderbool= true;
			
			$succeed = _insertUser($email,$pass,$name,$surname,$birthdate,$genderbool);
			}
			$arr = array('Token' => $succeed,
						'New' => true	);
			echo json_encode($arr);
			
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
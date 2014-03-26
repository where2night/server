<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");

	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		  case 'POST':
		    if((isset($_POST["mobile"]) && $_POST["mobile"] == "1")){$mobile=true;}
			else {$mobile=false;}
			if (isset($_POST["email"]) && $_POST["email"] != ""){ 
				$email = $_POST["email"]; 
				$password = $_POST["password"]; 
				$succeed = _login($email,$password,$mobile); 
				echo json_encode($succeed);
			}
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
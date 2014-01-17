<?php

	require_once ("db.inc");
	require_once ("utils.inc");

	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		  case 'POST':
			if (isset($_POST["email"]) && $_POST["email"] != ""){ 
			$email = $_POST["email"]; 

			$succeed = _loginFB($email); 
			$arr = array('Token' => $succeed);
			echo json_encode($arr);
			}
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
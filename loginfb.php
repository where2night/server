<?php

	require_once ("db.inc");
	require_once ("utils.inc");

	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		  case 'POST':
			if (isset($_POST["email"]) && $_POST["email"] != ""){ 
			$email = $_POST["email"]; 
			$name = $_POST["name"]; 
			$surname = $_POST["surnames"]; 
			$birthday = $_POST["birthday"]; 
			$gender = $_POST["gender"]; 
			$newuser= false;
			$succeed = _loginFB($email); 
			
			
			if($succeed == '0'){
		
			$newuser = true;
			$succeed = _insertUserFB($email,$name,$surname,$birthday,true);
			}
			$arr = array('Token' => $succeed,
						'New' => $newuser	);
			echo json_encode($arr);
			}
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
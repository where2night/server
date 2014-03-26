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

			
			$newuser= false;
			$arr = _loginGP($email,$mobile); 
			
			
			if($arr['id'] == '0'){
			
				$picture = $_POST['picture'];
				$name = $_POST["name"]; 
				$surname = $_POST["surnames"]; 
				$birthdate = $_POST["birthdate"]; 
			
				
				$gender = $_POST["gender"]; 
				$genderbool=false;
				if($gender == 'male')$genderbool= true;
				$newuser = true;
				
				$arr = _insertUserGP($picture,$email,$name,$surname,$birthdate,$genderbool,$mobile);
			}
			$arr['New'] = $newuser;
			echo json_encode($arr);
			
			}
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
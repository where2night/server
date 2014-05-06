<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
$idProfile = $_POST["idProfile"];
$token = $_POST["token"];

	$tokenT= _tokenOK($idProfile,$token);
	//If $tokenT is 1 access granted if it is 0 access not granted
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT==1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':


			if (isset($_POST["idProfile"])){			
				$idProfile = $_POST["idProfile"];
				$oldPass = $_POST["oldPass"]; 
				$newPass = $_POST["newPass"]; 

				$a= _setUserPass($idProfile,$oldPass,$newPass);
							
				echo json_encode($a);
				
			}	
				
			break;	


		  default:
		//	rest_error($request);  
			break;
		}
	}
	else{
	echo json_encode(array('Error' => '1'));
	}

?>

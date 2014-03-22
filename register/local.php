<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");

	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		  case 'POST':
			if (isset($_POST["email"]) && $_POST["email"] != ""){ 
			
				$email = $_POST["email"]; 
				$companyName = $_POST["companyName"];
				$localName = $_POST["localName"]; 
				$cif = $_POST["cif"]; 
				$poblationLocal = $_POST["poblationLocal"]; 
				$cpLocal= $_POST["cpLocal"];
				$telephone= $_POST["telephone"];
				$street= $_POST["street"];
				$streetName= $_POST["streetName"];
				$streetNumber= $_POST["streetNumber"];
				
				$arr = _insertLocalUser($email,$companyName,$localName, $cif, $poblationLocal, $cpLocal, $telephone, $street, $streetName,$streetNumber);
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
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
				
				$address = $streetName . " " . $streetNumber . " " . $cpLocal . " " . $poblationLocal;
				
				$address = urlencode($address);
				$url = "http://maps.google.com/maps/api/geocode/json?sensor=false&address=" . $address;
				$response = file_get_contents($url);
				$json = json_decode($response,true);
				$lat = $json['results'][0]['geometry']['location']['lat'];
				$lng = $json['results'][0]['geometry']['location']['lng'];
				
				
				$arr = _insertLocalUser($email,$companyName,$localName, $cif, $poblationLocal, $cpLocal, $telephone, $street, $streetName,$streetNumber, $lat , $lng);
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
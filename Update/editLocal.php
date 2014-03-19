<?php

	require_once ("db.inc");
	require_once ("utils.inc");
	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if (isset($_POST["idProfile"])){

				$idProfile = $_POST["idProfile"];
				$companyNameLocal = $_POST["companyNameLocal"];
				$localName = $_POST["localName"];
				$cif = $_POST["cif"];
				$poblationLocal = $_POST["poblationLocal"];
				$cpLocal = $_POST["cpLocal"];
				$telephoneLocal = $_POST["telephoneLocal"];
				$street = $_POST["street"];
				$streetNameLocal = $_POST["streetNameLocal"];
				$streetNumberLocal = $_POST["streetNumberLocal"];
				$music = $_POST["music"];
				$entryPrice = $_POST["entryPrice"];
				$drinkPrice = $_POST["drinkPrice"];
				$openingHours = $_POST["openingHours"];
				$closeHours = $_POST["closeHours"];
				$picture = $_POST["picture"];				
				$about = $_POST["about"];

				_setLocalData($idProfile,$companyNameLocal,$localName,$cif,$poblationLocal,$cpLocal,$telephoneLocal,$street,$streetNameLocal,$streetNumberLocal,$music,$entryPrice,$drinkPrice,$openingHours,$closeHours,$picture,$about);
				
			}	
				
			break;	

		case 'GET':
		
			$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
			$idLocal = $request[0];
			$token = $request[1];
			$tokenT= _tokenOK($idLocal,$token);

			if($tokenT==1){
				$data = _getLocalData($idLocal);
				if ($data['gender'] == 1) $data['gender'] = male;
				else $data['gender'] = female;
				echo json_encode($data);
			}

			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
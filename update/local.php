<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idPartier = $request[0];
	$token = $request[1];
	$idLocal = $request[2];
	$tokenT= _tokenOK($idPartier,$token);
	//If $tokenT is 1 access granted if it is 0 access not granted
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT==1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if (isset($_POST["idProfile"])){

				$idProfile = $_POST["idProfile"];
				$companyNameLocal = $_POST["companyName"];
				$localName = $_POST["localName"];
				$cif = $_POST["cif"];
				$poblationLocal = $_POST["poblationLocal"];
				$cpLocal = $_POST["cpLocal"];
				$telephoneLocal = $_POST["telephoneLocal"];
				$street = $_POST["street"];
				$streetNameLocal = $_POST["streetName"];
				$streetNumberLocal = $_POST["streetNumber"];
				$lat = $_POST["latitude"];
				$lng = $_POST["longitude"];
				$music = $_POST["music"];
				$entryPrice = $_POST["entryPrice"];
				$drinkPrice = $_POST["drinkPrice"];
				$openingHours = $_POST["openingHours"];
				$closeHours = $_POST["closeHours"];
				$picture = $_POST["picture"];				
				$about = $_POST["about"];
				$facebook = $_POST['facebook'];
				$twitter = $_POST["twitter"]; 
				$instagram = $_POST["instragram"]; 

				_setLocalData($idProfile,$companyNameLocal,$localName,$cif,$poblationLocal,$cpLocal,$telephoneLocal,$street,$streetNameLocal,$streetNumberLocal,$lat,$lng,$music,$entryPrice,$drinkPrice,$openingHours,$closeHours,$picture,$about,$facebook,$twitter,$instagram);
				
			}	
				
			break;	

		case 'GET':
				$data = _getLocalData($idLocal);

				$follow = _userFollowsPub($idLocal,$idPartier);
				$followers = _howManyFollowsPub($idLocal);
				$go=_goesToPub($idPartier,$idLocal);
				$data['follow'] = $follow;
				$data['followers'] = $followers;
				$data['goto']= $go;
				echo json_encode($data);
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
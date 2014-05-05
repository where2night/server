<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idPartier = $request[0];
	$token = $request[1];
	$idUser= $request[2];
	$tokenT= _tokenOK($idPartier,$token);
	//If $tokenT is 1 access granted if it is 0 access not granted
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT==1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':


			if (isset($_POST["uploading"])){

				$picture = $_POST["picture"];
				$decoded = base64_decode($picture);
				$pictureName =  substr(md5(microtime()),1,8) . ".jpg";
				$pictureUrl = "../../profilesImages/" . $pictureName;
				file_put_contents($pictureUrl ,$decoded);
				$_POST["picture"] = "http://www.where2night.es/profilesImages/" . $pictureName;
			}
			if (isset($_POST["idProfile"])){			
				$idProfile = $_POST["idProfile"];
				$picture = $_POST["picture"]; 
				$name = $_POST["name"]; 
				$surnames = $_POST["surnames"]; 
				$birthdate = $_POST["birthdate"]; 
				$birthdate=_formato_fechasP($birthdate);			
				$gender = $_POST["gender"]; 
				$genderbool=false;
				if($gender == 'male')$genderbool= true;			
				$music = $_POST["music"]; 
				$civil_state = $_POST["civil_state"]; 
				$city = $_POST['city'];
				$drink = $_POST["drink"]; 
				$about = $_POST["about"]; 
				$facebook = $_POST['facebook'];
				$twitter = $_POST["twitter"]; 
				$instagram = $_POST["instragram"]; 
				_setPartierData($idProfile,$picture,$name,$surnames,$birthdate,$genderbool,$music,$civil_state,$city,$drink,$about,$facebook,$twitter,$instagram);
				
			}	
				
			break;	

		case 'GET':
				$data = _getPartierData($idUser);
				if ($data['gender'] == 1) $data['gender'] = male;
				else $data['gender'] = female;
				$data['birthdate'] = _formato_fechas($data['birthdate']);
				//0- not friends 1-he want to be your friend
				// 2-yourself 3-you want to be his friend 4-friends
				if($idProfile != $idUser){
					$friend= _getModeFollow($idProfile,$idUser);
					switch ($friend) {
						case '0': //you want to be his friend
							$auxdata['modefriend']= 3;
							break;
						case '1': //friends
							$auxdata['modefriend']= 4;
							break;
						case '4': // he want to be your friend
							$auxdata['modefriend']= 1;
							break;
						
						default: // not friend
							$auxdata['modefriend']= 0;
							break;
					}
				}else{ //yourself
					$auxdata['modefriend']= 2; 
				}
				$data=array_merge($data,$aux);
				echo json_encode($data);
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

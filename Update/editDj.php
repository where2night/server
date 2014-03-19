<?php

	require_once ("db.inc");
	require_once ("utils.inc");
	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if (isset($_POST["idProfile"])){

				$idProfile = $_POST["idProfile"];
				$nameDJ = $_POST["nameDJ"];
  				$name = $_POST["name"];
  				$surname = $_POST["surname"];
  				$telephoneDJ = $_POST["telephoneDJ"];
  				$gender = $_POST["gender"];
  				$genderbool=false;
				if($gender == 'male')$genderbool= true;	
  				$birthdate = $_POST["birthdate"];
  				$birthdate=_formato_fechasFB($birthdate);
  				$picture = $_POST["picture"];
  				$music= $_POST["music"];
  				$about= $_POST["about"];
				_setDJData($idProfile,$nameDJ,$name,$surname,$telephoneDJ,$genderbool,$birthdate,$picture,$music,$about);
				
			}	
				
			break;	

		case 'GET':
		
			$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
			$idDj = $request[0];
			$token = $request[1];
			$tokenT= _tokenOK($idDJ,$token);

			if($tokenT==1){
				$data = _getDJData($idDJ);
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
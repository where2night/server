<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));

	
	
	
	if (isset($_SERVER['REQUEST_METHOD']) ){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'POST':
<<<<<<< HEAD
				if ($idProfile != "" && $idUser != ""){
					$type=_getTypeProfile($idUser);
					if ($type == 0){ //Partier	
						$mode = _getModeFollow($idProfile,$idUser);
						if($mode == 4){
							$aux = _acceptFriend($idProfile,$idUser);
							$aux['follow']=true;
						}else{
							$aux['follow']= false; 
=======
				if (($_POST["idPartier1"] != "")&& ($_POST["idPartier2"] != "")){
				$idPartier1 = $_POST["idPartier1"];
				$idPartier2 = $_POST["idPartier2"];
				$idP1= _getIdPartier($idPartier1);
				$idP2= _getIdPartier($idPartier2);
			
				$type1 = _getTypeProfile($idPartier1);
				$type2 = _getTypeProfile($idPartier2);
				

					if ($type1 == 0 && $type2 == 0){ //Partier

						$mode = _getModeFollow($idP1,$idP2);
						if($mode == 0){
							
							$mode=1;
							$aux = _setModeFollowPartier($idP1,$idP2,$mode);
							$aux['follow']=true;
						}
						else{
							$aux["follow"]=false;
>>>>>>> 7662af396af71158be2d38b65ec2383172bf563e
						}

					}else{
					
						$aux['follow'] = false;
					}
					echo json_encode($aux);
				}
<<<<<<< HEAD
				echo json_encode($aux);
=======
			
				

>>>>>>> 7662af396af71158be2d38b65ec2383172bf563e
				break;
			case 'GET':
				if ($idProfile != "" && $idUser != ""){
					$type = _getTypeProfile($idUser);
					
					if ($type == 0){ //Partier
						$aux = _followPartier($idProfile,$idUser);
						$aux['follow']=true;
					}else{
						$aux['follow'] = false;
					}
					echo json_encode($aux);

				}

		break;	
		
				case 'DELETE':
					if ($idProfile != "" && $idUser != ""){
					$type = _getTypeProfile($idUser);
					if ($type == 0){ //Partier
						 //cancel request friendship
							$aux = _unFollowPartier($idProfile,$idUser);
							$aux['delete'] = true;
					}
					else{
						$aux['delete'] = false;
					}
					echo json_encode($aux);


				}
		 		
		break;
		default:
		//	rest_error($request);  
		break;		

		}

	}

?>

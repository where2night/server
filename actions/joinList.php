<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idList = $request[2];

	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {

			case 'POST': //add to List
				if ($idProfile != "" && $idList != ""){
					$numGuest=$_POST['numGuest'];
					$aux = _joinList($idProfile,$idList,$numGuest);
					$aux['join'] = true;
					

				}else{
					$aux['join']=false;
				}
				echo json_encode($aux);
					
			break;

			case 'DELETE':
				if($idProfile != "" && $idList != ""){
					
					$aux= _deleteOfList($idProfile,$idList);
					$aux['deleteofList']=true;
				
				}else{
					$aux['deleteofList']=true;
				}
				echo json_encode($aux);
			
			
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
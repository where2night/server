<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	//Checking credentials
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idList = $request[2];
	$tokenT= _tokenOK($idProfile,$token);

	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT==1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if ($idProfile != ""){

				$title = $_POST["title"];
  				$text = $_POST["text"];
  				$date = $_POST["date"];
  				$closedate= $_POST["closeDate"];
  				$maxGuest= $_POST["maxGuest"];
  				$date = _formato_fechasFB($date);
  				$closedate=_formato_fechasFB($closedate);
  				$startHour = $_POST["startHour"];
  				$closeHour = $_POST["closeHour"];
  				
				_setListData($idProfile,$idList,$title,$text,$date,$startHour,$closeHour,$closedate,$maxGuest);
				$aux['updateList']=true;
				
			}else{
				$aux['updateList']=false;
			}	
			echo json_encode($aux);	
			break;	

		case 'GET':
				
				if($idList != ""){
					$data = _getListData($idList,$idProfile);
					$data['date'] = _formato_fechas($data['date']);	
					$data['getList']=true;
				}else{
					$data['getList']=false;
				}
				
				echo json_encode($data);
			break;
		
		case 'DELETE':
				if($idList != ""){
					$data = _deleteList($idList,$idProfile);
					$data['DeleteList'] = true ;
				}else{
					$data['DeleteList']=false;
				}
				echo json_encode($data);
				break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>

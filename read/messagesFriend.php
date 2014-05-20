<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile1 = $request[0];
	$token = $request[1];
	$idProfile2 = $request[2];

	$tokenT= _tokenOK($idProfile1,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile1 != ""){
					$data= _getMessagesFriend($idProfile1,$idProfile2);
                    $num = sizeof($data);              
	                $data['num']=$num; 
                    $aux=_getPartierData($idProfile1); 
                    $aux2=_getPartierData($idProfile2);           
	                $data['name']=$aux['name'];   
	                $data['surnames']=$aux['surnames'];  
	                $data['picture']= $aux['picture'];
                    $data['nameF']=$aux2['name'];   
	                $data['surnamesF']=$aux2['surnames'];  
	                $data['pictureF']= $aux2['picture'];
				}
				echo json_encode($data);
					
			break;	

		  default: 
			break;
		}
	}

?>
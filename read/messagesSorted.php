<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];

	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile != ""){
					$aux1= _getPartiersMessages($idProfile);
					$aux2= _checkMessagesUnread($idProfile);

					if($aux2!=null){
					$aux = array_merge($aux2,$aux1);
					  for ($i=0; $i < sizeof($aux2) ; $i++){
                                          array_pop($aux);
                                           }
                                        }
                                        else {$aux=$aux1; }

				}
				
				for ($i=0; $i < sizeof($aux) ; $i++) {
                         	$idP = $aux[$i]['idProfile'];
							$data[$i] = _getMessagesFriend2($idProfile,$idP);
							$aux3=_getPartierData($idP);

                            $num = sizeof($data[$i]);             
	                        $data[$i]['idProfile']=$idP;  
	                        $data[$i]['num']=$num; 
	                        $data[$i]['name']=$aux3['name'];   
	                        $data[$i]['surnames']=$aux3['surnames'];  
	                        $data[$i]['picture']= $aux3['picture'];                                             
								
						} 


				echo json_encode($data);
			break;	

		  default: 
			break;
		}
	}

?>
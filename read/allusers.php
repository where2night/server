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
				{
					
                    $aux = _getPartiers();
			
						for ($i=0; $i < sizeof($aux) ; $i++) {
							$resaux1[$i]['name'] = $aux[$i]['name'];
							$resaux1[$i]['surnames']=$aux[$i]['surnames'];
							$resaux1[$i]['picture']= $aux[$i]['picture'];
							$resaux1[$i]['idProfile']=$aux[$i]['idProfile'];
							$resaux1[$i]['type']=0;
								
						} 
						
                    $auxx = _getLocals();
                    
						for ($i=0; $i < sizeof($auxx) ; $i++) {

							$resaux2[$i]['name']=$auxx[$i]['localName'];
							$resaux2[$i]['picture']= $auxx[$i]['picture'];
							$resaux2[$i]['idProfile']=$auxx[$i]['idProfile'];
							$resaux2[$i]['type']=1;
								
						}


                    $resaux=array_merge($resaux1,$resaux2);
                    echo json_encode($resaux);
				
				}
					
			break;	

		    default:
			break;
		}
	}

?>
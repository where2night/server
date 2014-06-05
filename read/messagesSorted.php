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
					
					
					$aux=_getAllMessages($idProfile);
					$aux1= _howManyMessages($idProfile);
					$ini=0;
					$num=$aux1['rows'];
					for($i=0 ; $i<$num ; $i++){
						$numMessage=$aux1[$i]['NUM'];
						$idP= $aux1[$i]['idProfile'] ;
						
						$name= $aux1[$i]['name'];
						$surnames= $aux1[$i]['surnames'];
						$picture= $aux1[$i]['picture'];
						$o=0;
								for($s=$ini ; $s<$ini+$numMessage ; $s++){
									
									$res[$i][$o]=$aux[$s];
									$o++;
								}
							
						$ini=$ini+$numMessage;
						$res[$i]['idProfile']= $idP ;
						$res[$i]['num']=$numMessage;
						$res[$i]['name']= $name;
						$res[$i]['surnames']= $surnames;
						$res[$i]['picture']= $picture;
						
						
					}
					}
					echo json_encode($res);
					
					
					
			break;	

		  default: 
			break;
		}
	}

?>

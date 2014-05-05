<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	
	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				{
				
                    $aux = _getLocals();
						$num= $aux['rows'];
						for ($i=0; $i < $num ; $i++) {
							$idP=$aux[$i]; 
							$idP=$idP['idProfile'];
							
							$aux1[$i]=_getPartierData($idP);
							$aux1[$i]['idProfile']=$idP;
							//$aux1[$i]['type']=1;
								
						}
  
                   echo json_encode($aux1);
				}
					
			break;	

		  default:
			break;
		}
	}

?>
<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	
	if (isset($_SERVER['REQUEST_METHOD'])){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if (isset($_GET["idProfile"]) && $_GET["idProfile"] != ""){
					$data= _getLocals();
					echo json_encode($data);

				}
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
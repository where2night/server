<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT==1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
		case 'POST':
			if (isset($_POST["idProfile"])){
				$idPartier = $_POST["idProfile"];
				$mode = $_POST["mode"];

				_setModePartier($idPartier,$mode);
				
			}	
				
			break;		
		  default:
		//	rest_error($request);  
			break;
		}
	}

?>
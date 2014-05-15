<?php

	require_once ("../db.inc");
	require_once ("../utils.inc");
	
	$request = explode("/", substr(@$_SERVER['PATH_INFO'], 1));
	$idProfile = $request[0];
	$token = $request[1];
	$idUser = $request[2];
	
	$tokenT= _tokenOK($idProfile,$token);
	
	if (isset($_SERVER['REQUEST_METHOD']) && $tokenT == 1){
		$method = $_SERVER['REQUEST_METHOD'];
		switch ($method) {
			case 'GET':
				if ($idProfile != ""){
					$type=_getTypeProfile($idProfile);
					
						$aux = _getStatisticsPub($idUser);
						$num= $aux['rows'];
						$numGo=0; //GENTE QUE VA A IR
						for($i=0; $i<$num ; $i++){
							if($aux[$i]['modeP']!= 1){
								$numGo++;
							}
						}
						
						$numCl=$num-$numGo; //NUMERO DE CLIENTES QUE YA HAN IDO
						/*100-143 gender music  100=3 143=46
						  200-225 drink		200=47 225=72
						  300-306 civil state   300=73 306=79
						*/
						$final=array('mens'=> 0, 'womens'=> 0,
							'a18-20'=> 0,'a21-23'=> 0, 'a24-30'=>0, 'am31'=> 0,
							'100'=>0,'101'=>0,'102'=>0,'103'=>0,'104'=>0,'105'=>0,'106'=>0,'107'=>0,
							'108'=>0,'109'=>0,'110'=>0,'111'=>0,'112'=>0,'113'=>0,'114'=>0,
							'115'=>0,'116'=>0,'117'=>0,'118'=>0, '119'=>0,'120'=>0,'121'=>0,
							'122'=>0,'123'=>0,'124'=>0,'125'=>0,'126'=>0,'127'=>0,'128'=>0,
							'129'=>0,'130'=>0,'131'=>0,'132'=>0,'133'=>0,'134'=>0,'135'=>0,
							'136'=>0,'137'=>0,'138'=>0,'139'=>0,'140'=>0,'141'=>0,'142'=>0,
							'143'=>0,'200'=>0,'201'=>0,'202'=>0,'203'=>0,'204'=>0,
							'205'=>0,'206'=>0,'207'=>0,'208'=>0,'209'=>0,'210'=>0,'211'=>0,'212'=>0,
							'213'=>0,'214'=>0,'215'=>0,'216'=>0,'217'=>0,'218'=>0,'219'=>0,
							'220'=>0,'221'=>0,'222'=>0,'223'=>0,'224'=>0,'225'=>0,
							'300'=>0,'301'=>0,'302'=>0,'303'=>0,'304'=>0,'305'=>0,'306'=>0,'numGo'=>$numGo);

						for ($i=0; $i < $numGo ; $i++) {
							$gender=$aux[$i]['gender'];
					
							$date=$aux[$i]['birthdate'];
							//date in yyyy-mm-dd format  
  							//explode the date to get month, day and year
 							$birthDate = explode("-", $date);
  							//get age from date or birthdate
  							$age = (date("md", date("U", mktime(0, 0, 0, $birthDate[1], $birthDate[2], $birthDate[0]))) > date("md")
    						? ((date("Y") - $birthDate[0]) - 1)
    						: (date("Y") - $birthDate[0]));
    						
    						
    						
    						$music=$aux[$i]['music'];
    						$music=$music+100;
    						$cState=$aux[$i]['civil_state'];
    						$cState=$cState+300;
    						$drink=$aux[$i]['drink'];
    						$drink=$drink+200;
    						$mode=$aux[$i]['modeP'];
    						if($mode == 0){
    							/*list partiers go to pub + womens,mens,gender music,drink,age, civil State*/
    							switch ($gender) {
    								case '0'://female
    									$final['womens']++;
    									break;
    								case '1'://male
    									$final['mens']++;
    									break;
    								default:
    									# code...
    									break;
    							}
    							
    							$final[$music]++;
    							$final[$drink]++;
    							$final[$cState]++;
    						
    						if ($age>=18 and $age<=20) {
    							$final['a18-20']++;
    							
    						}elseif ($age>=21 and $age<=23) {
    							$final['a21-23']++;
    						}elseif ($age>=24 and $age<=30) {
    							$final['a24-30']++;
    						}elseif ($age>=31) {
    							$final['am31']++;
    						}

    						}//if($mode=0)
    					}//for.....
    						if($type == 0 ){ //for partier
    							/************************************/
    						//delete array elements.
    							for ($i=$numGo; $i <$num ; $i++) { 
    								unset($aux[$i]);
    							}
    							$result=array_merge($aux,$final);
    							$result['statisticsPartier']=true;
								echo json_encode($result);
							}
							elseif ($type ==1 and $idProfile==$idUser) {//for Pub only the same id
								$final['bestClients']=$numCl;
								$result=array_merge($aux,$final);
    								$result['statisticsPub']=true;
								
								
								echo json_encode($result);
							}
				}else{
					$aux['emptyId']=true;
					echo json_encode($aux);
				}
					
			break;	
		  default:
		//	rest_error($request);  
			break;
		}
	}else{
		$aux['token&&Id']=false;
		echo json_encode($aux);
	}


?>
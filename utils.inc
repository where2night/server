<?php

/*
 * Utils functions
 */

require_once 'db.inc';


// Protege variables tipo string contra posible ataques de inyecci贸n SQL
function _protect_data ($string)
{
	if (!get_magic_quotes_gpc())
		$secure = addslashes($string);
	else
		$secure = $string;

	return $secure;
}


function _protect_data_type_int ($object)
{
	if (!isset ($object) || !is_numeric ($object))
		die ("<br/><br/>Value not expected. Possible attempt to hack!");
}


// Protege arrays contra posible ataques de inyecci贸n SQL
function _protect_data_array ($array)
{
	if (isset ($array) && is_array ($array))
	{
		if (!get_magic_quotes_gpc())
			foreach ($array as $key => $value)
				$secure[addslashes ($key)] = addslashes ($value);	
		else
			// Revisar la protecci贸n de las claves en este caso
			$secure = $array;
		
		return $secure;
	}
}


function _protect_data_array_type_int ($array)
{
	if (isset ($array) && is_array ($array))
		foreach ($array as $key => $value)
			if (!is_numeric ($key) || !is_numeric ($value))
				die ("Value not expected. Possible attempt to hack!");
}


// Obtiene el path del archivo ejecutado
function _get_file ()
{
	return $_SERVER['PHP_SELF'];
}


function _get_id ()
{
	if (isset ($_SESSION['id']))
		return $_SESSION['id'];	
}


function _get_username ()
{
	if (isset ($_SESSION['username']))
		return $_SESSION['username'];	
}

function _formato_fechas($fecha)
{
	return str_replace("-","/",$fecha);
}

function _formato_fechasP($fecha)
{
	return str_replace("/","-",$fecha);
}

function _formato_fechasFB($date)
{

	$part = explode("/", $date);
	$year= "$part[2]";
	$month ="$part[1]";
	$day ="$part[0]";
	return "$year-$month-$day";
}

function _conversion_fecha_mysql_api($date)
{
	$part = explode("-", $date);
	$year= "$part[0]";
	$month ="$part[1]";
	$day ="$part[2]";
	return "$day/$month/$year";
}
function _fecha_dma($date){
	$part = explode("-", $date);
	$year= "$part[0]";
	$month ="$part[1]";
	$day ="$part[2]";
	return "$day-$month-$year";

}


function _session_destroy ()
{
		session_destroy();
}


function _login($email,$password,$mobile){

	_db_connect();
	
	$passEncriptada = sha1($password);

	$query = "Select loginSucceed('{$email}','{$passEncriptada}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);	
	if ($existe != 0){
		
		$sToken = md5(uniqid(mt_rand(), true));
		if ($mobile == 1){
		$query = "SELECT insertTokenMobile('{$email}','{$sToken}')";
		}
		else{
		$query = "SELECT insertToken('{$email}','{$sToken}')";
		}
		$resultado=_db_query($query);
		$campo1 = _db_fetch_array($resultado);
	    $usertype = current($campo1);
		
		
 
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $existe, 'type'=> $usertype);
		return $arr;	
	}
	else{
	       _db_close();
		   $arr = array('Token' => 0, 'id' => 0);
	       return $arr;
	}
	

}
function _loginFB($email,$mobile){

	_db_connect();
	$query = "Select loginSuccessFB('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$id = current($campo);
  
	if ($id != 0){
		$sToken = md5(uniqid(mt_rand(), true));
		if ($mobile == 1){
		$query = "SELECT insertTokenMobile('{$email}','{$sToken}')";
		}
		else{
		$query = "SELECT insertToken('{$email}','{$sToken}')";
		}
		$resultado=_db_query($query);
		$campo1 = _db_fetch_array($resultado);
	    $usertype = current($campo1);		
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $id, 'type'=> $usertype);
		return $arr;
	}
	else{
	    _db_close();
	    $arr = array('Token' => 0, 'id' => 0);
		return $arr;
	}
	

}

function _loginGP($email,$mobile){
	
	_db_connect();
	$query = "Select loginSuccessGP('{$email}')";

	$resultado = _db_query($query);
	
	$campo = _db_fetch_array($resultado);
			
	$id = current($campo);
  		
	if ($id != 0){
		$sToken = md5(uniqid(mt_rand(), true));
		if ($mobile == 1){
		$query = "SELECT insertTokenMobile('{$email}','{$sToken}')";
		}
		else{
		$query = "SELECT insertToken('{$email}','{$sToken}')";
		}
		$resultado=_db_query($query);
		$campo1 = _db_fetch_array($resultado);
	    $usertype = current($campo1);		
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $id, 'type'=> $usertype);
		return $arr;
	}
	else{
	    _db_close();
	    $arr = array('Token' => 0, 'id' => 0);
		return $arr;
	}
	

}

function _insertUserFB($picture,$email,$name,$surnames,$birthday,$gender,$mobile){
	_db_connect();
	$query = "Call insertFacebookUser('{$email}')";
	_db_query($query);
 
	
	$sToken = md5(uniqid(mt_rand(), true));
		if ($mobile == 1){
		$query = "SELECT insertTokenMobile('{$email}','{$sToken}')";
		}
		else{
		$query = "SELECT insertToken('{$email}','{$sToken}')";
		}
	$resultado=_db_query($query);
	$campo1 = _db_fetch_array($resultado);
	$usertype = current($campo1);		
	

	
	$query = "Select getIdProfile('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$id = current($campo);
	
	
	$query =  "call setPartierData('{$id}' ,'{$picture}', '{$name}',
	'{$surnames}', '{$birthday}' ,
	'{$gender}', \"\", \"\", \"\",\"\", \"\")";
	_db_query($query);
	_db_close();
	//$arr = array('Token' => $sToken, 'id' => $id);
	$arr = array('Token' => $sToken, 'id' => $id, 'type'=> $usertype);
	return $arr;	
}


function _insertUserGP($picture,$email,$name,$surnames,$birthday,$gender,$mobile){
	_db_connect();
	$query = "Call insertGoogleUser('{$email}')";
	_db_query($query);
 
	
	$sToken = md5(uniqid(mt_rand(), true));
		if ($mobile == 1){
		$query = "SELECT insertTokenMobile('{$email}','{$sToken}')";
		}
		else{
		$query = "SELECT insertToken('{$email}','{$sToken}')";
		}
	$resultado=_db_query($query);
	$campo1 = _db_fetch_array($resultado);
	$usertype = current($campo1);	
	
	$query = "Select getIdProfile('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$id = current($campo);
	
	
	$query =  "call setPartierData('{$id}' ,'{$picture}', '{$name}',
	'{$surnames}', '{$birthday}' ,
	'{$gender}', \"\", \"\", \"\",\"\", \"\")";
	_db_query($query);
	_db_close();
	$arr = array('Token' => $sToken, 'id' => $id, 'type'=> $usertype);
	//$arr = array('Token' => $sToken, 'id' => $id);
	return $arr;	
}

function _insertUser($email,$pass,$name,$surnames,$birthday,$gender,$mobile){
	_db_connect();
	
	$query = "Select userExists('{$email}')";
	
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);	

	if ($existe == 0){
	
		$passEncriptada = sha1($pass);
		
		$query = "Call insertNormalUser('{$email}','{$passEncriptada}')" ;
		_db_query($query);	
		$sToken = md5(uniqid(mt_rand(), true));
		if ($mobile == 1){
		$query = "SELECT insertTokenMobile('{$email}','{$sToken}')";
		}
		
		else{
		$query = "SELECT insertToken('{$email}','{$sToken}')";
		}
	
		$resultado=_db_query($query);
		$campo1 = _db_fetch_array($resultado);
	    $usertype = current($campo1);
		
		$query = "Select getIdProfile('{$email}')";
		$resultado = _db_query($query);
		$campo = _db_fetch_array($resultado);
		$id = current($campo);
				
		$query =  "call setPartierData('{$id}' ,\"\", '{$name}',
		'{$surnames}', '{$birthday}' ,'{$gender}', \"\", \"\", \"\",\"\",\"\")";
		_db_query($query);
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $id, 'type'=>$usertype);
		return $arr;	
	}	
	else {
		_db_close();
		$arr = array('Token' => 0, 'id' => 0, 'Error' => true);
		return $arr;	
	}
}

function _insertLocalUser($email,$companyName,$nameLocal,$cif,$poblationLocal,$cpLocal,$telephone,$street,$streetName,$streetNumber,$lat,$lng){

	_db_connect();
	$query = "Select userExists('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);	
	$length = 8;
	//$pass = substr(md5(microtime()),1,$length); //random pass
	/*Microtime Use () to give me the expression of complete time there, and I calculate the md5 hash with md5 (), which as you know takes a long chain, which at first sight are numbers and random letters [a-z0-9] and then extract the substr () function the first n (where n is $ length).*/
	$pass="123456Pub";
	//Send email to confirmate user later
	$to = "where2night@where2night.es";
	$subject = "Solicitud de where2night";
	$headers = "Content-Type: text/html; charset=ISO-8859-1\r\n";

	$message = '<html><body>';
	$message .= '<h1>El local '.$nameLocal.' ha solicitado registrarse</h1>';
	$message .= '<table style="border-color: #666;" cellpadding="10">';
	$message .= '<tr style="background: #eee;"><td><strong>Nombre local:</strong> </td><td>' . $nameLocal . '</td></tr>';
	$message .= '<tr><td><strong>Nombre compañía:</strong> </td><td>' . $companyName . '</td></tr>';
	$message .= '<tr><td><strong>Email:</strong> </td><td>' . $email . '</td></tr>';
	$message .= '<tr><td><strong>CIF:</strong> </td><td>' . $cif . '</td></tr>';
	$message .= '<tr><td><strong>Población:</strong> </td><td>' . $poblationLocal . '</td></tr>';
	$message .= '<tr><td><strong>C.P.:</strong> </td><td>' . $cpLocal . '</td></tr>';
	$message .= '<tr><td><strong>Teléfono:</strong> </td><td>' . $telephone . '</td></tr>';
	$message .= '<tr><td><strong>Tipo calle:</strong> </td><td>' . $street . '</td></tr>';
	$message .= '<tr><td><strong>Nombre calle:</strong> </td><td>' . $streetName . '</td></tr>';
	$message .= '<tr><td><strong>Número calle:</strong> </td><td>' . $streetNumber . '</td></tr>';
	$message .= '<tr style="background: #ddd;"><td><strong>Contraseña generada:</strong> </td><td align="center"><strong><span style="color:ff0000;">'.$pass.'</span></strong></td></tr>';
	$message .= '</table>';
	$message .= '</body></html>';
	$sent = mail($to, $subject, $message, $headers);

	if ($existe == 0 && $sent){
		$passEncriptada = sha1($pass);
	
		$query = "Call insertPubUser('{$email}','{$passEncriptada}')" ;
		_db_query($query);

		$sToken = md5(uniqid(mt_rand(), true));
		//$query = "Call insertToken('{$email}','{$sToken}')";
		//_db_query($query);
		$query = "SELECT insertToken('{$email}','{$sToken}')";
		$resultado=_db_query($query);
		$campo1 = _db_fetch_array($resultado);
	    $usertype = current($campo1);

		$query = "Select getIdProfile('{$email}')";
		$resultado = _db_query($query);
		$campo = _db_fetch_array($resultado);
		$id = current($campo);

		$query =  "call setLocalData('{$id}','{$companyName}' ,'{$nameLocal}','{$cif}','{$poblationLocal}','{$cpLocal}','{$telephone}','{$street}','{$streetName}','{$streetNumber}','{$lat}','{$lng}',\"\",\"\",\"\",\"\",\"\",\"\",\"\" )";

		_db_query($query);
		_db_close();
		//$arr = array('Token' => $sToken, 'id' => $id);
		$arr = array('Token' => $sToken, 'id' => $id, 'type'=> $usertype, 'pass'=> $pass);
		return $arr;	


	}
	else {
		_db_close();
		$arr = array('Token' => 0, 'id' => 0);
		return $arr;	
	}


}

function _insertDJUser($email,$nameDJ,$name, $surname,$telephone, $birthdate, $gender){
	
	_db_connect();
	$query = "Select userExists('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);	
	$length = 8;
	//$pass = substr(md5(microtime()),1,$length); //random pass
	/*Microtime Use () to give me the expression of complete time there, and I calculate the md5 hash with md5 (), which as you know takes a long chain, which at first sight are numbers and random letters [a-z0-9] and then extract the substr () function the first n (where n is $ length).*/
	$pass= "123456DJ";
	//Send email to confirmate user later
	$to = "where2night@where2night.es";
	$subject = "Solicitud de where2night";
	$headers = "Content-Type: text/html; charset=ISO-8859-1\r\n";

	$message = '<html><body>';
	$message .= '<h1>El DJ '.$nameDJ.' ha solicitado registrarse</h1>';
	$message .= '<table style="border-color: #666;" cellpadding="10">';
	$message .= '<tr style="background: #eee;"><td><strong>Nombre artístico:</strong> </td><td>'.$nameDJ.'</td></tr>';
	$message .= '<tr><td><strong>Email:</strong> </td><td>' . $email . '</td></tr>';
	$message .= '<tr><td><strong>Nombre:</strong> </td><td>' . $name . '</td></tr>';
	$message .= '<tr><td><strong>Apellidos:</strong> </td><td>' . $surname . '</td></tr>';
	$message .= '<tr><td><strong>Teléfono:</strong> </td><td>' . $telephone . '</td></tr>';
	$message .= '<tr><td><strong>Fecha de nacimiento:</strong> </td><td>' . $birthdate . '</td></tr>';
	$message .= '<tr><td><strong>Género:</strong> </td><td>' . $gender . '</td></tr>';
	$message .= '<tr style="background: #ddd;"><td><strong>Contraseña generada:</strong> </td><td align="center"><strong><span style="color:ff0000;">'.$pass.'</span></strong></td></tr>';
	$message .= '</table>';
	$message .= '</body></html>';
	$sent = mail($to, $subject, $message, $headers);

	if ($existe == 0 && $sent){
		$passEncriptada = sha1($pass);
		$query = "Call insertDJUser('{$email}','{$passEncriptada}')" ;
		_db_query($query);

		$sToken = md5(uniqid(mt_rand(), true));
		//$query = "Call insertToken('{$email}','{$sToken}')";
		//_db_query($query);
		$query = "SELECT insertToken('{$email}','{$sToken}')";
		$resultado=_db_query($query);
		$campo1 = _db_fetch_array($resultado);
	    $usertype = current($campo1);

		$query = "Select getIdProfile('{$email}')";
		$resultado = _db_query($query);
		$campo = _db_fetch_array($resultado);
		$id = current($campo);
		
		$query =  "call setDJData('{$id}','{$nameDJ}','{$name}','{$surname}','{$telephone}','{$gender}','{$birthdate}',null,null,null)";

		_db_query($query);

		
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $id, 'type'=> $usertype, 'pass'=> $pass);
		return $arr;	


	}
	else {
		_db_close();
		$arr = array('Token' => 0, 'id' => 0);
		return $arr;	
	}



}


function _setPartierData($idProfile,$picture,$name,$surnames,$birthdate,$genderbool,$music,$civil_state,$city,$drink,$about){
	_db_connect();
	$query = "call setPartierData('{$idProfile}','{$picture}','{$name}','{$surnames}','{$birthdate}','{$genderbool}','{$music}','{$civil_state}','{$city}','{$drink}','{$about}')";
	_db_query($query);
	_db_close();
}
function _tokenOk($id,$token){//devuelve 1 si corresponden
	_db_connect();
	$query = "Select tokenOK('{$id}','{$token}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$res = current($campo);
	_db_close();
	return $res;

}

function _setUserPass ($idProfile,$oldPass,$newPass){
   	_db_connect();

	
	$passEncriptada = sha1($oldPass);
	$passEncriptada1 = sha1($newPass);
	$query = "Select checkPass('{$idProfile}','{$passEncriptada}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);	

	if ($existe == -1){
	$query = "call setUserPass('{$idProfile}','{$passEncriptada1}')";
	$arr = array('Error' => '0');

	}
	else if ($existe == 0 OR $existe == 1) {//FB or Google user

	$arr = array('Error' => '2');
	}
	else if ($existe == 2 ) {//pass incorrect

	$arr = array('Error' => '3');
	}
	_db_query($query);
	_db_close();
			return $arr;	
}


function _getPartierData($id){  
	_db_connect();
	$query = "Call getPartierData('{$id}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	_db_close();
	return $campo;
	
}
function _getDJData($id){  
	_db_connect();
	$query = "Call getDJData('{$id}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	_db_close();
	return $campo;
	
}
function _getLocalData($id){  
	_db_connect();
	$query = "Call getLocalData('{$id}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	_db_close();
	return $campo;
	
}
function _setLocalData($idProfile,$companyNameLocal,$localName,$cif, $poblationLocal,$cpLocal,$telephoneLocal,$street,$streetNameLocal,$streetNumberLocal,$lat,$lng,$music,$entryPrice ,$drinkPrice,$openingHours,$closeHours,$picture,$about){
	
	_db_connect();
	$query = "call setLocalData('{$idProfile}','{$companyNameLocal}' ,'{$localName}','{$cif}','{$poblationLocal}','{$cpLocal}','{$telephoneLocal}','{$street}','{$streetNameLocal}','{$streetNumberLocal}','{$lat}','{$lng}','{$music}','{$entryPrice}' ,'{$drinkPrice}','{$openingHours}','{$closeHours}','{$picture}','{$about}')";
	_db_query($query);
	_db_close();
}

function _setDJData($idProfile,$nameDJ,$name,$surname,$telephoneDJ,$gender,$birthdate,$picture, $music, $about){

	_db_connect();
	$query = "call setDJData('{$idProfile}','{$nameDJ}','{$name}','{$surname}','{$telephoneDJ}','{$gender}','{$birthdate}','{$picture}' ,'{$music}' ,'{$about}')";
	_db_query($query);
	_db_close();

}
function _getTypeProfile($idProfile){

	_db_connect();
	$query = "Select getTypeProfile('{$idProfile}')";
	$campo= _db_query($query);
	$res=_db_fetch_array($campo);
	$type=current($res);
	_db_close();
	return $type;
}
function _getDjId($idProfile,$type){
	_db_connect();
	$query = "Select getDjId('{$idProfile}')";
	$campo = _db_query($query);
	$res = _db_fetch_array($campo);
	$id = current($res);
	_db_close();
	return $id;
}
function _getPubId($idProfile,$type){
	_db_connect();
	$query = "Select getPubId('{$idProfile}')";
	$campo = _db_query($query);
	$res = _db_fetch_array($campo);
	$id = current($res);
	_db_close();
	return $id;
}

function _insertEvent($idProfile,$title,$text,$date,$startHour,$closeHour){

	_db_connect();
	$query = "call setEvent('{$idProfile}','{$title}','{$text}','{$date}','{$startHour}','{$closeHour}')";

	$res=_db_query($query);

	_db_close();
			
	
	$arr = array();

	return $arr;
}

function _insertList($idProfile,$title,$text,$date,$startHour,$closeHour){

	_db_connect();
	$query = "call setList('{$idProfile}','{$title}','{$text}','{$date}','{$startHour}','{$closeHour}')";

	$res=_db_query($query);

	_db_close();
			
	
	$arr = array();

	return $arr;
}


function _userFollowsPub($idLocal,$idPartier){
	_db_connect();
	$query = "Select userFollowsPub('{$idLocal}','{$idPartier}')";
	$campo = _db_query($query);
	$res = _db_fetch_array($campo);
	$follows = current($res);
	_db_close();
	return $follows;
}

 function _howManyFollowsPub($idLocal){
	_db_connect();
	$query = "Select howManyFollowsPub('{$idLocal}')";
	$campo = _db_query($query);
	$res = _db_fetch_array($campo);
	$followers = current($res);
	_db_close();
	return $followers;
 }
 
 
 function _userFollowsDJ($idDJ,$idPartier){
	_db_connect();
	$query = "Select userFollowsDJ('{$idDJ}','{$idPartier}')";
	$campo = _db_query($query);
	$res = _db_fetch_array($campo);
	$follows = current($res);
	_db_close();
	return $follows;
}

 function _howManyFollowsDJ($idDJ){
	_db_connect();
	$query = "Select howManyFollowsDJ('{$idDJ}')";
	$campo = _db_query($query);
	$res = _db_fetch_array($campo);
	$followers = current($res);
	_db_close();
	return $followers;
 }

 function _setEventData($idProfile,$idEvent,$title,$text,$date,$startHour,$closeHour){
 	_db_connect();
 	$query = "call setEventData('{$idProfile}','{$idEvent}','{$title}','{$text}','{$date}','{$startHour}','{$closeHour}')";
 	$campo = _db_query($query);
 	_db_close();
 }

 function _getEventData($idEvent,$idProfile){
 	_db_connect();
 	$query = "call getEventData('{$idEvent}','{idProfile}')";
 	$campo=_db_query($query);
 	$res=_db_fetch_array($campo);
 	_db_close();
 	return $res;
 }

 function _getEvents($idProfile,$idPub){
 	_db_connect();
 	$query = "call getEvents('{$idProfile}','{$idPub}')";
 	$campo=_db_query($query);
 	$filas = _db_num_rows($campo);
 	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	_db_close();
 	return $res;

 }

 function _deleteEvent($idEvent,$idProfile){
 	_db_connect();
 	$query = "call deleteEvent('{$idEvent}','{$idProfile}')";
 	$campo=_db_query($query);
 	
 	_db_close();
 	return $res;
 }



function _setListData($idProfile,$idList,$title,$text,$date,$startHour,$closeHour){
 	_db_connect();
 	$query = "call setListData('{$idProfile}','{$idList}','{$title}','{$text}','{$date}','{$startHour}','{$closeHour}')";
 	$campo = _db_query($query);
 	_db_close();
 }

 function _getListData($idList,$idProfile){
 	_db_connect();
 	$query = "call getListData('{$idList}','{$idProfile}')";
 	$campo=_db_query($query);
 	$res=_db_fetch_array($campo);
 	_db_close();
 	return $res;
 }

 function _getLists($idProfile){
 	_db_connect();
 	$query = "call getLists('{$idProfile}')";
 	$campo=_db_query($query);
 	$filas = _db_num_rows($campo);
 	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	_db_close();
 	return $res;

 }

 function _deleteList($idList,$idProfile){
 	_db_connect();
 	$query = "call deleteList('{$idList}','{$idProfile}')";
 	$campo=_db_query($query);
 	
 	_db_close();
 	return $res;
 }


 function _getDjs(){
 	_db_connect();
 	$query = "call getDjs()";
 	$campo=_db_query($query);
 	$filas = _db_num_rows($campo);
 	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	_db_close();
 	return $res;
 }


function _getLocals(){
	_db_connect();
 	$query = "call getLocals()";
 	$campo=_db_query($query);
 	$filas = _db_num_rows($campo);
 	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	_db_close();
 	return $res;
}
function _getPartiers(){
 	_db_connect();
 	$query = "call getPartiers()";
 	$campo=_db_query($query);
 	$filas = _db_num_rows($campo);
 	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	_db_close();
 	return $res;
 }
function _followDj($idProfile,$idDJ){
	_db_connect();
	$query = "call followDJ('{$idDJ}','{$idProfile}')";
	$campo=_db_query($query);
	
	_db_close();
	return $res;

}

function _followLocal($idProfile,$idPub){
	_db_connect();

	$query = "call followPub('{$idPub}','{$idProfile}')";
	$campo=_db_query($query);
	
	_db_close();
	return $res;

}
function _unFollowDj($idProfile,$idDJ){
	_db_connect();

	$query = "call unFollowDJ('{$idDJ}','{$idProfile}')";
	$campo=_db_query($query);

	$res=_db_fetch_array($campo);
	_db_close();
	return $res;

}

function _unFollowLocal($idProfile,$idPub){
	_db_connect();
	$query = "call unFollowPub('{$idPub}','{$idProfile}')";
	$campo=_db_query($query);

	$res=_db_fetch_array($campo);
	_db_close();
	return $res;

}

function _followPartier($idProfile,$idPartier){
	_db_connect();
	$query = "call followPartier('{$idProfile}','{$idPartier}')";
	$campo=_db_query($query);
	
	_db_close();
	return $res;

}
function _unFollowPartier($idProfile,$idPartier){
	_db_connect();
	$query = "call unFollowPartier('{$idPartier}','{$idProfile}')";
	$campo=_db_query($query);
	
	_db_close();
	return $res;

}

function _goToEvent($idProfile,$idEvent){
	_db_connect();
	$query = "call goToEvent('{$idEvent}','{$idProfile}')";
	$campo=_db_query($query);
	
	_db_close();
	return $res;

}
function _dontGoToEvent($idProfile,$idPub){
	_db_connect();
	$query = "call dontGoToEvent('{$idProfile}','{$idPub}')";
	$campo=_db_query($query);
	
	_db_close();
	return $res;
}
function _pubFollowers($idProfile){
	_db_connect();
	$query = "call pubFollowers('{$idProfile}')";
	$campo= _db_query($query);
	$filas= _db_num_rows($campo);
	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	$res['rows']= $filas;
 	_db_close();
 	return $res;
}


function _eventsUser($idProfile){
	_db_connect();
 	$query = "call eventsUser('{$idProfile}')";
 	$campo=_db_query($query);
 	$filas = _db_num_rows($campo);
 	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	$res['rows']= $filas;
 	_db_close();
 	return $res;

}
function _goToPub($idProfile,$idPub){
	_db_connect();
	$query = "call goToPub('{$idPub}','{$idProfile}')";
	$campo=_db_query($query);
	
	_db_close();
	return $res;

}
function _dontGoToPub($idProfile,$idPub){
	_db_connect();
	$query = "call dontGoToPub('{$idPub}','{$idProfile}')";
	$campo=_db_query($query);
	
	_db_close();
	return $res;
}
function _goesToPub($idProfile,$idLocal){
	_db_connect();
	$query = "select userGoesToPub('{$idProfile}','{$idlocal}')";
	$campo=_db_query($query);
	$res= _db_fetch_array($campo);
	$res=current($res);
	_db_close();
	return $res;
}

function _getNews($idProfile,$start){
	_db_connect();
 	$query = "call getNews('{$idProfile}' )";
 	$campo=_db_query($query);
 	$filas = _db_num_rows($campo);
 	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	_db_close();
 	
	$arr = array_slice($res,$start,10);
	$arr['numElems'] = $filas;
 	return $arr;
}
function _getNewsUser($idProfile,$idPartier,$start){
	_db_connect();
 	$query = "call getNewsUser('{$idProfile}', '{$idPartier}')";
 	$campo=_db_query($query);
 	$filas = _db_num_rows($campo);
 	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	_db_close();
	$arr = array_slice($res,$start,10);
	$arr['numElems'] = $filas;
 	return $arr;
}


function _getEventsTodayUser($idProfile){
	_db_connect();
 	$query = "call getEventsTodayUser('{$idProfile}')";
 	$campo=_db_query($query);
 	$filas = _db_num_rows($campo);
 	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	_db_close();
	
	$arr['numElems'] = $res;
 	return $arr;
}


function _setModePartier($idPartier,$mode){
	_db_connect();
	$query = "call setModePartier('{$idPartier}','{$mode}')";
	_db_query($query);
	_db_close();

}
function _setStatusPartier($idPartier,$status){
	_db_connect();
	$query = "call setStatusPartier('{$idPartier}','{$status}')";
	_db_query($query);
	_db_close();

}
function _getMyFriends($idProfile){
	_db_connect();
	$query = "call myFriends('{$idProfile}')";
	$campo= _db_query($query);
	$filas= _db_num_rows($campo);
	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	$res['rows']= $filas;
 	_db_close();
 	return $res;
}
function _acceptFriend($idProfile,$idProfile1){
	_db_connect();
	$query = "call acceptFriend('{$idProfile}','{$idProfile1}')";
	_db_query($query);
	_db_close();
}

function _getModeFollow($idProfile,$idUser){
	_db_connect();
	$query = "Select getModeFollow('{$idProfile}','{$idUser}')";
	$campo = _db_query($query);
	$res = _db_fetch_array($campo);
	$id = current($res);
	_db_close();
	return $id;
}
function _getFriendship($idProfile){
	_db_connect();
	$query = "call friendship('{$idProfile}')";
	$campo= _db_query($query);
	$filas= _db_num_rows($campo);
	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	$res['rows']= $filas;
 	_db_close();
 	return $res;

}
function _getIdProfilePub($id){
	_db_connect();
	$query = "Select getIdProfilePub('{$id}')";
	$campo= _db_query($query);
	$res=_db_fetch_array($campo);
	$type=current($res);
	_db_close();
	return $type;
}
function  _getMyPetFriendship($idProfile){
	_db_connect();
	$query = "call myPetFriendship('{$idProfile}')";
	$campo= _db_query($query);
	$filas= _db_num_rows($campo);
	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	$res['rows']= $filas;
 	_db_close();
 	return $res;
}
function _getModePartier($idProfile){
	_db_connect();
	$query = "call getModePartier('{$idProfile}')";
	$campo = _db_query($query);
	$filas= _db_num_rows($campo);
	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	
	_db_close();
	return $res;
}
function _getStatusPartier($idProfile){
	_db_connect();
	$query = "call getStatusPartier('{$idProfile}')";
	$campo = _db_query($query);
	$filas= _db_num_rows($campo);
	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	
	_db_close();
	return $res;
}
function _localsUser($idProfile){
	_db_connect();
	$query = "call localsUser('{$idProfile}')";
	$campo= _db_query($query);
	$filas= _db_num_rows($campo);
	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	$res['rows']= $filas;
 	_db_close();
 	return $res;

}
function _eventsDontGo($idProfile){
	_db_connect();
	$query = "call getEventsFavDontGo('{$idProfile}')";
	$campo= _db_query($query);
	$filas= _db_num_rows($campo);
	for($i= 0 ; $i<$filas ; $i++){
 		$res[$i]=_db_fetch_array($campo);
 	}
 	$res['rows']= $filas;
 	_db_close();
 	return $res;
}
function _joinList($idProfile,$idList){
	_db_connect();
	$query = "call joinList('{$idList}','{$idProfile}')";
	_db_query($query);
	_db_close();
}
function _deleteOfList($idProfile,$idList){
	_db_connect();
	$query = "call deleteOfList('{$idList}','{$idProfile}')";
	_db_query($query);
	_db_close();
}


?>





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


function _session_destroy ()
{
		session_destroy();
}


function _login($email,$password){

	_db_connect();
	
	$passEncriptada = sha1($password);
	$query = "Select loginSucceed('{$email}','{$passEncriptada}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);	
	if ($existe != 0){
		$sToken = md5(uniqid(mt_rand(), true));
		$query = "Call insertToken('{$email}','{$sToken}')";
		_db_query($query);
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $existe);
		return $arr;	
	}
	else{
	       _db_close();
		   $arr = array('Token' => 0, 'id' => 0);
	       return $arr;
	}
	

}
function _loginFB($email){

	_db_connect();
	$query = "Select loginSuccessFB('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$id = current($campo);
  
	if ($id != 0){
		$sToken = md5(uniqid(mt_rand(), true));
		$query = "Call insertToken('{$email}','{$sToken}')";
		_db_query($query);
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $id);
		return $arr;
	}
	else{
	    _db_close();
	    $arr = array('Token' => 0, 'id' => 0);
		return $arr;
	}
	

}

function _loginGP($email){
	
	_db_connect();
	$query = "Select loginSuccessGP('{$email}')";
	$resultado = _db_query($query);
	
	$campo = _db_fetch_array($resultado);
	$id = current($campo);
  
	if ($id != 0){
		$sToken = md5(uniqid(mt_rand(), true));
		$query = "Call insertToken('{$email}','{$sToken}')";
		_db_query($query);
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $id);
		return $arr;
	}
	else{
	    _db_close();
	    $arr = array('Token' => 0, 'id' => 0);
		return $arr;
	}
	

}

function _insertUserFB($picture,$email,$name,$surnames,$birthday,$gender){
	_db_connect();
	$query = "Call insertFacebookUser('{$email}')";
	_db_query($query);
 
	
	$sToken = md5(uniqid(mt_rand(), true));
	$query = "Call insertToken('{$email}','{$sToken}')";
	_db_query($query);
	
	$query = "Select getIdProfile('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$id = current($campo);
	
	
	$query =  "call setPartierData('{$id}' ,'{$picture}', '{$name}',
	'{$surnames}', '{$birthday}' ,
	'{$gender}', \"\", \"\", \"\",\"\", \"\")";
	_db_query($query);
	_db_close();
	$arr = array('Token' => $sToken, 'id' => $id);
	return $arr;	
}


function _insertUserGP($picture,$email,$name,$surnames,$birthday,$gender){
	_db_connect();
	$query = "Call insertGoogleUser('{$email}')";
	_db_query($query);
 
	
	$sToken = md5(uniqid(mt_rand(), true));
	$query = "Call insertToken('{$email}','{$sToken}')";
	_db_query($query);
	
	$query = "Select getIdProfile('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$id = current($campo);
	
	
	$query =  "call setPartierData('{$id}' ,'{$picture}', '{$name}',
	'{$surnames}', '{$birthday}' ,
	'{$gender}', \"\", \"\", \"\",\"\", \"\")";
	_db_query($query);
	_db_close();
	$arr = array('Token' => $sToken, 'id' => $id);
	return $arr;	
}

function _insertUser($email,$pass,$name,$surnames,$birthday,$gender){
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
		$query = "Call insertToken('{$email}','{$sToken}')";
		_db_query($query);
		
		$query = "Select getIdProfile('{$email}')";
		$resultado = _db_query($query);
		$campo = _db_fetch_array($resultado);
		$id = current($campo);
				
		$query =  "call setPartierData('{$id}' ,\"\", '{$name}',
		'{$surnames}', '{$birthday}' ,'{$gender}', \"\", \"\", \"\",\"\",\"\")";
		_db_query($query);
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $id);
		return $arr;	
	}	
	else {
		_db_close();
		$arr = array('Token' => 0, 'id' => 0);
		return $arr;	
	}
}

function _insertLocalUser($email,$companyName,$nameLocal,$cif,$poblationLocal,$cpLocal,$telephone,$street,$streetName,$streetNumber){

	_db_connect();
	$query = "Select userExists('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);	
	$length = 8;
	$pass = substr(md5(microtime()),1,$length); //random pass
	/*Microtime Use () to give me the expression of complete time there, and I calculate the md5 hash with md5 (), which as you know takes a long chain, which at first sight are numbers and random letters [a-z0-9] and then extract the substr () function the first n (where n is $ length).*/

	if ($existe == 0){
		$passEncriptada = sha1($pass);
		$query = "Call insertPubUser('{$email}','{$passEncriptada}')" ;
		_db_query($query);

		$sToken = md5(uniqid(mt_rand(), true));
		$query = "Call insertToken('{$email}','{$sToken}')";
		_db_query($query);

		$query = "Select getIdProfile('{$email}')";
		$resultado = _db_query($query);
		$campo = _db_fetch_array($resultado);
		$id = current($campo);

		$query =  "call setLocalData('{$id}','{$companyName}' ,'{$nameLocal}','{$cif}','{$poblationLocal}','{$cpLocal}','{$telephone}','{$street}','{$streetName}','{$streetNumber}',\"\",\"\",\"\",\"\",\"\",\"\",\"\" )";

		_db_query($query);
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $id);
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
	$pass = substr(md5(microtime()),1,$length); //random pass
	/*Microtime Use () to give me the expression of complete time there, and I calculate the md5 hash with md5 (), which as you know takes a long chain, which at first sight are numbers and random letters [a-z0-9] and then extract the substr () function the first n (where n is $ length).*/

	if ($existe == 0){
		$passEncriptada = sha1($pass);
		$query = "Call insertDJUser('{$email}','{$passEncriptada}')" ;
		_db_query($query);

		$sToken = md5(uniqid(mt_rand(), true));
		$query = "Call insertToken('{$email}','{$sToken}')";
		_db_query($query);

		$query = "Select getIdProfile('{$email}')";
		$resultado = _db_query($query);
		$campo = _db_fetch_array($resultado);
		$id = current($campo);

		$query =  "call setDJData('{$id}',{$nameDJ}','{$name}','{$surname}','{$telephone}','{$gender}',{$birthdate}',\"\",\"\",\"\")";

		_db_query($query);
		_db_close();
		$arr = array('Token' => $sToken, 'id' => $id);
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
	$query = "Call tokenOK('{$id}','{$token}')";
	$res=_db_query($query);
	_db_close();
	return $res;

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
function _setLocalData($idProfile,$companyNameLocal,$localName,$cif, $poblationLocal,$cpLocal,$telephoneLocal,$street,$streetNameLocal,$streetNumberLocal,$music,$entryPrice ,$drinkPrice,$openingHours,$closeHours,$picture,$about){
	
	_db_connect();
	$query = "call setLocalData('{$idProfile}','{$companyNameLocal}' ,'{$localName}','{$cif}','{$poblationLocal}','{$cpLocal}','{$telephoneLocal}','{$street}','{$streetNameLocal}','{$streetNumberLocal}','{$music}','{$entryPrice}' ,'{$drinkPrice}','{$openingHours}','{$closeHours}','{$picture}','{$about}')";
	_db_query($query);
	_db_close();
}

function _setDJData($idProfile,$nameDJ,$name,$surname,$telephoneDJ,$gender,$birthdate,$picture, $music, $about){

	_db_connect();
	$query = "call setDJData('{$idProfile}',{$nameDJ}','{$name}','{$surname}','{$telephoneDJ}','{$gender}',{$birthdate}','{$picture}' ,'{$music}' ,'{$about}')";
	_db_query($query);
	_db_close();

}

?>








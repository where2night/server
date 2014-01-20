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

function _session_destroy ()
{
		session_destroy();
}


function _login($email,$password){

	_db_connect();
	
	$passEncriptada = sha1($password);
	$query = "Select loginSucceed('{$email}',\"{$passEncriptada}\")";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);	
	if ($existe == 1){
		$sToken = md5(uniqid(mt_rand(), true));
		$query = "Call insertToken('{$email}','{$sToken}')";
		_db_query($query);
		_db_close();
		return $sToken;	
	}
	else{
	       _db_close();
	       return 0;
	}
	

}
function _loginFB($email){

	_db_connect();
	$query = "Select loginSuccessFB('{$email}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);
  
	if ($existe == 1){
		$sToken = md5(uniqid(mt_rand(), true));
		$query = "Call insertToken('{$email}','{$sToken}')";
		_db_query($query);
		_db_close();
		return $sToken;		
		
	}
	else{
	       _db_close();
	       return 0;
	}
	

}

function _insertUserFB($email,$name,$surnames,$birthday,$gender){
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
	
	
	$query =  "call setPartierData('{$id}' ,NULL, '{$name}',
	'{$surnames}', '{$birthday}' ,
	'{$gender}', null, null, null, 
null, null)";
	_db_query($query);
	_db_close();
	return $sToken;		
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
	
	
	$query =  "call setPartierData('{$id}' ,NULL, '{$name}',
	'{$surnames}', '{$birthday}' ,
	'{$gender}', null, null, null, 
null, null)";
	_db_query($query);
	_db_close();
	return $sToken;	
	}	
	else {
		_db_close();
		return 0;	
	}
}

?>


















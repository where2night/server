<?php

/*
 * Utils functions
 */

require_once 'db.inc';


// Protege variables tipo string contra posible ataques de inyección SQL
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


// Protege arrays contra posible ataques de inyección SQL
function _protect_data_array ($array)
{
	if (isset ($array) && is_array ($array))
	{
		if (!get_magic_quotes_gpc())
			foreach ($array as $key => $value)
				$secure[addslashes ($key)] = addslashes ($value);	
		else
			// Revisar la protección de las claves en este caso
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

function _db_concuerdan($nombre,$id)
{
	 $query = "Select concuerdan('{$nombre}',{$id})";
	 $resultado = _db_query($query);
	 $concuerdan = _db_fetch_array($resultado);
	 $campo = current($concuerdan);	
	 return $campo;
}

function _check_privileges($email)
{
	 _db_connect();
	 $query = "Select existeUsuario('{$email}')";	 	
	 $resultado = _db_query($query);
	 $campo = _db_fetch_array($resultado);
	 $existe = current($campo);	
	 print($existe);

	 if ($existe == 1)
	 {
		 $query = "Select esAdministrador('{$email}')";
		 $resultado = _db_query($query);
	 	 $campo = _db_fetch_array($resultado);
	 	 $esAdmin = current($campo);	
		 print($esAdmin);		 
	 }
	 else
	 {
		 $query = "call crearUsuario('{$email}')";
		 _db_query($query);
		 $esAdmin = 0;
	 }
	 _db_close ();
	 return $esAdmin;	
}

function _formato_fechas($fecha)
{
	return str_replace("-","/",$fecha);
}

function _db_esGestor($id)
{
	 $query = "Select esGestor({$id})";
	 $resultado = _db_query($query);
	 $concuerdan = _db_fetch_array($resultado);
	 $campo = current($concuerdan);	
	 return $campo;
}

function _db_existeProyecto ($name)
{
	 $query = "select existeProyecto(\"{$name}\");";
	 $resultado = _db_query($query);	 
	 $existe = _db_fetch_array($resultado);
	 $campo = current($existe);	
	 return $campo;
}

function _session_destroy ()
{
		session_destroy();
}


function _login($email,$password){

	_db_connect();
	$query = "Select loginSucceed('{$email}','{$password}')";
	$resultado = _db_query($query);
	$campo = _db_fetch_array($resultado);
	$existe = current($campo);	
	if ($existe == 1){
		$sToken = md5(uniqid(mt_rand(), true));
		$query = "Call insertToken('{$email}','{$sToken}')";
		_db_query($query);
		return $sToken;	
	}
	else return 0;
	

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
		return $sToken;		
		
	}
	else return 0;
	

}

function _insertUserFB($email){
	
	$query = "Call insertFacebookUser('{$email}')";
	_db_query($query);
 
	
	$sToken = md5(uniqid(mt_rand(), true));
	$query = "Call insertToken('{$email}','{$sToken}')";
	_db_query($query);
	return $sToken;		
}

?>


















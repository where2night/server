#BackEnd Where2Night


##<a name='Content'></a>Contents
* [Team Members](#Members)
* [Connection Urls](#Connection)
* [User Section](#User)
* [Premises Section](#Premises)
* [Dj Section](#Dj)


##<a name='Members'></a>Team Members
######<b>Adrian Diaz Jimenez</b> 
######<b>Luis Cubero</b>

##<a name='Connection'></a>Connection Urls
* The API production base url is: <b> http://www.api.where2night.es </b>
* The API development base url is: <b> http://www.develop.where2night.es </b>
* Every data exchange uses JSON format


##<a name='User'></a>User Section
* [Register](#RegisterUser)
* [Login](#LoginUser)
* [Edit Profile](#EditUser)

###<a name='RegisterUser'></a>Register
	* <baseUrl> + /register/user.php
	* Method: POST
	* Data Sent:
		{
			"email": <email>
			"pass": <password>
			"name": <name>
			"surnames": <surname> // We must fix this and change it to surname
			"birthdate": <birthdate dd/mm/yyyy>
			"gender": <male> or <female>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"type"	: 0
			"New"	: True
		}

###<a name='LoginUser'></a>Login
There are three ways to login in our application:
* [Facebook Login](#Facebook)
* [Google Plus Login](#Google)
* [Email Login](#EmailUser)

####<a name='Facebook'></a>Facebook Login
	* <baseUrl> + /login/loginfb.php
	* Method: POST
	* Data Sent:
		{
			"email"		: <email gotten from Facebook>
			"picture"	: <Picture url from Facebook>
			"name"		: <name gotten from Facebook>
			"surnames"	: <surname gotten from Facebook> // We must fix this and change it to surname
			"birthdate"	: <birthdate gotten from Facebook>
			"gender"	: <male> or <female>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"type"	: 0
			"New"	: <true if is a new user> or <false if is not a new user>
		}


####<a name='Google'></a>Google Plus Login
	* <baseUrl> + /login/logingp.php
	* Method: POST
	* Data Sent:
		{
			"email"		: <email gotten from Facebook>
			"picture"	: <user's picture url Max 100 characters>
			"name"		: <name gotten from Facebook>
			"surnames"	: <surname gotten from Facebook> // We must fix this and change it to surname
			"birthdate"	: <birthdate gotten from Facebook>
			"gender"	: <male> or <female>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"type"	: 0
			"New"	: <true if is a new user> or <false if is not a new user>
		}

####<a name='EmailUser'></a>Email Login
	* <baseUrl> + /login/login.php
	* Method: POST
	* Data Sent:
		{
			"email"	  : <email gotten from Facebook>
			"password": <user's password>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"type"	: 0
		}


###<a name='EditUser'></a>Edit Profile
	* <baseUrl> + /update/user.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{
			"idProfile"	: <User's idProfile>
			"picture"	: <user's picture url Max 100 characters>
			"name"		: <Max 20 characters>
			"surnames"	: <Max 45 characters> // We must fix this and change it to surname
			"birthdate"	: <birthdate dd/mm/yyyy>
			"gender"	: <male> or <female>
			"music"		: <Max 20 characters>
			"civil_sate"	: <Max 20 characters>
			"city"		: <Max 20 characters>
			"drink"		: <Max 20 characters>
			"about"		: <Max 200 characters>
		}
	* Method: POST
	* Every slot has to be text
	* Data Sent:
		{
			"idProfile"	: <User's idProfile>
			"picture"	: <user's picture url Max 100 characters>
			"name"		: <Max 20 characters>
			"surnames"	: <Max 45 characters> // We must fix this and change it to surname
			"birthdate"	: <birthdate dd/mm/yyyy>
			"gender"	: <male> or <female>
			"music"		: <Max 20 characters>
			"civil_sate"	: <Max 20 characters>
			"city"		: <Max 20 characters>
			"drink"		: <Max 20 characters>
			"about"		: <Max 200 characters>
		}


##<a name='Premises'></a>Premises Section
* [Register](#RegisterPremises)
* [Login](#LoginPremises)
* [Edit Profile](#EditPremises)

###<a name='RegisterPremises'></a>Register
	* <baseUrl> + /register/local.php // We must change to the English word Premises
	* Method: POST
	* Data Sent:
		{
			"email"		: <Max 50 characters>
			"companyName"	: <Max 50 characters>
			"localName"	: <Max 20 characters>
			"cif"		: <Max 9 characters>
			"poblationLocal": <Max 20 characters>
			"cpLocal"	: <This must be a numer>
			"telephone"	: <This must be a numer>
			"street"	: <0 street> or <1 Avda> or <2 Plaza>
			"streetName"	: <Max 50 characters>
			"streetNumber"	: <Max 50 characters>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"New"	: True
		}


###<a name='LoginPremises'></a>Login
	* <baseUrl> + /login/login.php
	* Method: POST
	* Data Sent:
		{
			"email": <email gotten from Facebook>
			"password": <user's password>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"type"	: 0 //Not Added Yet (21/03/14)
		}

###<a name='EditPremises'></a>Edit Profile
	* <baseUrl> + /update/local.php/<idProfile>/<Token>/<idLocal> // We must change to the English word Premises
	* Method: GET
	* Response:
		{
			"companyName"	: <Max 50 characters>
			"localName"	: <Max 20 characters>
			"cif"		: <Max 9 characters>
			"poblationLocal": <Max 20 characters>
			"cpLocal"	: <This must be a numer>
			"telephone"	: <This must be a numer>
			"street"	: <0 street> or <1 Avda> or <2 Plaza>
			"streetName"	: <Max 50 characters>
			"streetNumber"	: <Max 50 characters>
			"music"		: <Max 20 characters>
			"entryPrice"	: <This must be a numer>
			"drinkPrice"	: <This must be a numer>
			"openingHours"	: <This must be a time>
			"closeHours"	: <This must be a time>
			"picture"	: <Profile's picture url>
			"about"		: <Max 100 characters>
		}
	* <baseUrl> + /update/local.php/<idProfile>/<Token> // We must change to the English word Premises
	* Method: POST
	* Data Sent:
		{
			"idProfile"	: <Premises's idProfile>
			"companyName"	: <Max 50 characters>
			"localName"	: <Max 20 characters>
			"cif"		: <Max 9 characters>
			"poblationLocal": <Max 20 characters>
			"cpLocal"	: <This must be a numer>
			"telephone"	: <This must be a numer>
			"street"	: <0 street> or <1 Avda> or <2 Plaza>
			"streetName"	: <Max 50 characters>
			"streetNumber"	: <Max 50 characters>
			"music"		: <Max 20 characters>
			"entryPrice"	: <This must be a numer>
			"drinkPrice"	: <This must be a numer>
			"openingHours"	: <This must be a time>
			"closeHours"	: <This must be a time>
			"picture"	: <Profile's picture url>
			"about"		: <Max 100 characters>
		}


##<a name='Dj'></a>Dj Section
* [Register](#RegisterDj)
* [Login](#LoginDj)
* [Edit Profile](#EditDj)

###<a name='RegisterDj'></a>Register
	* <baseUrl> + /register/dj.php 
	* Method: POST
	* Data Sent:
		{
			"email"		: <Max 50 characters>
			"nameDJ"	: <Max 30 characters>
			"name"		: <Max 20 characters>
			"surname"	: <Max 45 characters>
			"telephone"	: <This must be a number>
			"birthdate"	: <birthdate dd/mm/yyyy>
			"telephone"	: <This must be a numer>
			"gender"	: <male> or <female>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"type"	: -1
			"New"	: True
		}


###<a name='LoginDj'></a>Login
	* <baseUrl> + /login/login.php
	* Method: POST
	* Data Sent:
		{
			"email"		: <email gotten from Facebook>
			"password"	: <user's password>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"type"	: -1 
		}

###<a name='EditDj'></a>Edit Profile
	* <baseUrl> + /update/user.php/<idProfile>/<Token>/<idDj>
	* Method: GET
	* Response:
		{
			"nameDJ"	: <Max 30 characters>
			"name"		: <Max 20 characters>
			"surname"	: <Max 45 characters>
			"telephone"	: <This must be a number>
			"birthdate"	: <birthdate dd/mm/yyyy>
			"telephone"	: <This must be a numer>
			"gender"	: <male> or <female>
			"music"		: <Max 20 characters>
			"picture"	: <Profile's picture url>
			"about"		: <Max 100 characters>
		}
	* <baseUrl> + /update/user.php/<idProfile>/<Token>
	* Method: POST
	* Data Sent:
		{
			"idProfile"	: <Premises's idProfile>
			"nameDJ"	: <Max 30 characters>
			"name"		: <Max 20 characters>
			"surname"	: <Max 45 characters>
			"telephone"	: <This must be a number>
			"birthdate"	: <birthdate dd/mm/yyyy>
			"telephone"	: <This must be a numer>
			"gender"	: <male> or <female>
			"music"		: <Max 20 characters>
			"picture"	: <Profile's picture url>
			"about"		: <Max 100 characters>
		}

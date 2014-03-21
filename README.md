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
			"New"	: <true if is a new user> or <false if is not a new user>
		}


####<a name='Google'></a>Google Plus Login
	* <baseUrl> + /login/logingp.php
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
			"New"	: <true if is a new user> or <false if is not a new user>
		}

####<a name='EmailUser'></a>Email Login
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
			"type"	: -1 //Not Added Yet (21/03/14)
		}


###<a name='EditUser'></a>Edit Profile
	* <baseUrl> + /update/user.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{
			"idProfile"	: <User's idProfile>
			"picture"	: <user's picture url>
			"name"		: <name>
			"surnames"	: <surname> // We must fix this and change it to surname
			"birthdate"	: <birthdate dd/mm/yyyy>
			"gender"	: <male> or <female>
			"music"		: <Favourite music style>
			"civil_sate"	: <>
			"city"		: <City where user is>
			"drink"		: <Favourite drink>
			"about"		: <Some info user wants to share>
		}
	* Method: POST
	* Every slot has to be text
	* Data Sent:
		{
			"idProfile"	: <User's idProfile>
			"picture"	: <user's picture url>
			"name"		: <name>
			"surnames"	: <surname> // We must fix this and change it to surname
			"birthdate"	: <birthdate dd/mm/yyyy>
			"gender"	: <male> or <female>
			"music"		: <Favourite music style>
			"civil_sate"	: <>
			"city"		: <City where user is>
			"drink"		: <Favourite drink>
			"about"		: <Some info user wants to share>
		}




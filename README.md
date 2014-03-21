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
###Login
There are three ways to login in our application:
* [Facebook Login](#Facebook)
* [Google Plus Login](#Google)
* [Email Login](#Email)

####Facebook Login
	* <baseUrl> + /login/loginfb.php
	* Method: POST
	* Data Sent:
		{
			"email": <email gotten from Facebook>
			"picture": <Picture url from Facebook>
			"name": <name gotten from Facebook>
			"surnames": <surname gotten from Facebook> // We must fix this and change it to surname
			"birthdate": <birthdate gotten from Facebook>
			"gender": <male> or <female>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"New"	: <true if is a new user> or <false if is not a new user>
		}







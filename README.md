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
######<b>Sergio Primo</b>

##<a name='Connection'></a>Connection Urls
* The API production base url is: <b> http://www.api.where2night.es </b>
* The API development base url is: <b> http://www.develop.where2night.es </b>
* Every data exchange uses JSON format


##<a name='User'></a>User Section
* [Register](#RegisterUser)
* [Login](#LoginUser)
* [Edit Profile](#EditUser)
* [News](#News)
* [My Pet Friendship] (#myPetFriendship)
* [My events] (#myEvents)
* [Go to pub] (#goToPub)
* [Go to event] (#goToEvent)
* [Follow friend] (#followFriend)
* [Follow] (#follow)
* [Read Dj] (#ReadDj)
* [Read Events] (#ReadEvents)
* [Read Locals] (#ReadLocals)
* [Read my friends] (#)ReadMyFriends
* [Read my news] (#ReadMyNews)
* [Read Partiers] (#ReadPartiers)
* [Read my pet friendship] (#ReadPetFriendship)
* [Read all users, searchs] (#ReadAllUsers)
* [Number of Partiers who go to a pub] (#numPartiersGoToPub)
* [Number of Partiers who go to a event] (#numPartiersGoToEvent)
* [Mode] (#Mode)
* [Status] (#Status)
* [Check unread Messages](#checkMessagesUnread)
* [Read all my messages](#ReadMessages)
* [Read all my messages Sorted by Friend](#ReadMessagesSorted)
* [Read my messages of a Friend](#ReadMessagesFriend)
* [Partiers with which you have messages](#partiersMessages)
* [SendMessage](#sendMessage)

###<a name='RegisterUser'></a>Register
	* <baseUrl> + /register/user.php
	* Method: POST
	* Data Sent:
		{
			"email"		: <email>
			"pass"		: <password>
			"name"		: <name>
			"surnames"	: <surname> // We must fix this and change it to surname
			"birthdate"	: <birthdate dd/mm/yyyy>
			"gender"	: <male> or <female>
			"mobile" 	: <if this variable is set, means that the request is from mobile>
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
			"mobile" 	: <if this variable is set, means that the request is from mobile>
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
			"email"		: <email gotten from Google Plus>
			"picture"	: <user's picture url Max 100 characters>
			"name"		: <name gotten from Google Plus>
			"surnames"	: <surname gotten from Google Plus> // We must fix this and change it to surname
			"birthdate"	: <birthdate gotten from Google Plus>
			"gender"	: <male> or <female>
			"mobile" 	: <if this variable is set, means that the request is from mobile>
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
			"mobile"  : <if this variable is set, means that the request is from mobile>
		}
	* Response:
		{
			"Token"	: <Access Token>
			"id"	: <Profile ID>
			"type"	: 0
		}


###<a name='EditUser'></a>Edit Profile
	* <baseUrl> + /update/user.php/<idProfile>/<Token>/<idUser>
	* Method: GET
	* Response:
		{
			"idProfile"	: <User's idProfile>
			"picture"	: <user's picture url Max 100 characters>
			"uploading"	: <if this variable is set means that Android app is uploading profile image>
			"name"		: <Max 20 characters>
			"surnames"	: <Max 45 characters> // We must fix this and change it to surname
			"birthdate"	: <birthdate dd/mm/yyyy>
			"gender"	: <male> or <female>
			"music"		: <Max 20 characters>
			"civil_sate"	: <Max 20 characters>
			"city"		: <Max 20 characters>
			"drink"		: <Max 20 characters>
			"about"		: <Max 200 characters>
			"mode"      : <tinyint>
			"status"    : <Max 140 characters>
			"modefriend": <0- not friends, 1-he want to be your friend, 2-yourself, 
			               3-you want to be his friend, 4-friends>
			"facebook"	: <Max 50 characters>
			"twitter"	: <Max 15 characters>
			"instagram"	: <Max 30 characters>

			
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
			"mode"      : <tinyint>
			"status"    : <Max 140 characters>
			"facebook"	: <Max 50 characters>
			"twitter"	: <Max 15 characters>
			"instagram"	: <Max 30 characters>
		}


###<a name='News'></a>News
	* <baseUrl> + /read/news.php/<idProfile>/<Token>/<Page>
	* Method: GET
	* Response:
		[	
		    {
		        "localName"	: <Max 20 characters>
		        "picture"	: <Profile's picture url>
		        "title"		: ""
		        "text"		: ""
		        "date"		: < Date >
		        "startHour"	: < Time >
		        "closeHour"	: < Time >
		        "createdTime"	: < DateTime >
		        "TYPE"		: "1" < That means that is an event >
		        "GOES"		: < If this filed is not null means that this partier goes to this event >
		    }
		]
		
###<a name='NewsUser'></a>NewsUser
	* <baseUrl> + /read/newsUser.php/<idProfile>/<Token>/<idUserProfiel>/<Page>
	* Method: GET
	* Response:
		[	
		    {
		        "localName"	: <Max 20 characters>
		        "picture"	: <Profile's picture url>
		        "title"		: ""
		        "text"		: ""
		        "date"		: < Date >
		        "startHour"	: < Time >
		        "closeHour"	: < Time >
		        "createdTime"	: < DateTime >
		        "TYPE"		: "1" < That means that is an event >
		        "GOES"		: < If this filed is not null means that this partier goes to this event >
		    }
		]

		
###<a name='myPetFriendship'></a>My pet friendship
    * We get the data to whom we have sent the friendship request and has not answered yet.
	* <baseUrl> + /action/mypetfriendship.php/<idProfile>/<Token>
	* Method: GET
	* Response:		
		{    
		   For 0 to "i":{
		            "idProfile"	: <User's idProfile>
           		    "picture"	: <user's picture url Max 100 characters>
			        "name"		: <Max 20 characters>
			        "surnames"	: <Max 45 characters> // We must fix this and change it to surname
			        "birthdate"	: <birthdate dd/mm/yyyy>
			        "gender"   	: <male> or <female>
			        "music"		: <Max 20 characters>
			        "civil_sate"	: <Max 20 characters>
			        "city"		: <Max 20 characters>
			        "drink"		: <Max 20 characters>
			        "about"		: <Max 200 characters>
			        "mode"      : <>
			        "status"    : <Max 140 characters>
	                }
					
          "numPetitions"   : <value of $i>
          "myfriendship"   : <true/false>	
		
		}		

###<a name='myEvents'></a>My events
	* <baseUrl> + /action/myevents.php/<idProfile>/<Token>
	* Method: GET
	* Response:		
		{    
		   For 0 to "i":{
					"name"      :  <Pub's name>
					"pictureC"  :  <Pub's picture>
					"idProfile" :  <Pub's id>
	                }
		
		}	
		
		
###<a name='goToPub'></a>Go to pub
	* <baseUrl> + /action/goToPub.php/<idProfile>/<Token>/<idLocal>
	* Method: GET
	* Response:
		{
			"goToPub"   : <True or error>
		}
	* Method: DELETE
	* Data deleted:
		{
			"goToPub"   : <False or error>
		}		


		
###<a name='goToEvent'></a>Go to event
	* <baseUrl> + /action/goToEvent.php/<idProfile>/<Token>/<idEvent>
	* Method: GET
	* Response:
		{
			"goto"   : <True>
		}
	* Method: DELETE
	* Data deleted:
		{
			"goto"   : <False>
		}

	
###<a name='followFriend'></a>Follow Friend
	* <baseUrl> + /action/followFriend.php/<idProfile>/<Token>/<idUser>
	* Method: GET
	* Response:
		{
			"follow"   : <true or false>
		}
	* Method: POST
	* Data Sent:
		{
			"follow"   : <true or false>
		}
    * Method: DELETE
	* Data deleted:
		{
			"delete"   : <true or false>
		}
	

###<a name='follow'></a>Follow
	* <baseUrl> + /action/follow.php/<idProfile>/<Token>/<idUser>
	* Method: GET
	* Response:
		{
			"follow"   : <true or error>
		}

    * Method: DELETE
	* Data deleted:
		{
			"delete"   : <false or error>
		}
		



###<a name='ReadDj'></a>Read Djs
	* <baseUrl> + /read/djs.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{
		    "idProfile"	: <Dj's idProfile>
			"nameDJ"	: <Max 30 characters>
			"music"		: <Max 20 characters>
			"picture"	: <Profile's picture url>
		}
		
		
###<a name='ReadEvents'></a>Read Events
	* <baseUrl> + /read/events.php/<idProfile>/<Token>/<idUser>
	* Method: GET
	* Response:
		{
			"name"	   : <Max 30 characters>
			"pictureC" : <Profile's picture url>
			"error"    : <false or true>
			"idEvent   : <Event's profile>
			"title"    : <Max 40 characters>
			"text"     : <Max 40 characters>
			"date"     : <dd/mm/yyyy>
			"startHour": <time>
			"CloseHour": <time>
			"CreatedTime": <timeStamp>
			
		}
		
		
###<a name='ReadLocals'></a>Read Locals
	* <baseUrl> + /read/locals.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{
		    "idProfile"	: <Pub's idProfile>
			"localName"	: <Max 20 characters>
			"telephoneLocal"		: <Max 11 characters>
			"street"	: <0 street> or <1 Avda> or <2 Plaza>
			"streetNameLocal"	: <Max 50 characters>
			"streetNumberLocal"	: <Max 50 characters>
			"latitude"	: <Max 11 characters>
			"longitude"	: <Max 11 characters>
			"picture"	: <Profile's picture url>
		}
		
		
###<a name='ReadMyFriends'></a>Read Locals
	* <baseUrl> + /read/myFriends.php/<idProfile>/<Token>/<idUser>
	* Method: GET
	* Response:
		{
		   For to "i":{
		            "idProfile"	: <User's idProfile>
           		    "picture"	: <user's picture url Max 100 characters>
			        "name"		: <Max 20 characters>
			        "surnames"	: <Max 45 characters> // We must fix this and change it to surname
			        "birthdate"	: <birthdate dd/mm/yyyy>
			        "gender"   	: <male> or <female>
			        "music"		: <Max 20 characters>
			        "civil_sate"	: <Max 20 characters>
			        "city"		: <Max 20 characters>
			        "drink"		: <Max 20 characters>
			        "about"		: <Max 200 characters>
			        "mode"      : <tinyint>
			        "status"    : <Max 140 characters>
			        "facebook"	: <Max 50 characters>
			        "twitter"	: <Max 15 characters>
			        "instagram"	: <Max 30 characters>
				  
				  }


           "numFriends": $i 
           "myfriends": <true or false>}

		}
		
		
###<a name='ReadMyNews'></a>Read News
	* <baseUrl> + /read/news.php/<idProfile>/<Token>/<page>
	* Method: GET
	* Response:
		{
		   For to "i":{
		            "idProfile"	: <User's idProfile>
           		    "picture"	: <user's picture url Max 100 characters>
			        "name"		: <Max 20 characters>
			        "surnames"	: <Max 45 characters> // We must fix this and change it to surname
			        "birthdate"	: <birthdate dd/mm/yyyy>
			        "gender"   	: <male> or <female>
			        "music"		: <Max 20 characters>
			        "civil_sate"	: <Max 20 characters>
			        "city"		: <Max 20 characters>
			        "drink"		: <Max 20 characters>
			        "about"		: <Max 200 characters>
			        "mode"      : <tinyint>
			        "status"    : <Max 140 characters>
				  
				  }


           "numFriends": $i 
           "myfriends": <true or false>}

		}
		
		

###<a name='ReadPartiers'></a>Read Partiers
	* <baseUrl> + /read/partiers.php/<idProfile>/<Token>
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
			"mode"      : <tinyint>
			"status"    : <Max 140 characters>
			"facebook"	: <Max 50 characters>
			"twitter"	: <Max 15 characters>
			"instagram"	: <Max 30 characters>
		}		
		
		
###<a name='ReadPetFriendship'></a>Read Pet Friend ship
	* <baseUrl> + /read/petFriendship.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{
		       
		   For 0 to "i":{
		            "idProfile"	: <User's idProfile>
           		    "picture"	: <user's picture url Max 100 characters>
			        "name"		: <Max 20 characters>
			        "surnames"	: <Max 45 characters> // We must fix this and change it to surname
			        "birthdate"	: <birthdate dd/mm/yyyy>
			        "gender"   	: <male> or <female>
			        "music"		: <Max 20 characters>
			        "civil_sate"	: <Max 20 characters>
			        "city"		: <Max 20 characters>
			        "drink"		: <Max 20 characters>
			        "about"		: <Max 200 characters>
			        "mode"      : <tinyint>
			        "status"    : <Max 140 characters>
			        "facebook"	: <Max 50 characters>
			        "twitter"	: <Max 15 characters>
			        "instagram"	: <Max 30 characters>
	                }
					
          "numPetitions"   : <value of $i>
          "friendship"   : <true or false>	
		
		}	
			

###<a name='ReadAllUsers'></a>Read All Users
	* <baseUrl> + /read/allusers.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{

        Partiers:
		  For 0 to "i": {
		  	"name"		: <Max 20 characters>
			"surnames"	: <Max 45 characters>
			"picture"	: <user's picture url Max 100 characters>
			"idProfile"	: <User's idProfile> 
			"type"      : 0
		}	

		Pubs:
		  For 0 to "j": {
		  	"name"		: <Max 20 characters>
			"picture"	: <user's picture url Max 100 characters>
			"idProfile"	: <User's idProfile> 
			"type"      : 1
		}


        }


###<a name='Mode'></a>Mode
	* <baseUrl> + /update/mode.php/<idProfile>/<Token>
	* Method: POST
	* Data Sent:
		{
			"mode" : <tinyint>
		}
    * Response:
		{
			"mode"  : <true or false>
		}


###<a name='Status'></a>Status
	* <baseUrl> + /update/status.php/<idProfile>/<Token>
	* Method: POST
	* Data Sent:
		{
			"status" : <Max 140 characters>
		}
    * Response:
		{
			"status"  : <true or false>
		}

###<a name='numPartiersGoToPub'></a>Number of Partiers who go to a pub
	* <baseUrl> + /read/numPartiersGoToPub.php/<idProfile>/<Token>/<idUser>   //idUser have to be a pub
	* Method: GET
	* Response:
		{
		    "howManyGoToPub('idProfilePub')"	: <Int>
		}

###<a name='numPartiersGoToEvent'></a>Number of Partiers who go to a event
	* <baseUrl> + /read/numPartiersGoToPub.php/<idProfile>/<Token>/<idEvent>
	* Method: GET
	* Response:
		{
		    "howManyGoesToEvent('idEvent')"	: <Int>
		}	

###<a name='checkMessagesUnread'></a>Check unread Messages
	* <baseUrl> + /read/checkMessagesUnread.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{
		    For 0 to "i": {

		    	           "idProfile" : <idProfile of all users who sent you a message without reading>
		    	           "name"      :<Friend's name>
                           "surnames"  :<Friend's surnames>
		    }

		    //if it is null, don't new messages
		}	


###<a name='ReadMessages'></a>Read all my messages
	* <baseUrl> + /read/messages.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{
		    For 0 to "i": {

		    	           "message"    : <Max 1000 characters>
		    	           "createdTime": <Sent time>
		    	           "idProfile"  : <idProfile who have sent or received>
		    	           "mode"       : <0:sent  1:received, but NOT read  2:read>
		    }
		}	


###<a name='ReadMessagesSorted'></a>Read all my messages Sorted by Friend
	* <baseUrl> + /read/messagesSorted.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{
		      
            For 0 to "i": {
              
		        For 0 to "j": {

		    	           "message"    : <Max 1000 characters>
		    	           "createdTime": <Sent time>
		    	           "mode"       : <0:sent  1:received, but NOT read  2:read>
		             }
                         "idProfile" : <idProfile who have sent or received>
                         "num"       :<number of messages>
                         "name"      :<Friend's name>
                         "surnames"  :<Friend's surnames>
                         "picture"   :<Friend's picture>

                  }

		}	


###<a name='ReadMessagesFriend'></a>Read my messages of a Friend
	* <baseUrl> + /read/messagesFriend.php/<idProfile1>/<Token>/<idProfile2>
	* Method: GET
	* Response:
	    {
		For 0 to "i": {
		    
		    "message"    : <Max 1000 characters>
		    "createdTime": <Sent time>
		    "mode"       : <0:sent  1:received, but NOT read  2:read>
		    
		}
		 "num"       :<number of messages>	
         "name"      :<idProfile1's name>
         "surnames"  :<idProfile1's surnames>
         "picture"   :<idProfile1's picture>
         "nameF"     :<idProfile2's name>
         "surnamesF" :<idProfile2's surnames>
         "pictureF"  :<idProfile2's picture>
       }


###<a name='partiersMessages'></a>Partiers with which you have messages
	* <baseUrl> + /read/partiersMessages.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		{
		    For 0 to "i": {

		    	        "idProfile"  : <idProfile who have sent or received message(s)>
		    }
		}	


####<a name='sendMessage'></a>Send Message
	* <baseUrl> + /actions/sendMessage.php/<idProfile>/<Token>/<idReceiver>
	* Method: POST
	* Data Sent:
		{
			"message" : <max 1000 characters>
		}
	* Response:
		{
			"sent"	: <True or false>
		}

				
	
##<a name='Premises'></a>Premises Section
* [Register](#RegisterPremises)
* [Login](#LoginPremises)
* [Edit Profile](#EditPremises)
* [Pub Followers] (#PubFollowers)
* [Create Event] (#CreateEvent)
* [Edit Event]  (#EditEvent)

###<a name='RegisterPremises'></a>Register
	* <baseUrl> + /register/local.php // We must change to the English word Premises
	* Method: POST
	* Data Sent:
		{
			"email"		: <Max 50 characters>
			"companyNameLocal"	: <Max 50 characters>
			"localName"	: <Max 20 characters>
			"cif"		: <Max 9 characters>
			"poblationLocal": <Max 20 characters>
			"cpLocal"	: <This must be a numer>
			"telephoneLocal"	: <This must be a numer>
			"street"	: <0 street> or <1 Avda> or <2 Plaza>
			"streetNameLocal"	: <Max 50 characters>
			"streetNumberLocal"	: <Max 50 characters>
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
			"companyNameLocal"	: <Max 50 characters>
			"localName"  	: <Max 20 characters>
			"cif"		    : <Max 9 characters>
			"poblationLocal": <Max 20 characters>
			"cpLocal"	    : <This must be a numer>
			"telephoneLocal": <This must be a numer>
			"street"	    : <0 street> or <1 Avda> or <2 Plaza>
			"streetNameLocal"	: <Max 50 characters>
			"streetNumberLocal"	: <Max 50 characters>
			"latitude"	    : <Max 11 characters>
			"longitude"	    : <Max 11 characters>
			"music"		    : <Max 20 characters>
			"entryPrice"	: <This must be a number>
			"drinkPrice"	: <This must be a number>
			"openingHours"	: <This must be a time>
			"closeHours"	: <This must be a time>
			"picture"	    : <Profile's picture url>
			"about"		    : <Max 100 characters>
			"facebook"	: <Max 50 characters>
			"twitter"	: <Max 15 characters>
			"instagram"	: <Max 30 characters>
			"createdTime"   : <timestamp>
			"follow:	    : <0 not following this local by idProfile> or <1 following this local by idProfile>
			"followers"	    : <total followers of this premise>
		}

	* <baseUrl> + /update/local.php/<idProfile>/<Token> // We must change to the English word Premises
	* Method: POST
	* Data Sent:
		{
			"idProfile"	: <Premises's idProfile>
			"companyNameLocal"	: <Max 50 characters>
			"localName"	: <Max 20 characters>
			"cif"		: <Max 9 characters>
			"poblationLocal": <Max 20 characters>
			"cpLocal"	: <This must be a number>
			"telephoneLocal"	: <This must be a number>
			"street"	: <0 street> or <1 Avda> or <2 Plaza>
			"streetNameLocal"	: <Max 50 characters>
			"streetNumberLocal"	: <Max 50 characters>
			"latitude"	: <Max 11 characters>
			"longitude"	: <Max 11 characters>
			"music"		: <Max 20 characters>
			"entryPrice"	: <This must be a number>
			"drinkPrice"	: <This must be a number>
			"openingHours"	: <This must be a time>
			"closeHours"	: <This must be a time>
			"picture"	: <Profile's picture url>
			"about"		: <Max 100 characters>
			"facebook"	: <Max 50 characters>
			"twitter"	: <Max 15 characters>
			"instagram"	: <Max 30 characters>

		}

###<a name='PubFollowers'></a>Pub followers
	* <baseUrl> + /action/pubfollowers.php/<idProfile>/<Token>/<idPub> 
	* Method: GET
	* Response:		
		{    
		    For 1 to "followers"{
		      "idProfile"	: <User's idProfile>
			  "picture"	    : <user's picture url Max 100 characters>
			  "name"		: <Max 20 characters>
			  "surnames"	: <Max 45 characters> // We must fix this and change it to surname
			  "birthdate"	: <birthdate dd/mm/yyyy>
			  "gender"   	: <male> or <female>
			  "music"		: <Max 20 characters>
			  "civil_sate"	: <Max 20 characters>
			  "city"		: <Max 20 characters>
			  "drink"		: <Max 20 characters>
			  "about"		: <Max 200 characters>
			  "mode"        : <>
			  "status"      : <Max 140 characters>
			  "facebook"	: <Max 50 characters>
			  "twitter"	: <Max 15 characters>
			  "instagram"	: <Max 30 characters>
		     }
		
		    "pubfollowers"	: <true if is a pub or false if isn't>
		
				
		}	

	
###<a name='EditEvent'></a>Edit Event
	* <baseUrl> + /update/event.php/<idEvent> <idProfile>
	* Method: GET
	* Response:
		{

			"idEvent   : <Event's profile>
			"title"    : <Max 40 characters>
			"text"     : <Max 40 characters>
			"date"     : <dd/mm/yyyy>
			"startHour": <time>
			"CloseHour": <time>
			"CreatedTime": <timeStamp>
		}

	* <baseUrl> + /update/event.php/<idEvent> <idProfile>
	* Method: POST
	* Data Sent:
		{
			"idProfile"	: <Event's idProfile>
			"idEvent"   : <Event's id>
			"title"		: <Max 40 characters>
			"text"	    : <Max 200 characters>
			"date"		: <dd/mm/yy>
			"startHour"	: <time>
			"closeHour"	: <time>

		}
	* Method: DELETE
		{
			"delete"    : <True>

		}
		
				

###<a name='CreateEvent'></a> Create Event
	* <baseUrl> + /create/event.php 
	* Method: POST
	* Data Sent:
		{
			"title"		: <Max 40 characters>
			"text"	    : <Max 200 characters>
			"date"		: <dd/mm/yy>
			"startHour"	: <time>
			"closeHour"	: <time>
		}
	* Response:
		{
			"New"	: <True or False>
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
	* <baseUrl> + /update/dj.php/<idProfile>/<Token>/<idDj>
	* Method: GET
	* Response:
		{
			"nameDJ"	: <Max 30 characters>
			"name"		: <Max 20 characters>
			"surname"	: <Max 45 characters>
			"telephoneDJ"	: <This must be a number>
			"birthdate"	: <birthdate dd/mm/yyyy>
			"gender"	: <male> or <female>
			"music"		: <Max 20 characters>
			"picture"	: <Profile's picture url>
			"about"		: <Max 100 characters>
			"follow:	: <0 not following this local by idProfile> or <1 following this local by idProfile>
			"followers"	: <total followers of this premise
		}
		
	* <baseUrl> + /update/dj.php/<idProfile>/<Token>
	* Method: POST
	* Data Sent:
		{
			"idProfile"	: <Dj's idProfile>
			"nameDJ"	: <Max 30 characters>
			"name"		: <Max 20 characters>
			"surname"	: <Max 45 characters>
			"telephoneDJ"	: <This must be a number>
			"birthdate"	: <birthdate dd/mm/yyyy>
			"gender"	: <male> or <female>
			"music"		: <Max 20 characters>
			"picture"	: <Profile's picture url>
			"about"		: <Max 100 characters>
		}

###<a name='EventsTodayUser'></a>EventsTodayUser
	* <baseUrl> + /read/eventsTodayUser.php/<idProfile>/<Token>
	* Method: GET
	* Response:
		[	
		    {
		        "localName"	: <Max 20 characters>
		        "picture"	: <Profile's picture url>
				"street"	:
				"streetNameLocal"	: ""
				"streetNumberLocal"	: ""
		        "title"		: ""
		        "text"		: ""
		        "date"		: < Date >
		        "startHour"	: < Time >
		        "closeHour"	: < Time >
		        "createdTime"	: < DateTime >
		        
		    }
		]
###<a name='updatePass'></a>updatePass
	* <baseUrl> + /update/updatePass.php
	* Method: POST
	* Data Sent:
		{
			"idProfile"		: <id Profile>
			"token"	: <user's token>
			"oldPass"	: <user's old password>
			"newPass"	: <user's new password>
		}
	* Response:
		{
			"error"	: 0 -> ok
					  1 -> tokens fail 
					  2 -> user fb or google (can't change)
					  3 -> old pass is incorrect
			
		}


##<a name='Lists'></a>Lists

* [Create Lists](#CreateLists)
* [Update Lists](#UpdateLists)
* [Join List](#JoinList)
* [Pub Lists] (#PubLists)
* [My Lists Partiers](#MyLists)
* [Partiers in List PUB](#PartiersInList)

###<a name='CreateLists'></a> Create
	* <baseUrl> + /create/list.php/<idProfile>/<Token>
	* Method: POST
	* Data Sent:
		{

			"title" : <Max 40 characters>
  			"text" : <Max 140 characters>
  			"date" : <dd/mm/yyyy>
  			"closeDate": <dd/mm/yyyy>
  			"maxGuest": <int>
  			"startHour" : <time>
  			"closeHour" : <time>
		}
	* Response:
	{
		"New": <True or False>

	}
###<a name='UpdateLists'></a> Update
	* <baseUrl> + /update/list.php/<idProfile>/<Token>/<idList>
	* Method: POST
	* Data Sent:
		{
			
			"title" : <Max 40 characters>
  			"text" : <Max 140 characters>
  			"date" : <dd/mm/yyyy>
  			"closeDate": <dd/mm/yyyy>
  			"maxGuest": <int>
  			"startHour" : <time>
  			"closeHour" : <time>
		}
	* Response:
	{
		"updateList": <True or False>

	}

	* Method: GET	
	* Response:
	{
		"title" : <Max 40 characters>
  		"text" : <Max 140 characters>
  		"date" : <dd/mm/yyyy>
  		"startHour" : <time>
		"closeHour" : <time>
		"dateClose": <dd/mm/yyyy>
		"maxGuest": <int>
		"createdTime": <yyyy-mm-dd hh:mm:ss>
		"getList": <True or False>

	}

	* Method: DELETE
	* Response:
		{
			
			"DeleteList" : <true or false>
		}

###<a name='JoinList'></a> Join List
	* <baseUrl> + /actions/joinList.php/<idProfile>/<Token>/<idList>
	* Method: POST
	* Data Sent:
		{
			
			"numGuest" : <int>
  
		}
	* Response:
	{
		"join": <True or False>

	}

	* Method: DELETE
	* Response:
	{
		"deleteofList": <True or False>

	}
###<a name='PubLists'></a> Pub Lists
	* <baseUrl> + /read/lists.php/<idProfile>/<Token>/<idProfilePub>
	* Method: GET
	* Response:
	{
		"name": localname <Max 20 characters>
		"picture": <Max 100 characters>
		"error":<true or false>
		For 0 to i:{
			"idLists":""
			"title":<Max 40 characters>
			"about":<Max 140 characters>
			"dateClose": <yyyy-mm-dd>
			"maxGuest": <int>
			"createdTime":<yyyy-mm-dd hh:mm:ss>
			"date":<yyyy-mm-dd>
			"startHour":<time>
			"closeHour":<time>
			"GOES": <idProfile or null>
		}

	}
###<a name='MyLists'></a> My Lists Partier
	* <baseUrl> + /actions/myLists.php/<idProfile>/<Token>
	* Method: GET
	* Response:
	{
		For 0 to i:{
			"idLists":""
			"idPub":""
			"title":<Max 40 characters>
			"about":<Max 140 characters>
			"date":<yyyy-mm-dd>
			"dateClose": <yyyy-mm-dd>
			"maxGuest": <int>
			"startHour":<time>
			"closeHour":<time>
			"name": localname <Max 20 characters>
			"picture": <Max 100 characters>
			"idProfile": <idProfilePub>
		}
		"rows": <int>
		"myLists":<true or false>

	}

###<a name='PartiersInList'></a> Partiers in List
	* <baseUrl> + /read/partiersInList.php/<idProfile>/<Token>/<idList>
	* Method: GET
	* Response:
	{
		For 0 to i:{
			"idProfile"	: <User's idProfile>
			"picture"	    : <user's picture url Max 100 characters>
			"name"		: <Max 20 characters>
			"surnames"	: <Max 45 characters> // We must fix this and change it to surname
			"birthdate"	: <birthdate dd/mm/yyyy>
			"gender"   	: <male> or <female>
			"music"		: <Max 20 characters>
			"civil_sate"	: <Max 20 characters>
			"city"		: <Max 20 characters>
			"drink"		: <Max 20 characters>
			"about"		: <Max 200 characters>
			"mode"        : <>
			"status"      : <Max 140 characters>
		}
		"rows": <int>
		"getPartiersInList": <true or false>
	}
##<a name='JukeBox'></a>JukeBox

* [Create Track](#CreateTrack)
* [Update Track](#UpdateTrack)
* [Get Pub Playlist](#PlayList)
* [Partier Vote Track](#PartierVoteTrack)
* [My Tracks Voted In Pub](#MyTracksIn)
* [Restart Playlist](#Restart)
* [Play Track](#PlayTrack)

###<a name='CreateTrack'></a> Create Track
	* <baseUrl> + /create/track.php/<idProfile>/<Token>
	* Method: POST
	* Data Sent:
		{

			"name" : <Max 40 characters>
  			"artist" : <Max 40 characters>

		}
	* Response:
	{
		if track exist
		"idTrack":
		"Error": 1
		"NewTrack": <False>

		if new track
		"Error": 0
		"NewTrack": <True>

	}
###<a name='UpdateTrack'></a> Update Track
	* <baseUrl> + /update/track.php/<idProfile>/<Token>/<idTrack>
	* Method: POST
	* Data Sent:
		{
			
			"name" : <Max 40 characters>
  			"artist" : <Max 40 characters>
		}
	* Response:
	{
		"updateTrack": <True or False>

	}

	* Method: GET	
	* Response:
	{
		"idTrack": ""
		"trackName" : <Max 40 characters>
  		"trackArtist" : <Max 40 characters>
		"playing": <0 or 1>
		"createdTime": <yyyy-mm-dd hh:mm:ss>
		"getTrack": <True or False>

	}

	* Method: DELETE
	* Response:
		{
			
			"DeleteTrack" : <true or false>
		}
###<a name='PlayList'></a> Get Pub Playlist
	* <baseUrl> + /read/playList.php/<idProfile>/<Token>/<idProfilePub>
	* Method: GET
	* Response:
	ORDER BY VOTES DESC AND trackArtist ASC
	{
		"name": localname <Max 20 characters>
		"picture": <Max 100 characters>
		"error":<true or false>
		For 0 to i:{
			"idTrack":""
			"trackName":<Max 40 characters>
			"trackArtist":<Max 40 characters>
			"createdTime":<yyyy-mm-dd hh:mm:ss>
			"votes":<>
			"playing":<0 stop 1 playing>
			"VOTE": <idPartier or null>
			
		}

	}

###<a name='PartierVoteTrack'></a> Partier Vote Track
	* <baseUrl> + /actions/voteTrack.php/<idProfile>/<Token>/<idPub>/<idTrack>
	* Method: POST
	* Response:
	{
		"vote": <True or False>
		"error": <True or False>
				"vote=true and error=false": <vote ok>
				"error=true": <NO PARTIER>
				"vote=false and error=true": <some field empty>
	}
	* Method: DELETE
	* Response:
	{
		"deleteVote": <True or False>
		"error": <True or False>
				"deleteVote=true and error=false": <vote ok>
				"error=true": <NO PARTIER>
				"deleteVote=false and error=true": <some field empty>
	}
###<a name='MyTracksIn'></a> My Tracks Voted In Pub
	* <baseUrl> + /actions/myTracksIn.php/<idProfile>/<Token>/<idProfilePub>
	* Method: GET
	* Response:
	{
		For 0 to i:{
			"idTrack":""
		}

	}
###<a name='PlayTrack'></a> Play Track
	* <baseUrl> + /actions/playTrack.php/<idProfile>/<Token>/<idTrack>
	* Method: POST
	* Response:
	{
		for 0 to i {
			"idTrack": ""
		}
		"playTrack": <True or False>
	}
###<a name='Restart'></a> Restart Playlist
	* <baseUrl> + /actions/restartPlaylist.php/<idProfile>/<Token>
	* Method: POST
	* Response:
	{
		"restartPlaylist": <True or False>
	}
##<a name='Statistics'></a>Statistics

* [Get Statistics](#GetStatistics)

###<a name='GetStatistics'></a> Get Statistics
	* <baseUrl> + /actions/statisticsPub.php/<idProfile>/<Token>/<idProfilePub>
	* Method: GET
	* Response:
	{
		
		for "0" to i:{
			For PARTIER only get modeP=0
			For LOCAL I add modeP=1 
			"idProfile"	: <User's idProfile>
			"picture"	    : <user's picture url Max 100 characters>
			"name"		: <Max 20 characters>
			"surnames"	: <Max 45 characters> 
			"birthdate"	: <birthdate yyyy-mm-dd>
			"gender"   	: <male> or <female>
			"music"		: <int>
			"civil_sate"	: <int>
			"city"		: <Max 20 characters>
			"drink"		: <int>
			"about"		: <Max 200 characters>
			"mode"        : <>
			"status"      : <Max 140 characters>
			"modeP": <0 partier who will goes to pub - 1 partier who has gone to pub>
			"num":""
			}
			"rows": <int>
			"mens": <int>
			"womens": <int>
			"a18-20": <int> 18 <= age <= 20
			"a21-23": <int> 21 <= age <= 23
			"a24-30": <int> 24 <= age <= 30
			"am31": <int> 31 <= age
			"i+1":<int> this i continues with initial i, this i varies depending of quantity of users returns the query (quantity in "rows" example: 4 users this i=4 final i=80)
			"i+2": to "i+77": <int>
			(meaning of "i":
			i+1 to i+44: music order by list in googleDrive
			i+45 to i+70: drink order by list in googleDrive
			i+71 to i+77: civil state order by list in googleDrive
			these fields contain the number of partiers who share that field)
			"numGo":<int> partiers who will goes to pub 
				//coment if partier
				"statisticsPartier":true
				//comment id pub
				"bestClients":<int> partiers who have gone to pub
				"statisticsPub":true

	}

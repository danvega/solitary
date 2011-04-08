--------------------------------------------------------------------------------------
ABOUT
--------------------------------------------------------------------------------------

	Project: Solitary Security Module (https://github.com/cfaddict/solitary)
	Author: Daniel Vega (danvega@gmail.com)

 	Building a new application that requires a security in framework can be a very 
 	tedious task. A security framework usually starts off as a simple requirement 
 	and ends up growing into a project all on its own. You first decide to either 
 	copy some code from a previous project or start from scratch. What if there was 
 	a way to drop a folder into your project and have a security framework in place 
 	instantly? Well now there is!
 	
	When modules came out for ColdBox I thought this would be a great first project 
	to work. Solitary is a ColdBox module that handles roles based security for 
	your application. When you drop the module into your project it will instantly 
	lock down your entire application and create the necessary tables in your 
	database. Under the hood it uses the ColdBox interceptor so its fully customizable.
   
-------------------------------------------------------------------------------------- 	
SYSTEM REQUIREMENTS
--------------------------------------------------------------------------------------

	Coldbox 3.0
	ColdFusion 9.0.1

--------------------------------------------------------------------------------------
INSTALL INSTRUCTIONS
--------------------------------------------------------------------------------------

1.) Drop the solitary folder into your modules folder {project_root}/modules/

2.) Add a mapping to {project_root}/Application.cfc
	
	this.mappings['/solitary'] = COLDBOX_APP_ROOT_PATH & "/modules/solitary";

3.) Update {project_root}/Application.cfc to enable ORM
	
	this.ormEnabled = true;
	this.datasource = "YOUR_DATASOURCE_HERE";
	this.ormSettings = {
		dbcreate = "update",
		eventhandling = true,
		flushAtRequestEnd = false,
		cfclocation = []
	};

--------------------------------------------------------------------------------------
USAGE
--------------------------------------------------------------------------------------
	
	Once you have the module installed just navigate to your application and reload
	ORM (?ormReload). Once that is done you can reiniatilize the application so the 
	module is found.Basically you have to reload your ORM application to add the 
	database tables needed and you need to re initialize the ColdBox application 
	to load the module. Of course this is not needed if this is the first time
	you are launching the application. 
	
	You should now be presented with a login screen. I think this is the great thing 
	about this module. All of the views / business logic has already been built for 
	you! Please view the video tutorial below to learn more about how the module works.

	When you have loaded the module please visit /docs to view the documentation.

--------------------------------------------------------------------------------------
VIDEO TUTORIALS
--------------------------------------------------------------------------------------

	Part 1: Introduction & Installation - http://vimeo.com/22110435
		
	Part 2: Features - http://vimeo.com/22111233
	
--------------------------------------------------------------------------------------
RULES
--------------------------------------------------------------------------------------
	
	This module takes advantage of the ColdBox security interceptor. There is a 
	default rules config file as it is listed below but if you would like to read 
	more about the security interceptor please visit
	http://wiki.coldbox.org/wiki/Interceptors:Security.cfm.
	
	<?xml version="1.0" encoding="UTF-8"?>
	<!--
	Declare as many rule elements as you want, order is important 
	Remember that the securelist can contain a list of regular
	expression if you want
	
	ex: All events in the user handler
	 user\..*
	ex: All events
	 .*
	ex: All events that start with admin
	 ^admin
	
	If you are not using regular expression, just write the text
	that can be found in an event.
	-->
	<rules>
	    <rule>
	        <whitelist>solitary:security\..*,docs\..*</whitelist>
	        <securelist>\..*</securelist>
	        <roles>admin,author</roles>
	        <permissions></permissions>
	        <redirect>security/login</redirect>
			<useSSL>false</useSSL>
	    </rule>
	</rules>	
	

--------------------------------------------------------------------------------------
NOTES
--------------------------------------------------------------------------------------

	* Session Management needs to be enabled in {project_root}/Application.cfc
		
		this.sessionManagement = true;
		this.sessionTimeout = createTimeSpan(0,0,30,0);

	* Make sure autoReload = false or the security rules will reload on every request
	
	modules = {
		//Turn to false in production
		autoReload = false,
		// An array of modules names to load, empty means all of them
		include = [],
		// An array of modules names to NOT load, empty means none
		exclude = [] 
	};
	
	* Update your robots.txt so this module doesn't get picked up by the search engine
 		
 	  Disallow: /modules/solitary

--------------------------------------------------------------------------------------
SUPPORT
--------------------------------------------------------------------------------------

Please visit the source code repository at https://github.com/cfaddict/solitary. From there you can contact me as well as file bugs. 	  
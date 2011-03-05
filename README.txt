--------------------------------------------------------------------------------------
ABOUT
--------------------------------------------------------------------------------------

    Who: Daniel Vega (danvega@gmail.com)
   What: Solitary
  Where: http://www.danvega.org/blog	
   When: 2/26/2011

-------------------------------------------------------------------------------------- 	
SYSTEM REQUIREMENTS
--------------------------------------------------------------------------------------

	Coldbox 3.0 RC2
	ColdFusion 9.0.1

--------------------------------------------------------------------------------------
INSTALL INSTRUCTIONS
--------------------------------------------------------------------------------------

1.) drop the solitary folder into your modules folder {project_root}/modules/

2.) add a mapping to {project_root}/Application.cfc
	
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

	* limitation for version 0.1 is that you can only assign a single role to a user 
	* I will fix this shortly
	
	
	* Update your robots.txt so this module doesn't get picked up by the search engine
 		
 	  Disallow: /modules/solitary
	
--------------------------------------------------------------------------------------
FUTURE DEVELOPMENT IDEAS
--------------------------------------------------------------------------------------		
 
 il8n for all display messages
 GA Plugin
 Audit Trail
 Permissions
 Import data / Data Migration
 different email templates html/txt/pdf/image
 other ways to send notifications email/sms/twitter
 
 view current session?
 view all sessions?
 configuration for password requirements? 
 configuration for username requirements?
 
--------------------------------------------------------------------------------------
BUGS
--------------------------------------------------------------------------------------		

	if user.getLastName() is null (or any prop for that matter) we have an error in mail service. 	
 
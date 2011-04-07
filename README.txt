--------------------------------------------------------------------------------------
ABOUT
--------------------------------------------------------------------------------------

    Who: Daniel Vega (danvega@gmail.com)
  Where: http://www.danvega.org/blog	
   When: 2/26/2011
   What: A ColdBox module that handles roles based security for your application. 
   	     By default this will lock down your entire application and allow you
   	     to create users/roles. It is fully customizeable so that you can secure
   	     only certain routes/controllers/actions. 
   
-------------------------------------------------------------------------------------- 	
SYSTEM REQUIREMENTS
--------------------------------------------------------------------------------------

	Coldbox 3.0
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
USAGE
--------------------------------------------------------------------------------------

	
	

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
 	  
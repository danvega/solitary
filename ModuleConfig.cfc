/**
Module Directives as public properties
this.title 				= "Title of the module";
this.author 			= "Author of the module";
this.webURL 			= "Web URL for docs purposes";
this.description 		= "Module description";
this.version 			= "Module Version"

Optional Properties
this.viewParentLookup   = (true) [boolean] (Optional) // If true, checks for views in the parent first, then it the module.If false, then modules first, then parent.
this.layoutParentLookup = (true) [boolean] (Optional) // If true, checks for layouts in the parent first, then it the module.If false, then modules first, then parent.
this.entryPoint  		= "" (Optional) // If set, this is the default event (ex:forgebox:manager.index) or default route (/forgebox) the framework
									       will use to create an entry link to the module. Similar to a default event.

structures to create for configuration
- parentSettings : struct (will append and override parent)
- settings : struct
- datasources : struct (will append and override parent)
- webservices : struct (will append and override parent)
- interceptorSettings : struct of the following keys ATM
	- customInterceptionPoints : string list of custom interception points
- interceptors : array
- layoutSettings : struct (will allow to define a defaultLayout for the module)
- routes : array Allowed keys are same as the addRoute() method of the SES interceptor.
- wirebox : The wirebox DSL to load and use

Available objects in variable scope
- controller
- appMapping (application mapping)
- moduleMapping (include,cf path)
- modulePath (absolute path)
- log (A pre-configured logBox logger object for this object)
- binder (The wirebox configuration binder)

Required Methods
- configure() : The method ColdBox calls to configure the module.

Optional Methods
- onLoad() 		: If found, it is fired once the module is fully loaded
- onUnload() 	: If found, it is fired once the module is unloaded

*/
component {
	
	property name="installService" inject="model:installService@Solitary";

	// Module Properties
	this.title 				= "Solitary";
	this.author 			= "Daniel Vega";
	this.webURL 			= "http://www.danvega.org";
	this.description 		= "A Security Module";
	this.version			= "0.1";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "security";
	
	function configure(){
		
		// parent settings
		parentSettings = {
		
		};
	
		// module settings - stored in modules.name.settings
		settings = {
			// emails are sent from
			sendEmailFrom = "danvega@gmail.com"
		};
		
		// Layout Settings
		layoutSettings = {
			defaultLayout = "layout.security.cfm"
		};
		
		// datasources
		datasources = {
		
		};
		
		// web services
		webservices = {
		
		};
		
		// SES Routes
		routes = [
			{pattern="/", handler="security",action="index"},	
			{pattern="/login", handler="security",action="login"},		
			{pattern="/doLogin", handler="security",action="doLogin"},		
			{pattern="/logout", handler="security",action="logout"},
			{pattern="/forgotPassword", handler="security",action="forgotPassword"},
			{pattern="/resetPassword/:eph", handler="security",action="resetPassword"},
			{pattern="/changePassword", handler="security",action="changePassword"},
			{pattern="/doChangePassword", handler="security",action="doChangePassword"},
			{pattern="/users/list", handler="users",action="list"},
			{pattern="/users/edit/:id?", handler="users",action="edit"},
			{pattern="/users/save", handler="users",action="save"},
			{pattern="/users/remove", handler="users",action="remove"},
			{pattern="/roles/list", handler="roles",action="list"},
			{pattern="/roles/edit/:id?", handler="roles",action="edit"},
			{pattern="/roles/save", handler="roles",action="save"},
			{pattern="/roles/remove", handler="roles",action="remove"}		
		];
		
		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};
		
		// Custom Declared Interceptors
		interceptors = [
			 //security 
			 {class="coldbox.system.interceptors.security",
			 	properties={
			 		rulesSource="xml",
			 		rulesFile="#modulePath#/config/securityRules.xml.cfm",
			 		preEventSecurity="true",
			 		validatorModel="securityService@Solitary"
			 	}
			 }	
		];

		// wirebox mappings
		binder.map("SecurityService@Solitary")
			.to("#moduleMapping#.model.security.SecurityService")
			.asSingleton();
			
		binder.map("UserService@Solitary")
			.to("#moduleMapping#.model.users.UserService")
			.asSingleton();	
		
		binder.map("RoleService@Solitary")
			.to("#moduleMapping#.model.roles.RoleService")
			.asSingleton();
			
		binder.map("InstallService@Solitary")
			.to("#moduleMapping#.model.install.Install")
			.asSingleton();
			
	}
	
	/**
	 * Fired when the module is registered and activated.
	 */
	public void function onLoad(){
		var setupPath = getDirectoryFromPath(getCurrentTemplatePath()) & "config\setup.xml";
		
		// if a file named setup.xml exists in the config folder lets install some default data	
		if( fileExists(setupPath) ){
			installService.setConfigPath(setupPath);
			installService.setup();
		}
	}
	
	/**
	 * Fired when the module is unregistered and unloaded
	 */
	public void function onUnload(){
		
	}
	
}
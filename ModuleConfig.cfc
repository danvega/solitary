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
			sendEmailFrom = "admin@localhost"
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
			{pattern="/docs", handler="docs",action="index"},	
			{pattern="/login", handler="security",action="login"},		
			{pattern="/doLogin", handler="security",action="doLogin"},		
			{pattern="/logout", handler="security",action="logout"},
			{pattern="/forgotPassword", handler="security",action="forgotPassword"},
			{pattern="/resetPassword/:eph", handler="security",action="resetPassword"},
			{pattern="/changePassword", handler="security",action="changePassword"},
			{pattern="/doChangePassword", handler="security",action="doChangePassword"},
			{pattern="/accessDenied", handler="security",action="accessDenied"},
			{pattern="/users/list", handler="users",action="list"},
			{pattern="/users/list/role/:id", handler="users",action="list"},
			{pattern="/users/edit/:id?", handler="users",action="edit"},
			{pattern="/users/save", handler="users",action="save"},
			{pattern="/users/remove/:id", handler="users",action="remove"},
			{pattern="/users/usernameExists/:username", handler="users",action="usernameExists"},
			{pattern="/roles/list", handler="roles",action="list"},
			{pattern="/roles/edit/:id?", handler="roles",action="edit"},
			{pattern="/roles/save", handler="roles",action="save"},
			{pattern="/roles/remove/:id", handler="roles",action="remove"},
			{pattern="/sessiontracking/current", handler="sessiontracking",action="current"},		
			{pattern="/sessiontracking/active", handler="sessiontracking",action="active"}				
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
		var installService = binder.getInjector().getInstance("InstallService@Solitary");
		
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
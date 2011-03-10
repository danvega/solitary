/**
 * I handle installation of default data for Solitary
 */
component accessors="true" {

	property name="userService" inject="model:userService@Solitary";
	property name="roleService" inject="model:roleService@Solitary";
	property name="log" inject="logbox:root";
	property name="configPath" type="string";
	property name="configXML" type="string";
	
	public Install function init(){
		return this;
	}
	
	public void function setup(){
		var f = fileRead(getConfigPath());
				
		try {
			setConfigXML( xmlParse(f) );
		} catch(any e){
			log.error("There was an error parsing the solitary xml config file.");
		}
		
		// we only want to add this data if there are no records
		// this is only to add some dummy data to the database		
		if( userService.count() == 0 && roleService.count() == 0 ){
			setupRoles();
			setupUsers();			
		}		

	}
	
	private void function setupRoles(){
		var roles = xmlSearch(getConfigXML(),"/solitary/roles/role");
		
		for(var role in roles){
			var r = roleService.new();
			r.setname(role.xmlText);
			userService.save(r);
		}
		
		log.info("The default role(s) were created successfully.");
	}
	
	private void function setupUsers(){
		var users = xmlSearch(getConfigXML(),"/solitary/users/user");
		
		for(var user in users){
			var u = userService.new();
			u.setFirstName(user.xmlChildren[1].xmlText);
			u.setLastName(user.xmlChildren[2].xmlText);
			u.setEmail(user.xmlChildren[3].xmlText);
			u.setUsername(user.xmlChildren[4].xmlText);
			u.setPassword(user.xmlChildren[5].xmlText);
			
			// loop list of roles
			for(var x=1; x<=listLen(user.xmlChildren[6].xmlText); ++x){
				// try and find the role by name
				var r = roleService.findWhere({name=listGetAt(user.xmlChildren[6].xmlText,x)});
				u.addRole(r);
			}
			
			userService.save(u);
		}
		
		log.info("The default user(s) were created successfully.");	
	}

}
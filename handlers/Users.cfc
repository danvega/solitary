component accessors="true" {

	property name="userService"	inject="model:userService@solitary";
	property name="roleService"	inject="model:roleService@solitary";
	property name="sessionStorage"	inject="coldbox:plugin:SessionStorage";

	function preHandler(event,action){
		
	}
	
	public void function index(){
		setNextEvent("security/users/list");
	}
	
	public void function list(event){
		var rc = event.getCollection();
		rc.currentUser = sessionStorage.getVar('user');
		
		//filters 
		if( structKeyExists(rc,"role") ){
			rc.users = userService.findAll("select u from User u join u.roles r where r.id = :role",{role=rc.role});			
		} else {
			rc.users = userService.list(sortOrder="lastName desc",asQuery=false);
		}
		
	}

	public void function edit(event){
		var rc = event.getCollection();
		event.paramValue("id","");
		rc.user  = event.getValue("user",userService.get( rc.id ));
		rc.roles = roleService.list(sortOrder="name",asQuery=false);
	}	

	public void function save(event){
		var rc = event.getCollection();		
		var roles = [];
		rc.user = populateModel( userService.get(id=rc.userID) );
		
		event.paramValue("roles","");
		
		if(len(rc.roles)){
			// oUser.addRoles() takes an array of roles to add to the user
			// userService.addRoles returns an array of roles
			roles = userService.addRoles(rc.roles);
		}
				
		// if they have added a new role		
		if(len(rc.addrole)){
			//arrayAppend(roles,userService.addNewRole(rc.addrole));
			userService.addNewRole(rc.addrole);
		}
		
		rc.user.addRoles(roles);
		
		userService.save( rc.user );
		getPlugin("MessageBox").setMessage("info","User saved!");
		setNextEvent('security.users.list');
	}
	
	public void function remove(event){
		var rc 		= event.getCollection();		
		var oUser 	= userService.get(rc.id);
		    	
		if( isNull(oUser) ){
			getPlugin("MessageBox").setMessage("warning","Invalid user detected!");
			setNextEvent('security.users.list');
		}
		
		userService.delete( oUser );
		getPlugin("MessageBox").setMessage("info","User Removed!");
		setNextEvent('security.users.list');
	}
	
	public void function usernameExists(event) {
		var rc = event.getCollection();
		var user = userService.executeQuery("from User where email = :arg OR username = :arg",{arg=rc.username},0,0,0,false);
		var result = {};
		
		if( arrayLen(user) ){
			result['exists'] = true;
			result['msg'] = "username is unavailable";
		} else {
			result['exists'] = false;
			result['msg'] = "username is available";
		}
		
		event.renderData(type="JSON",data=result,nolayout=true);
	}

}
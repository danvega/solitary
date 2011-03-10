component accessors="true" {

	property name="userService"	inject="model:userService@solitary";
	property name="roleService"	inject="model:roleService@solitary";
	property name="sessionStorage"	inject="coldbox:plugin:SessionStorage";

	function preHandler(event,action){
		
	}
	
	public void function index(){
		setNextEvent('users.list');
	}
	
	public void function list(event){
		var rc = event.getCollection();
		rc.currentUser = sessionStorage.getVar('user');
		rc.users = userService.list(sortOrder="lastName desc",asQuery=false);
	}

	public void function edit(event){
		var rc = event.getCollection();
		event.paramValue("id","");
		rc.user  = userService.get( rc.id );
		rc.roles = roleService.list(sortOrder="name",asQuery=false);
	}	

	public void function save(event){
		var rc = event.getCollection();		
		var oUser = populateModel( userService.get(id=rc.userID) );
				
		if(len(rc.addrole)){
			var role = roleService.new(properties={name=rc.addrole});			
			roleService.save(entity=role,flush=true);
			rc.roles = listAppend(rc.roles,role.getRoleId());
		}
		
		// add a list of roles to the user (list of ids)
		oUser.addRoles(rc.roles);
		
		userService.save( oUser );
		getPlugin("MessageBox").setMessage("info","User saved!");
		setNextEvent('security.users.list');
	}
	
	public void function remove(event){
		var rc 		= event.getCollection();
		var oUser 	= userService.get(rc.userID);
		    	
		if( isNull(oUser) ){
			getPlugin("MessageBox").setMessage("warning","Invalid user detected!");
			setNextEvent('security.users.list');
		}
		
		userService.delete( oUser );
		getPlugin("MessageBox").setMessage("info","User Removed!");
		setNextEvent('security.users.list');
	}


}
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
		
		//clear roles
		oUser.setRoles([]);
		// for each role in list admin,author,audit,etc
		for(var i=1; i<=listLen(rc.roles); ++i){
			var role = roleService.get(listGetAt(rc.roles,i));
			oUser.addRole(role);
			role.addUser(oUser);
		}
		
		if(len(rc.addrole)){
			var role = roleService.new();
			role.setName(rc.addrole);
			role.addUser(oUser);
			roleService.save(role);
			
			oUser.addRole(role);
		}
		
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
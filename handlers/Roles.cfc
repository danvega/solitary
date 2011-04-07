component{

	property name="roleService" inject="model:roleService@Solitary";

	public void function index(event){
		setNextEvent("security/roles/list");
	}		public void function list(event){
		var rc = event.getCollection();
		rc.roles = roleService.list(orderby="name",asQuery=false);
	}	public void function edit(event){
		var rc = event.getCollection();
		rc.role = roleService.get( event.getValue("id","") );
		
		if( isNull(rc.role) ){
			roleNotFound();
		}
	}		public void function save(event){
		var rc = event.getCollection();
		var role = roleService.get( event.getValue("roleid","") );
		
		if( !isNull(role) ){
			role.setName(rc.name);
			roleService.save(role);
			getPlugin("messagebox").setMessage("info","The role #rc.name# was created successfully.");
			setNextEvent("security.roles.list");
		} else {
			roleNotFound();			
		}
	}		public void function remove(event){
		var rc = event.getCollection();		
		var role = roleService.get( rc.id );
				
		if( !isNull(role)){
			// we have a valid role, is it deleteable
			if( role.canBeDeleted() ){
				getPlugin("messagebox").setMessage("info","The role #role.getName()# was deleted successfully.");
				// delete the role
				roleService.delete(role);
				setNextEvent("security/roles/list");
				
			} else {
				// let the user know that this role can't be deleted because
				// there are users associated with this role
				getPlugin("messagebox").setMessage("error","We are unable to remove this role because it is assigned to one or more users.");
				setNextEvent("security.roles.list");
			}			
		} else {			
			getPlugin("messagebox").setMessage("error","We are unable to locate the role you are trying to remove, please try again.");
			setNextEvent("security.roles.list");
		}
		
	}		private void function roleNotFound(){
		getPlugin("messagebox").setMessage("error","We were unable to locate the role you are trying to edit.");
		setNextEvent("security.roles.list");			
	}
		
}

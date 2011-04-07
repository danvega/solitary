component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {
	
	property name="roleService"	inject="model:roleService@solitary";
	
	public UserService function init(){
		super.init(entityName="User");
		return this;
	}
	
	public void function addNewRole(required string name){		
		var role = roleService.new();
		role.setName(arguments.name);
		//roleService.save(role);
		entitySave(role);
		
	}
	
	public any function addRoles(required string roles){
		var _roles = [];
		
		if( len(arguments.roles) ){
			// for each role in list admin,author,audit,etc
			for(var i=1; i<=listLen(arguments.roles); ++i){
				var role = entityLoadByPK("Role",listGetAt(arguments.roles,i));
				arrayAppend(_roles,role);
			}
		}
		
		return _roles;		
	}
	
	public String function resetPassword(any user){
		var newPassword = randomPassword();
		user.setPassword(newPassword);
		user.setPasswordHasReset(true);
		save(user);
		return newPassword;
	}
	
	public void function changePassword(id,string pass){
		var u = get(id);
		u.setPassword(arguments.pass);
		save(u);
	}

	private String function randomPassword(){
		var valid_password = 0;
		var loopindex = 0;
		var this_char = "";
		var seed = "";
		var new_password = "";
		var new_password_seed = "";
		
		while (valid_password == 0){
			new_password = "";
			new_password_seed = CreateUUID();
			
			for(loopindex=20; loopindex LT 35; loopindex = loopindex + 2){
				this_char = inputbasen(mid(new_password_seed, loopindex,2),16);
				seed = int(inputbasen(mid(new_password_seed,loopindex/2-9,1),16) mod 3)+1;
		
				switch(seed){
					case "1": {
						new_password = new_password & chr(int((this_char mod 9) + 48));
						break;
					}
					case "2": {
						new_password = new_password & chr(int((this_char mod 26) + 65));
						break;
					}
					case "3": {
						new_password = new_password & chr(int((this_char mod 26) + 97));
						break;
					}
				}
			}
		
			valid_password = iif(refind("(O|o|0|i|l|1|I|5|S)",new_password) gt 0,0,1);    
		}
		
		return new_password;
	}

}
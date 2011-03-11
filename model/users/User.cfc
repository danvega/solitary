component persistent="true" extends="solitary.model.BaseEntity" table="users"{
	
	property name="userid" column="user_id" fieldtype="id" generator="uuid" setter="false";
	
	/** 
	 * @notempty 
	 */
	property name="firstName";
	
	/** 
	 * @notempty 
	 */
	property name="lastName";
	
	/** 
	 * @notempty 
	 * @range 5,20
	 * @custom solitary.model.validation.rules.isUniqueUsername
	 * @custom-message That username already exists
	 */
	property name="userName";
	
	/**
	 * @display Password
	 * @ismatch {confirmPassword}
	 */
	property name="password";	
	
	/**
	 * @display Confirm Password
	 * @persistent false
	 */
	property name="confirmPassword";
	
	/** 
	 * @notempty
	 * @email
	 * @custom solitary.model.validation.rules.isUniqueEmail
	 * @custom-message That email address already exists in our system	 
	 */
	property name="email";
	
	property name="lastLogin" ormtype="timestamp";
	property name="usernamePasswordHash" column="uph" type="string";
	property name="emailPasswordHash" column="eph" type="string";
	property name="passwordHasReset" type="boolean";  
	property name="roles" fieldtype="many-to-many" cfc="solitary.model.roles.Role" singularname="role" fkcolumn="user_id" inversejoincolumn="role_id" linktable="users_roles";   
	
	public User function init(){
		roles = [];
		passwordHasReset = false;
		return this;
	}
	
	public string function getRolesList(){
		var roles = "";
		for( var i=1; i<=arrayLen(getRoles()); ++i ){
			roles = listAppend(roles,getRoles()[i].getName());
		}
		return roles;
	}
	
	public void function addRoles(required array roles){
		if( arrayLen(arguments.roles) ){
			//clear roles
			setRoles([]);
			// for each role in list admin,author,audit,etc
			for(var i=1; i<=arrayLen(arguments.roles); ++i){
				this.addRole(arguments.roles[i]);
			}
		}
	}	
	
	public void function setPassword(String password){
		variables.password = hash(arguments.password);	
	}
	
	public void function setConfirmPassword(String password){
		variables.confirmPassword = hash(arguments.password);
	}

	public string function getName(){
		return getFirstName() & " " & getLastName();
	}
	
	public string function getDisplayLastLogin(){
		var lastLogin = getLastLogin();
		
		if(  NOT isNull(lastLogin) ){
			return dateFormat(lastLogin,'long') & " " & timeFormat(lastLogin,'hh:mm:ss tt');
		}
		
		return "Never";
	}
	
	// EVENT HANDLERS
   	public void function preInsert(){
		super.preInsert();
		// REMEMBER: the password is hashed in setPassword so you don't need to do it here
		setUsernamePasswordHash(hash(getUsername()) & getPassword() );
		setEmailPasswordHash(hash(getEmail()) & getPassword() );
	} 
	
	public void function preUpdate(oldData){
		super.preUpdate();
		// what is the new hash of email+password
		// REMEMBER: the password is hashed in setPassword so you don't need to do it here
		var eph = hash(getEmail()) & getPassword();
		
		// if they are not the same then something has changed, update the hashes		
		if( getEmailPasswordHash() != eph ){
			setUsernamePasswordHash(hash(getUsername()) & getPassword() );
			setEmailPasswordHash(eph);
		}
	}
	
}
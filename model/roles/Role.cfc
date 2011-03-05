component persistent="true" extends="solitary.model.BaseEntity" table="roles" {
	
	property name="roleid" column="role_id" fieldtype="id" generator="uuid" setter="false";
	
	/**
	 * @NotEmpty
	 */
	property name="name";
	
	property name="users" fieldtype="many-to-many" cfc="solitary.model.users.User" singularname="User"  linktable="users_roles" fkcolumn="role_id" inversejoincolumn="user_id" inverse="true";   
	
	public Role function init(){
		users = [];
		return this;
	}
	
	public boolean function canBeDeleted(){
		return arrayLen(getUsers()) == 0;
	}
	
}
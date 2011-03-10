component persistent="true" extends="solitary.model.BaseEntity" table="roles" {
	
	property name="roleid" column="role_id" fieldtype="id" generator="uuid" setter="false";
	property name="name";
		
	public Role function init(){
		users = [];
		return this;
	}
	
	public boolean function canBeDeleted(){
		return arrayLen(getUsers()) == 0;
	}
	
}
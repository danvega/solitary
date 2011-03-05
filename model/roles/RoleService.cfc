component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {
	
	public RoleService function init(){
		super.init(entityName="Role");
		return this;
	}

}
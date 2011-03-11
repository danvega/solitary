component accessors="true" implements="solitary.model.hyrule.rules.IValidator" {

	public boolean function isValid(Struct prop){				
		var valid = true;
		var user = entityLoad("User",{email=arguments.prop.value});

		if( arrayLen(user) ){
			valid = false;
		}

		return valid;
	}

}
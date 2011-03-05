component mappedsuperclass="true" {

	property name="dateCreated" ormtype="timestamp";
	property name="lastUpdated" ormtype="timestamp";
	property name="errors" persistent="false" setter="false";
	property name="errorProperties" persistent="false" setter="false";
	
	public any function init(){
		variables.errors = [];
		variables.errorProperties= [];
		return this;
	}

	// EVENT HANDLERS
	public void function preInsert(){
		setDateCreated(now());
		setLastUpdated(now());
	}
	
	public void function preUpdate(){
		setLastUpdated(now());
	}
	
	public struct function toStruct(string exclude=""){
		var data = {};
		var props = getMetaData(this).properties;
		
		for(var x=1; x <= arrayLen(props); x++){
			// if we want to exclude properties from automatically getting set
			// we can pass an exclude list user.toStruct('roles');
			if( listFindNoCase(arguments.exclude,props[x].name) == 0 ){
				var method = this["get" & props[x].name];				
				data["#props[x].name#"] = method();
			}
		}
		
		return data;
	}


	// Hyrule --------------------------------------------------------------------

	/** Erase all errors from the Object */
	public void function clearErrors() {
		variables.errors = [];
		variables.errorProperties= [];
		return;
	}

	/** Set multiple errors into the Object
		@Errors shared.model.object.Error[] */
	public void function setErrors(required array Errors) {
		var i = 0;
		var n = arrayLen(arguments.Errors);
		for (i=1; i<=n; i++)
			addError(arguments.errors[i]);

		return;
	}

	/** Add an error object. Also saves the property to a errorProperties array for quick searching.
		@Error shared.model.object.Error */
	public void function addError(required Error) {
		if (structKeyExists(variables, 'errors')) {
			arrayAppend(errors, arguments.error);
			arrayAppend(errorProperties, arguments.error.getProperty() );
		} else {
			variables.errors = [ arguments.error ];
			variables.errorProperties = [ arguments.error.getProperty() ];
		}

		return;
	}

	/** Returns true if any error exist. */
	public boolean function hasErrors () {
		if (structKeyExists(variables, 'errors'))
			return !arrayIsEmpty(errors);
		return false;
	}

	/** Returns true if the property is in error
		@property The name of the property to check for errors. */
	public boolean function errorExists(required string property) {
		if (!hasErrors())
			return false;
		return arrayContains(variables.errorProperties, property);
	}

}
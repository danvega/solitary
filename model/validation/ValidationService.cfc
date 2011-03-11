component accessors="true" singleton="true" {

	property name="Validator"  inject="model:validator@Solitary";
	
	public ValidationService function init(){
		return this;
	}
	
	/** Validate an Object. Errors will be set into the Object
		@Object The object to be validated.
		@Include A list. If provided, only properties listed that are in error will be parsed.
		@Exclude A list. If provided, all properties except these will be parsed for errors. Ignored if "include" is provided. */
	public boolean function validate(required any Object, string include, string exclude) {
		Object.clearErrors();

		var errors = getValidator().validate(Object);

		// Return TRUE if we have no Errors from Hyrule.
		if (!errors.hasErrors())
			return true;

		// Filter errors if desired
		if (structKeyExists(arguments, 'include'))
			var results = filterErrors(errors=errors,include=arguments.include);
		else if (structKeyExists(arguments, 'exclude'))
			var results = filterErrors(errors=errors,excelude=arguments.exclude);

		// Set the errors in the object and return false
		Object.setErrors( errors.getErrors() );
		return false;
	}

	/** Removes any errors not found within the list. Useful for partial object validation.
		@include A list of properties to retain if they exist within the error list. */
	private array function filterErrors(required array errors, string include, string exclude) {

		// THIS METHOD NOT TESTED BEFORE PUBLICATION.
		// Posted in response to discussion in the ColdBox forum.

		var i 				= 0;
		var n 				= arrayLen(errors);
		var retainedErrors 	= [];
		var exclusion 		= structKeyExists(arguments, 'exclude');
		var props			= (exclusion) ? arrayToList(arguments.exclude) : arrayToList(arguments.include);

		if (!exclusion) {
			// Include any errors found within the list.
			for (i=1; i<=n; i++)
				if ( arrayContains(props, errors[i].getProperty()) )
					arrayAppend(retainedErrors, errors[i]);
		} else {
			// Copy all errors
			retainedErrors = errors;
			// Exclude any found errors from the list.
			for (i=1; i<=n; i++)
				if ( arrayContains(props, errors[i].getProperty()) )
					arrayDeleteAt(retainedErrors, i);
		}

		return retainedErrors;
	}

}
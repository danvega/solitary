import solitary.model.users.User;

component accessors="true" singleton="true" {
	
	property name="userService" inject="model:userService@solitary";
	property name="sessionStorage" inject="coldbox:plugin:SessionStorage";
	property name="mailService" inject="coldbox:plugin:MailService";
	property name="renderer" inject="coldbox:plugin:Renderer";
	property name="configBean" inject="coldbox:configBean";
	
	public SecurityService function init(){		
		return this;
	}
	
	public void function updateUserLoginTimestamp(){
		var user = getUserSession();
		user.setLastLogin( now() );
		userService.save( user );
		
		//update the session with the new lastLogin
		setUserSession(user);
	}
	
	public boolean function userValidator(struct rule,any messagebox, any controller){
		var isAllowed = false;
		var user = getUserSession();
		var cPermission = "";
		
		if( !isNull(user) ){			
			// verify user has role
			for(var x=1; x<=listLen(arguments.rule['roles']); ++x){
				if( listFindNoCase(user.getRolesList(),listGetAt(arguments.rule['roles'],x)) ){
					return true;
				}
			}
		}
		
		return isAllowed;
	}
	
	public any function getUserSession(){
		var user = sessionStorage.getVar('user',{});
		if( !structIsEmpty(user) ){
			return userService.get( user.userid );
		}
		return userService.new();
	}	
	
	public void function setUserSession(any user){
		sessionStorage.setVar("user",arguments.user.toStruct(exclude="roles"));
	} 

	public void function deleteUserSession(){
		if( !structIsEmpty(sessionStorage.getVar('user',{})) ){
			sessionStorage.deleteVar("user");
		}		
	}

	public boolean function isUserVerified(required string username, required string password){
		var userPassHash = hash(arguments.username) & hash(arguments.password);
		// allow the user to login with username+password or email+password
		var user = userService.findIt("from User u where u.emailPasswordHash = :uph OR u.usernamePasswordHash = :uph",{uph=userPassHash});
				
		//check if found and return verification
		if( not isNull(user) ){
			setUserSession( user );
			return true;
		}
		
		return false;	
	}
	
	public void function sendForgotPasswordNotification(required User user){
		var settings = configBean.getKey("modules").solitary.settings;
		var baseURL = len(configBean.getKey('sesBaseURL')) ? configBean.getKey('sesBaseURL') : configBean.getKey('htmlBaseURL');
		rc.emailView = 'notification/forgotPasswordNotification';
		
		// Create a new mail object
		local.email = MailService.newMail().config(
			from=settings.sendEmailFrom,
			to=arguments.user.getEmail(),
			subject="Forgot Password Notification"
		);	
				
		/** 
		 * Set tokens within the mail object. The tokens will be evaluated
		 * by the ColdBox Mail Service. Any matching @key@ within the view
		 * will be replaced with the token's value
		 */
		local.email.setBodyTokens({
			firstName = arguments.user.getFirstName(),
			lastName = arguments.user.getLastName(),
			url = baseURL & "security/resetPassword/" & user.getEmailPasswordHash()
		});
		
		// Add HTML email
		local.email.addMailPart(charset='utf-8',type='text/html',body=renderer.renderView(view=rc.emailView,module="solitary"));
		
		// Send the email. MailResult is a boolean.
		local.mailResult = mailService.send(local.Email);

	}

}	

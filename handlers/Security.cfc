component accessors="true" {
	
	property name="securityService" inject="model:securityService@Solitary";
	property name="userService" inject="model:userService@Solitary";
	property name="cookieStorage" inject="coldbox:plugin:CookieStorage";
	property name="defaultEvent" inject="coldbox:setting:defaultEvent";
		
	public void function index(event){
		setNextEvent("security/login");
	}		public void function login(event){
		var rc = event.getCollection();
		// if the user checks remember me we drop a cookie with their username
		// if the cookie does not exist the cookieStorage returns an empty string
		rc.username = cookieStorage.getVar('username');
		
		event.setView(name="security/login",layout="layout.login");
	}

	public void function doLogin(event){
		var rc = event.getCollection();
		
		event.paramValue("username","");
		event.paramValue("password","");
		event.paramValue("rememberme",false);
		
		if( securityService.isUserVerified(rc.username,rc.password) ){
			securityService.updateUserLoginTimestamp();
			// if the user selected remember set a cookie
			if( rc.rememberme ){
				cookieStorage.setVar("username",rc.username,999);
			}			
			setNextEvent( variables.defaultEvent );
		}
		else{
			getPlugin("MessageBox").setMessage("error","Login Failed: Please try again.");
			setNextEvent("security.login");
		}
		
	}		
	/**
	 * a user is 'logged in' if a valid seesion exists for them
	 * to log them out simply remove the session user map
	 */	public void function logout(event){
		securityService.deleteUserSession();
		setNextEvent("security.login");
	}
	
	/**
	 * forgot password
	 */		public void function forgotPassword(){
		var rc = event.getCollection();
		var userFound = false;
		
		event.paramValue("email","");
		
		if( cgi.request_method == "POST" ){
			// we have a valid email address
			if( isValid("email",rc.email) ){
				var user = userService.findWhere({email=rc.email});				
				// and now we have a valid user
				if(!isNull(user)){
					// send the forgot password notification email
					securityService.sendForgotPasswordNotification(user);
					// TODO: update user with flag, user needs to change password
					getPlugin("MessageBox").setMessage("info","Email Sent.");
					userFound = true;
				}
			}
			// we either have a improper formatted email address or the user does not exist
			if(!userFound){
				getPlugin("MessageBox").setMessage("error","We could not locate a registered user with that email address, please try again.");
			}			
		}
		
	}
	/**
	 *
	 */
	public void function resetPassword(){
		var rc = event.getCollection();
		var user = userService.findWhere({emailPasswordHash=rc.eph});
		
		event.paramValue("newPassword","");
		
		if( !isNull(user) ){
			rc.newPassword = userService.resetPassword(user);
			rc.userid = user.getUserId();
			setNextEvent(event="security.changepassword",persist="newPassword,userid");
		} else {
			getPlugin("MessageBox").setMessage("error","We were unable to locate that account.");
			event.setView("security/forgotPassword");
		}
		
	}

	public void function changePassword(){
		var rc = event.getCollection();
	}

	public void function doChangePassword(){
		var rc = event.getCollection();
		var user = userService.findWhere({userid=rc.userid});

		// currentPassword,newPassword,newPasswordConfirm
		if( !isNull(user) && (rc.newPassword == rc.newPasswordConfirm) ){
			userService.changePassword(user.getUserId(),rc.newPassword);
			getPlugin("MessageBox").setMessage("info",'Your password has been changed.');
			setNextEvent("security.login");
		} else {
			// user is null or passwords do not match
			if( isNull(user) ){
				getPlugin("MessageBox").setMessage("error","We could not locate the account that you are trying to change..");
			} else {
				getPlugin("MessageBox").setMessage("error","The password and confirm password did not match, please try again.");
			}
			setNextEvent(event="security.changepassword",persist="newPassword,userid");
		}
				
	}
	
	public void function accessDenied(){
		
	}
		
}

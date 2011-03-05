<cfoutput>
<h1>Users: Change Password</h1>
#getPlugin("MessageBox").renderit()#
<form method="post" action="#event.buildLink('security.users.changePassword')#">
	<input type="hidden" name="currentPassword" id="currentPassword" value="#rc.newPassword#" />
	<input type="hidden" name="eph" id="eph" value="#rc.eph#" />
	<div>
		<label for="password">New Password:</label>
		<input type="password" name="password"/>
	</div>
	<div>
		<label for="passwordConfirm">Confirm New Password:</label>
		<input type="password" name="passwordConfirm"/>
	</div>	
	<div align="right">
		<input type="button" value="Cancel" onclick="location.href='#event.buildLink('security.roles.list')#'"> 
		<input type="submit" value="Save">
	</div>	
</form>
</cfoutput>
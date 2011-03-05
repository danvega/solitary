<cfoutput>
<h1>Change Password</h1>
#getPlugin("MessageBox").renderit()#
<form method="post" action="#event.buildLink('security.doChangePassword')#">
	<input type="hidden" name="userid" id="userid" value="#rc.userid#" />
	<input type="hidden" name="currentPassword" id="currentPassword" value="#rc.newPassword#" />
	<div>
		<label for="newPassword">New Password:</label>
		<input type="password" name="newPassword"/>
	</div>
	<div>
		<label for="newPasswordConfirm">Confirm New Password:</label>
		<input type="password" name="newPasswordConfirm"/>
	</div>	
	<div align="right">
		<input type="submit" value="Save">
	</div>	
</form>
</cfoutput>
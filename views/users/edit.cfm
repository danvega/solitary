<h1>User Editor</h1>

<cfoutput>
<form action="#event.buildLink('security.users.save')#" method="POST" name="newPostForm">
	<input type="hidden" name="userID" id="userID" value="#rc.user.getUserID()#" />
	
	<fieldset>
		<legend>General Information</legend>
		<div>
			<label for="firstname">First Name:</label>
			<input type="text" name="firstName" value="#rc.user.getFirstName()#"/>
		</div>
		<div>
			<label for="lastName">Last Name:</label>
			<input type="text" name="lastname" value="#rc.user.getLastName()#"/>
		</div>
	
		<div>
			<label for="email">Email Address:</label>
			<input type="text" name="email" value="#rc.user.getEmail()#"/>
		</div>		
	</fieldset>
	
	<fieldset>
		<legend>Login Information</legend>
		<div>
			<label for="username">Username:</label>
			<input type="text" name="username" value="#rc.user.getUsername()#"/>
		</div>		
		<cfif NOT len(rc.user.getUserID())>
		<div>
			<label for="password">Password:</label>
			<input type="password" name="password" value=""/>
		</div>	
		<div>
			<label for="confirmPassword">Confirm Password:</label>
			<input type="password" name="confirmPassword" value=""/>
		</div>
		</cfif>
		<div>
			<label for="roles">Role(s):</label>
			<select name="roles" multiple="true">
				<cfloop array="#rc.roles#" index="role">
					<option value="#role.getRoleId()#" <cfif rc.user.hasRole(role)>selected</cfif>>#role.getName()#</option>
				</cfloop>
			</select>			
		</div>
		<div>
			<label for="addrole">Add New Role:</label>
			<input type="text" name="addrole"/>
		</div>		
		<div class="clear">&nbsp;</div>		
		<div>
			<label for="lastlogin">Last Login:</label>
			#rc.user.getDisplayLastLogin()#
		</div>
	</fieldset>
	
	<div align="right">
		<input type="button" value="Cancel" onclick="location.href='#event.buildLink('security.users.list')#'"> 
		<input type="submit" value="Save">
	</div>
</form>
</cfoutput>

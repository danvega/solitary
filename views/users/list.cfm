<cfoutput>
<!--- js --->
<cfsavecontent variable="js">
<cfoutput>
<script type="text/javascript">
	function removeUser(userID){
		if( confirm("Really delete?") ){
			$("##userID").val( userID );
			$("##userForm").submit();
		}
	}
</script>
</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">

<h1>User Management</h1>
<p align="right"><a href="#event.buildLink('security.users.edit')#">Create New User</a></p>

#getPlugin("MessageBox").renderit()#

<form name="userForm" id="userForm" method="post" action="#event.buildLink('security.users.remove')#">
<input type="hidden" name="userID" id="userID" value="" />

<!--- users --->
<table name="users" id="users" class="tablelisting" width="98%">
	<thead>
		<tr>
			<th>Name</th>
			<th>Username</th>
			<th>Last Login</th>
			<th width="125" class="center">Actions</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#rc.users#" index="user">
		<tr>
			<td><a href="#event.buildLink('security.users.edit')#/#user.getUserID()#" title="Edit User">#user.getName()#</a></td>
			<td>#user.getUsername()#</td>
			<td>#user.getDisplayLastLogin()#</td>
			<td class="center">
				<cfif rc.currentUser.userid NEQ user.getUserId()>
					<input type="button" onclick="removeUser('#user.getUserID()#')" value="Delete"/>
				</cfif>
			</td>
		</tr>
		</cfloop>
	</tbody>
</table>
</form>

<p align="right"><a href="#event.buildLink('security.users.edit')#">Create New User</a></p>

</cfoutput>
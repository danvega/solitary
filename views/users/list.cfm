<cfoutput>
<h1>User Management</h1>

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
				<a href="#event.buildLink('security.users.edit')#/#user.getUserID()#" title="Edit User" class="edit action">Edit</a> 
				<cfif rc.currentUser.userid NEQ user.getUserId()>
					<a href="#event.buildLink('security.users.remove')#/#user.getUserID()#" title="Delete User" class="delete action" onClick="return removeUser();">Delete</a>
				</cfif>
			</td>
		</tr>
		</cfloop>
	</tbody>
</table>
</form>

<div class="right"><a href="#event.buildLink('security.users.edit')#" class="add" alt="Create New User">Create New User</a></div>
</cfoutput>

<script type="text/javascript">
function removeUser(userID){
	if( confirm("Really delete?") ){
		return true;
	}
	return false;
}
</script>

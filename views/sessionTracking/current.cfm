<cfset user = rc.activeSession>

<cfoutput>
	
	<h1>Session Tracking: Current Session</h1>
		
	<p>
		<strong>First Name: </strong> #user.firstname#<br/>
		<strong>Last Name: </strong> #user.lastname#<br/>
		<strong>Email: </strong> #user.email#<br/>
		<strong>Username: </strong> #user.username#<br/>
		<strong>Date Created: </strong> #dateFormat(user.dateCreated,'mm/dd/yyyy hh:mm:ss')#<br/>
		<strong>Last Login: </strong> #dateFormat(user.lastlogin,'mm/dd/yyyy hh:mm:ss')#<br/>			
	</p>
	
	<div><a href="#event.buildLink('security.sessiontracking.active')#">View All Active Sessions</a></div>

	
</cfoutput>
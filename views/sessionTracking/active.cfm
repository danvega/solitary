<cfoutput>
	
	<h1>Session Tracking: Active Sessions</h1>
	<p>Total Active Sessions: #arrayLen(rc.activeSessions)#</p>

	<cfloop array="#rc.activeSessions#" index="user">
		<div id="#user.sessionKey#" class="session">
			<div class="sessionkey">
				#user.sessionkey# {#user.username#}
			</div>
			<div class="user-data">
				<strong>First Name: </strong> #user.firstname#<br/>
				<strong>Last Name: </strong> #user.lastname#<br/>
				<strong>Email: </strong> #user.email#<br/>
				<strong>Username: </strong> #user.username#<br/>
				<strong>Date Created: </strong> #dateFormat(user.dateCreated,'mm/dd/yyyy hh:mm:ss')#<br/>
				<strong>Last Login: </strong> #dateFormat(user.lastlogin,'mm/dd/yyyy hh:mm:ss')#<br/>
			</div>
		</div>
	</cfloop>
	
	<script type="application/javascript">
		$(function(){
			$('.sessionkey').click(function(){
				$(this).next('.user-data').slideToggle("fast");
			})
		});	
	</script>
	
</cfoutput>
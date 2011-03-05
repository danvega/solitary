<cfset sessionStorage = caller.controller.getPlugin("SessionStorage")>
<cfset event = caller.event>

<cfoutput>
<cfif thisTag.executionMode eq "start">
	<cfset user = sessionStorage.getVar('user')>
	<cfif isStruct(user)>
		Welcome #user.firstname# #user.lastname# | <a href="#event.buildLink('security.logout')#">Logout</a>
	<cfelse>
		Welcome Guest User | <a href="#event.buildLink('security.login')#">Login</a>
	</cfif>
</cfif>
</cfoutput>
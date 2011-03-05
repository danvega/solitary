<cfoutput>
<div id="loginForm">
<h1>Login</h1>
<p>Please login using your username and password.</p>

<!--- display any messages in the event --->
#getPlugin("MessageBox").renderit()#

<form name="loginForm" method="POST" action="#event.buildLink('security.doLogin')#">
	<p>Username:<br/>
	<input type="text" name="username" value="#rc.username#"></p>
	<p>Password:<br/>
	<input type="password" name="password"></p>
	<p>
	<input type="checkbox" value="true" name="rememberme" <cfif len(rc.username)>checked</cfif>> Remember Me 
	<input type="submit" value="Login" name="submit">
	</p>
	<a href="#event.buildLink('security.forgotPassword')#">forgot password?</a>
</form>
</div>
</cfoutput>


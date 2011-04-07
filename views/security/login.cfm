<cfoutput>
<div id="login" class="shadow round-corners">
	<h1>Login</h1>
	<p>Please login using your username and password.</p>

	<!--- display any messages in the event --->
	#getPlugin("MessageBox").renderit()#
	
	<form id="loginForm" name="loginForm" method="POST" action="#event.buildLink('security.doLogin')#">
		
		<div>
			<label for="username">Username:<label>
			<input type="text" name="username" value="#rc.username#">
		</div>
		
		<div class="clear">&nbsp;</div>
		
		<div>
			<label for="password">Password:</label>
			<input type="password" name="password">
		</div>

		<input type="checkbox" value="true" name="rememberme" <cfif len(rc.username)>checked</cfif>> Remember Me 
		<input type="submit" value="Login" name="submit" id="btnLogin">
		
		<div class="clear">&nbsp;</div>
		
		<a href="#event.buildLink('security.forgotPassword')#">forgot password?</a>
	</form>
	
</div>
</cfoutput>

<script type="application/javascript">
	$(function(){
		$("#loginForm").submit(function(){
			$("#btnLogin").attr("disabled",true);
			return true;
		});
	});
</script>




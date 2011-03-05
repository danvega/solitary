<h1>Password Recovery</h1>

<cfoutput>
	#getPlugin("MessageBox").renderit()#
	<p>Enter the e-mail address associated with your account, then click Continue. We'll email you a link to a page where you can easily create a new password.</p>
	<form method="post" action="#event.buildLink('security.forgotPassword')#">
		<div>
			<label for="email">Email Address:</label>
			<input type="text" name="email">
			<input type="submit" name="submit" value="Continue">
		</div>
	</form>
</cfoutput>
<cfoutput>
<h1>User Editor</h1>
#getPlugin("MessageBox").renderit()#
<form action="#event.buildLink('security.users.save')#" method="POST" name="newPostForm">
	<input type="hidden" name="userID" id="userID" value="#rc.user.getUserID()#" />
	<cfif len(rc.user.getUserId())>
		<input type="hidden" name="context" value="update">
	<cfelse>
		<input type="hidden" name="context" value="create">		
	</cfif>
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
		<cfif NOT len(rc.user.getUserID())>
		<div>
			<label for="email">Email Address:</label>
			<input type="text" name="email" value="#rc.user.getEmail()#"/>
		</div>
		<cfelse>
		<div>
			<label for="email">Email Address:</label>
			#rc.user.getEmail()#
		</div>					
		</cfif>
	</fieldset>
	
	<fieldset>
		<legend>Login Information</legend>
		<cfif NOT len(rc.user.getUserID())>
		<div>
			<label for="username">Username:</label>
			<input type="text" id="username" name="username" value="#rc.user.getUsername()#"/>
			<span id="validateUsername" class="help">between 5-20 characters</span>
		</div>		
		<div>
			<label for="password">Password:</label>
			<input type="password" name="password" value=""/>
			<a id="generate" href="##">Generate Password</a>
		</div>	
		<div>
			<label for="confirmPassword">Confirm Password:</label>
			<input type="password" name="confirmPassword" value=""/>
		</div>
		<cfelse>
		<div>
			<label for="username">Username:</label>
			#rc.user.getUsername()#
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

<script type="application/javascript">

	$(function(){
		var pass = password(8).toUpperCase();
		$('##generate').click(function(event){
			event.preventDefault();
			$("input[type='password']").val(pass);
		});
		var $validateUsername = $("##validateUsername");
		$('##username').keyup(function(){
			var t = this;
			
			if(this.value.length > 0){
				if(this.value != this.lastValue) {
					if(this.timer)clearTimeout(this.time);
					
					$validateUsername
						.removeClass('unavailable')
						.html('<img src="#event.getModuleRoot()#/includes/images/ajax-loader.gif" width="16"/> check availibility ...');
					
					this.timer = setTimeout(function(){
						$.ajax({
							url: '#event.buildLink("security.users.usernameExists")#/' + t.value,
							type: 'post',
							dataType: 'json',
							success: function(data){
								$validateUsername.html(data.msg).addClass( (data.exists == true) ? 'unavailable' : 'available');
								console.log(data.exists);
							},
							error : function(xhr,textStatus,errorThrown){
								$validateUsername
									.html('there was an error checking username status, please refresh the page')
									.removeClass('available')
									.removeClass('unavailable');								
							}
						});
					}, 200);
					this.lastValue = this.value
				}
			} else {
				$validateUsername
					.html('between 5-20 characters')
					.removeClass('available');
			}
		});
	});

	// I did not write this and I totally forgot where I got this from
	// my apologies to the author (and thank you)
	function password(length, special) {
		var iteration = 0;
		var password = "";
		var randomNumber;
		
		if(special == undefined){
			var special = false;
		}
		
		while(iteration < length){
			randomNumber = (Math.floor((Math.random() * 100)) % 94) + 33;
			if(!special){
				if ((randomNumber >=33) && (randomNumber <=47)) { continue; }
				if ((randomNumber >=58) && (randomNumber <=64)) { continue; }
				if ((randomNumber >=91) && (randomNumber <=96)) { continue; }
				if ((randomNumber >=123) && (randomNumber <=126)) { continue; }
			}
			iteration++;
			password += String.fromCharCode(randomNumber);
		}
	
		return password;
	}	
</script>
</cfoutput>

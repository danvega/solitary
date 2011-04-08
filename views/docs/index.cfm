<cfoutput>
	
	<h1>Solitary Documentation</h1>

	<ul>
		<li><a href="##name">About</a></li>
		<li><a href="##install">Installation</a></li>
		<li><a href="##rules">Rules</a></li>
		<li><a href="##usage">Usage</a></li>
		<li><a href="##videos">Videos</a></li>
		<li><a href="##support">Support</a></li>
	</ul>
	
	
	<h2><a name="about">About</a></h2>
	<p>Building a new application that requires a security in framework can be a very tedious task. A security framework usually starts off as a simple requirement and ends up growing into a project all on its own. You first decide to either copy some code from a previous project or start from scratch. What if there was a way to drop a folder into your project and have a security frameowrk in place instantly? Well now there is!</p>
	<p>When modules came out for ColdBox I thought this would be a great first project to work. Solitary is a ColdBox module that handles roles based security for your application. When you drop the module into your project it will instantly lock down your entire application and create the necessary tables in your database. Under the hood it uses the ColdBox interceptor so its fully customizable.</p>
	
	<h2><a name="install">Installation</a></h2>
	<ol>
	<li>Drop the solitary folder into your modules folder {project_root}/modules/</li>
	<li>Add a mapping to {project_root}/Application.cfc
		<br/>
		&nbsp;&nbsp;&nbsp;&nbsp;this.mappings['/solitary'] = COLDBOX_APP_ROOT_PATH & "/modules/solitary";
	</li>
	<li>
		Update {project_root}/Application.cfc to enable ORM<br/><br/>
		<script src="https://gist.github.com/906965.js?file=gistfile1.cfm"></script>
	</li>	
	</ol>

	<h2><a name="rules">Rules</a></h2>
	<p>This module takes advantage of the <a href="http://wiki.coldbox.org/wiki/Interceptors:Security.cfm">ColdBox security interceptor.</a> There is a default rules config file as it is listed below but if you would like to read more about the security interceptor <a href="http://wiki.coldbox.org/wiki/Interceptors:Security.cfm">please click here</a>. </p>
	<script src="https://gist.github.com/906960.js?file=gistfile1.xml"></script>
	<br/>
	
	<h2><a name="usage">Usage</a></h2>
	<p>Once you have the module installed just navigate to your application and reload ORM (?ormReload). Once that is done you can reiniatilize the application so the module is found.Basically you have to reload your ORM application to add the database tables needed and you need to re initialize the ColdBox application to load the module. Of course this is not needed if this is the first time you are launching the application. </p>
	<p>You should now be presented with a login screen. I think this is the great thing about this module. All of the views / business logic has already been built for you! Please view the video tutorial below to learn more about how the module works.</p>
	
	<h2><a name="videos">Video Tutorials</a></h2>
	<p>Part 1: Introduction & Installation - <a href="http://vimeo.com/22110435">http://vimeo.com/22110435</a></p>	
	<p>Part 2: Features  - <a href="http://vimeo.com/22111233">http://vimeo.com/22111233</a></p>
	


	<h2><a name="support">Support</a></h2>
	<p>Please visit the source code repository at <a href="https://github.com/cfaddict/solitary">https://github.com/cfaddict/solitary</a>. From there you can contact me as well as file bugs.
		
</cfoutput>


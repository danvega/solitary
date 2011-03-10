component accessors="true" {

	property name="sessionStorage" inject="coldbox:plugin:SessionStorage";

	public void function current(){
		var rc = event.getCollection();		
		rc.activeSession = sessionStorage.getVar('user');
	}
	
	public void function active(){
		var rc = event.getCollection();
		var app = application.getApplicationSettings().name;		
		var sessiontracker = createObject("java","coldfusion.runtime.SessionTracker");
		var sessionCollection = sessionTracker.getSessionCollection(app);
		
		rc.activeSessions = [];
		
		for(var s in sessionCollection){
			var user = sessionCollection['#s#'].cbStorage.user;
			user['sessionKey'] = s; 			
			arrayAppend(rc.activeSessions,user);
		}
		
	}

}
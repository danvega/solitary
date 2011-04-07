<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Solitary Coldbox Module</title>

    <link rel="stylesheet" href="#event.getModuleRoot()#/includes/css/blueprint/screen.css" type="text/css" media="screen, projection"> 
    <link rel="stylesheet" href="#event.getModuleRoot()#/includes/css/blueprint/print.css" type="text/css" media="print"> 
    <!--[if lt IE 8]><link rel="stylesheet" href="#event.getModuleRoot()#/includes/css/blueprint/ie.css" type="text/css" media="screen, projection"><![endif]--> 
    <link rel="stylesheet" href="#event.getModuleRoot()#/includes/css/solitary.css" type="text/css" media="screen, projection"> 
	
	<script type="application/javascript" src="#event.getModuleRoot()#/includes/js/jquery-1.5.1.min.js"></script>		
</head>
<body id="action-#event.getCurrentAction()#">
	
	<div class="container">
		#renderView()#
	</div>
		
</body>
</html>
</cfoutput>
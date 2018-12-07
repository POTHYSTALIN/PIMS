<cfoutput>
			<!--- <cfdump var="#rc#" /><cfabort /> --->
	<cfparam name="rc.batchID" default="">
	<cfparam name="rc.viewSelectdata.batchName" default="">
	<cfparam name="rc.viewSelectdata.startdate" default="">
	<html>
		<head>
			<title>Emp Batch</title>
			<script src="btnvalidations.js"></script>
		</head>
		<body>
			<form name="batch_form" action="#event.buildLink('main.addbatch')#" method="post">
				<h1>New Employee Batch Details</h1>
				<label><b>Enter Name</b></label>
				<input type="text" name="batchName" value="#rc.viewSelectdata.batchName#"><br><br>
				<label><b>Enter StartDate</b></label>
				<input type="text" name="startdate" value="#rc.viewSelectdata.startdate#"><br><br>
				<input type="hidden" name="id" value="#rc.batchID#">
				<input type="Submit" name="Submit" value="submit">
				<input type="reset" name="reset">
				<a href="#event.buildLink('main.index')#" style="text-decoration:none">Back</a>
			</form> 
		</body>
	</html>
</cfoutput>

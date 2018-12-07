<cfoutput>
	<html>
		<head>
			<title>Batch Views</title>
			<script src="btnvalidations.js"></script>
		</head>
		<body>
			<cfoutput>
				<h1>Employee Batch Details</h1>
				<a href="#event.buildLink( linkTo='main.addbatch')#" style="text-decoration: none;" >Add Batch</a><br><br>
				<table border=1 style="width:50%;text-align:center;">
					<tr>
						<th>Emp_id</th>
						<th>Name</th>
						<th>Batch</th>
						<th>Action</th>
					</tr>
					<cfloop query="#rc.viewEmpbatch#">
						<tr>
							<td>#rc.viewEmpbatch.id#</td>
							<td>#rc.viewEmpbatch.batchName#</td>
							<td>#rc.viewEmpbatch.startdate#</td>
							<td><a href="#event.buildLink('main.addbatch')#&batchID=#id#" style="text-decoration: none;"
							onclick = 'return jsEdit()'>Edit</a>
							<span style="padding:10px">
							<!--- <a href="#event.buildLink('main.deleteBatch')#&batchID=#id#" style="text-decoration: none;"
							onclick = 'return jsDelete()'>Delete</a></span></td> --->
						</tr>
					</cfloop>
				</table>
			</cfoutput>
		</body>
	</html>
</cfoutput>
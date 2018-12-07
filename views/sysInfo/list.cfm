<cfoutput>
<html>
<head>
	<title></title>
	<script type="text/javascript">
		function deletefn(){
			var deleteAction = confirm("Do you want delete");
			if (deleteAction == false){
			 	return false;
			}
		}
	</script>
</head>
<h1>employee list</h1>
<!--- <cfdump var="#variables#" /> --->
<h1><a href="#event.buildLink( linkTo='main.listAction')#"  style="text-decoration: none;">Add Employee</a></h1>
<body>
	<cfif rc.employee.recordCount>
		<table class="table table-bordered table-condensed">
			<thead>
				<tr>
					<th>FirstName</th>
					<th>LastName</th>
					<th>Employee Batch</th>
					<th>Employee Destination</th>
					<th>Active</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
			</thead>
				<cfloop query="rc.employee">
			<tbody>
				<td>#rc.employee.FirstName#</td>
				<td>#rc.employee.lastName#</td>
				<td>#rc.employee.batchName#</td>
				<td>#rc.employee.typeName#</td>
				<td><cfif rc.employee.status eq 0>InActive<cfelse>Active</cfif></td>
				<td><a href="#event.buildLink( linkTo='main.listAction', queryString="ID=#rc.employee.ID#" )#" style="text-decoration: none;">Edit</a></td>
				<td><a href="#event.buildLink( linkTo='main.delete', queryString="did=#rc.employee.ID#" )#" onclick="return deletefn()" style="text-decoration: none;">Delete</a></td>
			</tbody>
			</cfloop>
		</table>
	</cfif>
</body>
</html>
</cfoutput>
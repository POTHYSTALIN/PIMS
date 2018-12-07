<cfoutput>
	 <script type="text/javascript">
	 	function delList(){
		if (confirm("Are you sure you want to delete?")){
			return true;
		}else{
			return false;
		}
	}
	 </script>
	<h1>List of Systems</h1>
	<a href="#event.buildLink('main.addEditSys')#"><button type="button" class="btn btn-secondary">Add System Info</button></a>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Label</th>
				<th>Processor</th>
				<th>RAM</th>
				<th>HDD</th>
				<th>Cabinet</th>
				<th>Installation type</th>
				<th>MotherBoard</th>
				<th>Action</th>
			</tr>
		</thead>
		<tr>
		<cfloop query="rc.listSysInfo">
			<tbody>
				<tr>
					<td>#id#</td>
					<td>#name#</td>
					<td>#Label#</td>
					<td>#Processor#</td>
					<td>#RAM#</td>
					<td>#HDD#</td>
					<td>#Cabinet#</td>
					<td>#Installationtype#</td>
					<td>#MotherBoard#</td>
					<td>
                        <span></span>
                        <a href="#event.buildLink('main.addEditSys')#&empID=#id#">Edit</a>
                        <span></span>
                        <a href="#event.buildLink('main.deleteSysInfo')#&empDelID=#id#" data-toggle="modal" onclick = "return delList()">Delete</a>
                    </td>
				</tr>
			</tbody>
		</cfloop>
	</table>
</cfoutput>
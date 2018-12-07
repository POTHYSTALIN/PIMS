<cfoutput>
	<cfparam name="rc.employee.ID" default="">
	<cfparam name="rc.employee.firstName" default="">
	<cfparam name="rc.employee.lastName" default="">
	<cfparam name="rc.employee.typeID" default="">
	<cfparam name="rc.employee.batchID" default="">
	<cfparam name="rc.employee.status" default="">
	<div class="tab-pane active in" id="login_form">
		<div class="panel-body">
			<form name="login_form" method="post" action="#event.buildLink( linkTo='main.listAction' )#">
				<input type="hidden"  name="ID"  value="#rc.employee.ID#">
				<div class="form-group controls">
					First Name:<input type="text" class="form-control required" placeholder="firstName" name="firstName" value="#rc.employee.firstName#">
				</div>
				<div class="form-group controls">
					Last Name:<input type="text" class="form-control required" placeholder="lasttName" name="lastName" value="#rc.employee.lastName#">
				</div>
				<div class="form-group col-sm-6">
					<label>Employee type</label>
					<select id="formType" class="form-control" name="typeID">
						<option>Select Employee type</option>
						<cfloop query="#rc.empType#">
							<option value="#rc.empType.ID#"<cfif #rc.employee.typeID# eq #rc.empType.ID#>selected=selected</cfif>>#rc.empType.typeName#</option>
						</cfloop>
					</select>
				</div>
				<div class="form-group col-sm-6">
					<label>Employee batch</label>
					<select class="form-control" name="batchID">
						<option>Select Employee batch</option>
						<cfloop query="#rc.empBatch#">
							<option value="#rc.empBatch.ID#"<cfif #rc.employee.batchID# eq #rc.empBatch.ID#>selected=selected</cfif>>#rc.empBatch.batchName#</option>
						</cfloop>
					</select>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-4" for="title">Active</label>
					<div class="col-sm-4 check_active ">
						<input type="checkbox" class="form-control" name="status" value="1" <cfif rc.employee.status eq "1">checked</cfif>>
					</div>
				</div>
				<input type="submit" class="btn btn-sm btn-success" name="submit" value="submit">
			</form>
		</div>
	</div>
	<a href="#event.buildLink( linkTo='main.list')#" style="text-decoration: none;">
		List</a>
</cfoutput>
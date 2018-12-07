<cfoutput>
	<div>
		<h3>Add System Info</h3>
		<form name="addEditSys" method="post" action="#event.buildLink('main.addEditSys')#">
			<div class="form-group row">
				<label for="Name" class="col-2 col-form-label">Name</label>
				<div class="col-5">
					<input type="text" class="form-control" name="Name" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.selectedsys.name neq ''>#rc.selectedsys.name#</cfif>">
				</div>
			</div>
			<div class="form-group row">
				<label for="Label" class="col-2 col-form-label">Label</label>
				<div class="col-5">
					<input type="text" class="form-control" name="Label" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.selectedsys.label neq ''>#rc.selectedsys.Label#</cfif>"></br>
				</div>
			</div>
			<div class="form-group row">
				<label for="Cabinet" class="col-2 col-form-label">Cabinet</label>
				<div class="col-5">
					<input type="text" class="form-control" name="Cabinet" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.selectedsys.Cabinet neq ''>#rc.selectedsys.Cabinet#</cfif>"></br>
				</div>
			</div>
			<div class="form-group row">
				<label for="Motherboard" class="col-2 col-form-label">Motherboard</label>
				<div class="col-5">
					<input type="text" class="form-control" name="Motherboard" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.selectedsys.Motherboard neq ''>#rc.selectedsys.Motherboard#</cfif>"></br>
				</div>
			</div>
			<div class="form-group row">
				<label for="Processor" class="col-2 col-form-label">Processor</label>
				<div class="col-5">
					<input type="text" class="form-control" name="Processor" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.selectedsys.Processor neq ''>#rc.selectedsys.Processor#</cfif>"></br>
				</div>
			</div>
			<div class="form-group row">
				<label for="Ram" class="col-2 col-form-label">Ram</label>
				<div class="col-5">
					<input type="text" class="form-control" name="Ram" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.selectedsys.Ram neq ''>#rc.selectedsys.Ram#</cfif>"></br>
				</div>
			</div>
			<div class="form-group row">
				<label for="HDD" class="col-2 col-form-label">HDD</label>
				<div class="col-5">
					<input type="text" class="form-control" name="HDD" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.selectedsys.HDD neq ''>#rc.selectedsys.HDD#</cfif>"></br>
				</div>
			</div>
			<div class="form-group row">
				<label for="OS" class="col-2 col-form-label">OS</label>
				<div class="col-5">
					<input type="text" class="form-control" name="OS" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.selectedsys.OS neq ''>#rc.selectedsys.OS#</cfif>"></br>
				</div>
			</div>
			<div class="form-group row">
				<label for="InstallationType" class="col-2 col-form-label">InstallationType</label>
				<div class="col-5">
					<input type="text" class="form-control" name="InstallationType" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.selectedsys.InstallationType neq ''>#rc.selectedsys.InstallationType#</cfif>">
				</div>
			</div>
			<input type="hidden" class="form-control" name="hiddenID" value="<cfif structKeyExists(RC, 'SELECTEDSYS') AND rc.empID neq ''>#rc.empID#</cfif>">
			<div class="form-group row">
				<label class="col-2 col-form-label"></label>
				<div class="col-2">
					<input type="submit" class="form-control btn btn-success" name="submitToInsert" value="Click to submit">
				</div>
				<div class="col-2">
					<input type="reset" class="form-control btn btn-info" name="Clear" value="Clear ALL">
				</div>
				<div class="col-1">
					<a href="#event.buildLink('main.systemInfo')#"><input type="button" class="form-control btn btn-warning" name="Back" value="Back"></a>
				</div>
			</div>
		</form>
	</div>
</cfoutput>
<!--- Fields needed --->
<!--- Table: Accounts --->
<!--- PK: AccID --->
<!--- Col1: Site --->
<!--- Col2: Username --->
<!--- Col3: Password --->
<!--- Col4: Additional Security(boolean) --->
<!--- Col5: Col4: Additional Security Details(varchar - should be email/mobile number) --->
<!--- Col6: DateCreated --->
<!--- Col7: DateUpdated --->

<!--- New Table for Additional security : AdditionalSecurity --->
<!--- AccID : from Passwords --->
<!--- SecurityType : SMS/Email/Others --->
<!--- Details : number/email --->


<cfoutput>
<!--- Uncomment below lines if this page needs header --->
<!--- <div class="container">
	<div class="p-t-20"> --->
		<form action="#event.buildLink( lCase(rc.formAction) )#" method="post">
			<input type="hidden" name="id" value="#rc.id#">
			<div class="form-group row">
				<label for="sitename" class="col-sm-2 col-form-label">Site</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="sitename" name="sitename" placeholder="Sitename" value="#rc.passwordDetails.site#">
				</div>
			</div>
			<div class="form-group row">
				<label for="username" class="col-sm-2 col-form-label">Username</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="username" name="username" placeholder="Username" value="#rc.passwordDetails.username#">
				</div>
			</div>
			<div class="form-group row">
				<label for="password" class="col-sm-2 col-form-label">Password</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="password" name="password" placeholder="Password" value="#len(rc.passwordDetails.password)?decrypt(rc.passwordDetails.password, rc.passwordDetails.salt):''#">
				</div>
			</div>
			<div class="form-group row">
				<label for="password" class="col-sm-2 col-form-label">Two Step</label>
				<div class="col-sm-10">
					<input type="checkbox" name="additionalEnabled" value="1" onclick="javascript: toggleAddSecurity(this);" <cfif rc.additionalSecDetails.recordCount>checked</cfif>>  enabled &nbsp;&nbsp;&nbsp;
					<span id="addSec" class="cursor text-success" <cfif NOT rc.additionalSecDetails.recordCount>style="display:none;"</cfif> onclick="javascript: addNewSecurityItem();"><i class="glyphicon glyphicon-plus"></i></span>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10" id="addSecWrapper">
					<cfif rc.additionalSecDetails.recordCount>
						<cfloop query="#rc.additionalSecDetails#">
							<div class="form-group row addSecContent" id="addSecContent#rc.additionalSecDetails.id#" data-id="#rc.additionalSecDetails.id#">
								<div for="password" class="col-sm-3">
									 <div class="dropdown">
										<button class="btn btn-secondary btn-sm dropdown-toggle-split" type="button" data-toggle="dropdown" id="secTypeDropdown#rc.additionalSecDetails.id#">#rc.additionalSecDetails.securityType#
										<span class="caret"></span></button>
										<ul class="dropdown-menu">
											<li><a href="##" onclick="javascript: changeSecType('#rc.additionalSecDetails.id#', 'SMS');">SMS</a></li>
											<li><a href="##" onclick="javascript: changeSecType('#rc.additionalSecDetails.id#', 'Email');">Email</a></li>
											<li><a href="##" onclick="javascript: changeSecType('#rc.additionalSecDetails.id#', 'Others');">Others</a></li>
										</ul>
										<input type="hidden" id="addSec#rc.additionalSecDetails.id#ID" name="addSec#rc.additionalSecDetails.id#ID" value="#rc.additionalSecDetails.id#">
										<input type="hidden" id="addSec#rc.additionalSecDetails.id#Type" name="addSec#rc.additionalSecDetails.id#Type" value="#rc.additionalSecDetails.securityType#">
									</div>
								</div>
								<div class="col-sm-7">
									<input type="text" class="form-control input-sm" name="addSec#rc.additionalSecDetails.id#Details" value="#rc.additionalSecDetails.details#">
								</div>
								<div class="col-sm-2">
									<i class="cursor glyphicon glyphicon-remove" onclick="javascript: removeAddionalSecurity('#rc.additionalSecDetails.id#');"></i>
								</div>
							</div>
						</cfloop>
					<cfelse>
						<div class="form-group row addSecContent" id="addSecContent1" data-id="1" style="display: none;">
							<div for="password" class="col-sm-3">
								 <div class="dropdown">
									<button class="btn btn-secondary btn-sm dropdown-toggle-split" type="button" data-toggle="dropdown">SMS
									<span class="caret"></span></button>
									<ul class="dropdown-menu">
										<li><a href="##" onclick="javascript: changeSecType('1', 'SMS');">SMS</a></li>
										<li><a href="##" onclick="javascript: changeSecType('1', 'Email');">Email</a></li>
										<li><a href="##" onclick="javascript: changeSecType('1', 'Others');">Others</a></li>
									</ul>
									<input type="hidden" id="addSec1ID" name="addSec1ID" value="0">
									<input type="hidden" id="addSec1Type" name="addSec1Type" value="SMS">
								</div>
							</div>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm" name="addSec1Details" value="">
							</div>
							<div class="col-sm-2">
								<i class="cursor glyphicon glyphicon-remove" onclick="javascript: removeAddionalSecurity('1');"></i>
							</div>
						</div>
					</cfif>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-8 col-sm-2">
					<input type="submit" class="btn btn-success" name="Submit" value="#rc.formSubmit#">
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
		</form>
<!--- 	</div>
</div> --->
</cfoutput>
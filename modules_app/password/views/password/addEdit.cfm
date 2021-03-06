<cfoutput>
	<form action="#event.buildLink( lCase( prc.formAction ) )#" method="post">
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
				<span id="addSec" class="cursor text-success" <cfif NOT rc.additionalSecDetails.recordCount>style="display:none;"</cfif> onclick="javascript: addNewSecurityItem();"><i class="fas fa-plus"></i></span>
			</div>
		</div>
		<div class="form-group row justify-content-sm-end">
			<div class="col-sm-10" id="addSecWrapper">
				<cfif rc.additionalSecDetails.recordCount>
					<cfloop query="#rc.additionalSecDetails#">
						<div class="form-group row addSecContent" id="addSecContent#rc.additionalSecDetails.id#" data-id="#rc.additionalSecDetails.id#">
							<div for="password" class="col-sm-3">
									<div class="dropdown">
									<button class="btn btn-secondary btn-sm dropdown-toggle-split" type="button" data-toggle="dropdown" id="secTypeDropdown#rc.additionalSecDetails.id#">#rc.additionalSecDetails.securityType#
									<span class="fas fa-angle-down"></span></button>
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
								<i class="cursor text-danger fas fa-times-circle" onclick="javascript: removeAddionalSecurity('#rc.additionalSecDetails.id#');"></i>
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
							<i class="cursor text-danger fas fa-times-circle" onclick="javascript: removeAddionalSecurity('1');"></i>
						</div>
					</div>
				</cfif>
			</div>
		</div>
		<div class="form-group row">
			<div class="offset-9 col-sm-1 pr-0 pl-4 mr-1">
				<input type="submit" class="btn btn-success" name="Submit" value="#prc.formSubmit#">
			</div>
			<div class="col-sm-1 p-0 mr-2 ml-5">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</form>
</cfoutput>
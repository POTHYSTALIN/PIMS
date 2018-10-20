<cfparam name="rc.id" default="0">
<cfparam name="rc.msg" default="">
<cfparam name="rc.msgAction" default="">
<cfparam name="rc.searchStr" default="">
<script type="text/javascript">
	jQuery(function(){
		setTimeout(function(){
			jQuery("div.alert").slideUp(1000);
		},10000);
	});
</script>
<cfoutput>
<div class="container">
	<div style="min-height: 10px;">&nbsp;</div>
	<cf_alerts msg="#rc.msg#" msgAction="#rc.msgAction#">

	<div class="row">
		<div class="col-xs-6">
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr>
						<th>ID</th>
						<th>Bank</th>
						<th>Short name</th>
						<th width="10">Status</th>
						<th width="70">&nbsp;</th>
					</tr>
				</thead>
				<cfloop query="prc.allBanks">
					<tr class="#iif(prc.allBanks.deleted, "'negative'", "'positive'")#">
						<td>#prc.allBanks.ID#</td>
						<td>#prc.allBanks.name#</td>
						<td>#prc.allBanks.shortname#</td>
						<td class="text-center">
							<cfif prc.allBanks.deleted><i class="glyphicon glyphicon-remove text-danger"><cfelse><i class="glyphicon glyphicon-ok text-success"></i></cfif>
						</td>
						<td>
							<a href="#event.BuildLink( LinkTo='edit.bank.#prc.allBanks.ID#')#" title="Edit"><i class="glyphicon glyphicon-edit text-primary"></i></a>
							<cfif NOT prc.allBanks.deleted>
								<a href="#event.BuildLink( LinkTo='delete.bank.#prc.allBanks.ID#')#" title="Delete"><i class="glyphicon glyphicon-remove text-danger"></i></a>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</table>
		</div>
		<div class="col-xs-6">
			<form class="ui form grid" action="#event.BuildLink('new.bank')#" method="post">
				<input type="hidden" name="ID" value="#val(prc.currBankDetails.ID)#">
				<div class="form-group col-xs-12">
					<label for="name">Bank</label>
					<input class="form-control" type="text" name="name" value="#prc.currBankDetails.name#" placeholder="Bank Name">
				</div>
				<div class="form-group col-xs-12">
					<label>Short name</label>
					<input class="form-control" type="text" name="shortname" value="#prc.currBankDetails.shortname#" placeholder="Short Name">
				</div>
				<div class="form-group col-xs-12">
					<label>Status</label>
					<select name="deleted" class="form-control">
						<option value="0" <cfif prc.currBankDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
						<option value="1" <cfif prc.currBankDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
					</select>
				</div>
				<div class="form-group col-xs-12">
					<input class="btn btn-success" type="submit" name="Add" value="#iif(val(prc.currBankDetails.id), "'Update'", "'Add'")#">
				</div>
			</form>
		</div>
	</div>
</div>
</cfoutput>
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
		<!--- <div class="col-xs-12">
			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="##list">List</a></li>
				<li><a data-toggle="tab" href="##add">Add</a></li>
			</ul>

			<div class="tab-content">
				<div id="list" class="tab-pane fade in active">
					<table class="table table-bordered table-striped table-hover">
						<thead>
							<tr>
								<th>ID</th>
								<th>Category Type</th>
								<th width="10">Status</th>
								<th width="70">&nbsp;</th>
							</tr>
						</thead>
						<cfloop query="prc.allCategoryTypes">
							<tr class="#iif(prc.allCategoryTypes.deleted, "'negative'", "'positive'")#">
								<td>#prc.allCategoryTypes.ID#</td>
								<td>#prc.allCategoryTypes.name#</td>
								<td class="text-center">
									<cfif prc.allCategoryTypes.deleted><i class="glyphicon glyphicon-remove text-danger"><cfelse><i class="glyphicon glyphicon-ok text-success"></i></cfif>
								</td>
								<td>
									<a href="#event.BuildLink( LinkTo='edit.categoryType.#prc.allCategoryTypes.ID#')#" title="Edit"><i class="glyphicon glyphicon-edit text-primary"></i></a>
									<cfif NOT prc.allCategoryTypes.deleted>
										<a href="#event.BuildLink( LinkTo='delete.categoryType.#prc.allCategoryTypes.ID#')#" title="Delete"><i class="glyphicon glyphicon-remove text-danger"></i></a>
									</cfif>
								</td>
							</tr>
						</cfloop>
					</table>
				</div>
				<div id="add" class="tab-pane fade">
					<form class="ui form grid" action="#event.BuildLink('new.categoryType')#" method="post">
						<input type="hidden" name="ID" value="#val(prc.currCategoryTypeDetails.ID)#">
						<div class="form-group col-xs-6">
							<label for="name">Category Name</label>
							<input class="form-control" type="text" name="name" value="#prc.currCategoryTypeDetails.name#" placeholder="Category Name">
							<!--- <small id="nameHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> --->
						</div>
						<div class="form-group col-xs-6">
							<label>Status</label>
							<select name="deleted" class="form-control">
								<option value="0" <cfif prc.currCategoryTypeDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
								<option value="1" <cfif prc.currCategoryTypeDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
							</select>
						</div>
						<div class="form-group col-xs-6">
							<input class="btn btn-success" type="submit" name="Add" value="#iif(val(prc.currCategoryTypeDetails.ID), "'Update'", "'Add'")#">
						</div>
					</form>
				</div>
			</div>
		</div> --->
		<div class="col-xs-6">
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr>
						<th>ID</th>
						<th>Category Type</th>
						<th width="10">Status</th>
						<th width="70">&nbsp;</th>
					</tr>
				</thead>
				<cfloop query="prc.allCategoryTypes">
					<tr class="#iif(prc.allCategoryTypes.deleted, "'negative'", "'positive'")#">
						<td>#prc.allCategoryTypes.ID#</td>
						<td>#prc.allCategoryTypes.name#</td>
						<td class="text-center">
							<cfif prc.allCategoryTypes.deleted><i class="glyphicon glyphicon-remove text-danger"><cfelse><i class="glyphicon glyphicon-ok text-success"></i></cfif>
						</td>
						<td>
							<a href="#event.BuildLink( LinkTo='edit.categoryType.#prc.allCategoryTypes.ID#')#" title="Edit"><i class="glyphicon glyphicon-edit text-primary"></i></a>
							<cfif NOT prc.allCategoryTypes.deleted>
								<a href="#event.BuildLink( LinkTo='delete.categoryType.#prc.allCategoryTypes.ID#')#" title="Delete"><i class="glyphicon glyphicon-remove text-danger"></i></a>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</table>
		</div>
		<div class="col-xs-6">
			<form class="ui form grid" action="#event.BuildLink('new.categoryType')#" method="post">
				<input type="hidden" name="ID" value="#val(prc.currCategoryTypeDetails.ID)#">
				<div class="form-group col-xs-6">
					<label for="name">Category Type</label>
					<input class="form-control" type="text" name="name" value="#prc.currCategoryTypeDetails.name#" placeholder="Category type">
					<!--- <small id="nameHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> --->
				</div>
				<div class="form-group col-xs-6">
					<label>Status</label>
					<select name="deleted" class="form-control">
						<option value="0" <cfif prc.currCategoryTypeDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
						<option value="1" <cfif prc.currCategoryTypeDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
					</select>
				</div>
				<div class="form-group col-xs-6">
					<input class="btn btn-success" type="submit" name="Add" value="#iif(val(prc.currCategoryTypeDetails.ID), "'Update'", "'Add'")#">
				</div>
			</form>
		</div>
	</div>
</div>
</cfoutput>
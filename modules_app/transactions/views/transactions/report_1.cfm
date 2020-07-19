<cfoutput>
	<cfif prc.currBalances.isEmpty()>
		<div class="row">
			<div class="col">
				No data is tracked for you, please add initial amount for all accounts, you need to track.
			</div>
		</div>
	<cfelse>
		<cfset total = 0 />
		<cfloop collection="#prc.currBalances#" item="itm" index="idx">
			<cfset total += itm.amount />
			<div class="row">
				<div class="offset-sm-3 col-sm-3">
					<cfif itm.type EQ "hand">
						<i class="fas fa-hands"></i>
					<cfelse>
						<i class="fas fa-university"></i>
					</cfif>&nbsp;
					#itm.accountName#
				</div>
				<div class="col-sm-3">
					<!--- Rupee symbol for html --->
					<!--- &##8377; &##x20B9; --->
					<h5><i class="fas fa-rupee-sign"></i> #numberFormat( itm.amount, "__.__" )#</h5>
				</div>
			</div>
		</cfloop>
		<hr />
		<div class="row">
			<div class="offset-sm-3 col-sm-3">Total</div>
			<div class="col-sm-3"><h5><i class="fas fa-rupee-sign"></i> #numberFormat( total, "__.__" )#</h5></div>
		</div>
	</cfif>

	<div class="row">
		<div class="offset-sm-8 col-sm-2">
			<!--- TODO: Need to make download working --->
			<button type="button" class="btn btn-success" onclick="javascript: window.location.href=/?download=true"><i class="fas fa-download"></i>&nbsp;&nbsp;Export</button>
		</div>
		<div class="col-sm-2">
			<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times"></i>&nbsp;&nbsp;Close</button>
		</div>
	</div>
</cfoutput>
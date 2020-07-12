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
				<div class="col-sm-3">
					<cfif itm.type EQ "hand">
						<i class="fas fa-hands"></i>
					<cfelse>
						<i class="fas fa-university"></i>
					</cfif>&nbsp;
					#itm.accountName#
				</div>
				<div class="col-sm-9">
					<!--- Rupee symbol for html --->
					<!--- &##8377; &##x20B9; --->
					<h5>&##8377; #itm.amount#</h5>
				</div>
			</div>
		</cfloop>
		<hr />
		<div class="row">
			<div class="col-sm-3">Total</div>
			<div class="col-sm-6"><h5>&##8377; #total#</h5></div>
		</div
	</cfif>
	
	<div class="row">
		<div class="offset-sm-10 col-sm-2">
			<button type="button" class="btn btn-danger float-right" data-dismiss="modal">Close</button>
		</div>
	</div>
</cfoutput>
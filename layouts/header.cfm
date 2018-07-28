<cfoutput>
	<style type="text/css">
		
	</style>
	<div class="navbar navbar-inverse navbar-fixed-top scrollclass">
		<div class="container">
			#renderView("main/navbar")#
			<!--- <div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="##">Apps Manager</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#event.buildLink('home')#" <cfif rc.action EQ "main.index">class="active"</cfif>>Home</a></li>
					<li><a href="#event.buildLink('list.password')#" <cfif rc.action EQ "password.index">class="active"</cfif>>Password</a></li>
					<li class="dropdown">
						<div class="btn-group">
							<a class="btn btn-secondary header-link <cfif rc.action EQ "transaction.index"> active</cfif>" id="dropdownMenuButton" href="#event.buildLink('list.transactions')#">
								Transactions
							</a>
							<a class="header-link caret-holder <cfif rc.action EQ "transaction.index"> active</cfif>" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" href="##">
								<span class="caret b-t-7 cursor"></span>
							</a>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
								<li><a class="dropdown-item" href="#event.buildLink('list.categoryTypes')#">Transaction Types</a></li>
								<li><a class="dropdown-item" href="#event.buildLink('list.categories')#">Transaction categories</a></li>
								<li><a class="dropdown-item" href="#event.buildLink('list.transactions')#">Transactions</a></li>
							</ul>
						</div> &nbsp;
					</li>
					<li class="p-l-20"><a href="#event.buildLink('list.events')#" <cfif rc.action EQ "events.index">class="active"</cfif>>Events</a></li>
					<!--- <li><a href="#event.buildLink('list.transactions')#" <cfif rc.action EQ "transaction.index">class="active"</cfif>>Transactions</a></li> --->
					<li class="p-l-20"><a href="#event.buildLink('logout')#">Signout</a></li>
					<!--- <li><a href="##features-sec">Features</a></li>
					<li><a href="##advance-sec">Advance</a></li>
					<li><a href="##gallery-sec">Gallery</a></li>
					<li><a href="##location-sec">Location</a></li> --->
				</ul>
			</div> --->
		</div>
	</div>
</cfoutput>
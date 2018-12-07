<cfoutput>
<div class="navbar-header">
	<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##navbar-collapse-1">
		<span class="sr-only">Toggle navigation</span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	</button>
	<a class="navbar-brand" href="/">Apps Manager<cfif structKeyExists(url, "debug")> ( #rc.action# )</cfif></a>
</div>
<div class="collapse navbar-collapse" id="navbar-collapse-1">
	<ul class="nav navbar-nav navbar-left" style="width: 86%">
		<!--- simple link --->
		<!--- <li><a href="##">Link</a></li> --->
		<!--- dropdown link --->
		<!--- <li class="dropdown">
			<a href="##" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret b-t-7 cursor"></b></a>
			<ul class="dropdown-menu">
				<li class="kopie"><a href="##">Dropdown</a></li>
			</ul>
		</li> --->
		<!--- multi level dropdown link --->
		<!--- <li class="dropdown">
			<a href="##" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret b-t-7 cursor"></b></a>
			<ul class="dropdown-menu">
				<li class="kopie"><a href="##">Dropdown</a></li>
				<li class="dropdown dropdown-submenu">
					<a href="##" class="dropdown-toggle" data-toggle="dropdown">Dropdown Link 4</a>
					<ul class="dropdown-menu">
						<li class="kopie"><a href="##">Dropdown Link 4</a></li>
						<li><a href="##">Dropdown Submenu Link 4.1</a></li>
						<li><a href="##">Dropdown Submenu Link 4.2</a></li>
						<li><a href="##">Dropdown Submenu Link 4.3</a></li>
						<li><a href="##">Dropdown Submenu Link 4.4</a></li>
					</ul>
				</li>
			</ul>
		</li> --->
		<li><a href="#event.buildLink('home')#" <cfif rc.action EQ "main.index">class="active"</cfif>>Home</a></li>
		<li><a href="#event.buildLink('list.password')#" <cfif rc.action EQ "password.index">class="active"</cfif>>Password</a></li>
		<li class="dropdown">
			<a class="btn btn-secondary header-link <cfif listFirst(rc.action, '.') EQ 'transaction'> active</cfif>" id="dropdownMenuButton" href="#event.buildLink('list.transactions')#">
				Transactions <b class="caret b-t-7 cursor"></b>
			</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="#event.buildLink('list.categoryTypes')#">Transaction Types</a></li>
				<li><a class="dropdown-item" href="#event.buildLink('list.categories')#">Transaction categories</a></li>
				<li><a class="dropdown-item" href="#event.buildLink('list.transactions')#">Transactions</a></li>
				<li><a class="dropdown-item" href="#event.buildLink('list.banks')#">Banks</a></li>
				<li><a class="dropdown-item" href="#event.buildLink('list.bankAccounts')#">Bank Accounts</a></li>
			</ul>
		</li>
		<li><a href="#event.buildLink('list.events')#" <cfif rc.action EQ "events.index">class="active"</cfif>>Events</a></li>
		<li class="dropdown">
			<a class="btn btn-secondary header-link <cfif listFirst(rc.action, '.') EQ 'commons'> active</cfif>" id="dropdownMenuButton" href="##">
				Commons <b class="caret b-t-7 cursor"></b>
			</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="#event.buildLink('list.tasks')#">Tasks</a></li>
				<li><a class="dropdown-item" href="#event.buildLink('list.taskTypes')#">Task Types</a></li>
				<li><a class="dropdown-item" href="#event.buildLink('list.taskCategories')#">Task Categories</a></li>
				<hr>
				<li><a href="#event.buildLink('list.tips')#">Tips & Tricks</a></li>
				<li><a href="#event.buildLink('list.sysInfo')#">System Information</a></li>
			</ul>
		</li>
		<li class="dropdown pull-right">
			<a href="##" class="dropdown-toggle" data-toggle="dropdown">My Account <b class="caret b-t-7 cursor"></b></a>
			<ul class="dropdown-menu">
				<li class="kopie"><a href="##">#Session.UserName#</a></li>
				<li><a href="##">Profile</a></li>
				<li><a href="#event.buildLink('logout')#">Signout</a></li>
				<cfif session.UserID NEQ -1 AND session.myBankAccounts.recordcount>
					<li class="dropdown dropdown-submenu">
						<a href="##" class="dropdown-toggle" data-toggle="dropdown">My Accounts</a>
						<ul class="dropdown-menu" style="left: -106%;margin-left: 10px;">
							<li class="kopie"><a href="##">Banks</a></li>
							<cfloop query="session.myBankAccounts">
								<li><a href="##">#session.myBankAccounts.shortname# ( #session.myBankAccounts.accountID# )</a></li>
							</cfloop>
						</ul>
					</li>
				</cfif>
			</ul>
		</li>
	</ul>
</div>
</cfoutput>
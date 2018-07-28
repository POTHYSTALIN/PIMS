<cfoutput>
<div class="navbar-header">
	<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##navbar-collapse-1">
		<span class="sr-only">Toggle navigation</span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	</button>
	<a class="navbar-brand" href="/">Apps Manager</a>
</div>
<div class="collapse navbar-collapse" id="navbar-collapse-1">
	<ul class="nav navbar-nav navbar-left" style="width: 89%">
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
			<a class="btn btn-secondary header-link <cfif rc.action EQ "transaction.index"> active</cfif>" id="dropdownMenuButton" href="#event.buildLink('list.transactions')#">
				Transactions <b class="caret b-t-7 cursor"></b>
			</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="#event.buildLink('list.categoryTypes')#">Transaction Types</a></li>
				<li><a class="dropdown-item" href="#event.buildLink('list.categories')#">Transaction categories</a></li>
				<li><a class="dropdown-item" href="#event.buildLink('list.transactions')#">Transactions</a></li>
				<li class="dropdown dropdown-submenu">
					<a href="##" class="dropdown-toggle" data-toggle="dropdown">Banks</a>
					<ul class="dropdown-menu">
						<li class="kopie"><a href="##">Banks</a></li>
						<li><a href="##">Dropdown Submenu Link 4.1</a></li>
						<li><a href="##">Dropdown Submenu Link 4.2</a></li>
						<li><a href="##">Dropdown Submenu Link 4.3</a></li>
						<li><a href="##">Dropdown Submenu Link 4.4</a></li>
					</ul>
				</li>
			</ul>
		</li>
		<li><a href="#event.buildLink('list.events')#" <cfif rc.action EQ "events.index">class="active"</cfif>>Events</a></li>
		<li class="dropdown pull-right">
			<a href="##" class="dropdown-toggle" data-toggle="dropdown">My Account <b class="caret b-t-7 cursor"></b></a>
			<ul class="dropdown-menu">
				<li class="kopie"><a href="##">My Account</a></li>
				<li><a href="##">Profile</a></li>
				<li><a href="#event.buildLink('logout')#">Signout</a></li>
			</ul>
		</li>
	</ul>
</div>
</cfoutput>
<cfoutput>
<section id="topbar" class="d-none d-lg-block">
	<div class="container-fluid clearfix">
		<div class="contact-info float-left">
			<!--- <i class="fa fa-envelope-o"></i> <a href="mailto:contact@example.com">contact@example.com</a> --->
			<i class="far fa-envelope"></i> <a href="mailto:contact@example.com">contact@example.com</a>
			<i class="fa fa-phone"></i> +1 5589 55488 55
		</div>
		<div class="social-links float-right">
			<a href="##" class="twitter"><i class="fab fa-twitter"></i></a>
			<a href="##" class="facebook"><i class="fab fa-facebook-f"></i></a>
			<a href="##" class="instagram"><i class="fab fa-instagram"></i></a>
			<a href="##" class="google-plus"><i class="fab fa-google-plus-g"></i></a>
			<a href="##" class="linkedin"><i class="fab fa-linkedin-in"></i></a>
		</div>
	</div>
</section>

<!--==========================
Header
============================-->
<header id="header">
	<div class="container-fluid">

		<div id="logo" class="pull-left">
			<h1><a href="##body" class="scrollto">My <span>App</span></a></h1>
			<!-- Uncomment below if you prefer to use an image logo -->
			<!-- <a href="##body"><img src="img/logo.png" alt="" title="" /></a>-->
		</div>

		<nav id="nav-menu-container">
			<ul class="nav-menu">
				<li id="menu_home"><a href="/home">Home</a></li>
				<cfif structKeyExists(session, "UserID")>
					<li id="menu_password"><a href="/password">Password</a></li>
					<li id="menu_mitrahsoft" class="menu-has-children">
						<a href="##">MitrahSoft</a>
						<ul id="menu_mitrahsoft_submenus">
							<!--- <li id="menu_mitrahsoft_sysinfo">
								<a href="/mitrahsoft/sysinfo">System Information</a>
							</li> --->
							<li id="menu_mitrahsoft_sysinfo">
								<a href="/mitrahsoft/sysinfo">System Information</a>
								<ul>
									<li>
										<a href="/mitrahsoft/sysinfo/items">Hardwares</a>
									</li>
									<li>
										<a href="/mitrahsoft/sysinfo/item-props">Hardware Properties</a>
									</li>
									<li>
										<a href="/mitrahsoft/sysinfo/prop-details">Hardware Property Details</a>
									</li>
									<li>
										<a href="#event.buildLink("mitrahsoft.sysinfo.item-details")#">Hardware Details</a>
									</li>
									<li>
										<a href="/mitrahsoft/sysinfo/item-purchases">Hardware Purchases</a>
									</li>
									<li>
										<a href="/mitrahsoft/sysinfo/item-problems">Hardware problems</a>
									</li>
								</ul>
							</li>
							<li id="menu_mitrahsoft_submenu_1"><a href="##">Drop Down 3</a></li>
							<li id="menu_mitrahsoft_submenu_1"><a href="##">Drop Down 4</a></li>
						</ul>
					</li>
					<li id="menu_user" class="menu-has-children">
						<a href="">Pothys Ravichandran</a>
						<ul id="menu_user_submenus">
							<li id="menu_user_submenu_1"><a href="##">Drop Down 1</a></li>
							<li id="menu_user_submenu_1"><a href="##">Drop Down 3</a></li>
							<li id="menu_user_submenu_1"><a href="?fwreinit=true">reload</a></li>
							<li id="menu_user_submenu_logout"><a href="/logout">Logout</a></li>
						</ul>
					</li>
				<cfelse>
					<cfif lcase(cgi.path_info) IS NOT "/login" AND NOT structKeyExists(session, "UserID")>
						<li id="menu_login"><a href="/login">Login</a></li>
					</cfif>
					<cfif lcase(cgi.path_info) IS NOT "/signup" AND NOT structKeyExists(session, "UserID")>
						<li id="menu_signup"><a href="/signup">Signup</a></li>
					</cfif>
				</cfif>
			</ul>
		</nav><!-- ##nav-menu-container -->
	</div>
</header><!-- ##header -->
</cfoutput>
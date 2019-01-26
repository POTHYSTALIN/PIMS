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
				<li class="menu-active"><a href="##body">Home</a></li>
				<cfif structKeyExists(session, "UserID")>
					<li><a href="##team">single</a></li>
					<li class="menu-has-children"><a href="">Drop Down</a>
						<ul>
							<li><a href="##">Drop Down 1</a></li>
							<li><a href="##">Drop Down 3</a></li>
							<li><a href="##">Drop Down 4</a></li>
							<li><a href="##">Drop Down 5</a></li>
						</ul>
					</li>
				<cfelseif lcase(cgi.path_info) IS "/login">
					<li><a href="/signup">Signup</a></li>
				<cfelseif lcase(cgi.path_info) IS "/signup">
					<li><a href="/login">Login</a></li>
				</cfif>
			</ul>
		</nav><!-- ##nav-menu-container -->
	</div>
</header><!-- ##header -->
</cfoutput>
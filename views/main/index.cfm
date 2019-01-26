<cfoutput>
<!--- <cfdump var="#request#" /><cfabort /> --->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>myapp.com - Manages all your transactions</title>
		<meta content="width=device-width, initial-scale=1.0" name="viewport">

		<!-- Google Fonts -->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800|Montserrat:300,400,700" rel="stylesheet">

		<!-- Bootstrap CSS File -->
		<link href="#request.assetsPath#/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

		<!-- Libraries CSS Files -->
		<link href="#request.assetsPath#/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/animate/animate.min.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/ionicons/css/ionicons.min.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/magnific-popup/magnific-popup.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/ionicons/css/ionicons.min.css" rel="stylesheet">

		<!-- Main Stylesheet File -->
		<link href="#request.assetsPath#/style.css" rel="stylesheet">
	</head>
	<body>
		<section id="topbar" class="d-none d-lg-block">
			<div class="container clearfix">
				<div class="contact-info float-left">
					<i class="fa fa-envelope-o"></i> <a href="mailto:contact@example.com">contact@example.com</a>
					<i class="fa fa-phone"></i> +1 5589 55488 55
				</div>
				<div class="social-links float-right">
					<a href="##" class="twitter"><i class="fa fa-twitter"></i></a>
					<a href="##" class="facebook"><i class="fa fa-facebook"></i></a>
					<a href="##" class="instagram"><i class="fa fa-instagram"></i></a>
					<a href="##" class="google-plus"><i class="fa fa-google-plus"></i></a>
					<a href="##" class="linkedin"><i class="fa fa-linkedin"></i></a>
				</div>
			</div>
		</section>

		<!--==========================
		Header
		============================-->
		<header id="header">
			<div class="container">

				<div id="logo" class="pull-left">
					<h1><a href="##body" class="scrollto">My<span>app</span></a></h1>
					<!-- Uncomment below if you prefer to use an image logo -->
					<!-- <a href="##body"><img src="img/logo.png" alt="" title="" /></a>-->
				</div>

				<nav id="nav-menu-container">
					<ul class="nav-menu sf-js-enabled sf-arrows">
						<li class="menu-active"><a href="##body">Home</a></li>
						<li><a href="##about">About Us</a></li>
						<li><a href="##services">Services</a></li>
						<li><a href="##portfolio">Portfolio</a></li>
						<li><a href="##team">Team</a></li>
						<li class="menu-has-children"><a class="sf-with-ul" href="">Drop Down</a>
							<ul>
								<li><a href="##">Drop Down 1</a></li>
								<li><a href="##">Drop Down 3</a></li>
								<li><a href="##">Drop Down 4</a></li>
								<li><a href="##">Drop Down 5</a></li>
							</ul>
						</li>
						<li><a href="##contact">Contact</a></li>
					</ul>
				</nav><!-- ##nav-menu-container -->
			</div>
		</header><!-- ##header -->
	</body>
</html>
</cfoutput>
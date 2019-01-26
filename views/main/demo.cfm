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
		<!--- <link href="#request.assetsPath#/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --->
		<link href="#request.assetsPath#/vendor/bootstrap-4.2.1-dist/css/bootstrap.min.css" rel="stylesheet">

		<!-- Libraries CSS Files -->
		<!--- <link href="#request.assetsPath#/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet"> --->
		<link href="#request.assetsPath#/vendor/fontawesome-free-5.6.3-web/css/all.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/animate/animate.min.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/ionicons/css/ionicons.min.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/magnific-popup/magnific-popup.css" rel="stylesheet">
		<link href="#request.assetsPath#/lib/ionicons/css/ionicons.min.css" rel="stylesheet">

		<!-- Main Stylesheet File -->
		<link href="#request.assetsPath#/style.css" rel="stylesheet">
		<link href="#request.assetsPath#/my_style.css" rel="stylesheet">
	</head>
	<body>
		<cfinclude template="/views/main/header.cfm" runonce="true">

		<div id="intro-carousel" class="owl-carousel">
			<div class="item">
				<section id="intro">
					<div class="intro-content">
						<h2>Test 1 Making <span>your ideas</span><br>happen!</h2>
						<div>
							<a href="##about" class="btn-get-started scrollto">Get Started</a>
							<a href="##portfolio" class="btn-projects scrollto">Our Projects</a>
						</div>
					</div>
				</section>
			</div>
			<div class="item">
				<section id="intro">
					<div class="intro-content">
						<h2>Test 2 Making <span>your ideas</span><br>happen!</h2>
						<div>
							<a href="##about" class="btn-get-started scrollto">Get Started</a>
							<a href="##portfolio" class="btn-projects scrollto">Our Projects</a>
						</div>
					</div>
				</section>
			</div>
			<div class="item">
				<section id="intro">
					<div class="intro-content">
						<h2>Test 3 Making <span>your ideas</span><br>happen!</h2>
						<div>
							<a href="##about" class="btn-get-started scrollto">Get Started</a>
							<a href="##portfolio" class="btn-projects scrollto">Our Projects</a>
						</div>
					</div>
				</section>
			</div>
			<div class="item">
				<section id="intro">
					<div class="intro-content">
						<h2>Test 4 Making <span>your ideas</span><br>happen!</h2>
						<div>
							<a href="##about" class="btn-get-started scrollto">Get Started</a>
							<a href="##portfolio" class="btn-projects scrollto">Our Projects</a>
						</div>
					</div>
				</section>
			</div>
			<div class="item">
				<section id="intro">
					<div class="intro-content">
						<h2>Test 5 Making <span>your ideas</span><br>happen!</h2>
						<div>
							<a href="##about" class="btn-get-started scrollto">Get Started</a>
							<a href="##portfolio" class="btn-projects scrollto">Our Projects</a>
						</div>
					</div>
				</section>
			</div>
		</div>
		<section id="about" class="wow fadeInUp">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12 content">
						<h2>Lorem ipsum dolor sit amet, consectetur adipiscing</h2>
						<h3>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</h3>
						<ul>
							<li><i class="ion-android-checkmark-circle"></i> Ullamco laboris nisi ut aliquip ex ea commodo consequat.</li>
							<li><i class="ion-android-checkmark-circle"></i> Duis aute irure dolor in reprehenderit in voluptate velit.</li>
							<li><i class="ion-android-checkmark-circle"></i> Ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate trideta storacalaperda mastiro dolore eu fugiat nulla pariatur.</li>
						</ul>
					</div>
				</div>
			</div>
		</section>

		<cfinclude template="/views/main/footer.cfm" runonce="true">
	</body>
</html>
</cfoutput>
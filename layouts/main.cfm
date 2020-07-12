<cfparam name="rc.msg" default="">
<cfparam name="rc.msgAction" default="">
<cfheader name="Access-Control-Allow-Origin" value="https://fonts.gstatic.com">
<cfoutput>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>myapp.com - Manages all your transactions</title>
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
		<link rel="shortcut icon" href="/assets/img/logo.png">

		<!-- Google Fonts -->
		<!--- <link href="#request.assetsPath#/vendor/fonts.googleapis/css.css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800|Montserrat:300,400,700" rel="stylesheet"> --->
		<link href="#request.assetsPath#/vendor/fonts.googleapis/css.css" rel="stylesheet">

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

		<link href="#request.assetsPath#/vendor/fullcalendar-4.3.1/packages/core/main.min.css" rel="stylesheet" />
		<link href="#request.assetsPath#/vendor/fullcalendar-4.3.1/packages/daygrid/main.min.css" rel="stylesheet" />
		<script src="#request.assetsPath#/vendor/fullcalendar-4.3.1/packages/core/main.min.js"></script>
		<script src="#request.assetsPath#/vendor/fullcalendar-4.3.1/packages/interaction/main.min.js"></script>
		<script src="#request.assetsPath#/vendor/fullcalendar-4.3.1/packages/daygrid/main.min.js"></script>

		<style>
			body {
				margin: 40px 10px;
				padding: 0;
				font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
				font-size: 14px;
			}

			##calendar {
				max-width: 900px;
				margin: 0 auto;
			}
		</style>

		<!-- Main Stylesheet File -->
		<link href="#request.assetsPath#/style.css" rel="stylesheet">
		<link href="#request.assetsPath#/my_style.css" rel="stylesheet">

		<cfset currAssetPaths = listChangeDelims(rc.action, ",", ":.")>
		<cfset currPath = "">
		<cfloop list="#currAssetPaths#" item="currItem">
			<cfset currPath &= "/" & currItem />
			<cfset pageSpecificCss = expandPath("/assets/modules#currPath#.css")>
			<cfif fileExists(pageSpecificCss)>
				<link href="/assets/modules#currPath#.css" rel="stylesheet" />
			</cfif>
		</cfloop>
		
		<!--- <cfset pageSpecificCss = expandPath("/assets/#listFirst(rc.action, '.')#.css")>
		<cfif fileExists(pageSpecificCss)>
			<link href="/assets/#listFirst(rc.action, '.')#.css" rel="stylesheet" />
		</cfif>
		<cfset pageSpecificCss = expandPath("/assets/#cgi.path_info#.css")>
		<cfif fileExists(pageSpecificCss)>
			<link href="/assets/#cgi.path_info#.css" rel="stylesheet" />
		</cfif> --->
	</head>
	<body>
		#renderView("main/header")#
		<div class="container-fluid">
			<cf_alerts msg="#rc.msg#" msgAction="#rc.msgAction#" />
			#renderView()#
		</div>
		#renderView("main/footer")#
	</body>
</html>
</cfoutput>
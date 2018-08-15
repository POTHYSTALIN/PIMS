<cfoutput>
	<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns##" xmlns:fb="https://www.facebook.com/2008/fbml">
		<head>
			<meta charset="utf-8" />
			<!-- meta tags -->
			<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
			<meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1" />
			<title>myapp.com - Manages all your transactions.</title>
			<script type="text/javascript" src="/assets/js/jquery-1.11.3.min.js"></script>
			<script type="text/javascript" src="/assets/js/bootstrap_3.3.6.min.js"></script>
			<!--- <script type="text/javascript" src="/assets/js/bootstrap.min.js"></script> --->
			<!--- <script src="/assets/js/bootstrap-toggle/bootstrap-toggle.min.js"></script> --->
			<cfif fileExists(expandPath("/assets/js/#rc.action#.js"))>
				<script type="text/javascript" src="/assets/js/#rc.action#.js"></script>
			<cfelseif fileExists(expandPath("/assets/js/#listFirst(rc.action, '.')#.js"))>
				<script type="text/javascript" src="/assets/js/#listFirst(rc.action, '.')#.js"></script>
			</cfif>
			<script type="text/javascript" src="/assets/js/notifications.js"></script>
			<!-- BOOTSTRAP CORE STYLE  -->
			<!--- <link href="/assets/css/bootstrap_3.2.0.css" rel="stylesheet" /> --->
			<!--- <link href="/assets/css/bootstrap-toggle/bootstrap-toggle.min.css" rel="stylesheet"> --->
			<link rel="stylesheet" href="/assets/css/style_bootstrap_dropdown.css">
			<link href="/assets/css/bootstrap_3.3.6.min.css" rel="stylesheet" id="bootstrap-css">		<!-- FONT AWESOME ICON STYLE  -->		<link href="/assets/css/font-awesome.css" rel="stylesheet" />
			<!-- PRETTYPHOTO STYLE -->
			<!--- <link href="/assets/css/prettyPhoto.css" rel="stylesheet" /> --->
			<!-- CUSTOM STYLE CSS -->
			<link rel="stylesheet" href="/assets/css/style.css">
			<link href="/assets/css/style_main.css" rel="stylesheet" />
			<!-- CUSTOM THEME COLOR -- YOU CAN USE LIGHT & DARK THEMES  -->
			<link href="/assets/css/themes/dark.css" rel="stylesheet" />
			<!-- GOOGLE FONT -->
			<link href='/assets/css/font-styles.css?family=Open+Sans' rel='stylesheet' type='text/css' />
			<cfif fileExists(expandPath("/assets/css/#listFirst(rc.action, '.')#.css"))>
				<link href="/assets/css/#listFirst(rc.action, '.')#.css" rel='stylesheet' type='text/css' />
			</cfif>
			<script type="text/javascript">
				jQuery(function(){
					setTimeout(function(){
						jQuery("div.alert").slideUp(1000);
					},10000);
				});
			</script>
		</head>
		<body>
			#renderView('../layouts/header')#
			<div class="main-wrap">#renderView()#</div>
		</body>
	</html>
</cfoutput>
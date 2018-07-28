<cfoutput>
<html>
<head>
	<title>Login</title>
	<!-- BOOTSTRAP CORE STYLE  -->
	<link href="/assets/css/bootstrap_3.2.0.css" rel="stylesheet" />
	<link href="/assets/css/bootstrap-toggle/bootstrap-toggle.min.css" rel="stylesheet">

	<link rel="stylesheet" href="assets/css/style.css">

	<script type="text/javascript" src="/assets/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript">
		jQuery(function(){
			setTimeout(function(){
				jQuery("div.alert").slideUp(1000);
			},10000);
		});
	</script>
</head>
<body>
	<div class="main-wrap">
		#renderView()#
	</div>
</body>
</html>
</cfoutput>
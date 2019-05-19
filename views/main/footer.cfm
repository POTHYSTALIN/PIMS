<cfoutput>
<!-- JavaScript Libraries -->
<script src="#request.assetsPath#/lib/jquery/jquery.min.js"></script>
<script src="#request.assetsPath#/lib/jquery/jquery-migrate.min.js"></script>
<script src="#request.assetsPath#/lib/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="#request.assetsPath#/lib/easing/easing.min.js"></script>
<script src="#request.assetsPath#/lib/superfish/hoverIntent.js"></script>
<script src="#request.assetsPath#/lib/superfish/superfish.min.js"></script>
<script src="#request.assetsPath#/lib/wow/wow.min.js"></script>
<script src="#request.assetsPath#/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="#request.assetsPath#/lib/magnific-popup/magnific-popup.min.js"></script>
<script src="#request.assetsPath#/lib/sticky/sticky.js"></script>

<!-- Template Main Javascript File -->
<script src="#request.assetsPath#/main.js"></script>

<cfset moduleSpec = listRest(rc.action, ":")>
<cfset handlerSpec = listRest(moduleSpec, ":")>

<cfif fileExists(expandPath('/assets/#listFirst(rc.action, ":")#.js'))>
	<!--- module specific js --->
	<script src="/assets/#listFirst(rc.action, ":")#.js"></script>
<cfelseif fileExists(expandPath('/assets/#listFirst(moduleSpec, ".")#.js'))>
	<!--- handler specific js --->
	<script src="/assets/#listFirst(moduleSpec, ".")#.js"></script>
<cfelseif fileExists(expandPath('/assets/#cgi.path_info#.js'))>
	<script src="/assets/#cgi.path_info#.js"></script>
</cfif>
<script>
	jQuery(function(){
		setTimeout(function(){
			jQuery("div.alert").slideUp(1000);
		}, 10000);
	});
</script>
</cfoutput>
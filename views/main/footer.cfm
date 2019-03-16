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

<cfset pageSpecificJs = expandPath('/assets/#listFirst(rc.action, ".")#.js')>
<cfif fileExists(pageSpecificJs)>
	<script src="/assets/#listFirst(rc.action, ".")#.js"></script>
</cfif>
<cfset pageSpecificJs = expandPath('/assets/#cgi.path_info#.js')>
<cfif fileExists(pageSpecificJs)>
	<script src="/assets/#cgi.path_info#.js"></script>
</cfif>
</cfoutput>
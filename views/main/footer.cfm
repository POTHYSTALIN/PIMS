<cfoutput>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog modal-lg">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header my-success">
				<h4 class="modal-title">Update password details</h4>
				<button type="button" class="close text-white" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<p>Some text in the modal.</p>
			</div>
		</div>
	</div>
</div>
<!-- JavaScript Libraries -->
<script src="#request.assetsPath#/lib/jquery/jquery.min.js"></script>
<!--- <script src="#request.assetsPath#/lib/jquery/jquery-migrate.min.js"></script> --->
<script src="#request.bootstrapPath#/js/bootstrap.bundle.min.js"></script>
<!--- <script src="#request.assetsPath#/lib/easing/easing.min.js"></script> --->
<script src="#request.assetsPath#/lib/superfish/hoverIntent.js"></script>
<script src="#request.assetsPath#/lib/superfish/superfish.min.js"></script>
<!--- <script src="#request.assetsPath#/lib/wow/wow.min.js"></script> --->
<script src="#request.assetsPath#/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="#request.assetsPath#/lib/sticky/sticky.js"></script>
<script src="#request.assetsPath#/vendor/jquery-validate/js/jquery.validate.1.19.1.min.js"></script>
<!--- <script src="#request.assetsPath#/vendor/jquery-menu/js/navbar.js"></script> --->

<!--- uxsolutions - bootstrap - datepicker-1.9.0 / https://github.com/uxsolutions/bootstrap-datepicker --->
<script src="#request.assetsPath#/vendor/uxsolutions-bootstrap-datepicker-1.9.0/js/bootstrap-datepicker.min.js"></script>

<!--- bootstrap-select-1.13.18 - https://github.com/snapappointments/bootstrap-select --->
<script src="#request.assetsPath#/vendor/bootstrap-select-1.13.18/bootstrap-select.min.js"></script>
<!--- <cfdump var="#prc#" abort="true" /> --->
<cfif prc.currentRoutedModule is "tips" AND listFindNoCase( "preview/,markdown/,:id-numeric/,:id-numeric/:title/", prc.currentRoute )>
	<cfinclude template="./md-editor.cfm" runonce="true" />
</cfif>

<!-- Template Main Javascript File -->
<script src="#request.assetsPath#/main.js"></script>

<cfset currAssetPaths = listChangeDelims(rc.action, ",", ":.")>
<cfset currPath = "">
<cfloop list="#currAssetPaths#" item="currItem">
	<cfset currPath &= "/" & currItem />
	<cfset pageSpecificjs = expandPath("/assets/modules#currPath#.js")>
	<cfif fileExists(pageSpecificjs)>
		<script src="/assets/modules#currPath#.js"></script>
	</cfif>
</cfloop>

<!--- <cfset moduleSpec = listRest(rc.action, ":")>
<cfset handlerSpec = listRest(moduleSpec, ":")>

<cfif fileExists(expandPath("/assets/#listFirst(rc.action, ":")#.js"))>
	<!--- module specific js --->
	<script src="/assets/#listFirst(rc.action, ":")#.js"></script>
<cfelseif fileExists(expandPath("/assets/#listFirst(moduleSpec, ".")#.js"))>
	<!--- handler specific js --->
	<script src="/assets/#listFirst(moduleSpec, ".")#.js"></script>
<cfelseif fileExists(expandPath("/assets/#cgi.path_info#.js"))>
	<script src="/assets/#cgi.path_info#.js"></script>
</cfif> --->
</cfoutput>
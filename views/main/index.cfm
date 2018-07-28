<cfparam name="rc.msg" default="">
<cfparam name="rc.msgAction" default="">

<link rel="stylesheet" type="text/css" href="../../assets/css/carousel/style.css">
<div class="container">
	<cfoutput>
		<div style="min-height: 10px;">&nbsp;</div>
		<cfif len(rc.msg) AND rc.msgAction EQ "Error">
			<div class="alert alert-dismissible alert-danger" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Error!</strong> #rc.msg#
			</div>
		<cfelseif len(rc.msg) AND rc.msgAction EQ "Success">
			<div class="alert alert-dismissible alert-success" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Success!</strong> #rc.msg#
			</div>
		</cfif>
	</cfoutput>
<div id="carousel-example" class="mbr-slider mbr-section mbr-section__container carousel slide mbr-section-nopadding mbr-after-navbar" data-ride="carousel" style="background-color: #6E6E6F; color: white; margin: 175px 0 0 220px; width: 70%; min-height: 300px; opacity: 0.60;">
	<!-- Indicators -->
	<!--- <ol class="carousel-indicators">
		<li data-target="#carousel-example" data-toggle="prev" class="active"></li>
		<li data-target="#carousel-example" data-slide-to="1"></li>
		<li data-target="#carousel-example" data-slide-to="2"></li>
	</ol> --->
	<!-- Wrapper for slides -->
	<div class="row">
		<div class="col-xs-offset-2 col-xs-8" style="margin-left: 10.668%; width: 79%;">
			<cfset kuralList = "">
			<cfloop condition="true EQ true">
				<cfset currNo = randRange(1,1330)>
				<cfif listFindNoCase(kuralList, currNo & ".txt")>
					<!--- To avoid repeated numbers --->
					<cfcontinue>
				</cfif>
				<cfset kuralList = listAppend(kuralList, numberFormat(currNo, "0000") & ".txt")>
				<cfif listLen(kuralList) EQ 10>
					<!--- Load only 10 kural in dynamic way --->
					<cfbreak>
				</cfif>
			</cfloop>
			<cfdirectory action="list" directory="#expandPath('./assets/kural/')#" name="thirukural" filter="*.txt">
			<cfquery name="thirukural" dbtype="query">
				select * from thirukural
				where name in ( #listQualify(kuralList, "'")# )
			</cfquery>
			<div class="carousel-inner">
				<cfloop query="#thirukural#">
					<cffile action="read" file="#expandPath('./assets/kural/' & thirukural.name)#" variable="local.content">
					<div class="item <cfif thirukural.currentRow EQ 1>active</cfif>">
						<div class="carousel-content slick-slide">
							<div>
								<cfoutput>
									<cftry>
									<h1><strong><img src="/assets/img/valluvar.png" width="50" height="50"><!--- ###listFirst(thirukural.name, ".")# ---> #listGetAt(content, 1, '|')#</strong></h1>
									<h3><strong>#listGetAt(content, 2, '|')#</strong></h3>
									<h5>மு.வ : #listGetAt(content, 3, '|')#</h5>
									<!--- <h5>சாலமன் பாப்பையா : #listGetAt(content, 4, '|')#</h5> --->
									<cfcatch type="any">
										<h1><strong>Please add correct content for kural #thirukural.name#</strong>#content#</h1>
									</cfcatch>
									</cftry>
								</cfoutput>
							</div>
						</div>
					</div>
				</cfloop>
				<!--- <div class="item active" data-url="/render/62805">
					<div class="carousel-content slick-slide">
						<div>
							<h3><strong>#1</strong></h3>
							<p><strong>This is a twitter bootstrap carousel that only uses text. There are no images in the carousel slides.</strong></p>
						</div>
					</div>
				</div>
				<div class="item">
					<div class="carousel-content slick-slide">
						<div>
							<h3>#2</h3>
							<p>This is another much longer item. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi, sint fuga temporibus nam saepe delectus expedita vitae magnam necessitatibus dolores tempore consequatur dicta cumque repellendus eligendi ducimus placeat! Sapiente, ducimus, voluptas, mollitia voluptatibus nemo explicabo sit blanditiis laborum dolore illum fuga veniam quae expedita libero accusamus quas harum ex numquam necessitatibus provident deleniti tenetur iusto officiis recusandae corporis culpa quaerat?</p>
						</div>
					</div>
				</div>
				<div class="item">
					<div class="carousel-content slick-slide">
						<div>
							<h3>#3</h3>
							<p>This is the third item.</p>
						</div>
					</div>
				</div>
				<div class="item">
					<div class="carousel-content slick-slide">
						<div>
							<h3>#4</h3>
							<p>This is the third item.</p>
						</div>
					</div>
				</div> --->
			</div>
		</div>
	</div>
	<a data-app-prevent-settings="" class="left carousel-control" role="button" data-slide="prev" href="#carousel-example">
		<span class="icon-prev" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</a>
	<a data-app-prevent-settings="" class="right carousel-control" role="button" data-slide="next" href="#carousel-example">
		<span class="icon-next" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</a>
</div>
</div>


<!--- see the below link for carousel --->
<!--- https://mobirise.com/bootstrap-carousel/ --->
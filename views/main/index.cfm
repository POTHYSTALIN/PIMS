<cfoutput>
	<cfset kuralList = "">
	<cfloop condition="true EQ true">
		<cfset currNo = randRange(1,1330)>
		<cfif listFindNoCase(kuralList, currNo & ".txt")>
			<!--- To avoid repeated numbers --->
			<cfcontinue>
		</cfif>
		<cfset kuralList = listAppend(kuralList, numberFormat(currNo, "0000") & ".txt")>
		<cfif listLen(kuralList) EQ 10>
			<!--- Load only 10 kural in a dynamic way --->
			<cfbreak>
		</cfif>
	</cfloop>
	<cfdirectory action="list" directory="#expandPath('./assets/kural/')#" name="thirukural" filter="*.txt">
	<cfquery name="thirukural" dbtype="query">
		select * from thirukural
		where name in ( #listQualify(kuralList, "'")# )
	</cfquery>
	<div id="intro-carousel" class="owl-carousel">
		<cfloop query="#thirukural#">
			<cffile action="read" file="#expandPath('./assets/kural/' & thirukural.name)#" variable="local.content">
			<div class="item <cfif thirukural.currentRow EQ 1>active</cfif>">
				<section id="intro">
					<div class="intro-content">
						<cftry>
							<h1>
								<span style="width: 15%; float: left;">
									<img src="/assets/img/valluvar.png">
								</span>
								<strong style="width: 85%; float: left;"><!--- ###listFirst(thirukural.name, ".")# ---> #listGetAt(content, 1, '|')#</strong></h1>
							<h3><strong>#listGetAt(content, 2, '|')#</strong></h3>
							<h5>மு.வ : #listGetAt(content, 3, '|')#</h5>
							<!--- <h5>சாலமன் பாப்பையா : #listGetAt(content, 4, '|')#</h5> --->
							<cfcatch type="any">
								<h1><strong>Please add correct content for kural #thirukural.name#</strong>#content#</h1>
							</cfcatch>
						</cftry>
					</div>
				</section>
			</div>
		</cfloop>
		<!--- <cfloop index="idx" from="1" to="5">
			<div class="item">
				<section id="intro">
					<div class="intro-content">
						<h2>Test #idx# Making <span>your ideas</span><br>happen!</h2>
						<div>
							<a href="##about" class="btn-get-started scrollto">Get Started</a>
							<a href="##portfolio" class="btn-projects scrollto">Our Projects</a>
						</div>
					</div>
				</section>
			</div>
		</cfloop> --->
	</div>
</cfoutput>
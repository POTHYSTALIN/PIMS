<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml"
	  xmlns:og="http://ogp.me/ns##"
	  xmlns:fb="https://www.facebook.com/2008/fbml">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1" />
		<title>myapp.com - Events.</title>

		<!--- <link href="/assets/css/bootstrap_3.2.0.css" rel="stylesheet" /> --->

		<!--- <link href="/assets/js/fullcalendar-3.9.0/fullcalendar.css" rel="stylesheet" />

		<link href="/assets/js/fullcalendar-3.9.0/fullcalendar.print.css" rel="stylesheet" media="print" />

		<script type="text/javascript" src="/assets/js/fullcalendar-3.9.0/lib/moment.min.js"></script>
		<script type="text/javascript" src="/assets/js/fullcalendar-3.9.0/fullcalendar.js"></script>

		<link href="/assets/js/jquery-ui-1.12.1.custom/jquery-ui.css" rel="stylesheet" />
		<!--- bootstrap date time picker --->
		<link href="/assets/js/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
		<script type="text/javascript" src="/assets/js/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script> --->

		<style>
			#calendar {
				max-width: 1300px;
				margin: 0 auto;
			}
			.fc-button-primary {
				color: #50d8af;
				background-color: #FFFFFF;
				border-color: #50d8af;
			}
			.fc-button-primary:hover {
				color: #FFFFFF;
				background-color: #50d8af;
				border-color: #50d8af;
			}
		</style>

	</head>
	<cfoutput>
		<body>
			<cfset eventsArr = []>
			<cfloop query="#prc.getEvents#">
				<cfset currEvnt = {}>
				<cfset currEvnt.title = name>
				<cfset currEvnt.id = id>
				<cfset currEvnt.start = dateTimeFormat(sDate, "mm/dd/yyyy h:nn TT")>
				<cfset currEvnt.end = dateTimeFormat(eDate, "mm/dd/yyyy h:nn TT")>
				<cfset currEvnt.description = desc>
				<cfif type EQ "events">
					<cfset currEvnt.color = "purple">
				<cfelseif type EQ "tasks">
					<cfset currEvnt.color = "green">
				</cfif>
				<cfset currEvnt.timeFormat = "H(:mm)">
				<cfset arrayAppend(eventsArr, currEvnt)>
			</cfloop>

			<cfset allEvents = serializeJSON(eventsArr)>
			<cfloop list="start,end,title,color,description,timeFormat" index="currItem">
				<cfset allEvents = replaceNoCase(allEvents, '"#currItem#"', currItem, "ALL")>
			</cfloop>

			<div style="min-height: 10px;">&nbsp;</div>
			<div id="calendar"></div>
			<!--- <div class="modal fade" id="events" data-backdrop="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Add Events</h4>
						</div>
						<div class="modal-body">
							<form class="form-horizontal" role="form" action="#event.buildLink( lCase( prc.formAction ) )#" method="post">
								<input type="hidden" name="id" id="id" value="0">
								<div class="form-group">
									<label  class="col-sm-2 control-label" for="name">Event Name</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="name" name="name" /> 
									</div>
								 </div>
								 <div class="form-group">
									<label  class="col-sm-2 control-label" for="desc">Description</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="desc" name="desc" />
									</div>
								 </div>
								 <div class="form-group">
									<label  class="col-sm-2 control-label" for="sdate">Start Date</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="sdate" name="sdate" /> 
									</div>
								 </div>
								 <div class="form-group">
									<label  class="col-sm-2 control-label" for="edate">End Date</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="edate" name="edate" /> 
									</div>
								 </div>
								 <div class="form-group">
									<label  class="col-sm-2 control-label"></label>
									<div class="col-sm-2">
										<input type="submit" class="form-control btn btn-primary" name="submit" value="submit" / > 
									</div>
									<div class="col-sm-2">
										<button type="submit" class="form-control btn btn-danger" name="submit" value="delete">Delete</button>
									</div>
									<div class="col-sm-2">
										<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									</div>
								 </div>
							</form>
						</div>
					</div>
				</div>
			</div> --->
		</body>
	</cfoutput>

	<!--- <script type="text/javascript">

		$(document).ready(function() {
				// var eventData = $("#eventsData").val();
				// var eventRes = JSON.parse(eventData);
				// console.log(eventRes.DATA);
			// page is now ready, initialize the calendar...
			$("#calendar").fullCalendar({
				// put your options and callbacks here
				header: {
					left: "prev,next today",
					center: "title",
					right: "month,agendaWeek,agendaDay,listWeek"
				},
				height: 450,
				theme: true,
				navLinks: true, // can click day/week names to navigate views
				editable: true,
				eventLimit: true,
				events : <cfoutput>#allEvents#</cfoutput>,
				eventRender: function(eventObj, $el) {
					$el.popover({
						title: eventObj.title,
						content: eventObj.description,
						trigger: "hover",
						placement: "top",
						container: "body"
					});
				},
				dayClick: function(date, jsEvent, view) {
					var day 	= date._d.getDate();
					var Month 	= date._d.getMonth()+1;
					var year 	= date._d.getFullYear()+" "+"12:00 AM";
					var getDate = Month+"/"+day+"/"+year;

					$("#sdate").val(getDate);
					$("#events").modal("show");

				},
				eventClick: function(calEvent, jsEvent, view){
					console.clear();
					console.log(calEvent);
					$("#name").val(calEvent.title);
					$("#id").val(calEvent.ID);
					$("#desc").val(calEvent.DESC);
					$("#sdate").val(calEvent.start._i);
					if( calEvent._end != null)
						$("#edate").val(calEvent._end._i);
					$("#events").modal("show");
				}
			});

			$("#sdate,#edate").datetimepicker();
			$("#sdate").on("dp.change", function (e) {
				if($("#edate").val() != "")
					$("#edate").data("DateTimePicker").minDate(e.date);
			});
		});
	</script> --->
</html>
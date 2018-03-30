<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml"
	  xmlns:og="http://ogp.me/ns##"
	  xmlns:fb="https://www.facebook.com/2008/fbml">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1" />
		<title>myapp.com - Events.</title>

		<link href="/assets/css/bootstrap_3.2.0.css" rel="stylesheet" />

		<link href="/assets/js/fullcalendar-3.4.0/fullcalendar.css" rel="stylesheet" />

		<link href='/assets/js/fullcalendar-3.4.0/fullcalendar.print.css' rel='stylesheet' media='print' />

		<script type="text/javascript" src="/assets/js/jquery-1.11.3.min.js"></script>

		<script type="text/javascript" src="/assets/js/bootstrap.min.js"></script>

		<script type="text/javascript" src="/assets/js/fullcalendar-3.4.0/lib/moment.min.js"></script>
		<script type="text/javascript" src="/assets/js/fullcalendar-3.4.0/fullcalendar.js"></script>

		<link href="/assets/js/jquery-ui-1.12.1.custom/jquery-ui.css" rel="stylesheet" />
		<!--- bootstrap date time picker --->
		<link href="/assets/js/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
		<script type="text/javascript" src="/assets/js/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>

		<style>
			#calendar {
				max-width: 1300px;
				margin-top: 8% !important;
				margin: 0 auto;
			}
			#events{
				margin-top: 3%;
			}
		</style>

	</head>
	<cfoutput>
		<body>
		
			<cfset eventsArr = []>
			<cfloop query="#rc.getEvents#">
				<cfset currEvnt = {}>
				<cfset currEvnt.title = EVENT_NAME>
				<cfset currEvnt.event_id = EVENT_ID>
				<cfset currEvnt.start = dateFormat(START_DATE, "yyyy-mm-dd")>
				<cfset currEvnt.end = dateFormat(END_DATE, "yyyy-mm-dd")>
				<cfset currEvnt.event_desc = EVENT_DESC>
				<cfset arrayAppend(eventsArr, currEvnt)>
			</cfloop>

			<cfset allEvents = replaceNoCase(replaceNoCase(replaceNoCase(serializeJSON(eventsArr), '"start"', "start", "ALL"), '"end"', "end", "ALL"), '"title"', "title", "ALL")>

			<div style="min-height: 10px;">&nbsp;</div>
			<div id="calendar"></div>
			<div class="modal fade" id="events" data-backdrop="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Add Events</h4>
						</div>
						<div class="modal-body">
							<form class="form-horizontal" role="form" action="#event.buildLink(lCase(rc.formaction))#" method="post">
								<div class="form-group">
									<label  class="col-sm-2 control-label" for="eventName">EventName</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="eventName" name="eventName" /> 
									</div>
								 </div>
								 <div class="form-group">
									<label  class="col-sm-2 control-label" for="description">Description</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="description" name="description" />
									</div>
								 </div>
								 <div class="form-group">
									<label  class="col-sm-2 control-label" for="date">StartDate</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="eventStartDate" name="eventStartDate" /> 
									</div>
								 </div>
								 <div class="form-group">
									<label  class="col-sm-2 control-label" for="date">EndDate</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="eventEndDate" name="eventEndDate" /> 
									</div>
								 </div>
								 <div class="form-group">
									<label  class="col-sm-2 control-label"></label>
									<div class="col-sm-2">
										<input type="submit" class="form-control btn btn-primary" name="submit" value="submit" / > 
									</div>
									<div class="col-sm-2">
										<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									</div>
								 </div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</body>
	</cfoutput>

	<script type="text/javascript">

		$(document).ready(function() {
				// var eventData = $('#eventsData').val();
				// var eventRes = JSON.parse(eventData);
				// console.log(eventRes.DATA);
			// page is now ready, initialize the calendar...
			$('#calendar').fullCalendar({
				// put your options and callbacks here
				header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay,listWeek'
				},
				height: 450,
				theme: true,
				navLinks: true, // can click day/week names to navigate views
				editable: true,
				eventLimit: true,
				events : <cfoutput>#allEvents#</cfoutput>,
				dayClick: function(date, jsEvent, view) {
					var day 	= date._d.getDate();
					var Month 	= date._d.getMonth()+1;
					var year 	= date._d.getFullYear()+" "+"00:00";
					var getDate = Month+"/"+day+"/"+year;

					$("#events").modal("show");
					$("#eventStartDate").val(getDate);
					// $("#eventStartDate").val("07/19/2017 2:03 PM");
					// $("#eventStartDate").datetimepicker("setDate", new Date(2017,5,10));
					$('#eventStartDate').data("DateTimePicker").date(new Date());

				},
				eventClick: function(calEvent, jsEvent, view){
					console.clear();
					console.log(calEvent);
					$("#events").modal("show");
                    $("#eventName").val(calEvent.title);
                    $("#description").val(calEvent.EVENT_DESC);
                    $("#eventStartDate").val(calEvent._start._i);
                    $("#eventEndDate").val(calEvent._end._i);
                    $('#events form').append('<input type="hidden" name="event_id" value='+calEvent.EVENT_ID+'>');
					// alert('Event: ' + calEvent.title);
					// alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
					// alert('View: ' + view.name);

					// change the border color just for fun
					// $(this).css('border-color', 'red');
					// var day 	= date._d.getDate();
					// var Month 	= date._d.getMonth()+1;
					// var year 	= date._d.getFullYear()+" "+"00:00";
					// var getDate = Month+"/"+day+"/"+year;

				 //    $("#events").modal("show");
				 //    $("#eventStartDate").val(getDate);
				}
			});
			// date time picker
			// $('#eventStartDate').datetimepicker();
			// $('#eventEndDate').datetimepicker({
			// 	useCurrent: false
			// });

			$('#eventStartDate,#eventEndDate').datetimepicker();
			// $('#eventStartDate').data("DateTimePicker").date(new Date());
			// $("#eventEndDate").on("dp.change", function (e) {
			//     $('#eventStartDate').data("DateTimePicker").maxDate(e.date);
			// });
			$("#eventStartDate").on("dp.change", function (e) {
				$('#eventEndDate').data("DateTimePicker").minDate(e.date);
			});
			// $('#eventStartDate').on('dp.change', function (e) {
			// 	var incrementDay = moment(new Date(e.date));
			// 	incrementDay.add(0, 'days');
			// 	$('#eventEndDate').data('DateTimePicker').minDate(incrementDay);
			// 	// $(this).data("DateTimePicker").hide();
			// });

			// $('#eventEndDate').datetimepicker().on('dp.change', function (e) {
			// 	var decrementDay = moment(new Date(e.date));
			// 	decrementDay.subtract(1, 'days');
			// 	$('#eventStartDate').data('DateTimePicker').maxDate(decrementDay);
			// 	 // $(this).data("DateTimePicker").hide();
			// });
		});

	</script>
</html>
document.addEventListener( "DOMContentLoaded" , function() {
	var calendarEl = document.getElementById( "calendar" );

	var calendar = new FullCalendar.Calendar( calendarEl, {
		plugins: [ "interaction", "dayGrid" ],
		defaultDate: "2019-08-12",
		editable: false,
		eventLimit: true, // allow "more" link when too many events

		eventTextColor: "#ffffff",
		eventBackgroundColor: "#50d8af",
		eventBorderColor: "#50d8af",

		buttonText: {
			today:    "Today",
			month:    "Month",
			week:     "Week",
			day:      "Day",
			list:     "List"
		},

		header: {
			left: "prevYear,prev,today,next,nextYear ", // will normally be on the left. if RTL, will be on the right
			center: "title",
			right: "dayGridWeek,dayGridMonth,dayGridDay"
		},

		eventSources:[
			"/events/samples",
			"/events/notifications",
			"/events/todos"
		],

		// https://fullcalendar.io/docs/dateClick
		dateClick: function(info) {
			showAddEditModal( "create", info );
		},

		// https://fullcalendar.io/docs/eventClick
		eventClick: function(info) {
			showAddEditModal( "edit", info );
		}
	});

	calendar.render();
});


function showAddEditModal( type, info ) {
	if( type == "create" ) {
		console.log( info );
		// alert("Clicked on: " + info.dateStr);
		// alert("Coordinates: " + info.jsEvent.pageX + "," + info.jsEvent.pageY);
		// alert("Current view: " + info.view.type);
		// // change the day's background color just for fun
		// info.dayEl.style.backgroundColor = "red";
	} else {
		console.log( info.event.id );
		// alert("Event: " + info.event.title);
		// alert("Coordinates: " + info.jsEvent.pageX + "," + info.jsEvent.pageY);
		// alert("Current view: " + info.view.type);
		// // change the day's background color just for fun
		// info.dayEl.style.backgroundColor = "green";
	}
	jQuery(".modal-title").html("Update password details");
	jQuery(".modal-body").html("temp");
	jQuery("#myModal").modal();
	return false;
}
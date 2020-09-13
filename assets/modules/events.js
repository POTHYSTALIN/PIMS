document.addEventListener( "DOMContentLoaded" , function() {
	var calendarEl = document.getElementById( "calendar" );

	var calendar = new FullCalendar.Calendar( calendarEl, {
		// , "momentPlugin"
		plugins: [ "interaction", "dayGrid" ],
		defaultDate: "2019-08-12",
		editable: false,
		eventLimit: true, // allow "more" link when too many events

		eventTextColor: "#ffffff",
		eventBackgroundColor: "#50d8af",
		eventBorderColor: "#50d8af",

		titleFormat: { // will produce something like "Tuesday, September 18, 2018"
			month: "long",
			year: "numeric"
			// day: "numeric",
			// weekday: "short"
		},

		// using momentPlugin
		// titleFormat: "dddd, MMMM D, YYYY",

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
			// "/events/samples",
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
		},
		eventRender: function( event ) {
			jQuery( event.el ).find( ".fc-content" ).append( "<i class='delete-event fas fa-times float-right cursor'></i>" );
			jQuery( event.el ).find( ".fc-content" ).find( ".delete-event" ).click( function() {
				// Show confirm delete modal
				alert( "Show confirm delete modal" );
				// $( "#calendar" ).fullCalendar( "removeEvents", event._id );
				return false;
			});
		}
	});

	calendar.render();
});


function showAddEditModal( type, info ) {
	let id = 0;
	let url = "/events/edit/";
	let appendURL = "";
	if( type == "create" ) {
		jQuery( ".modal-title" ).html( "Create a new Event" );
		appendURL += id + "/" + info.dateStr;
		console.log( info );
		// alert("Clicked on: " + info.dateStr);
		// alert("Coordinates: " + info.jsEvent.pageX + "," + info.jsEvent.pageY);
		// alert("Current view: " + info.view.type);
		// // change the day's background color just for fun
		// info.dayEl.style.backgroundColor = "red";
	} else {
		jQuery( ".modal-title" ).html( "Update Event" );
		id = info.event.id;
		appendURL += id;
		console.log( info.event.id );
		// alert("Event: " + info.event.title);
		// alert("Coordinates: " + info.jsEvent.pageX + "," + info.jsEvent.pageY);
		// alert("Current view: " + info.view.type);
		// // change the day's background color just for fun
		// info.dayEl.style.backgroundColor = "green";
	}

	url += appendURL;

	jQuery.get({
		url: url,
		success: function( res ) {
			// success function
			if( parseInt( id ) == 0 )
				jQuery( ".modal-title" ).html( "Create a new Event" );
			else
				jQuery( ".modal-title" ).html( "Update Event" );
			jQuery( ".modal-body" ).html( res );
			jQuery( "#myModal" ).modal();
		},
		error: function( err ) {
			console.clear();
			console.log( err.responseText );
			jQuery( ".modal-body" ).html( "Some error occurred!<br>" + err.responseText );
			jQuery( "#myModal" ).modal();
		}
	});
	return false;
}
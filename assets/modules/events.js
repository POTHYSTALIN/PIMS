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
		dateClick: function( info ) {
			showAddEditModal( "create", info );
		},

		// https://fullcalendar.io/docs/eventClick
		eventClick: function( info ) {
			showAddEditModal( "edit", info );
		},
		eventRender: function( info ) {
			jQuery( info.el ).find( ".fc-content" ).append( "<i class='delete-event fas fa-times float-right cursor'></i>" );
			jQuery( info.el ).find( ".fc-content" ).find( ".delete-event" ).click( function() {
				// Show confirm delete modal
				showDeleteConfirmModal( jQuery( info.el ), info.event.id );
				return false;
			});
		}
	});

	calendar.render();
});

function showDeleteConfirmModal(elem, id) {
	var confirmContent = "<p>Are you sure to delete this data?</p><div class='row'><div class='offset-9 col-sm-1 pr-0 pl-5 mr-3'><button type='button' class='btn btn-sm btn-danger' onclick='javascript: deleteEvent(" + id + ")'>Delete</button></div><div class='col-sm-1 p-0 ml-5'><button type='button' class='btn btn-sm btn-secondary' data-dismiss='modal'>Close</button></div></div>";
	jQuery(".modal-title").html("Confirm delete");
	jQuery(".modal-body").html(confirmContent);
	jQuery("#myModal").modal({
		backdrop: "static",
		keyboard: false
	});
}

function deleteEvent( id ) {
	$('#myModal').modal( "hide" );
	window.location.href = "/events/delete/" + id;
}

function showAddEditModal( type, info ) {
	let id = 0;
	let url = "/events/edit/";
	let appendURL = "";
	if( type == "create" ) {
		jQuery( ".modal-title" ).html( "Create a new Event" );
		appendURL += id + "/" + info.dateStr;
	} else {
		jQuery( ".modal-title" ).html( "Update Event" );
		id = info.event.id;
		appendURL += id;
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
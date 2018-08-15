jQuery(function(){
	window.addEventListener('load', function () {
		// At first, let's check if we have permission for notification
		// If not, let's ask for it
		if (window.Notification && Notification.permission !== "granted") {
			Notification.requestPermission(function (status) {
				if (Notification.permission !== status) {
					Notification.permission = status;
				}
			});
		}
	});
	setTimeout(function(){
		jQuery("div.alert").slideUp(1000);
	},10000);

	i = 0;
	// checkNotification();
	setInterval(function(){
		// This will call every one hour to check for a new event
		// checkNotification();
	},1*60000);
});

function checkNotification() {
	jQuery.post(
		"/list/notifications",
		function(res){
			// success function
			res = JSON.parse(res);
			(function setDelayForNotifications (i) {
				setTimeout(function () {
					showNotification(res[i].ID, res[i].NAME, res[i].DESC, res[i].SDATE, res[i].EDATE, res[i].TYPE);
					i++;
					if (i < res.length) setDelayForNotifications(i);
				}, 1000)
			})(0);
		}
	);
}

function showNotification(id, name, desc, sdate, edate, type){
	if (window.Notification && Notification.permission === "granted"){
		window["notifications" + i] = new Notification(
			name,
			{
				tag: 'soManyNotification' + i,
				data: 'I like peas.',

				// below are important
				body: desc,
				icon: '/assets/img/' + type + '.png'
			}
		);
		window["notifications" + i].onclick = function(event){
			event.preventDefault();
			alert("Test");
		}
		i++;
	}else if (window.Notification && Notification.permission !== "denied"){
		Notification.requestPermission(function (status) {
			// If the user said okay
			if (status === "granted") {
				var i = 0;
				// Using an interval cause some browsers (including Firefox) are blocking notifications if there are too much in a certain time.
				var interval = window.setInterval(function () {
					// Thanks to the tag, we should only see the "Hi! 9" notification 
					var n = new Notification("Hi! " + i, {tag: 'soManyNotification' + i, body: 'Do you like my body?'});
					if (i++ == 9) {
						window.clearInterval(interval);
					}
				}, 200);
			} else {
			// Otherwise, we can fallback to a regular modal alert
				alert("Permission denied");
			}
		});
	}else{
	}
}
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
	.fc-button-primary:hover, .fc-button-primary:not(:disabled).fc-button-active, .fc-button-primary:not(:disabled):active, .fc-button-primary:disabled {
		color: #FFFFFF;
		background-color: #50d8af;
		border-color: #50d8af;
	}
</style>
<cfoutput>
	<div style="min-height: 10px;">&nbsp;</div>
	<div id="calendar"></div>
</cfoutput>
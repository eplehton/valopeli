var subId = "";

$(document).ready( function() {
	
	$(".btn").click(
		function(ev) {
			var button = $(this);
			button.css("background", "-moz-linear-gradient(270deg, #ffffff 0%, #000000 100%)");
			button.css("background", "-webkit-gradient(linear, left top, left bottom, color-stop(0%, #ffffff), color-stop(100%, #000000))");
			button.css("background", "-webkit-linear-gradient(270deg, #ffffff 0%, #000000 100%)");
			button.css("background", "-o-linear-gradient(270deg, #ffffff 0%, #000000 100%");
			button.css("background", "-ms-linear-gradient(270deg, #ffffff 0%, #000000 100%)");
			button.css("background", "linear-gradient(180deg, #ffffff 0%, #000000 100%)");
			button.css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#000000',GradientType=0 )");			
		}
	)
	
	$("#taustakyselyNappi").click(
		function(ev) {
			var url = 'https://docs.google.com/forms/d/1fryttMmREd18KZa3LXhcvmHzTmN3Pf-R9SiMc0i_-Ls/viewform?entry.1578273402=' + subId + '&entry.813295141&entry.308946281';
			window.open(url);
		}
	)
	
	$("#flowKyselyNappi1").click(
		function(ev) {
			var url = '' + subId + '';
			window.open(url);
		}
	)
	
	$("#flowKyselyNappi2").click(
		function(ev) {
			var url = '' + subId + '';
			window.open(url);
		}
	)
	
	$("#flowKyselyNappi3").click(
		function(ev) {
			var url = '' + subId + '';
			window.open(url);
		}
	)
	
	function askSubId() {
		subId = prompt("KH ID", "");
		switch(subId) {
			case "":
				askSubId();
				break;
			default:
				break;
		}
	}
	
	askSubId();
})
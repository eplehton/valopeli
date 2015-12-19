var subId = "";
var group = "";

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
			// var url = 'https://docs.google.com/forms/d/1fryttMmREd18KZa3LXhcvmHzTmN3Pf-R9SiMc0i_-Ls/viewform?entry.1578273402=' + subId + '&entry.813295141&entry.308946281';
			var url = 'https://docs.google.com/forms/d/1HPEvajWXUSsk2vxaGWVhqqb-TgxcPPo4bPn_tY7dT3M/viewform?entry.420552715=' + subId + '&entry.1875584432&entry.357050892';
			window.open(url);
		}
	)
	
	$("#flowKyselyNappi1").click(
		function(ev) {
			var url = 'https://docs.google.com/forms/d/1gVjC6nUBwu25tyuFJkXAq2NSL-iBkPD30GWPw-OTwDw/viewform?entry.1626504697=' + subId + '&entry.940710790=' + group + '&entry.659074400=' + '1';
			window.open(url);
		}
	)
	
	$("#flowKyselyNappi2").click(
		function(ev) {
			var url = 'https://docs.google.com/forms/d/1gVjC6nUBwu25tyuFJkXAq2NSL-iBkPD30GWPw-OTwDw/viewform?entry.1626504697=' + subId + '&entry.940710790=' + group + '&entry.659074400=' + '2';
			window.open(url);
		}
	)
	
	$("#flowKyselyNappi3").click(
		function(ev) {
			var url = 'https://docs.google.com/forms/d/1gVjC6nUBwu25tyuFJkXAq2NSL-iBkPD30GWPw-OTwDw/viewform?entry.1626504697=' + subId + '&entry.940710790=' + group + '&entry.659074400=' + '3';
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
			askGroup();
				break;
		}
	}
	
		function askGroup() {
		group = prompt("Ryhma", "");
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
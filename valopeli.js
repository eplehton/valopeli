var reds = [];
var nextPress = 0;
var testResults = [];
var stopGame = false;

function game(isStaticGame, flashRedsintervals) {
	
	
	for (var i=0; i<500; i++) {
		
		var x = Math.floor(Math.random() * (10-1) + 1);
		if (reds.length == 0) {
			reds.push(x); 
		} else {
			while (reds[ reds.length-1 ] == x) {
				x = Math.floor(Math.random() * (10-1) + 1)
			}
			reds.push(x);
		}
	}
	
	function flashReds(position) {
		if (stopGame == false) {
			var cellId = "#cellCircle" + reds[position];
			var randomNumber = Math.floor(Math.random() * (60));
			if(position > 0) {
				switchColorGray("#cellCircle" + reds[position - 1]);
			}
			
			switchColorRed(cellId);
			
			if (position < reds.length - 1) {
				setTimeout( function() { flashReds(position+1); }, flashRedsintervals);
				if (randomNumber < 3) {
					flashBlue(position);
				}
				if (randomNumber == 4) {
					flashDistractor(position);
				}
			}
			
			if(isStaticGame == false) {
				if (flashRedsintervals < 200) {
					flashRedsintervals--;
				} else {
					flashRedsintervals -= 2;
				}			
			}
		} else {
			testResults.push(flashRedsintervals);
		}
	}
	
	function flashBlue(position) {
		var nextCellId = "#cellCircle" + reds[position + 1];
		switchColorBlue(nextCellId);
	}
	
	function flashDistractor(position) {
		var rNumber = Math.floor(Math.random() * (10-1) + 1);
		console.log(rNumber);
		if(rNumber != position) {
			switchColorGreen("#cellCircle" + rNumber);
			setTimeout(function() {switchColorGray("#cellCircle" + rNumber);}, flashRedsintervals - 1);
		} else {
			flashDistractor(position);
		}
	}
	
	flashReds(0);
}


function switchColorRed(id) {
	var circle = $(id);
	circle.css("background", "-moz-radial-gradient(center, ellipse cover, #ff0000 0%, #ff0000 40%, #000000 100%)");
	circle.css("background", "-webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(0%, #ff0000), color-stop(40%, #ff0000), color-stop(100%, #000000))");
	circle.css("background", "-webkit-radial-gradient(center, ellipse cover, #ff0000 0%, #ff0000 40%, #000000 100%)");
	circle.css("background", "-o-radial-gradient(center, ellipse cover, #ff0000 0%, #ff0000 40%, #000000 100%)");
	circle.css("background", "-ms-radial-gradient(center, ellipse cover, #ff0000 0%, #ff0000 40%, #000000 100%)");
	circle.css("background", "radial-gradient(ellipse at center, #ff0000 0%, #ff0000 40%, #000000 100%)");
	circle.css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='#ff0000', endColorstr='#000000',GradientType=1 )");
}

function switchColorGray(id) {
	var circle = $(id);
	circle.css("background", "-moz-radial-gradient(center, ellipse cover, #ffffff 0%, #000000 100%)");
	circle.css("background", "-webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(0%, #ffffff), color-stop(100%, #000000))");
	circle.css("background", "-webkit-radial-gradient(center, ellipse cover, #ffffff 0%, #000000 100%)");
	circle.css("background", "-o-radial-gradient(center, ellipse cover, #ffffff 0%, #000000 100%)");
	circle.css("background", "-ms-radial-gradient(center, ellipse cover, #ffffff 0%, #000000 100%)");
	circle.css("background", "radial-gradient(ellipse at center, #ffffff 0%, #000000 100%)");
	circle.css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#000000',GradientType=1 )");
}

function switchColorBlue(id) {
	var circle = $(id);
	circle.css("background", "-moz-radial-gradient(center, ellipse cover, #0000ff 0%, #0000ff 40%, #000000 100%)");
	circle.css("background", "-webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(0%, #0000ff), color-stop(40%, #0000ff), color-stop(100%, #000000))");
	circle.css("background", "-webkit-radial-gradient(center, ellipse cover, #0000ff 0%, #0000ff 40%, #000000 100%)");
	circle.css("background", "-o-radial-gradient(center, ellipse cover, #0000ff 0%, #0000ff 40%, #000000 100%)");
	circle.css("background", "-ms-radial-gradient(center, ellipse cover, #0000ff 0%, #0000ff 40%, #000000 100%)");
	circle.css("background", "radial-gradient(ellipse at center, #0000ff 0%, #0000ff 40%, #000000 100%)");
	circle.css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='#0000ff', endColorstr='#000000',GradientType=1 )");
}

function switchColorGreen(id) {
	var circle = $(id);
	circle.css("background", "-moz-radial-gradient(center, ellipse cover, #00FF00 0%, #00FF00 40%, #000000 100%)");
	circle.css("background", "-webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(0%, #00FF00), color-stop(40%, #00FF00), color-stop(100%, #000000))");
	circle.css("background", "-webkit-radial-gradient(center, ellipse cover, #00FF00 0%, #00FF00 40%, #000000 100%)");
	circle.css("background", "-o-radial-gradient(center, ellipse cover, #00FF00 0%, #00FF00 40%, #000000 100%)");
	circle.css("background", "-ms-radial-gradient(center, ellipse cover, #00FF00 0%, #00FF00 40%, #000000 100%)");
	circle.css("background", "radial-gradient(ellipse at center, #00FF00 0%, #00FF00 40%, #000000 100%)");
	circle.css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='#00FF00', endColorstr='#000000',GradientType=1 )");
}

$(document).ready( function() {
	
	$("#pietimerArea").pietimer({
	    seconds: 3,
		color: 'rgba(0, 0, 0, 0.8)',
		height: 500,
		width: 500	
	}, function(){
		$("#pietimerArea").css("z-index", "-1");
		game(false, 500);
	});
	
	$("#gametable").find("td").click(
		function(ev) { 
			if (ev.target.id != "cell" + reds[nextPress]) {
				//location.reload();
			}
			//nextPress++;
		}
	);
	
	$("#gametable").find("div").click(
		function(ev) {
			if (ev.target.id != "cellCircle" + reds[nextPress]) {
				stopGame = true;
			}
			nextPress++;
		}
	)
	
	$("startButton").click(
		function(ev) {
			console.log("sfhso");
		}
	);
	
	$("#pietimerArea").pietimer("start");
});

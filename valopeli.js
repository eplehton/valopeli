var reds = [];
var nextPress = 0;

function disco() {

	var flashRedsintervals = 2000;
	
	for (var i=0; i<500; i++) {
		
		var x = Math.floor(Math.random() * (10-1) + 1);
		if (reds.length == 0) {
			reds.push(x); 
		} else {
			while (reds[ reds.length-1 ] == x) {
				x = Math.floor(Math.random() * (9-1) + 1)
			}
			reds.push(x);
		}
	}
	
	function flashReds(position) {
		var cellId = "cellButton" + reds[position];
		var randomNumber = Math.floor(Math.random() * (60));
		if(position > 0) {
			switchImageColor("cellButton" + reds[position - 1], "gray");
		}
		
		switchImageColor(cellId, "red");
		
		if (position < reds.length - 1) {
			setTimeout( function() { flashReds(position+1); }, flashRedsintervals );
			if (randomNumber < 3) {
				flashBlue(position);
			}
			if (randomNumber == 4) {
				flashDistractor(position, "green");
			}
		}
		
		if (flashRedsintervals < 200) {
			flashRedsintervals--;
		} else {
			flashRedsintervals -= 2;
		}
	}
	
	function flashBlue(position) {
		var nextCellId = "cellButton" + reds[position + 1];
		switchImageColor(nextCellId, "blue");
	}
	
	function flashDistractor(position, color) {
		var rNumber = Math.floor(Math.random() * (9-1) + 1);
		console.log(rNumber);
		if(rNumber != position) {
			switchImageColor("cellButton" + rNumber, "green");
			setTimeout(function() {switchImageColor("cellButton" + rNumber, "gray");}, flashRedsintervals);
		} else {
			flashDistractor(position, "green");
		}
	}
	
	flashReds(0);
}

function switchCellColor(cellId, color) {
    var e = document.getElementById(cellId);
	e.style.backgroundColor = color;
}

function switchImageColor(cellButtonId, color) {
	document.getElementById(cellButtonId).src="images/button_" + color + ".png";
}
$(document).ready( function() {
	
	$("#pietimerArea").pietimer({
	    seconds: 3,
		color: 'rgba(0, 0, 0, 0.8)',
		height: 500,
		width: 500	
	}, function(){
		disco();
	});
	
	$("#gametable").find("td").click(
		function(ev) { 
			if (ev.target.id != "cell" + reds[nextPress]) {
				//location.reload();
			}
			//nextPress++;
		}
	);
	
	$("#gametable").find("img").click(
		function(ev) {
			if (ev.target.id != "cellButton" + reds[nextPress]) {
				location.reload();
			}
			nextPress++;
		}
	)
	
	$("startButton").click(
		function(ev) {
			console.log("sfhso");
			disco();
		}
	);
	
	$("#pietimerArea").pietimer("start");
});

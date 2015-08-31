
function disco() {

	var reds = [];
	var flashRedsintervals = 500;
	
	for (var i=0; i<500; i++) {
		
		var x = Math.floor(Math.random() * (10-1) + 1);
		if (reds.length == 0) {
			reds.push(x); 
		} else {
			while (reds[ reds.length-1 ] == x) {
				console.log(x);
				x = Math.floor(Math.random() * (9-1) + 1)
			}
			reds.push(x);
		}
	}
	
	console.log(reds);
	
	function flashReds(position) {
		var cellId = "cell" + reds[position];
		var randomNumber = Math.floor(Math.random() * (60));
		if(position > 0) {
			switchColor("cell" + reds[position - 1], "white")
		}
		
		switchColor(cellId, "red");
		
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
		var nextCellId = "cell" + reds[position + 1];
		switchColor(nextCellId, "blue");
	}
	
	function flashDistractor(position, color) {
		var rNumber = Math.floor(Math.random() * (9-1) + 1);
		console.log(rNumber);
		if(rNumber != position) {
			switchColor("cell" + rNumber, "green");
			setTimeout(function() {switchColor("cell" + rNumber, "white");}, flashRedsintervals);
		} else {
			flashDistractor(position, "green");
		}
	}
	
	flashReds(0);
}

function switchColor(cellId, color) {
    var e = document.getElementById(cellId);
	e.style.backgroundColor = color;
}


$(document).ready( function() {

	$("#gametable").find("td").click( 
		function(ev) { 
			console.log(ev.target.id);
			console.log(reds[position]);
			if (ev.target.id != "cell" + reds[position]) {
				console.log(ev.target.id);
			}
		}
	);
	
	disco();	

});
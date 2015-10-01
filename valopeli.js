var reds = [];
var nextPress = 0;
var testResults = [];
var stopGame = false;
var stopCycle = false;
var numberOfTestGames = 3;
var gameInterval = 500;
var difficultyChange = 0;
var isStaticGame = false;
var lastInterval = gameInterval;
var blop = new Audio("sounds/blop.mp3");
var errorSound = new Audio("sounds/error.mp3");
var presses = [];
var rounds = [];
var pressID = 0;
var round = 0;
var redsPosition = -1;
var currentRed = -1;
var roundStartTime = 0;
var date = new Date();
var subId;
var cycleId;
var groupId;
var isGameTimeSet = false;

function game(isStaticGame, flashRedsintervals) {
	
	reds = []
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
			currentRed = "#cellCircle" + reds[position];
			var randomNumber = Math.floor(Math.random() * (100));
			
			switchColorRed(currentRed);
			
			if (position < reds.length - 1) {
				redsPosition++;
				setTimeout( function() { switchColorGray(currentRed); }, flashRedsintervals);
				setTimeout( function() { flashReds(position+1); }, flashRedsintervals);
				if (randomNumber < 25) {
					flashBlue(reds[position + 1]);
				}
				if (randomNumber > 75) {
					flashDistractor(reds[position]);
				}
			}
			
			if(isStaticGame == false) {
				flashRedsintervals = changeInterval(flashRedsintervals);			
			}
		}
	}
	
	function flashBlue(nextCirclePosition) {
		var nextcurrentRed = "#cellCircle" + nextCirclePosition;
		switchColorBlue(nextcurrentRed);
		setTimeout( function() { 
			switchColorGray(nextcurrentRed); 
		}, flashRedsintervals - 10);
	}
	
	function flashDistractor(circlePosition) {
		var rNumber = Math.floor(Math.random() * (10-1) + 1);
		if(rNumber != circlePosition) {
			switchColorGreen("#cellCircle" + rNumber);
			setTimeout(function() {
				switchColorGray("#cellCircle" + rNumber);
			}, flashRedsintervals - 10);
		}
	}

	flashReds(0);
}

function changeInterval(interval) {
	if (interval < 200) {
		return interval -= 1;
	} else if (interval < 500){
		return interval -= 2;
	} else {
		return interval -= 5;
	}
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

function average(array) {
	var sum = 0;
	for(var i = 0; i < array.length; i++) {
		sum += array[i];
	}
	return parseInt(sum/array.length);
} 

function pushPressData(ev, presstype) {
	press = {
		pressId : pressID, 
		buttonId : ev.target.id,
		presstype : presstype,
		Xcor : ev.pageX, 
		Ycor : ev.pageY, 
		behindCurrentRed : redsPosition - pressID,
		pressTime : date.getTime() - roundStartTime
	}
	presses.push(press);
}

function pushRoundData(isStatic) {
	round = {
		isStatic : isStatic,
		roundNumber : round,
		finalInterval : lastInterval, 
		presses : presses, 
		duration : date.getTime() - roundStartTime
	}
	rounds.push(round);
}

function saveCycleData() {
	cycleData = {
		cycleId : cycleId,
		subId : subId,
		group : groupId,
		rounds : rounds,		
	}
	localStorage.setItem(subId+" C" + cycleId, JSON.stringify(cycleData));
}

function clearCycle() {
	stopGame = true;
	stopCycle = true;
	isStaticGame = false;
	cycleData = [];
	rounds = [];
	round = 0;
	nextPress = 0;
	numberOfTestGames = 3;
	gameInterval = 500;
	lastInterval = 500;
	isGameTimeSet = false;
}

$(document).ready( function() {
	
	$("#pietimerArea").pietimer({
	    seconds: 3,
		color: 'rgba(0, 0, 0, 0.8)',
		height: 500,
		width: 500	
	}, function(){
		if (stopCycle == false) {
			round++;
			presses = [];
			pressId = 0;
			
			$("#pietimerArea").css("z-index", "-1");
			$("#mask").css("z-index", "-1");
			stopGame = false;
			roundStartTime = date.getTime;
			game(isStaticGame, gameInterval);			
		}
	});
	
	$(".circle").click(
		function(ev) {
			pressData = [];
			pressID++;
			if (ev.target.id == "cellCircle" + reds[nextPress - 1]){
				pushPressData(ev, "doubleclick");
			} else if (ev.target.id != "cellCircle" + reds[nextPress]) {
				pushPressData(ev, "miss");
				nextPress = 0;
				stopGame = true;
				pushRoundData(isStaticGame);
				errorSound.play();
				$("#pietimerArea").css("z-index", "1");
				$("#mask").css("z-index", "1");
				
				stopGame = true;
				if (numberOfTestGames > 1) {
					testResults.push(lastInterval);
					console.log(lastInterval);
					lastInterval = gameInterval;
					console.log("uusi nopeutuva peli");
					$("#pietimerArea").pietimer("start");
				} else {
					if (isStaticGame == false) {
						testResults.push(lastInterval);
					}
					console.log(testResults);
					console.log("uusi tasainen peli");
					isStaticGame = true;
					
					if(groupId == 1) {
						gameInterval = average(testResults);
					} else if (groupId == 2) {
						gameInterval = average(testResults) - 25;
					} else if (groupId == 3) {
						gameInterval = average(testResults) - 50;
					}
					
					console.log(gameInterval);
					
					if (isGameTimeSet == false) {
						isGameTimeSet = true;
						setTimeout( function() {
								saveCycleData();
								clearCycle();
								askcycleId();
						}, 1*60000);						
					}

					$("#pietimerArea").pietimer("start");
				}
				numberOfTestGames--;
			} else {
				blop.play();
				pushPressData(ev, "hit");
				lastInterval = changeInterval(lastInterval);
				nextPress++;
			}
		}
	)
	
	$("#startbutton").click(
		function(ev) {
			$("#startbutton").css("z-index", "-2");
			$("#pietimerArea").css("z-index", "1");
			$("#pietimerArea").pietimer("start");
		}		
	)
	
	function askcycleId() {
		cycleId = prompt("Monesko pelikierros?", "");
		switch(cycleId) {
			case "":
				askcycleId();
				break;
			default:
				stopCycle = false;
				$("#startbutton").css("z-index", "2");
				break;
		}
	}
	
	function askgroupId() {
		groupId = prompt("Ryhmä", "");
		switch(groupId) {
			case "1":
				askcycleId();
				break;
			case "2":
				askcycleId();
				break;
			case "3":
				askcycleId();	
				break;
			default:	
				askgroupId();
				break;	
		}
	}
	
	function askSubId() {
		subId = prompt("KH ID", "");
		switch(subId) {
			case "":
				askSubId();
				break;
			default:
				askgroupId();
				break;
		}
	}
	
	askSubId();
});

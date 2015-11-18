var reds = [];
var nextPress = 0;
var testResults = [];
var stopGame = false;
var stopRound = false;
var numberOfTestGames = 3;
var gameInterval = 0;
var testGameStartInterval = 500;
var lastInterval = testGameStartInterval;
var difficultyChange = 0;
var numberOfRedsFlashed = 0;
var numberOfRightPresses = 0;
var isStaticGame = false;
var blop = new Audio("sounds/blop.mp3");
var errorSound = new Audio("sounds/error.mp3");
var fanfare = new Audio("sounds/fanfare.mp3");
var presses = [];
var games = [];
var pressID = 0;
var gameId = 0;
var redsPosition = -1;
var currentRed = -1;
var gameStartTime = 0;
var roundStartTime = 0;
var date = new Date();
var subId;
var roundId;
var groupId;
var isGameTimeSet = false;
var changeRound = false;
var gameSuccess = [];
var isFirstStaticGame = true;
var previousIntervalChange;

function startGame(isStaticGame, flashRedsintervals) {
	
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
			numberOfRedsFlashed += 1;
			
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
	return sum/array.length;
} 

function pushPressData(ev, presstype) {
	press = {
		pressId : pressID, 
		buttonId : ev.target.id,
		presstype : presstype,
		Xcor : ev.pageX, 
		Ycor : ev.pageY, 
		behindCurrentRed : numberOfRedsFlashed - numberOfRightPresses,
		pressTime : (new Date()).getTime() - gameStartTime
	}
	presses.push(press);
}

function pushGameData(isStatic, success) {
	game = {
		isStatic : isStatic,
		successInStatic : success,
		gameNumber : gameId,
		finalInterval : lastInterval,
		gameInterval : gameInterval,
		previousIntervalChange : previousIntervalChange,
		duration : (new Date()).getTime() - gameStartTime,
		presses : presses
	}
	games.push(game);
}

function saveRoundData() {
	roundData = {
		roundId : roundId,
		subId : subId,
		group : groupId,
		duration : (new Date()).getTime() - roundStartTime,
		games : games		
	}
	localStorage.setItem(subId+"R" + roundId, JSON.stringify(roundData));
}

function clearRound() {
	stopGame = true;
	stopRound = true;
	isStaticGame = false;
	roundData = [];
	games = [];
	testResults = [];
	gameId = 0;
	nextPress = 0;
	numberOfTestGames = 3;
	lastInterval = 500;
	isGameTimeSet = false;
	changeRound = false;
	isFirstStaticGame = true;
}

function adaptInteval(amountOfOutcomes, previousInterval, epsilon) {
	console.log("peli suoritukset: " + gameSuccess);
	var outcomes = [];
	if(gameSuccess.length > amountOfOutcomes) {
		outcomes = gameSuccess.slice(-1*amountOfOutcomes);
	} else {
		outcomes = gameSuccess;
	}
	var weightedOutcomes = weight(outcomes);
	console.log("painotetut outcomit: " + weightedOutcomes);
	var delta = average(weightedOutcomes);
	console.log("delta: " + delta + " muutos: " + epsilon*delta);
	console.log("uusi intervalli: " + (previousInterval + epsilon * delta));
	previousIntervalChange = epsilon * delta;
	return previousInterval + epsilon * delta;
}

function weight(array) {
	weightedArray = []
	for (var i = 0; i < array.length; i++) {
		var weight = (i + 1) / array.length;
		console.log("painokerroin: " + weight + " painotettava arvo: " + array[i] + " target arvo: " + getGroupsTargetP());
		weightedArray.push(weight * (getGroupsTargetP() - array[i]))
	}
	return weightedArray;
}

function getGroupsTargetP() {
	if (groupId == 1) {
		return 0.20;
	} else if (groupId == 2) {
		return 0.5;
	} else if (groupId == 3) {
		return 0.95;
	}
}

$(document).ready( function() {
	
	$("#pietimerArea").pietimer({
	    seconds: 3,
		color: 'rgba(0, 0, 0, 0.8)',
		height: 500,
		width: 500	
	}, function(){
		if (stopRound == false) {
			gameId++;
			presses = [];
			pressId = 0;
			
			$("#pietimerArea").css("z-index", "-1");
			$("#mask").css("z-index", "-1");
			stopGame = false;
			gameStartTime = (new Date()).getTime();
			numberOfRedsFlashed = 0;
			numberOfRightPresses = 0;
			if (isStaticGame) {
				startGameTimer(10, 625);
				startGame(isStaticGame, gameInterval);
			} else {
				startGame(isStaticGame, testGameStartInterval);
			}	
		}
	});
	
	$(".circle").mousedown(
		function(ev) {
			pressData = [];
			pressID++;
			if (ev.target.id == "cellCircle" + reds[nextPress - 1]){
				pushPressData(ev, "doubleclick");
			} else if (ev.target.id != "cellCircle" + reds[nextPress]) {
				pushPressData(ev, "miss");
				errorSound.play();
				endGame(false);
				if (isStaticGame == true) {
					gameSuccess.push(0);
				}
				if (numberOfTestGames > 1) {
					newTestGame();
				} else {
					if (changeRound == true) {
						startNewRound();
						return;
					} else {
						$("#gameTimer").css("z-index", "0");
						newStaticGame();
						if (isGameTimeSet == false) {
							isGameTimeSet = true;
							setTimeout( function() {
								changeRound = true;
								console.log("lastGame!");
							}, 4*60000);						
						}					
					}
				}
				numberOfTestGames--;
			} else {
				numberOfRightPresses += 1;
				blop.play();
				pushPressData(ev, "hit");
				lastInterval = changeInterval(lastInterval);
				nextPress++;
			}
		}
	)
	
	function endGame(staticGameSuccess) {
		nextPress = 0;
		stopGame = true;
		pushGameData(isStaticGame, staticGameSuccess);
		$("#pietimerArea").css("z-index", "1");
		$("#mask").css("z-index", "1");
	}
	
	function newTestGame() {
		testResults.push(lastInterval);
		console.log(lastInterval);
		lastInterval = testGameStartInterval;
		console.log("uusi nopeutuva peli");
		$("#pietimerArea").pietimer("start");
	}
	
	function newStaticGame() {
		if (isStaticGame == false) {
			testResults.push(lastInterval);
			console.log(testResults);
		}
		console.log("uusi tasainen peli");
		isStaticGame = true;
		
		if(isFirstStaticGame && roundId == 1) {
			if (groupId == 1) {
				gameInterval = parseInt(average(testResults) - 20);
			} else if (groupId == 2) {
				gameInterval = parseInt(average(testResults) + 20);
			} else {
				gameInterval = parseInt(average(testResults) + 40);
			}
		} else {
			gameInterval = parseInt(adaptInteval(10, gameInterval, 50));
		}
		isFirstStaticGame = false;
		console.log(gameInterval);
		$("#pietimerArea").pietimer("start");
	}
	
	function startGameTimer(sec, currentSize) {
		if (stopGame == false) {
			if (currentSize - 1 >= 0) {
				$("#gameTimer").css("width", currentSize - 1 + "px");
				setTimeout(function() { startGameTimer(sec, currentSize - 1); }, (sec*1000) / 625);
			} else {
				waitForRightAmountOfPresses(numberOfRedsFlashed);
			}			
		}
	}
	
	function waitForRightAmountOfPresses(amountOfPressesNeeded) {
		if (stopGame == false) {
			if(numberOfRightPresses >= amountOfPressesNeeded) {
				fanfare.play();
				gameSuccess.push(1);
				endGame(true);
				if (changeRound == true) {
					startNewRound();
				} else {
					newStaticGame();
				}
			} else {
				setTimeout(function() { waitForRightAmountOfPresses(amountOfPressesNeeded); }, 5);
			}			
		}
	}
	
	function startNewRound() {
		saveRoundData();
		clearRound();
		$("#gameTimer").css("z-index", "-2");
		roundId++;
		$("#startbutton").css("z-index", "2");
	}
	
	$("#startbutton").click(
		function(ev) {
			stopRound = false;
			$("#startbutton").css("z-index", "-2");
			$("#pietimerArea").css("z-index", "1");
			roundStartTime = (new Date()).getTime();
			$("#pietimerArea").pietimer("start");
		}		
	)
	
	function askRoundId() {
		roundId = prompt("Monesko pelikierros?", "");
		switch(roundId) {
			case "":
				askRoundId();
				break;
			default:
				$("#startbutton").css("z-index", "2");
				break;
		}
	}
	
	function askgroupId() {
		groupId = prompt("Ryhmä", "");
		switch(groupId) {
			case "1":
				askRoundId();
				break;
			case "2":
				askRoundId();
				break;
			case "3":
				askRoundId();	
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
	
    $("#savebutton").click( function() {
        
        var key = prompt("Anna datan avain");
        var data = localStorage.getItem(key);
        
        var blob = new Blob([data], {type : "text/plain;charset=utf-8"});
        saveAs(blob, "valopeli_tulokset_" + key +".json");
        
    });
    
	askSubId();
});

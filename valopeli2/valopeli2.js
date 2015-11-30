{//variables
var reds = [];
var nextPress = 0;
var stopGame = false;
var stopRound = false;
var numberOfTestGamesPlayed = 0;
var gameInterval = 0;
var difficultyChange = 0;
var numberOfRedsFlashed = 0;
var numberOfRightPresses = 0;
var blop = new Audio("sounds/blop.mp3");
var errorSound = new Audio("sounds/error.mp3");
var fanfare = new Audio("sounds/fanfare.mp3");
var presses = [];
var games = [];
var rounds = [];
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
var adaptiveGameSuccess = [];
var previousIntervalChange = 0;
var experimentStartTime;
var isExperimentStarted = false;
var isTestGame = true;
var numberOfTestsPlayed = 0;
var numberOfAdaptedPlayed = 0;
var testGameIntervals = [];
var testId = 1;
var previousInterval = 400;
var pressesToSuccess;
}


{//html independed

{//asking prompts

	function askRoundId() {
		roundId = prompt("Monesko pelikierros?", "");
		switch(roundId) {
			case "":
				askRoundId();
				break;
			default:
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
	}

//Game loop
function startGame(flashRedsintervals) {
	
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
				if (randomNumber < 80) {
					flashBlue(reds[position + 1]);
				}
				if (randomNumber >= 80) {
					flashDistractor(reds[position]);
				}
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

{//color switchers

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
}

{//interval Handlers

function generateTestIntervals() {
	testGameIntervals.push(450);
	testGameIntervals.push(450);
	testGameIntervals.push(450);
	testGameIntervals.push(375);
	testGameIntervals.push(375);
	testGameIntervals.push(375);
	testGameIntervals.push(300);	
	testGameIntervals.push(300);
	testGameIntervals.push(300);
//	var a = 0;
//	var b = 0;
//	var c = 0;
//	while (testGameIntervals.length < 9) {
//		var randomNumber = Math.floor(Math.random() * (3));
//		if (randomNumber == 0 && a < 3) {
//			testGameIntervals.push(450);
//		} else if (randomNumber == 1 && b < 3) {
//			testGameIntervals.push(375);
//		} else if (randomNumber == 2 && c < 3) {
//			testGameIntervals.push(300);
//		}
	}
}

function adaptInteval(amountOfOutcomes, epsilon) {
	console.log("peli suoritukset: " + adaptiveGameSuccess);
	var outcomes = [];
	if(adaptiveGameSuccess.length > amountOfOutcomes) {
		outcomes = adaptiveGameSuccess.slice(-1*amountOfOutcomes);
	} else {
		outcomes = adaptiveGameSuccess;
	}
	var weightedOutcomes = weight(outcomes);
	console.log("painotetut outcomit: " + weightedOutcomes);
	var delta = average(weightedOutcomes);
	console.log("delta: " + delta + " muutos: " + epsilon*delta);
	console.log("uusi intervalli: " + (previousInterval + epsilon * delta));
	previousIntervalChange = epsilon * delta;
	previousInterval = previousInterval + epsilon * delta
	return previousInterval;
}
}

{//saving and clearing

function clearRound() {
	stopGame = true;
	stopRound = true;
	isStaticGame = false;
	roundData = [];
	games = [];
	testResults = [];
	nextPress = 0;
	numberOfTestGamesPlayed = 0;
	lastInterval = 500;
	isGameTimeSet = false;
	changeRound = false;
	isFirstStaticGame = true;
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

function pushGameData(isTestGame, success) {
	game = {
		isTestGame : isTestGame,
		successInStatic : success,
		gameNumber : gameId,
		gameInterval : gameInterval,
		previousIntervalChange : previousIntervalChange,
		pressesToSuccess : pressesToSuccess,
		duration : (new Date()).getTime() - gameStartTime,
		presses : presses
	}
	games.push(game);
}

function saveRoundData(isTest) {
	roundData = {
		roundId : roundId,
		isTestGame : isTest,
		group : groupId,
		duration : (new Date()).getTime() - roundStartTime,
		games : games		
	}
	rounds.push(roundData);
	if (isTest == true) {
		localStorage.setItem(subId+"T" + roundId, JSON.stringify(roundData));
	} else {
		localStorage.setItem(subId+"R" + roundId, JSON.stringify(roundData));
	}
	
}

function saveSubData() {
	subData = {
		subId : subId,
		experimentStartTime : experimentStartTime,
		experimentDuration : new Date() - experimentStartTime,
		rounds : rounds
	}
	localStorage.setItem(subId, JSON.stringify(subData));
}

}

{//Tools
function average(array) {
	var sum = 0;
	for(var i = 0; i < array.length; i++) {
		sum += array[i];
	}
	return sum/array.length;
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
}

$(document).ready( function() {

{//Buttons 

    $("#savebutton").click( function() {
        var key = prompt("Anna datan avain");
        var data = localStorage.getItem(key);
        var blob = new Blob([data], {type : "text/plain;charset=utf-8"});
        saveAs(blob, "tulokset_" + key +".json");
    });
	
	$("#startbutton").click(
		function(ev) {
			setTimeout( function() {
						changeRound = true;
						console.log("lastGame!");
						numberOfAdaptedPlayed += 1;
			}, 3*60000);
			startNewGame();
		}		
	)
	
	$("#testbutton").click(
		function(ev) {
			if (isExperimentStarted == false) {
				experimentStartTime = new Date();
			}
			isExperimentStarted = true;
			generateTestIntervals();
			console.log("test intervals:" + testGameIntervals);
			gameInterval = testGameIntervals[testId - 1];
			startNewGame();
		}		
	)
}

{//Single Game functions

//Start new game

	function startNewGame() {
		putButtonsBack();
		stopRound = false;
		roundStartTime = (new Date()).getTime();
		$("#pietimerArea").pietimer("start");
	}
	
// Starting the game with a timer

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
			if (isTestGame) {
				gameInterval = testGameIntervals[numberOfTestGamesPlayed];
				console.log("uusi testi");
			} else {
				console.log("uusi harkka");
				if (adaptiveGameSuccess.length > 0) {
					gameInterval = adaptInteval(15, 50);
				} else {
					gameInterval = previousInterval;
				}
			}
			console.log("gameinterval: " + gameInterval);
			$("#gameTimer").css("z-index", "0");
			startGameTimer(10, 625);
			startGame(gameInterval);
		}
	});
	
//Click handler

	$(".circle").mousedown(
		function(ev) {
			pressData = [];
			pressID++;
			if (ev.target.id == "cellCircle" + reds[nextPress - 1]){//douple click handler
				pushPressData(ev, "doubleclick");
			} else if (ev.target.id != "cellCircle" + reds[nextPress]) {//miss handler
				pushPressData(ev, "miss");
				errorSound.play();
				pressesToSuccess = numberOfRedsFlashed - numberOfRightPresses;
				endGame(false);
			} else {//right click handler
				numberOfRightPresses += 1;
				blop.play();
				pushPressData(ev, "hit");
				nextPress++;
			}
		}
	)
	
//Game timer

	function startGameTimer(sec, currentSize) {
		if (stopGame == false) {
			if (currentSize - 1 >= 0) {
				$("#gameTimer").css("width", currentSize - 1 + "px");
				setTimeout(function() 
					{ startGameTimer(sec, currentSize - 1);}
					
					, (sec*1000) / 625);
			} else {
				waitForRightAmountOfPresses(numberOfRedsFlashed);
			}			
		}
	}
	
	function waitForRightAmountOfPresses(amountOfPressesNeeded) {
		if (stopGame == false) {
			if(numberOfRightPresses >= amountOfPressesNeeded) {
				fanfare.play();
				adaptiveGameSuccess.push(1);
				endGame(true);
			} else {
				setTimeout(function() { waitForRightAmountOfPresses(amountOfPressesNeeded); }, 5);
			}			
		}
	}
	
//End game

	function endGame(gameSuccess) {
		nextPress = 0;
		stopGame = true;
		pushGameData(isTestGame, gameSuccess);
		$("#pietimerArea").css("z-index", "1");
		$("#mask").css("z-index", "1");		
		
		if (isTestGame == true) {
			numberOfTestGamesPlayed++;
			console.log("test games played " + numberOfTestGamesPlayed);
			if (numberOfTestGamesPlayed < 9) {
				startNewGame();
			} else {
				console.log("testi loppui");
				numberOfTestsPlayed++;
				endRound();
			}
		} else {
			adaptiveGameSuccess.push(0);
			if (changeRound == true) {
				endRound();
			} else {
				startNewGame();
			}		
		}
	}
}

//Round functions

	function selectNextGameType() {
		if (numberOfTestGamesPlayed % 9 == 0 && numberOfAdaptedPlayed == 0 || numberOfAdaptedPlayed % 3 != 0) {
			isTestGame = false;
		} else {
			isTestGame = true;
		}
	}
	
//End round

	function endRound() {
		saveRoundData(isTestGame);
		saveSubData();
		clearRound();
		selectNextGameType();
		$("#gameTimer").css("z-index", "-2");
		roundId++;
		$("#savebutton").css("z-index", "2");
		if (numberOfTestsPlayed == 4) {
			alert("Koe loppui!");
		}
		if (isTestGame == true) {
			$("#testbutton").css("z-index", "2");
		} else {
			$("#startbutton").css("z-index", "2");
		}
	}

//Layer changers

	function putButtonsBack() {
		$("#startbutton").css("z-index", "-2");
		$("#testbutton").css("z-index", "-2");
		$("#savebutton").css("z-index", "-2");
		$("#pietimerArea").css("z-index", "1");
	}


//Starts experiment

	askSubId();
});
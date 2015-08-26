


function disco() {

	console.log("rai");
	
	
	var reds = [];

	for (var i=0; i<10; i++) {
		
		var x = Math.floor(Math.random() * (9-1) + 1);
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
	
	function flash(position) {
		console.log(reds);
		console.log(reds[position]);
		var cellId = "cell" + reds[position];
		switchColor(cellId);
		
		if (position < reds.length - 1) {
			setTimeout( function() { flash(position+1); }, 1000 );
		}
	}
	
	flash(0);
	
        //setInterval("switchColor('cell1')", 3000);
	//setInterval("switchColor('cell3')", 500);
	//setInterval("switchColor('cell7')", 1000);
	//setInterval("switchColor('cell8')", 2000);
    

}


function switchColor(cellId) {
    console.log(cellId);
    //alert("Hoi!");
    var e = document.getElementById(cellId);
    
    var bgColor = e.style.backgroundColor;
    if (bgColor == 'green') {
	e.style.backgroundColor = "red";
    } else {
        e.style.backgroundColor = "green";
    }
    //setTimeout("switchColor('"+ cellId +"');", 2000);
}







// events

//document.addEventListener("ready", vcxvxzbz  )

$(document).ready( function() {

	$("#gametable").find("td").click( function(ev) { 
			var id = ev.target.id;
			switchColor(id); });
	
	disco();	

});
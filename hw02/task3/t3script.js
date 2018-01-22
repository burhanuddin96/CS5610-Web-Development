// Javascript file for Task3.html

(function() {
	
	var div_li = document.getElementById("lorenIpsum");
	var div_nnb = document.getElementById("nninebottles");
	var div_lt = document.getElementById("lastthing");
	
	var link_li = document.getElementById("l_ipsum");
	link_li.onclick = function() {
 		div_li.className ="seen"; 
 		div_nnb.className ="hidden";
 		div_lt.className ="hidden";	
	}
	
	var link_nnb = document.getElementById("nnbottles");
	link_nnb.onclick = function() {
		div_nnb.className ="seen";
		div_li.className ="hidden";
		div_lt.className ="hidden";	
	}
	
	var link_lt = document.getElementById("l_thing");
	link_lt.onclick = function() {
		div_lt.className ="seen"; 
 		div_nnb.className ="hidden";
 		div_li.className ="hidden";		
	}
})();

//Javascript file for Task2.html

(function (){
	"use strict";

	var btn_alert = document.getElementById("btn_alert");
	btn_alert.onclick = function() {
		var num = document.getElementById("num").innerHTML;
		alert(num);
	}
	
	var btn_inc = document.getElementById("btn_inc");
	btn_inc.onclick = function() {
		var num = document.getElementById("num");
		var newVal = parseInt(num.innerHTML) + 1;
		num.innerHTML = newVal;
	}
	
	var btn_adp = document.getElementById("btn_adpara");
	btn_adp.onclick = function() {
		var num = document.getElementById("num").innerHTML;
		var para = document.createElement("p");
		var text = document.createTextNode(num);
		para.appendChild(text);
		
		var div = document.getElementById("app_div");
		div.appendChild(para);
	}
	
})();

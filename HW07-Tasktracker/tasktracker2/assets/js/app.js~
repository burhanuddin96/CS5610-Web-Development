// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function update_buttons(){
	$(".time_button").each( (_, bb) =>{
		let task_id = $(bb).data('task_id');
		let timeblock_id = $(bb).data('timeblock_id');
		if (timeblock_id != "") {
			$(bb).text("End Task");
		}
		else{
			$(bb).text("Start Task");
		}
	});
}

function set_button(task_id, timeblock_id) {
	$(".time_button").each( (_, bb) => {
		if (task_id == $(bb).data('task_id')) {
			$(bb).data('timeblock_id', timeblock_id);
		}
	});
	update_buttons();
}

function start_task(task_id) {
	var currentdate = new Date(); 
	var datetime = (currentdate.getMonth()+1) + "/"
                + currentdate.getDate() + "/" 
                + currentdate.getFullYear() + " @ "  
                + currentdate.getHours() + ":"  
                + currentdate.getMinutes() + ":" 
                + currentdate.getSeconds();
	let text = JSON.stringify({
		time_block: {
			stime: datetime,
			etime: "",
			task_id: task_id,
		}		
	});
	
	$.ajax(time_path, {
		method: "POST",
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		data: text,
		success: (resp) => {set_button(task_id, resp.data.id); },
	});
}

function end_task(task_id, timeblock_id){
	var currentdate = new Date(); 
	var datetime = (currentdate.getMonth()+1) + "/"
                + currentdate.getDate() + "/" 
                + currentdate.getFullYear() + " @ "  
                + currentdate.getHours() + ":"  
                + currentdate.getMinutes() + ":" 
                + currentdate.getSeconds();
	let text = JSON.stringify({
		time_block: {
			etime: datetime,
		}		
	});
	
	$.ajax(time_path + "/" + timeblock_id, {
		method: "PUT",
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		data: text,
		success: (resp) => {set_button(task_id, ""); },
	});
}

function time_click(ev){
	let btn = $(ev.target);
	let task_id = btn.data('task_id');
	let timeblock_id = btn.data('timeblock_id');
	if (timeblock_id == "") {
		start_task(task_id);
	}
	else{
		end_task(task_id, timeblock_id);
	}
}

function delete_click(ev){
	let btn = $(ev.target);
	let timeblock_id = btn.data('timeblock_id');
	
	$.ajax(time_path + "/" + timeblock_id, {
	method: "DELETE",
	dataType: "json",
	contentType: "application/json; charset=UTF-8",
	data: "{}",
	success: (resp) => {},
	});
	
	location.reload();
}

function update_stime_click(ev){
	let btn = $(ev.target);
	let timeblock_id = btn.data('timeblock_id');
	
	var newdate = new Date($('#sdate'+timeblock_id).val());
	var newhour = $('#shour'+timeblock_id).val();
    var newmin = $('#smin'+timeblock_id).val();
    console.log(newdate + "+" + newhour + "+" + newmin)
    var datetime = (newdate.getMonth()+1) + "/"
                + newdate.getDate() + "/" 
                + newdate.getFullYear() + " @ "
                + newhour + ":" + newmin + ":00" 

	let text = JSON.stringify({
		time_block: {
			stime: datetime,
		}		
	});
	
	$.ajax(time_path + "/" + timeblock_id, {
	method: "PUT",
	dataType: "json",
	contentType: "application/json; charset=UTF-8",
	data: text,
	success: (resp) => {},
	});
	
	location.reload();
}

function update_etime_click(ev){
	let btn = $(ev.target);
	let timeblock_id = btn.data('timeblock_id');
	
	var newdate = new Date($('#edate'+timeblock_id).val());
	var newhour = $('#ehour'+timeblock_id).val();
    var newmin = $('#emin'+timeblock_id).val();
    
    var datetime = (newdate.getMonth()+1) + "/"
                + newdate.getDate() + "/" 
                + newdate.getFullYear() + " @ "
                + newhour + ":" + newmin + ":00" 

	let text = JSON.stringify({
		time_block: {
			etime: datetime,
		}		
	});
	
	$.ajax(time_path + "/" + timeblock_id, {
	method: "PUT",
	dataType: "json",
	contentType: "application/json; charset=UTF-8",
	data: text,
	success: (resp) => {console.log(resp)},
	});
	
	location.reload();
}


function init_timeblock(){
	if(!($(".time_button") && $(".delete_tblock_button")))
		return;
	if($(".time_button")){
		$(".time_button").click(time_click);
		update_buttons();
	}
	if($(".delete_tblock_button")){
		$(".delete_tblock_button").click(delete_click);
	}
	if($(".update_stime")){
		$(".update_stime").click(update_stime_click);
	}
	if($(".update_etime")){
		$(".update_etime").click(update_etime_click);
	}
}

$(init_timeblock);

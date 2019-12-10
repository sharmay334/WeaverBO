var unitWidth = 4.80;
var unique_identifier="";
var type,first,tier_name,default_grace,date="";

$(function() {
//	$( ".section" ).draggable({ containment: "#resultDiv", scroll: false,handle: ".drag-icon"  });
//	$( ".section" ).resizable();
	var topTier = $('#toptier').val();
	
	var maintenancePt = $('#currentTierMaintanancePoints').val();
	var currentProgress = $('#currentEarning').val();
	var nextTierEntry = topTier=='true'?maintenancePt:$('#nextTierEntryPoints').val();
	currentEarning(currentProgress, nextTierEntry);
	maintenanceLine(maintenancePt, nextTierEntry);
	designEntryPt(nextTierEntry);
	initPointAddDialog();

	var packet_table;
	/*$(document).ready(function() {
		packet_table = $('#packet_table').dataTable({
			"scrollX" : true,
			"lengthMenu": [[5], [5]],
			"sPaginationType" : "full_numbers",
			"aoColumnDefs" : [ {
				'bSortable' : false,
				"aTargets" : [ 0 ]
			} ]
		});

	});
*/
	
	$('#grace_button').click(function(){
		var date = $("#grace_input").val();
//		var mode = first?"default":"variable";
		var mode = "variable";
		var proceed = true;

//		if(!first){
//			var timestamp = Date.parse(date); 
			if (!isNumber(date)) { 
				alert("invalid number");
				proceed = false;
			} 
//		}
		if(proceed && confirmBox('Are you sure grace?') ){
			var map = _ajaxCallJson("com/stpl/pms/action/bo/loyalty/bo_ajax_call_grace_add.action?graceForm.type="
					+type+"&graceForm.identifier="+unique_identifier+"&graceForm.mode="+mode+"&graceForm.totalDays="+date,"");
			if(map.result == 0){
				alert("grace added successfully !!");
				$('#grace_dialog').dialog("destroy");
				refreshDetail(map.master_id);
			}else if(map.result == 400){
				alert("grace failed. please refresh and try again !!");
				$('#grace_dialog').dialog("destroy");
			}
		}
	});
	
	$("#point_add_button").click(function(){
		var run = true;
		var player_master_id = $('#player_master_id').val();
		var points = $('#point_added').val();
		if(isNumber(points)){
			if(run && confirmBox('Are you sure points?')){
				run = false;
				var map = _ajaxCallJson("com/stpl/pms/action/bo/loyalty/bo_ajax_call_add_points.action?pointAddForm.playerMasterId="
						+player_master_id+"&pointAddForm.value="+points,"");
				if(map.result == 0){
					alert("Point added successfully !!");
					$( "#point_addition_dialog" ).dialog("destroy");
					refreshDetail(map.master_id);

				}else if(map.result == 400){
					alert("Point addition failed. Please refresh or contact support staff !!");
					$( "#point_addition_dialog" ).dialog("destroy");
				}
			}
		}else{
			alert("please enter valid amount!!");
			
		}
	});
});


function currentEarning(currentProgress, nextTierEntry) {

	var mainBar = $('#progressBar');
	mainBar.width(100*unitWidth);
	var progressBarWidthVal = (currentProgress / nextTierEntry);
	if(progressBarWidthVal > 1){
		progressBarWidthVal = 1;
	}
	var progressBarWidth = progressBarWidthVal*100*unitWidth;

	var element = mainBar.find('#current_earning');

	element.animate({
		width : progressBarWidth
	}).html("earning " + currentProgress);

}

function maintenanceLine(maintenancePt, nextTierEntry) {

	var mainBar = $('#progressBar');
	var position_left = (maintenancePt / nextTierEntry)*100*unitWidth;

	var element = mainBar.find('#maintenance_point');

	element.animate({
		left : position_left
	});

	/*var title = element.attr("title");
	element.attr("title", title + "</br>" + maintenancePt);*/

	//configure maintanance description
	var descEl = element.find('#maintanence_desc');
	//set content

	descEl.text(descEl.text() + " " + maintenancePt);
	//set width
	var width = descEl.width();
	descEl.css('left', -1 * (width / 2));
}

function designEntryPt(nextTierEntry) {
	var topTier = $('#toptier').val();
	var mainBar = $('#progressBar');
	var element = mainBar.find('#entry_point');
	if(topTier == 'true'){
		element.hide();
	}
	var title = element.attr("title");
	element.attr("title", title + "<br>" + nextTierEntry);

	//configure maintanance description
	var descEl = element.find('#entry_desc');
	//set content
	descEl.text(descEl.text() + " " + nextTierEntry);
	//set width
	var width = descEl.width();
	descEl.css('left', -1 * (width / 2));
}


function initPointAddDialog(){
	


}

function initPointAdd(player_master_id){
	$( "#point_added").val("");
	$( "#point_addition_dialog" ).dialog({
		modal: true,
		autoOpen: false,
	});
	$("#point_addition_dialog" ).dialog( "open" );
	$('#player_master_id').val(player_master_id);
}

function initGraceAddDialog(unique_identifier,type,first,tier_name,default_grace,date){
	console.log(unique_identifier,type,first,tier_name,default_grace,date);
	
	this.unique_identifier=unique_identifier;
	this.type=type;
	this.first=first;
	this.tier_name=tier_name;
	this.default_grace=default_grace;
	this.date=date;
	
	$('#grace_input').val("");
	var $graceDialog = $('#grace_dialog');
	/*if($graceDialog)
		$graceDialog.dialog( "destroy" );*/
	
	var $identifier = $graceDialog.find('#unique_identifier');
	var $type = $graceDialog.find('#type');
//	var $defaultDiv = $graceDialog.find('#defaultDiv');
	var $varDiv = $graceDialog.find('#varDiv');
//	var $defaultGrace = $graceDialog.find('#default_grace');
	var $graceInput = $graceDialog.find('#grace_input');
	var $tierType = $graceDialog.find('#tier_name');
	var $graceButton = $graceDialog.find('#grace_button');
	$type.val(type);
	$graceDialog.find('#typeSpan').text(type);
	$identifier.val(unique_identifier);

	var $noteDiv = $('#NoteDiv');
	if(first){
		$noteDiv.find('#typeSpan').text(type);
		$noteDiv.find('#tier_name').text($tierType);
		$noteDiv.find('#default_grace').text(default_grace);
		$graceInput.val(default_grace);
		
		$noteDiv.show();
	}else{
		$noteDiv.hide();
	}
//	if(first){
//		$defaultDiv.show();
//		$varDiv.hide();
//		$defaultGrace.text(default_grace);
//		$defaultGrace.show();
//	}else{
//		$defaultDiv.hide();
		$varDiv.show();
		var originalDate = new Date(date);
		/*$graceInput.datepicker({
			setDate:originalDate,
			minDate:originalDate
		});*//*.datepicker("setDate", originalDate).date("minDate",originalDate);*/
//	}

	$tierType.text(tier_name);

	$graceDialog.dialog({
		modal: true,
		autoOpen: false,
		width:600,
		height:200,
		  
	});
	
	

	$graceDialog.dialog( "open" );

	
}

function confirmBox(message){
	return true;
//	return confirm(message);
}

function isNumber(str) {
	var pattern = /^\d+$/;
	return pattern.test(str);  // returns a boolean
}

function refreshDetail(master_id){
	var $form = $('#FormSearch');
	var $playerId = $form.find('#masterId');
	$playerId.val(master_id);
	$form.submit();
}
var bonusTable;
$(document).ready(function() {
	bonusTable = $('#bonusList').dataTable({
		"scrollX" : true,
		"sPaginationType" : "full_numbers",
		"aoColumnDefs" : [ {
			'bSortable' : false,
			"aTargets" : [ 0 ]
		} ]
	});
	$('#allCheckBox').click(function() {
		var chk = $(this).prop('checked');
		$('input[id*=bonusIds_]', bonusTable.fnGetNodes()).prop('checked', chk);
		//$('input[id*=bonusIds_]', bonusTable.fnGetHiddenNodes()).prop('checked', chk);
	});
});
$("#btnSubmit").click(function() {
	var toBeProccessed = bonusTable.$(':checkbox', {"filter" : "applied"});
	var isChk = false;
	$(toBeProccessed).each(function() {
		if($(this).attr('checked')){
			isChk = true;
		}
	});
	if(!isChk)
		alert("Please Select One Bonus atleast");
	else{
		isChk = confirm("Are you sure you want to inactivate selected bonus?");
	}
	
	if(isChk){
		var selectedBonusIdArr = $(':checkbox', bonusTable.fnGetNodes()).serialize();
		var resp = _ajaxCallDiv('com/stpl/pms/action/bo/bonus/bo_promo_bonus_inactivate_result.action?'+selectedBonusIdArr, "","bonusSearchRes");
	}
	return false;
});

$("#hideButton").click(function() {
	var toBeProccessed = bonusTable.$(':checkbox', {"filter" : "applied"});
	var isChk = false;
	$(toBeProccessed).each(function() {
		if($(this).attr('checked')){
			isChk = true;
		}
	});
	if(!isChk)
		alert("Please Select One Bonus atleast");
	else{
		isChk = confirm("Are you sure you want to hide selected bonus?");
	}
	
	if(isChk){
		var selectedBonusIdArr = $(':checkbox', bonusTable.fnGetNodes()).serialize();
		var resp = _ajaxCallDiv('com/stpl/pms/action/bo/bonus/bo_promo_bonus_hide_result.action?'+selectedBonusIdArr, "","bonusSearchRes");
	}
	return false;
});

$(document).on('click','input[id*=bonusIds_]',function(){
	var toBeProccessed = bonusTable.$(':checkbox', {"filter" : "applied"});
	var chkAll = true;
	$(toBeProccessed).each(function() {
		if(!$(this).attr('checked')){
			chkAll = false;
		}
	});
	$('#allCheckBox').prop('checked', chkAll);
});

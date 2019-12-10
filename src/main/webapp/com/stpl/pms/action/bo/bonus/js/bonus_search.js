var activityData;
var criteriaData;
var activityValueType;
$(document).ready(function() {
	$("#addCriteria, #removeCriteria").hide();
	activityData = $.parseJSON($('#activityData').val());
	criteriaData = $.parseJSON($('#criteriaData').val());
	$('#relatedTo').empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
	$('#activityId').empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
	$.each(activityData, function(key, value) {
		$('#relatedTo').append($('<option></option>').val(key).html(key));
	});
	$('#activityValueYesNo').hide();
	$('#activityValueMinMax').hide();
	$('#relatedTo').change(function(){
		$('#activityId').empty().append(
				$('<option></option>').val("-1").html("----Please Select----"));
		activityValueType=new Array();
		$.each(activityData[$(this).val()], function(key, value) {
			$('#activityId').append($('<option bonusValueType="'+value.bonusValueType+'" criteriaValType="'+value.criteriaValueType+'"></option>').val(value.activityId).html(value.activity));
		});
		if($(this).val() =='WAGER')
		{
			$('input[name="bonusMaster.availabilityType"]').filter('[value=NO_EVENT]').prop('disabled', true);
			$('input[name="bonusMaster.availabilityType"]').filter('[value=PLR_SPECIFIC_EVENT]').prop('disabled', true);
			$('input[name="bonusMaster.availabilityType"]').filter('[value=GEN_EVENT]').prop('checked', true).change();
			$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=EMAIL_LIST]').prop('disabled', true);
			//$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=PLR_USERNAME_LIST]').prop('disabled', true);
			$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=SPECIFIC_CRITERIA]').prop('disabled', true);
			$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=GENERIC_CRITERIA]').prop('checked', true).change();
		}
		else
		{
			$('input[name="bonusMaster.availabilityType"]').filter('[value=NO_EVENT]').prop('disabled', false);
			$('input[name="bonusMaster.availabilityType"]').filter('[value=PLR_SPECIFIC_EVENT]').prop('disabled', false);
			$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=EMAIL_LIST]').prop('disabled', false);
			$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=PLR_USERNAME_LIST]').prop('disabled', false);
			$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=SPECIFIC_CRITERIA]').prop('disabled', false);
			$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=GENERIC_CRITERIA]').prop('checked', true).change();
		}
	});
	$('#activityId').change(function(){
		if($(this).val()==-1){
			$('#activityValueYesNo').hide();
			$('#activityValueMinMax').hide();
			$('#activityValueMin , #activityValueMax').removeScript();
		}else{
			var bonusTypeValue = $(this).find('option:selected').attr('bonusvaluetype');
			if($(this).find('option:selected').attr('criteriaValType')=="Y-N"){
				$('#activityValueYesNo').show();
				$('#activityValueMinMax').hide();
				$('#activityValueMin , #activityValueMax').removeScript();
			}else{
				$('#activityValueYesNo').hide();
				$('#activityValueMinMax').show();
				$('#activityValueMin , #activityValueMax').applyScript();
			}
		}
	});
	
	$('#genEventDateDiv').hide();
	$('#plrSpecificEventDiv').hide();
	
	$('input[id*="availabilityType"]').change(function() {
		var val = $(this).val();
		if (val == 'GEN_EVENT') {
			$('#genEventDateDiv').show();
			$('#availableFromDate , #availableToDate').applyScript();
			
			$('#plrSpecificEventDiv').hide();
			$('#availableBeforeDays , #availableAfterDays').removeScript();
		} else if (val == 'PLR_SPECIFIC_EVENT') {
			$('#genEventDateDiv').hide();
			$('#availableFromDate , #availableToDate').removeScript();
			
			$('#plrSpecificEventDiv').show();
			$('#availableBeforeDays , #availableAfterDays').applyScript();
		} else {
			$('#genEventDateDiv').hide();
			$('#availableFromDate , #availableToDate').removeScript();
			
			$('#plrSpecificEventDiv').hide();
			$('#availableBeforeDays , #availableAfterDays').removeScript();
		}
	});
	
	$('input[id*="eligibilityGroup"]').change(function(){
		$('#genCriteriaDiv').hide();
		$('#userNameDiv').hide();
		$('#emailIdDiv').hide();
		$('#addCriteria').hide();
		if($(this).val()=='GENERIC_CRITERIA'){
			$('#genCriteriaDiv').show();
			$('#criteriaDiv').hide();
		}else if($(this).val()=='SPECIFIC_CRITERIA'){
			$('#genCriteriaDiv').show();
			$('#addCriteria').show();
			var rowCount = $('#criteriaTlb tr').length;
			if(rowCount-1==0)
				$('#criteriaDiv').hide();
			else
				$('#criteriaDiv').show();

		}else if($(this).val()=='EMAIL_LIST'){
			$('#emailIdDiv').show();
			$('#criteriaDiv').hide();
		}else if($(this).val()=='PLR_USERNAME_LIST'){
			$('#userNameDiv').show();
			$('#criteriaDiv').hide();
		}
	});
	
	
	$('#domainId').change(function() {
		$('#vipLevelList_chzn').remove();
		$('#countryList_chzn').remove();
		//$('#aliasList_chzn').remove();
		$('#countryList').empty().removeClass('chzn-done').show();
		$('#vipLevelList').empty().removeClass('chzn-done').show();
		$('#aliasList').empty();
		$('#aliasList').append($('<option></option>').val(-1).html("----Please Select----"));
		var domainId = $(this).val();
		var jsonList = '["countryList","vipList","aliasList"]';
		var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
		if(domainId!="-1"){
			$.each(map["countryList"], function(
					index, value) {
				$('#countryList').append($('<option></option>').val(value.countryId).html(value.name));
			});
			$.each(map["vipList"], function(
					index, value) {
				$('#vipLevelList').append($('<option></option>').val(value.id).html(value.vipCode));
			});
			
			$.each(map["aliasList"], function(
					index, value) {
				$('#aliasList').append($('<option></option>').val(value.aliasId).html(value.aliasName));
			});
		}
		$('#vipLevelList').chosen('{}');
		$('#countryList').chosen('{}');
		//$('#aliasList').chosen('{}');
	});
	
	//for domain User
	if($("#domainId").val()>1){
		$(function(){
			$('#vipLevelList').chosen();
			$('#countryList').chosen();	
			//$('#aliasList').chosen();
		});
	}
	
	
	//Adding Criteria Column 
	var criRelatedTo=$('<select class="select1">');
	criRelatedTo.append($('<option></option>').val("-1").html("----Please Select----"));
	
	var criActivity=$('<select name="bonusMaster.criteriaActivityId" class="select1">');
	criActivity.append($('<option></option>').val("-1").html("----Please Select----"));
	$.each(criteriaData, function(key, value) {
		criRelatedTo.append($('<option></option>').val(key).html(key));
	});
	
	$('#addCriteria').click(function(){
		var tlb=$('#criteriaTlb tbody');
		var idArr;
		if($('#criteriaDiv').css('display') == 'none'){
			$('#criteriaDiv').show();
			idArr=['0','0'];
		}else{
			idArr=tlb.find('tr:last').attr('id').split('_');
		}
		var newId=parseInt(idArr[1])+1;
		var newTr=$('<tr id="criteriaRow_'+newId+'"></tr>');
		var newCriRelatedTo=criRelatedTo.clone();
		newCriRelatedTo.attr('id','criteriaRelatedTo_'+newId);
		newTr.append($('<td></td>').append(newCriRelatedTo));
		var newCriActivity=criActivity.clone();
		newCriActivity.attr('id','criteriaActivityId_'+newId);
		newTr.append($('<td></td>').append(newCriActivity));
		newTr.append($('<td></td><td></td><td><a id="criteriaRemoveBtnId_'+newId+'" theme="simple" href="javascript:void(0)"><img src="'+projectName+'/images/cross.gif" /></a></td>'));
		tlb.append(newTr);
		//createBubble();
	});
});

var removeCriteriaBtn=function(){
	var id=$(this).attr('id').replace('criteriaRemoveBtnId_','criteriaRow_');
	$('#'+id).remove();
	var rowCount = $('#criteriaTlb tr').length;
	if(rowCount-1==0)
		$('#criteriaDiv').hide();
};

var criteriaRelatedFn=function(){
	var id=$(this).attr('id').replace('criteriaRelatedTo_','criteriaActivityId_');
	$('#'+id).empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
	activityValueType=new Array();
	$.each(criteriaData[$(this).val()], function(key, value) {
		$('#'+id).append($('<option criteriaValType="'+value.criteriaValueType+'"></option>').val(value.activityId).html(value.activity));
		activityValueType[value.activityId]=value.criteriaValueType;
	});
};

var criteriaActivityFn=function(){
	var id=$(this).attr('id').replace('criteriaActivityId_','');
	var valObj1 = $(this).find('option:selected').attr('criteriaValType') != "Y-N" ? 
						$('<input type="text" name="bonusMaster.criteriaActivityValMin" id="criteriaActivityValMin_'+id+'" style="width:40px" />')
							: $('<input type="radio" value="YES"  id="criteriaActivityValYes_'+id+'" checked="checked" > Yes </input>');
						
	var valObj2 = $(this).find('option:selected').attr('criteriaValType') != "Y-N" ? 
					$('<input type="text" name="bonusMaster.criteriaActivityValMax" id="criteriaActivityValMax_'+id+'" style="width:40px" />')
					: '';
	
	$(this).parent('td').next('td').html(valObj1);
	$(this).parent('td').next('td').next('td').html(valObj2);
};

$(document).on('change','select[id*="criteriaRelatedTo_"]',criteriaRelatedFn);
$(document).on('change','select[id*="criteriaActivityId_"]',criteriaActivityFn);
$(document).on('click','a[id*="criteriaRemoveBtnId_"]',removeCriteriaBtn);
$(function() {
	$(".dateField").datetimepicker(
		{
			dateFormat : 'dd/mm/yy',
			timeFormat : 'HH:mm:ss',
			showSecond: true,
			onClose : function(dateText, inst) {
				if ($(this).attr('id').indexOf('availableFromDate') != -1) {
					$('#availableToDate').datetimepicker("option", "minDate",
							dateText);
					$('#availableToDate').datetimepicker("option", "minDateTime",
							new Date(dateText));
				} else if ($(this).attr('id').indexOf('availableToDate') != -1) {
					$('#availableFromDate').datetimepicker("option", "maxDate",
							dateText);
					$('#availableFromDate').datetimepicker("option", "maxDateTime",
							new Date(dateText));
				}
			}
	});
});
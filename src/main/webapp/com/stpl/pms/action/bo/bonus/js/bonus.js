var activityData;
var criteriaData;
var activityValueType;
var countryId = [];
var countryName = [];
var deviceSelectedValue,selectedDeviceArray,replacedText1,replacedText2;
var vipLevelSelectedValue,vipReplacedText1,vipReplacedText2,selectedVipArray,userNameArr,isUserNameListByFile;


$(document).ready(function() {

	if($("#userListByFileFlag").val()=="true"){		
		$("#divUserlist").hide();		
		$("#userFileLink").show();		
	}
	$("#userFileLink").click(function(){
		$(this).attr("href",'data:csv/plain;charset=utf-8,' + encodeURIComponent($("#userName").val()));			
	});
	
	$("#editUserName").click(function(){
		$("#divUserlist").show();		
		$("#userName").val("");
		$("#userListByFileFlag").val("false");
		$("#userFileLink").hide();		
		$(this).hide();
		return false;
	});
	
	activityData = $.parseJSON($('#activityData').val());
	criteriaData = $.parseJSON($('#criteriaData').val());
	//$('#gameTypeList').chosen('{}');
	$('#relatedTo').empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
	$('#activityId').empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
	$.each(activityData, function(key, value) {
		$('#relatedTo').append($('<option></option>').val(key).html(key));
	});
	$('#activityValueYesNo').hide();
	$('#activityValueMinMax').hide();
	$('#deviceValueYesNo').hide();
	$('#campaignDiv').hide();
	$('#addCriteria').hide();
	$('#relatedTo').change(function(){
		onRelatedToChnage($(this).val());
	});
	var val = $('input[id*="eligibilityGroup"]:checked').val();
	if(val=='PLR_USERNAME_LIST'  || val=='EMAIL_LIST'){
		if(val=='PLR_USERNAME_LIST'){
		$('#userNameDiv').show();
		$('#userName').val($('#userName').val().replace('[','').replace(']',''));
		
		}
		else if(val=='EMAIL_LIST'){
			$('#emailIdDiv').show();
			$('#emailIds').val($('#emailIds').val().replace('[','').replace(']',''));
		}
		$('#genCriteriaDiv').hide();
		}
		
	$('#activityId').change(function(){
		onActivityChange($(this).val(),$(this),"new");
	});
	
	//code added for state drop down
	$('#countryList').change(function() {
		$('#stateDiv').empty();
		$('#countryList :selected').each(function(i, selectedElement) {
			countryId[i] = $(selectedElement).val();
			countryName[i] = $(selectedElement).text();
			var domainId = $('#domainId').val();
			populateDropDown(domainId,"state",countryId[i],countryName[i]);
		});
	 });
	
	
	
	$('#maxCount').click(function(){
		if($('#maxCount').attr('checked')=='checked')
		{
			$('input[name="bonusMaster.maxUsageCount"]').val("-1");
			$('input[name="bonusMaster.maxUsageCount"]').prop('readonly', true);	
			$('input[name="bonusMaster.maxUsageCount"]').filter('[errorMassage=Only numbers or -1 allowed]').prop('disabled', true);
		}
		else
		{
			$('input[name="bonusMaster.maxUsageCount"]').val("");
			$('input[name="bonusMaster.maxUsageCount"]').prop('readonly', false);	
			$('input[name="bonusMaster.maxUsageCount"]').filter('[errorMassage=Only numbers or -1 allowed]').prop('disabled', false);
		}
		
	});
	
	$('#playerCount').click(function(){
		if($('#playerCount').attr('checked')=='checked')
		{
			$('input[name="bonusMaster.playerUsageCount"]').val("-1");
			$('input[name="bonusMaster.playerUsageCount"]').prop('readonly', true);	
			$('input[name="bonusMaster.playerUsageCount"]').filter('[errorMassage=Only numbers or -1 allowed]').prop('disabled', true);
		}
		else
		{
			$('input[name="bonusMaster.playerUsageCount"]').val("");
			$('input[name="bonusMaster.playerUsageCount"]').prop('readonly', false);	
			$('input[name="bonusMaster.playerUsageCount"]').filter('[errorMassage=Only numbers or -1 allowed]').prop('disabled', false);
		}
		
	});
	
	$('#genEventDateDiv').hide();
	$('#plrSpecificEventDiv').hide();
	
	$('input[name="bonusMaster.deliveryMode"]').filter('[value=COUPON_SAME]').prop('disabled', true);
	$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', true);
	$('input[name="bonusMaster.deliveryMode"]').filter('[value=COUPON_UNIQUE]').prop('disabled', true);
	
	$('input[id*="availabilityType"]').change(function() {
		var val = $(this).val();
		$('input[name="bonusMaster.playerEvent"]').prop('checked', false).change();
		if (val == 'GEN_EVENT') {
			$('#genEventDateDiv').show();
			$('#availableFromDate , #availableToDate').applyScript();
			
			$('#plrSpecificEventDiv').hide();
			$('#availableBeforeDays , #availableAfterDays').removeScript();
			
		} else if (val == 'PLR_SPECIFIC_EVENT') {
			$('#genEventDateDiv').hide();
			$('input[name="bonusMaster.playerEvent"]').filter('[value=BIRTHDAY]').prop('checked', true).change();
			$('#availableFromDate , #availableToDate').removeScript();
			
			$('#plrSpecificEventDiv').show();
			$('#availableBeforeDays , #availableAfterDays').applyScript();
		} else {
			$('#genEventDateDiv').hide();
			$('#availableFromDate , #availableToDate').removeScript();
			
			$('#plrSpecificEventDiv').hide();
			$('#availableBeforeDays , #availableAfterDays').removeScript();
		}
		
		if (val == 'GEN_EVENT' && $('#relatedTo').val()=='DEPOSIT') {
			$('input[name="bonusMaster.deliveryMode"]').filter('[value=COUPON_SAME]').prop('disabled', false);
			$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', false);
			$('input[name="bonusMaster.deliveryMode"]').filter('[value=AUTO]').prop('checked', true).change();
		}else{
			$('input[name="bonusMaster.deliveryMode"]').filter('[value=COUPON_SAME]').prop('disabled', true);
			$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', true);
			$('input[name="bonusMaster.visibility"]').filter('[value=SHOW]').prop('checked', true);
			$('input[name="bonusMaster.deliveryMode"]').filter('[value=AUTO]').prop('checked', true).change();
		}
	});
	$('#promoCodeDiv').hide();
	$('input[name="bonusMaster.deliveryMode"]').change(function(){
		var val = $(this).val();
		if (val == 'COUPON_SAME') {
			$('#promoCodeDiv').show();
			$('#promoCode').attr('disabled',false);
			$('#promoCode').applyScript();
			$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', false);
		} else {
			$('#promoCodeDiv').hide();
			$('#promoCode').removeScript();
			$('#promoCode').attr('disabled',true);
			$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', true);
			$('input[name="bonusMaster.visibility"]').filter('[value=SHOW]').prop('checked', true);
		}
	});
	
	
	$('#expiryAfterDateDiv').hide();
	$('#expiryAfterDaysDiv').hide();
	$('input[id*="expiryAfterAcceptType"]').change(function() {
		var val = $(this).val();
		if (val == 'DATE') {
			$('#expiryAfterDateDiv').show();
			$('#expiryAfterAcceptDate').applyScript();
			
			$('#expiryAfterDaysDiv').hide();
			$('#expiryAfterAcceptDays').removeScript();
		} else if (val == 'DAYS') {
			$('#expiryAfterDateDiv').hide();
			$('#expiryAfterDaysDiv').show();
			
			$('#expiryAfterAcceptDays').applyScript();
			$('#expiryAfterAcceptDate').removeScript();
		} else {
			$('#expiryAfterDateDiv').hide();
			$('#expiryAfterDaysDiv').hide();
			
			$('#expiryAfterAcceptDays').removeScript();
			$('#expiryAfterAcceptDate').removeScript();
		}
	});
	
	//countryMap = $.parseJSON($('#countryMapJson').val());
	//domainMap = $.parseJSON($('#domainMap').val());
	//vipLevelMap = $.parseJSON($('#vipLevelListJson').val());
	$('#domainId').change(function() {
		var domainId = $(this).val();
		onDomainChange(domainId);
	});
	
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
			if(rowCount>1)
				$('#criteriaDiv').show();
			else
				$('#criteriaDiv').hide();
		}else if($(this).val()=='EMAIL_LIST'){
			$('#emailIdDiv').show();
			$('#emailIds').val($('#emailIds').val().replace('[','').replace(']',''));
			$('#criteriaDiv').hide();
		}else if($(this).val()=='PLR_USERNAME_LIST'){
			$('#userNameDiv').show();			
			$('#userName').val($('#userName').val().replace('[','').replace(']',''));
			$('#criteriaDiv').hide();
		}
	});
	
	$('input[name="bonusMaster.bonusValueType"]').change(function() {
		var val = $(this).val();
		if (val == 'PERCENT') {
			$('#maxBonusValueDiv').show();
			$('#maxBonusValue').applyScript();
		} else if (val == 'FIXED') {
			$('#maxBonusValue').removeScript();
			$('#maxBonusValueDiv').hide();
			
		}
	});
	$('input[name="bonusMaster.bonusValueAs"]').change(function() {
		var val = $(this).val();
		if (val == 'CASH') {
			/*$('#wrTargetValue').val(1).parent().parent().hide();
			$('#redemptionCycle').val(1).parent().parent().hide();
			$('#wrTargetValue , #redemptionCycle').removeScript();*/
			$('#wageringDiv').hide();
			$('#wrTargetValue , #redemptionCycle').removeScript();
			var bonusId=$('input[name="bonusMaster.bonusId"]').val();
			if(bonusId==null || bonusId==0)
			{
				var relatedTo = $('#relatedTo').val();
				if(relatedTo == 'WAGER')
				{
					$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=NONE]').prop('disabled', true);
					$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=RAKE]').prop('disabled', false);
					$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=WAGER]').prop('disabled', false);
					$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=WAGER]').prop('checked', true);
				}
				else
				{
					$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=WAGER]').prop('disabled', true);
					$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=RAKE]').prop('disabled', true);
					$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=NONE]').prop('disabled', false);
					$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=NONE]').prop('checked', true);
				}
			}
			
			
		} else if (val == 'BONUS') {
			/*$('#wrTargetValue').parent().parent().show();
			$('#redemptionCycle').parent().parent().show();
			$('#wrTargetValue , #redemptionCycle').applyScript();*/
			$('#wageringDiv').show();
			$('#wrTargetValue , #redemptionCycle').applyScript();
			var bonusId=$('input[name="bonusMaster.bonusId"]').val();
			if(bonusId==null || bonusId==0)
			{
				$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=NONE]').prop('disabled', true);
				$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=RAKE]').prop('disabled', false);
				$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=WAGER]').prop('disabled', false);
				$('input[name="bonusMaster.gameBonusCriteria"]').filter('[value=WAGER]').prop('checked', true);
				changeBonusCriteria('WAGER');
			}
		}
	});
	
	
	/*$('#activityValueMax').click(function(){
		var minValue = $('input[name="bonusMaster.activityValueMin"]').val();
		if(minValue != 'undefined')
		$('#activityValueMax').attr('compareTo',minValue);
	});
	
	$('#maxBonusValue').click(function(){
		var minValue = $('input[name="bonusMaster.bonusValue"]').val();
		if(minValue != 'undefined')
		$('#maxBonusValue').attr('compareTo',minValue);
	});*/
	
	$('form').submit(function(){
		var bonusCriteriaBeanArray = new Array();
		var isValid = true;
		$('#criteriaTlb > tbody > tr').each(function(index){
			var $row = $(this);
			var criteriaId = $row.find('[id*=criteriaActivityId_]');
			var criteriaValue = $row.find('input[type="radio"]:checked').val();
			var criteriaValueMin = $row.find('[id*=criteriaActivityValMin_]').val();
			var criteriaValueMax = $row.find('[id*=criteriaActivityValMax_]').val();
			
			switch (criteriaId.find('option:selected').attr('criteriaValType')) {
			case 'Y-N':
				if(typeof criteriaValue == 'undefined'){
					isValid = false;
					alert("Please select criteria value");
				}
				break;
			case 'MIN-MAX':
				if (criteriaValueMin == '' && criteriaValueMax == ''){
					isValid = false;
					alert("Please fill all criteria value");
				}else if(parseInt(criteriaValueMin) > parseInt(criteriaValueMax)){
					isValid = false;
					alert("Minimum criteria value can't be greater than maximum criteria value.");
				}
				break;	
			default :
				isValid = false;
				alert("Please select criteria activity ");
			}
			
			bonusCriteriaBeanArray.push(new BonusCriteriaListBean(criteriaId.val(),criteriaValue,criteriaValueMin,criteriaValueMax));
			if(!isValid){
				criteriaId.focus();
			}
			return isValid;
		});
		
		var val = $('input[id*="bonusValueAs"]:checked').val();
		if(val == 'BONUS')
		{
			if($('input[name="gameType"]:checked').length == 0){
				$('#toolTip').show();
				isValid = false;
				return isValid;
			}
		}
		if(typeof document.getElementById('fileInput').files[0] == 'undefined'){
			userNameArr=$('#userName').val().split(',');
			if($("#userListByFileFlag").val()!="true")
				isUserNameListByFile=false;
			else
				isUserNameListByFile=true;
		}
		var	emailIdsArr=$('#emailIds').val().split(',');
		if (isValid) {
			var stateId = new Array();
			$('select[id*=stateList]').each(function(){
				if($(this).val()!=null){
					$.each($(this).val(),function(index,value){
						stateId.push(value);
					});
				}
			});
		
			var allVals = [];
			var jsonObj = new bonusCriteriaJson($('input[name=playerType]:checked').val(),$('#vipLevelList').val(),$('#countryList').val(),stateId,bonusCriteriaBeanArray,userNameArr,emailIdsArr,$('input[name=playerStatus]:checked').val(),$('input[name=emailVerification]:checked').val(),$('input[name=mobileVerification]:checked').val(),$('input[name=isDepositor]:checked').val(),isUserNameListByFile,$("#campIdList").val());
			$(this).append($('<input type="hidden" name="bonusMaster.eligibilityBeanStr"/>').val(JSON.stringify(jsonObj)));
			
			var jsonDeviceObj = new bonusClientDeviceJSON($('#deviceTypeList').val());
			$(this).append($('<input type="hidden" name="bonusMaster.deviceEligibilityBeanStr"/>').val(JSON.stringify(jsonDeviceObj)));
			
			$('input[name=gameType]:checked').each(function ()  {
				allVals.push($(this).val());
			});
			var jsonGameObj = new bonusClientGameJSON(allVals);
			$(this).append($('<input type="hidden" name="bonusMaster.gameEligibilityBeanStr"/>').val(JSON.stringify(jsonGameObj)));
			
			
		}
		
		return true;
	});
	
	
	  var fileInput = document.getElementById('fileInput');    

      fileInput.addEventListener('change', function(e) {
          var file = fileInput.files[0];
          
          var regex = new RegExp("(.*?)\.(csv)$");

          if (regex.test(file.name)) {
              var reader = new FileReader();

              reader.onload = function(e) {
            	  userNameArr=reader.result.split(',');
            	  $("#userName").val("");
            	  $("#userName").prop('readonly', true);    
            	  isUserNameListByFile=true;
              }
              

              reader.onerror = function(event) {
            	  
            	  alert("Not able to load File");
            	  $("#fileInput").val("");
              }

              reader.readAsText(file);    
          } else {
              alert("File not supported!");
              userNameArr="";
              $("#fileInput").val("");
              $("#userName").removeProp('readonly');
          }
      });
      
      $("#userName").change(function(){
    	 if($(this).val()=="") 
    		 $("#userFile").show();
    	 else{
    		 $("#userFile").hide();
    		 $("#filenote").hide();
    	 }
      });
	
	preloadBonus();
	
	$("#aliasList").change(function(){
		var jsonList = '["campaignList"]';
		if($("#activityId").val()==1 || $("#activityId").val()==2){
			var aliasId="";
			debugger;
			if($(this).val()!=-1)
				aliasId="&aliasId="+$(this).val();			
			var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+$("#domainId").val() +aliasId +"&jsonList="+jsonList,"");
			setCampaignData(map);
			
		}
		
	});
	
});

function changeBonusCriteria(radio)
{
	if(radio == 'WAGER')
	{
		$('#requirementType label').text('Wager Requirment Type');
		$('#requirementTargetType label').text('Wager Requirment Target Type');
		$('#requirementTargetValue label').text('Wager Requirment Target Value');
		$('#wageringDiv').show();
		$('#wrTargetValue , #redemptionCycle').applyScript();
	}
	else if(radio == 'RAKE')
	{
		$('#requirementType label').text('Rake Requirment Type');
		$('#requirementTargetType label').text('Rake Requirment Target Type');
		$('#requirementTargetValue label').text('Rake Requirment Target Value');
		$('#wageringDiv').show();
		$('#wrTargetValue , #redemptionCycle').applyScript();
	}
	else if(radio == 'NONE')
	{
		$('#wageringDiv').hide();
		$('#wrTargetValue , #redemptionCycle').removeScript();
	}
}

function bonusClientDeviceJSON(deviceTypeId){
	this.deviceTypeId = deviceTypeId;
	
}

function bonusClientGameJSON(gameType){
	this.gameType = gameType;
	
}

function bonusCriteriaJson(playerType,vipLevelId,countryId,stateId,criteriaList,userNameList,emailList,playerStatus,emailVerification,mobileVerification,isDepositor,isUserNameListByFile,campIdList){
	this.playerType = playerType;
	this.vipLevelId = vipLevelId;
	this.countryId = countryId;
	this.stateId = stateId;
	this.criteriaList = criteriaList;
	this.userNameList = $.trim(userNameList)==""?null:userNameList;
	this.emailList = $.trim(emailList)==""?null:emailList;
	this.playerStatus = playerStatus=="BOTH"?null:playerStatus;
	this.emailVerification = emailVerification=="NOT_APPLICABLE"?null:emailVerification;
	this.mobileVerification = mobileVerification=="NOT_APPLICABLE"?null:mobileVerification;
	this.isDepositor = isDepositor=="NOT_APPLICABLE"?null:isDepositor;
	this.isUserNameListByFile=isUserNameListByFile;
	this.campIdList=campIdList ;
	
}

function BonusCriteriaListBean(criteriaId,criteriaValue,criteriaValueMin,criteriaValueMax){
	this.criteriaId = criteriaId;
	this.criteriaValue = criteriaValue;
	this.criteriaValueMin = criteriaValueMin;
	this.criteriaValueMax = criteriaValueMax;
}


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
							: $('<input type="radio" value="YES"  id="criteriaActivityValYes_'+id+'" checked="checked"> Yes </input>');
						
	var valObj2 = $(this).find('option:selected').attr('criteriaValType') != "Y-N" ? 
					$('<input type="text" name="bonusMaster.criteriaActivityValMax" id="criteriaActivityValMax_'+id+'" style="width:40px" />')
					: '';
	
	$(this).parent('td').next('td').html(valObj1);
	$(this).parent('td').next('td').next('td').html(valObj2);
};

var removeCriteriaBtn=function(){
	var id=$(this).attr('id').replace('criteriaRemoveBtnId_','criteriaRow_');
	$('#'+id).remove();
	var rowCount = $('#criteriaTlb tr').length;
	if(rowCount-1==0)
		$('#criteriaDiv').hide();
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

function onBlurCheckbox(val)
{
	var val = $('input[id*="bonusValueAs"]:checked').val();
	if(val == 'BONUS')
	{
		if($('input[name="gameType"]:checked').length == 0){
			$('#toolTip').show();
			return false;
	    }
		else
		{
			fadeOut();
		}
	}
	else
	{
		fadeOut();
	}
}

function fadeOut()
{
	$('#toolTip').hide();
}

function setCampaignData(map){
	

	$('#campIdList_chzn').remove();
	$('#campIdList').empty().removeClass('chzn-done').show();
	$.each(map["campaignList"], function(
				index, value) {
			  var camp= value.split("~");			 
			$('#campIdList').append($('<option></option>').val(camp[0]).html(camp[1]));
		});
		
		$('#campIdList').chosen('{}');
	
	
	
}

function onDomainChange(domainId){
	$('#vipLevelList_chzn').remove();
	$('#countryList_chzn').remove();
	//$('#aliasList_chzn').remove();
	$('#countryList').empty().removeClass('chzn-done').show();
	$('#vipLevelList').empty().removeClass('chzn-done').show();
	$('#aliasList').empty();
	$('#aliasList').append($('<option></option>').val(-1).html("----Please Select----"));
	var jsonList = '["countryList","vipList","aliasList","campaignList"]';
	var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
	if(domainId!="-1"){
		$.each(map["countryList"], function(
				index, value) {
			$('#countryList').append($('<option></option>').val(value.countryId).html(value.name));
		});
		
		$.each(map["vipList"], function(
				index, value) {
			$('#vipLevelList').append($('<option></option>').val(value.vipLevel).html(value.vipCode));
		});
		
		$.each(map["aliasList"], function(
				index, value) {
			$('#aliasList').append($('<option></option>').val(value.aliasId).html(value.aliasName));
		});
		if($("#activityId").val()==1 || $("#activityId").val()==2){
			setCampaignData(map);
		}
	}	
	$('#vipLevelList').chosen('{}');
	$('#countryList').chosen('{}');
	
	//$('#aliasList').chosen('{}');
}

function onRelatedToChnage(relatedTo){
	
	$("#campaignDiv").hide();
	
	$('#activityId').empty().append(
			$('<option></option>').val("-1").html("----Please Select----"));
	activityValueType=new Array();
	$.each(activityData[relatedTo], function(key, value) {
		$('#activityId').append($('<option bonusValueType="'+value.bonusValueType+'" criteriaValType="'+value.criteriaValueType+'"clientDeviceType="'+value.clientDeviceType+'"></option>').val(value.activityId).html(value.activity));
	});
	if(relatedTo=='REFER_FRIEND'){
		$('#wrTypeTHIRD_PARTY').attr('disabled',false);
	}else{
		$('#wrTypeTHIRD_PARTY').attr('disabled',true);
	}
	if (relatedTo =='DEPOSIT' && $('input[id*="availabilityType"]:checked').val()=='GEN_EVENT') {
		$('input[name="bonusMaster.deliveryMode"]').filter('[value=COUPON_SAME]').prop('disabled', false);
		$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', false);
		//var deliveryMode = $('#deliveryMode').val();
		//$('input[name="bonusMaster.deliveryMode"]').filter('[value='+deliveryMode+']').prop('checked', true).change();
		if($('input[name="bonusMaster.deliveryMode"]:checked').val()=='COUPON_SAME'){
			$('#promoCodeDiv').show();
			$('#promoCode').attr('disabled',false);
			$('#promoCode').applyScript();
			var hideShow = $('input[name="bonusMaster.visibility"]:checked').val();
			$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', false);
			if(hideShow == 'SHOW')
				$('input[name="bonusMaster.visibility"]').filter('[value=SHOW]').prop('checked', true);
			else
				$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('checked', true);
		}
		else
		{
			$('#promoCodeDiv').hide();
			$('#promoCode').removeScript();
			$('#promoCode').attr('disabled',true);
			$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', true);
			$('input[name="bonusMaster.visibility"]').filter('[value=SHOW]').prop('checked', true);	
		}
	}else{
		$('input[name="bonusMaster.deliveryMode"]').filter('[value=COUPON_SAME]').prop('disabled', true);
		$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', true);
		$('input[name="bonusMaster.visibility"]').filter('[value=SHOW]').prop('checked', true);
		$('input[name="bonusMaster.deliveryMode"]').filter('[value=AUTO]').prop('checked', true).change();
	}
	if(relatedTo =='WAGER')
	{
		$('input[name="bonusMaster.availabilityType"]').filter('[value=NO_EVENT]').prop('disabled', true);
		$('input[name="bonusMaster.availabilityType"]').filter('[value=PLR_SPECIFIC_EVENT]').prop('disabled', true);
		$('input[name="bonusMaster.availabilityType"]').filter('[value=GEN_EVENT]').prop('checked', true).change();
		$('input[name="bonusMaster.bonusValueAs"]').filter('[value=BONUS]').prop('disabled', true);
		
		$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=EMAIL_LIST]').prop('disabled', true);
		//$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=PLR_USERNAME_LIST]').prop('disabled', true);
		$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=SPECIFIC_CRITERIA]').prop('disabled', true);
		//$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=GENERIC_CRITERIA]').prop('checked', true).change();
		$('input[name="bonusMaster.isRedeemable"]').filter('[value=YES]').prop('disabled', true);
		$('input[name="bonusMaster.isRedeemable"]').filter('[value=NO]').prop('checked', true).change();
		//alert($('input[name="gameGroupType"]').val());
		$('#gameGroup').empty();
		var gamezGroup="<div class='clearFRM'></div><div class='FormMainBox'><div class='labelDiv'><label>Game Group Type</label>	<em class='Req'>*</em></div>";
		if($('input[name="gameGroupType"]').val()!=null && $('input[name="gameGroupType"]').val()!='' && $('input[name="gameGroupType"]').val()!='undefined')
		{
			gamezGroup += "<div class='InputDiv'>";
			var selectedValues = $('input[name="gameGroupType"]').val().replace("[","").replace("]","");
			if(selectedValues.indexOf('RUMMY')!=-1)
			{
				gamezGroup += "<input type='checkbox' name='gameType' id='gameType1' value='RUMMY' checked onBlur='onBlurCheckbox(this)'>Rummy";
			}
			else
			{
				gamezGroup += "<input type='checkbox' name='gameType' id='gameType1' value='RUMMY' onBlur='onBlurCheckbox(this)'>Rummy";
			}
			if(selectedValues.indexOf('POKER')!=-1)
			{
				gamezGroup += "<input type='checkbox' name='gameType' id='gameType' value='POKER' checked onBlur='onBlurCheckbox(this)'>Poker";
			}
			else
			{
				gamezGroup += "<input type='checkbox' name='gameType' id='gameType' value='POKER' onBlur='onBlurCheckbox(this)'>Poker";
			}
			
			gamezGroup += "</div>";
		}
		else
		{
			gamezGroup += "<div class='InputDiv'><input type='checkbox' name='gameType' id='gameType1' value='RUMMY' onBlur='onBlurCheckbox(this)'>Rummy<input type='checkbox' name='gameType' id='gameType' value='POKER' onBlur='onBlurCheckbox(this)'>Poker</div>";
		}
		
		gamezGroup += "<div id='toolTip' onclick='fadeOut()' style='display:none; position:relative;'><p class='tooltip_p'>Please select one option.</p></div></div></div><div class='clearFRM'></div>";
		if($('input[name="bonusCrit"]').val()!=null && $('input[name="bonusCrit"]').val()!='' && $('input[name="bonusCrit"]').val()!='undefined')
		{
			if($('input[name="bonusCrit"]').val() == 'WAGER')
			{
				gamezGroup += "<div class='FormMainBox'><div class='labelDiv'><label>Game Bonus Criteria</label><em class='Req'>*</em></div><div class='InputDiv inpRadio'><input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria1' value='WAGER' checked disabled>On Wager<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='RAKE' disabled>On Rake<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='NONE' disabled>None</div></div>";
			}
			else if($('input[name="bonusCrit"]').val() == 'RAKE')
			{
				gamezGroup += "<div class='FormMainBox'><div class='labelDiv'><label>Game Bonus Criteria</label><em class='Req'>*</em></div><div class='InputDiv inpRadio'><input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria1' value='WAGER' disabled>On Wager<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='RAKE' checked disabled>On Rake<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='NONE' disabled>None</div></div>";
			}
			else if($('input[name="bonusCrit"]').val() == 'NONE')
			{
				gamezGroup += "<div class='FormMainBox'><div class='labelDiv'><label>Game Bonus Criteria</label><em class='Req'>*</em></div><div class='InputDiv inpRadio'><input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria1' value='WAGER' disabled>On Wager<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='RAKE' disabled>On Rake<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='NONE' checked disabled>None</div></div>";
			}
		}
		else
		{
			gamezGroup += "<div class='FormMainBox'><div class='labelDiv'><label>Game Bonus Criteria</label><em class='Req'>*</em></div><div class='InputDiv inpRadio'><input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria1' value='WAGER' checked onchange='changeBonusCriteria(this.value)'>On Wager<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='RAKE' onchange='changeBonusCriteria(this.value)'>On Rake<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria2' value='NONE' disabled>None</div></div>";
		}
		$('#gameGroup').append(gamezGroup);
		$('#gameingCriteria').empty();
		changeBonusCriteria('WAGER');
		$('input[name="bonusMaster.bonusValueAs"]').filter('[value=CASH]').prop('checked', true).change();
		
	}
	else
	{
		$('input[name="bonusMaster.availabilityType"]').filter('[value=NO_EVENT]').prop('disabled', false);
		$('input[name="bonusMaster.availabilityType"]').filter('[value=PLR_SPECIFIC_EVENT]').prop('disabled', false);
		$('input[name="bonusMaster.bonusValueAs"]').filter('[value=BONUS]').prop('disabled', false);
		
		$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=EMAIL_LIST]').prop('disabled', false);
		$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=PLR_USERNAME_LIST]').prop('disabled', false);
		$('input[name="bonusMaster.eligibilityGroup"]').filter('[value=SPECIFIC_CRITERIA]').prop('disabled', false);
		$('input[name="bonusMaster.isRedeemable"]').filter('[value=YES]').prop('disabled', false);
		//$('input[name="bonusMaster.gameBonusCriteria"]').prop('checked', true).change();
		//alert($('input[name="gameGroupType"]').val());
		$('#gameingCriteria').empty();
		var gamezGroup="<div class='FormMainBox'><div class='labelDiv'><label>Game Group Type</label>	<em class='Req'>*</em></div>";
		if($('input[name="gameGroupType"]').val()!=null && $('input[name="gameGroupType"]').val()!='' && $('input[name="gameGroupType"]').val()!='undefined')
		{
			gamezGroup += "<div class='InputDiv'>";
			var selectedValues = $('input[name="gameGroupType"]').val().replace("[","").replace("]","");
			if(selectedValues.indexOf('RUMMY')!=-1)
			{
				gamezGroup += "<input type='checkbox' name='gameType' id='gameType1' value='RUMMY' checked onBlur='onBlurCheckbox(this)'>Rummy";
			}
			else
			{
				gamezGroup += "<input type='checkbox' name='gameType' id='gameType1' value='RUMMY' onBlur='onBlurCheckbox(this)'>Rummy";
			}
			if(selectedValues.indexOf('POKER')!=-1)
			{
				gamezGroup += "<input type='checkbox' name='gameType' id='gameType' value='POKER' checked onBlur='onBlurCheckbox(this)'>Poker";
			}
			else
			{
				gamezGroup += "<input type='checkbox' name='gameType' id='gameType' value='POKER' onBlur='onBlurCheckbox(this)'>Poker";
			}
			gamezGroup += "</div>";
		}
		else
		{
			gamezGroup += "<div class='InputDiv'><input type='checkbox' name='gameType' id='gameType1' value='RUMMY' onBlur='onBlurCheckbox(this)'>Rummy<input type='checkbox' name='gameType' id='gameType' value='POKER' onBlur='onBlurCheckbox(this)'>Poker</div>";
		}
		gamezGroup += "<div id='toolTip' onclick='fadeOut()' style='display:none; position:relative;'><p class='tooltip_p'>Please select one option.</p></div></div></div><div class='clearFRM'></div>";
		if($('input[name="bonusCrit"]').val()!=null && $('input[name="bonusCrit"]').val()!='' && $('input[name="bonusCrit"]').val()!='undefined')
		{
			if($('input[name="bonusCrit"]').val() == 'WAGER')
			{
				gamezGroup += "<div class='FormMainBox'><div class='labelDiv'><label>Game Bonus Criteria</label><em class='Req'>*</em></div><div class='InputDiv inpRadio'><input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria1' value='WAGER' checked disabled>On Wager<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='RAKE' disabled>On Rake<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='NONE' disabled>None</div></div><div class='clearFRM'></div>";
			}
			else if($('input[name="bonusCrit"]').val() == 'RAKE')
			{
				gamezGroup += "<div class='FormMainBox'><div class='labelDiv'><label>Game Bonus Criteria</label><em class='Req'>*</em></div><div class='InputDiv inpRadio'><input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria1' value='WAGER' disabled>On Wager<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='RAKE' checked disabled>On Rake<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='NONE' disabled>None</div></div><div class='clearFRM'></div>";
			}
			else if($('input[name="bonusCrit"]').val() == 'NONE')
			{
				gamezGroup += "<div class='FormMainBox'><div class='labelDiv'><label>Game Bonus Criteria</label><em class='Req'>*</em></div><div class='InputDiv inpRadio'><input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria1' value='WAGER' disabled>On Wager<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='RAKE' disabled>On Rake<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='NONE' checked disabled>None</div></div><div class='clearFRM'></div>";
			}
		}
		else
		{
			gamezGroup += "</div><div class='FormMainBox'><div class='labelDiv'><label>Game Bonus Criteria</label><em class='Req'>*</em></div><div class='InputDiv inpRadio'><input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria1' value='WAGER' checked onchange='changeBonusCriteria(this.value)'>On Wager<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria' value='RAKE' onchange='changeBonusCriteria(this.value)'>On Rake<input type='radio' name='bonusMaster.gameBonusCriteria' id='gameBonusCriteria2' value='NONE' onchange='changeBonusCriteria(this.value)'>None</div></div><div class='clearFRM'></div>";
		}
		
		$('#gameingCriteria').append(gamezGroup);
		$('#gameGroup').empty();
		changeBonusCriteria('WAGER');
		var bonusValue = $('input[id*="bonusValueAs"]:checked').val();
		$('input[name="bonusMaster.bonusValueAs"]').filter('[value='+bonusValue+']').prop('checked', true).change();
	}
	
}



function onActivityChange(activityId,obj,str){
	var bonusMasterTypeValue;
	if(activityId==-1){
		$('#activityValueYesNo').hide();
		$('#activityValueMinMax').hide();
		$('#deviceValueYesNo').hide();
		$('#activityValueMin , #activityValueMax').removeScript();
		$('#activityName').val('');
	}else{
		
		var bonusTypeValue = obj.find('option:selected').attr('bonusvaluetype');
		var deviceTypeValue = obj.find('option:selected').attr('clientDeviceType');
		$('#activityName').val(obj.find('option:selected').text());
		if(obj.find('option:selected').attr('criteriaValType')=="Y-N"){
			$('#activityValueYesNo').show();
			$('#activityValueMinMax').hide();
			$('input[name="bonusMaster.activityValue"]').filter('[value=YES]').prop('checked', true).change();
			$('#activityValueMin , #activityValueMax').removeScript();
		}else{
			$('#activityValueYesNo').hide();
			$('#activityValueMinMax').show();
			$('input[name="bonusMaster.activityValue"]').filter('[value=YES]').prop('checked', false).change();
			$('#activityValueMin , #activityValueMax').applyScript();
		}
		if(str == 'edit')
		{
			bonusMasterTypeValue = $('input[name="bonusValueType"]').val();
			if (bonusTypeValue=='FIXED' ) {
				$('input[name="bonusMaster.bonusValueType"]').filter('[value=FIXED]').prop('checked', true).change();
				$('input[name="bonusMaster.bonusValueType"]').filter('[value=PERCENT]').prop('disabled',true);
			}
			else {
				if (bonusMasterTypeValue=='FIXED' ) {
					$('input[name="bonusMaster.bonusValueType"]').filter('[value=FIXED]').prop('checked', true).change();
					$('input[name="bonusMaster.bonusValueType"]').filter('[value=PERCENT]').prop('disabled',false);
				}
				else
				{
					$('input[name="bonusMaster.bonusValueType"]').filter('[value=PERCENT]').prop('disabled',false);
					$('input[name="bonusMaster.bonusValueType"]').filter('[value=PERCENT]').prop('checked', true).change();
				}
			}
		}
		else
		{
			if (bonusTypeValue=='FIXED' ) {
				$('input[name="bonusMaster.bonusValueType"]').filter('[value=FIXED]').prop('checked', true).change();
				$('input[name="bonusMaster.bonusValueType"]').filter('[value=PERCENT]').prop('disabled',true);
			} else {
				$('input[name="bonusMaster.bonusValueType"]').filter('[value=PERCENT]').prop('disabled',false);
				$('input[name="bonusMaster.bonusValueType"]').filter('[value=PERCENT]').prop('checked', true).change();
			}
		}
		if(deviceTypeValue=='Y')
		{
			//$('#deviceTypeList_chzn').remove();
			//$('#deviceTypeList').empty().removeClass('chzn-done').show();
			$('#deviceValueYesNo').show();
			$('#deviceTypeList').chosen('{}');
		}
		else
		{
			$('#deviceValueYesNo').hide();
		}
	}
	if(activityId==3){
		$('input[name="mobileVerification"]').filter('[value=YES]').prop('disabled', false);
		$('input[name="mobileVerification"]').filter('[value=NO]').prop('disabled', true);
		$('input[name="mobileVerification"]').filter('[value=NOT_APPLICABLE]').prop('disabled', true);
		$('input[name="mobileVerification"]').filter('[value=YES]').prop('checked', true);
	}else{
		$('input[name="mobileVerification"]').filter('[value=YES]').prop('disabled', false);
		$('input[name="mobileVerification"]').filter('[value=NO]').prop('disabled', false);
		$('input[name="mobileVerification"]').filter('[value=NOT_APPLICABLE]').prop('disabled', false);
		$('input[name="mobileVerification"]').filter('[value=NOT_APPLICABLE]').prop('checked', true);
		
	}
	if(activityId==4){
		$('input[name="emailVerification"]').filter('[value=YES]').prop('disabled', false);
		$('input[name="emailVerification"]').filter('[value=NO]').prop('disabled', true);
		$('input[name="emailVerification"]').filter('[value=NOT_APPLICABLE]').prop('disabled', true);
		$('input[name="emailVerification"]').filter('[value=YES]').prop('checked', true);
	}else{
		$('input[name="emailVerification"]').filter('[value=YES]').prop('disabled', false);
		$('input[name="emailVerification"]').filter('[value=NO]').prop('disabled', false);
		$('input[name="emailVerification"]').filter('[value=NOT_APPLICABLE]').prop('disabled', false);
		$('input[name="emailVerification"]').filter('[value=NOT_APPLICABLE]').prop('checked', true);
		
	}
	
	if(activityId==1 || activityId==2){
		$("#campaignDiv").show();	
		if($("#domainId").val()!=-1){
			var jsonList = '["campaignList"]';
			var aliasId="";
			
			if($('input[name="bonusMaster.aliasId"]').val()!=-1)
				aliasId="&aliasId="+$('input[name="bonusMaster.aliasId"]').val();			
			var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+$("#domainId").val() +aliasId +"&jsonList="+jsonList,"");
			setCampaignData(map);
		}
	}else{		
		$('#campIdList_chzn').remove();
		$('#campIdList').empty().removeClass('chzn-done').show();
		$("#campaignDiv").hide();
	}
	if(activityId==2){
		$('input[name="playerStatus"]').filter('[value=FULL]').prop('disabled', false);
		$('input[name="playerStatus"]').filter('[value=MINI]').prop('disabled', true);
		$('input[name="playerStatus"]').filter('[value=BOTH]').prop('disabled', true);
		$('input[name="playerStatus"]').filter('[value=FULL]').prop('checked', true);
		
	}else{
		$('input[name="playerStatus"]').filter('[value=FULL]').prop('disabled', false);
		$('input[name="playerStatus"]').filter('[value=MINI]').prop('disabled', false);
		$('input[name="playerStatus"]').filter('[value=BOTH]').prop('disabled', false);
		$('input[name="playerStatus"]').filter('[value=BOTH]').prop('checked', true);
		
	}
	
}


/* for Edit bonus load all Data here*/
function preloadBonus(){
	var domainId=$('#domainId').val();
	if(domainId!=-1)
		onDomainChange(domainId);
	
	if($('#tempRelatedTo').val()!=''){
		onRelatedToChnage($('#tempRelatedTo').val());
		$('#relatedTo').val($('#tempRelatedTo').val());
	}
	
	if($('#tempActivityId').val()!=''){
		$('#activityId').val($('#tempActivityId').val());
		onActivityChange($('#tempActivityId').val(),$('#activityId'),"edit");
	}
	if($('input[name="bonusMaster.deliveryMode"]:checked').val()=='COUPON_SAME'){
		//$('input[name="bonusMaster.deliveryMode"]').change();
		$('#promoCodeDiv').show();
		$('#promoCode').attr('disabled',false);
		$('#promoCode').applyScript();
		$('input[name="bonusMaster.visibility"]').filter('[value=HIDE]').prop('disabled', false);
	}
	var val = $('input[id*="availabilityType"]:checked').val();
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
	var value = $('input[id*="expiryAfterAcceptType"]:checked').val(); 
	if (value == 'DATE') {
		$('#expiryAfterDateDiv').show();
		$('#expiryAfterAcceptDate').applyScript();
		
		$('#expiryAfterDaysDiv').hide();
		$('#expiryAfterAcceptDays').removeScript();
	} else if (value == 'DAYS') {
		$('#expiryAfterDateDiv').hide();
		$('#expiryAfterDaysDiv').show();
		
		$('#expiryAfterAcceptDays').applyScript();
		$('#expiryAfterAcceptDate').removeScript();
	} else {
		$('#expiryAfterDateDiv').hide();
		$('#expiryAfterDaysDiv').hide();
		
		$('#expiryAfterAcceptDays').removeScript();
		$('#expiryAfterAcceptDate').removeScript();
	}
	
	var maxCountVal = $("#maxCountValue").val();
	if(maxCountVal == -1)
	{
		$('input[name="bonusMaster.maxUsageCount"]').prop('readonly', true);	
		$('input[name="bonusMaster.maxUsageCount"]').filter('[errorMassage=Only numbers or -1 allowed]').prop('disabled', true);
		$('input[name="maxCount"]').prop('checked', true);	
	}
	var playerCountVal = $('#playerCountValue').val();
	if(playerCountVal == -1)
	{
		$('input[name="bonusMaster.playerUsageCount"]').prop('readonly', true);	
		$('input[name="bonusMaster.playerUsageCount"]').filter('[errorMassage=Only numbers or -1 allowed]').prop('disabled', true);
		$('input[name="playerCount"]').prop('checked', true);	
	}
	
	if($('input[name="bonusCrit"]').val() == 'WAGER')
	{
		$('#requirementType label').text('Wager Requirment Type');
		$('#requirementTargetType label').text('Wager Requirment Target Type');
		$('#requirementTargetValue label').text('Wager Requirment Target Value');
	}
	else if($('input[name="bonusCrit"]').val() == 'RAKE')
	{
		$('#requirementType label').text('Rake Requirment Type');
		$('#requirementTargetType label').text('Rake Requirment Target Type');
		$('#requirementTargetValue label').text('Rake Requirment Target Value');
	}
	
	var bonusValue = $('input[id*="bonusValueAs"]:checked').val();
	$('input[name="bonusMaster.bonusValueAs"]').filter('[value='+bonusValue+']').prop('checked', true).change();
	
	setSelectBoxVal("#deviceTypeList",$('#deviceType').val());
	setSelectBoxVal("#vipLevelList",$('#vipLevel').val());
	setSelectBoxVal("#countryList",$('#countryLevel').val());
	setSelectBoxVal("#campIdList",$('#prevCampVal').val());
	
	
	//setSelectBoxVal("#gameTypeList",$('#gameGroupType').val());
	if($('#countryLevel').val()==null || $('#countryLevel').val()=='')
		return;
	
	$('#stateDiv').empty();
	$('#countryList :selected').each(function(i, selectedElement) {
		countryId[i] = $(selectedElement).val();
		countryName[i] = $(selectedElement).text();
		console.log(countryId[i]+" --------- "+ countryName[i]);
		populateDropDown($('#domainId').val(),"state",countryId[i],countryName[i]);
		setSelectBoxVal("#stateList_"+countryId[i],$('#stateLevel').val());
	});	
	
}

function setSelectBoxVal(objId,selectedValue){
	if(selectedValue==null || selectedValue=='')
		return;
	$(objId+'_chzn').remove();
	$(objId).removeClass('chzn-done').show();
	var selectedValues = selectedValue.replace("[","").replace("]","");
	var selectedValueArray = selectedValues.split(',');
	$.each(selectedValueArray,function(index,value){
		$(objId).find("option[value='"+$.trim(value)+"']").prop("selected", "selected");
	});
	$(objId).chosen('{}');
}

function populateDropDown(domainId,listName,selectedValue,nameValue)
{
	var selectBox ='<select theme="myTheme" class="select1" data-placeholder="All states" name="'+listName+'Id" id="'+listName+'List_'+selectedValue+'" multiple="true">';
	var stateDiv = '<div id="'+listName+'Id_'+selectedValue+'"><div class="FormMainBox" style="height:60px;"><div class="labelDiv"><label>State - '+nameValue+':</label></div><div class="InputDiv">';
	
	var jsonList = '['+listName+'List]';
	var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&countryId="+selectedValue+"&jsonList="+jsonList,"");
	if(domainId!="-1"){
		$.each(map[''+listName+'List'], function(
				index, value) {
			selectBox = selectBox + '<option value = '+value.stateId+'>'+value.name+'</option>';
		});
	}
	stateDiv = stateDiv+selectBox+'</select></div></div><div class="clearFRM"></div></div>';
	$('#'+listName+'Div').append(stateDiv);
	$('#'+listName+'List_'+selectedValue).chosen('{}');
}

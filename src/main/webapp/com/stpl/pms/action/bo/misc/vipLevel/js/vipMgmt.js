var critRowCount = 0;
var critRowClone = null;
function onReadyVip(){
		$('input[id=vipColor]').colorpicker().on("change.color", function(event, color) {
			$('#vipSubmitBtn').showElement();
		});	
		critRowCount = $('#vipCriteriaTbl > tbody > tr').length + 1;
		critRowClone = $('#vipCriteriaTbl > tbody').children('tr:first').html();
		
		$('#createRuleBtn').click(function() {
			createRule(false);
			$('#vipRuleEditDiv').hideElement();
		});
		
		$('#editVipRuleBtn').click(function() {
			createRule(true);
			$('#editVipRuleBtn').hideElement();
			$('#resetVipRuleBtn').showElement();
			
		});
		$('#resetVipRuleBtn').click(function() {
			$('#vipRuleDiv').html($('#currentVipRuleDiv').html());
			$('#vipRuleHidden').val($('#currentVipRuleHidden').val());
			$('#editVipRuleBtn').showElement();
			$('#resetVipRuleBtn').hideElement();
			
		});
		$('#vipLevel').change(function(){
			var action="com/stpl/pms/action/bo/misc/st_pms_misc_checkVipAvailability.action";
			var domainId = $('#vipSaveForm').find('[name="vipMaster.domainId"]').val();
			var vipLevel = $(this).val();
			var levelType = $('#vipSaveForm').find('[name="vipMaster.domainId"]').val();
			var ajaxParam="vipMaster.domainId="+domainId+"&vipMaster.levelType="+levelType+"&vipMaster.vipLevel="+vipLevel;
			var maxLimit=$(this).attr("max");
			var minLimit=$(this).attr("min");
			if(parseInt(vipLevel)>=parseInt(minLimit) && parseInt(vipLevel)<=parseInt(maxLimit)){
				var resp = _ajaxCallText(action,ajaxParam);			
				if(resp == 'success'){
					$('#vipLevelAvailMsg').html('Vip level available.').css('color','green');
				}else{
					$('#vipLevelAvailMsg').html(resp).css('color','red');
					$(this).val('');
				}
			}else{
				$('#vipLevelAvailMsg').html("");
			}
		});
		$('#vipSaveForm').submit(function() {
			var resp = prepareRule();
			$('#updateDomainId').val($('#domainId').val());
			return resp;
		});
	}

function createRule(isEdit) {
	var ruleHtml = $('<div></div>');
	var isValid = true;
	var openBracket = $('<select><option value=""></option></select>');
	var closeBracket = $('<select><option value=""></option></select>');
	var operator = $('<span class="operator"><select><option value="AND">AND</option> <option value="OR">OR</option> </select></span>');
	$('#vipCriteriaTbl tbody').find('tr').each(
		function(i) {
			var open = '';
			var close = '';
			for ( var j = 0; j <= i; j++) {
				open = open + '(';
				close = close + ')';
			}
			openBracket.append('<option value="' + open + '">' + open
					+ '</option>');
			closeBracket.append('<option value="' + close + '">' + close
					+ '</option>');
		});
	openBracket = $('<span class="openBracket"></span>').append(openBracket);
	closeBracket = $('<span  class="closeBracket"></span>')
			.append(closeBracket);

	$('#vipCriteriaTbl tbody').find('tr').each(
			function() {
				var code = $(this).find('td[id*=criCode_]').text();
				
				var min = $(this).find('input[id*=minValue_]').val();
				var max = $(this).find('input[id*=maxValue_]').val();
				var rowIndex = $('#vipCriteriaTbl tbody').children().index(
						$(this));
				if(!isEdit){
					code = $(this).find('select[id*=criteriaCode_]').val();
				}
				
				
				if (code != '' && code != '-1' && min != '' && max != ''
						&& parseInt(min) <= parseInt(max)) {
					if (rowIndex > 0)
						ruleHtml.append(closeBracket.clone()).append(
								operator.clone()).append(openBracket.clone())
								.append(
										'<span class="code">' + code
												+ ' BETWEEN (' + min + ','
												+ max + ')</span>');
					else
						ruleHtml.append(openBracket.clone()).append(
								'<span class="code">' + code + ' BETWEEN ('
										+ min + ',' + max + ')</span>');
				} else if (parseInt(min) > parseInt(max)) {
					alert("Min value can't be greater than max value.");
					isValid = false;
				} else {
					alert("Fill all fields.");
					isValid = false;
				}
				return isValid;
			});
	if (isValid) {
		$('#vipRuleDiv').html(ruleHtml.append(closeBracket.clone()).html());
		$('#vipRuleHidden').val('');
		$('#createRuleBtn').hideElement();
		$('#vipSubmitBtn').showElement();
	}

	return isValid;
}


function prepareRule() {
	var rule = $('#vipRuleHidden').val();
	var bracketBal = 0;
	var isValid = true;
	var spanArr = $('#vipRuleDiv').find('span');
	spanArr.each(
			function(index) {
					switch ($(this).attr('class')) {
					case 'code':
						rule += $(this).text();
						break;
					case 'operator':
						rule += $(this).find('select:eq(0)').val();
						break;
					case 'openBracket':
						rule += $(this).find('select:eq(0)').val();
						bracketBal = bracketBal
								+ $(this).find('select:eq(0)').val().length;
						break;
					case 'closeBracket':
						rule += $(this).find('select:eq(0)').val();
						bracketBal = bracketBal
								- $(this).find('select:eq(0)').val().length;
						break;
					}
					
					if (bracketBal < 0 ) {
						isValid = false;
						alert("Invalid sequence of brackets in rule.");
					}else if(index == spanArr.length-1 && bracketBal!=0) {
						isValid = false;
						alert("Invalid sequence of brackets in rule.");
					}
				return isValid;
			});
	if(rule=='' ){
		alert('Please create the rule before submit.');
		isValid = false;
	}else if(!isValid){
		$('#vipRuleHidden').val('');
	}else
		$('#vipRuleHidden').val(rule);
	
	return isValid;
}





(function($){
	$.fn.hideElement = function() {$(this).css('display', 'none');},
	$.fn.showElement = function() {$(this).css('display', '');}

})(jQuery);

$(document).on({
	beforeChangeVal:'',
	click:function() {
		this.beforeChangeVal = $(this).val();
	},
    change: function(event) {
		var thisEvt = this;
		event.preventDefault();
		var critVal = $(this);
		var isSelected = true;
		$(this).parent().parent().siblings('tr').each(
			function() {
				if (critVal.val()!=-1 && critVal.val() == $(this).find('td:eq(1) > select').val()) {
					alert("Criteria already selected.");
					isSelected = false;
					critVal.val(thisEvt.beforeChangeVal);
				}
				return isSelected;
			});
		if (isSelected) {
			var rowNo = $(this).attr('id').split('_')[1];
			var val = critVal.val()==-1?'':critVal.val();
			$('#criCode_' + rowNo).text(val);
			$('#minValue_' + rowNo).val('');
			$('#maxValue_' + rowNo).val('');
			$('#vipRuleDiv').html('');
			$('#vipRuleHidden').val('');
			$('#createRuleBtn').showElement();
			$('#vipSubmitBtn').hideElement();
			$('#vipRuleEditDiv').hideElement();
		}
		return false;
	
	}
}, "select[id^=criteriaCode_]");


$(document).on({
	click: function() {
		$('#vipCriteriaTbl > tbody > #noCritRow').remove();
		var newRow = $('<tr>'+critRowClone+'</tr>');
		newRow.children('td:first').attr('id','criCode_'+critRowCount).text('');
		newRow.find('input:not(:button),select').each(function(){
			var id = $(this).attr('id').split('_')[0];
			$(this).attr('id',id+'_'+critRowCount).val('').applyScriptWithBubble();
		});
		newRow.find('input:button').each(function(){
			var id = $(this).attr('id').split('_')[0];
			$(this).attr('id',id+'_'+critRowCount);
		});
		
		 $('#vipCriteriaTbl > tbody').append(newRow);
		 $('#createRuleBtn').showElement();
		 $('#vipSubmitBtn').hideElement();
		 $('#vipRuleDiv').html('');
		 $('#vipRuleHidden').val('');
		 $('#vipRuleEditDiv').hideElement();
		 critRowCount = critRowCount + 1;
		 
	}
}, ":button[id=addCriteriaBtn]");

$(document).on({
	click: function() {
		$('#vipRuleDiv').empty();
		$('#vipRuleHidden').val('');
		$('#createRuleBtn').showElement();
		$('#vipSubmitBtn').hideElement();
		$('#vipRuleEditDiv').hideElement();
		$(this).parent().parent().find('select,input').each(function(){
			$(this).removeScript();
		});
		
		$(this).parent().parent().remove();
		if($('#vipCriteriaTbl tbody').children().length==0){
			$('#vipCriteriaTbl tbody').html('<tr id = "noCritRow"><td colspan="5">No Criteria Selected</td></tr>');
			$('#createRuleBtn').hideElement();
		}
	}
}, ":button[id^=removeCriteriaBtn_]");

$(document).on({
    change: function() {
		$('#vipRuleDiv').html('');
		$('#vipRuleHidden').val('');
		$('#createRuleBtn').showElement();
		$('#vipSubmitBtn').hideElement();
		$('#vipRuleEditDiv').hideElement();
	}
}, "input[id^=minValue_],input[id^=maxValue_]");


var domainMap;

$(function() {
	/*$(".dateField").datetimepicker({
		dateFormat : 'yy-mm-dd',
		showSecond : false,
		showMinute : false,
		showHour : false,
		changeYear : true,
		changeMonth : true,
		startDate: '1980-01-01',
		minDate : '1930-01-01',
		onSelect : function(selectedDate) {
			if (selectedDate != "") {
				$("#paymentDate").datepicker("option", "minDate", selectedDate);
			} else {
				var date = new Date().getDate();
				$(function() {
					$("#paymentDate").datepicker({
						dateFormat : 'yy-mm-dd'
					}).datepicker("setDate", date);
				});
			}
		}
	});*/

	$('.jsonFrm').submit(function() {
		var allElement = $(this).serializeFromIdArray();
		// alert(allElement);
			var str = "{";
			$.each(allElement, function(index, value) {
				var val = value.value;
				if ((value.id.indexOf('Date')) != -1) {
					var valArr = value.value.split(' ');
					val = $.datepicker.formatDate('yy-mm-dd', $.datepicker
							.parseDate('dd/mm/yy', valArr[0]))
							+ ' ' + valArr[1];
				}
				str += '"' + value.id + '":"' + val + '",';
			});
			str = str.substring(0, str.length - 1) + "}";
			$('#reportData').val(str);
			
		});
	$('.jsonFrmNew').submit(function() {
		var reportType = $(this).find('#proceName').val();
		var allElement = $(this).serializeFromIdArray();
		 //alert(allElement);
		var str = "{";
		$.each(allElement, function(index, value) {
			var val = value.value;
			if ((value.id.indexOf('Date')) != -1) {
				var valArr = value.value.split(' ');
				val = $.datepicker.formatDate('yy-mm-dd', $.datepicker
						.parseDate('dd/mm/yy', valArr[0]))
						+ ' ' + valArr[1];
			}
			if ((value.id.indexOf('-')) == -1)
				str += '"' + value.id + '":"' + val + '",';
		});
			$("#playerSearchFrm").find('input[type=text],select,input:checked').each( function(index, value) {
				var val = value.value;
				if ((value.id.indexOf('-')) != -1){
					str += '"' + val+ '":Y,';
				}
			});
			str = str.substring(0, str.length - 1) + "}";
			$('#reportData').val(str);
		});
	
	$('.jsonFrmMisReport').submit(function() {
		var checkValue='NoValue';
		var reportType = $(this).find('#proceName').val();
		var allElement = $(this).find('.'+reportType+',.commonFilter');
		 //alert(allElement);
			var str = "{";
			$('.commonFilter').each(function(index, value) {
				var val = value.value;
				if ((value.id.indexOf('Date')) != -1) {
					if(value.value!=""){
					var valArr = value.value.split(' ');
					val = $.datepicker.formatDate('yy-mm-dd', $.datepicker
							.parseDate('dd/mm/yy', valArr[0]))
							+ ' ' + valArr[1];
					}	
				}
				if(val!='StateWiseReport' && value.name!='whatToGet') {
                    str += '"' + value.name + '":"' + val + '",';
                }
                else if(val=='StateWiseReport'){
					checkValue=	val;
				}
				else if(value.name=='whatToGet' && checkValue=='StateWiseReport'){
                    str += '"' + value.name + '":"' + val + '",';
				}
			});

			$("#"+reportType).find('input[type=text],select,input:checked').each( function(index, value) {
//				alert($(this).attr('id')+'--'+$(this).prop('tagName'));
				var val = value.value;
				if ((value.id.indexOf('Date')) != -1) {
					if(value.value!=""){
					var valArr = value.value.split(' ');
					val = $.datepicker.formatDate('yy-mm-dd', $.datepicker
							.parseDate('dd/mm/yy', valArr[0]))
							+ ' ' + valArr[1];
					}	
				}
				if ((value.id.indexOf('-')) != -1){
					//alert(val);
					str += '"' + val+ '":Y,';
				}else{

					str += '"' + value.name + '":"' + val + '",';
				}

			});
			str = str.substring(0, str.length - 1) + "}";
			$('#reportData').val(str);
		});
	
	$('form').submit(function() {		
		if($(this).attr("name")=="misSearchForm")
			return true;
		else
			return ajaxCall(this);
		
	});
		$(".campTrack").click(function(){
			$("#deviceType").removeAttr("disabled");
		})
		
	 $("#searchButton").click(function(){
		 if ($("#startIndex").length){ 
			 	$("#startIndex").val("0");
		 }
         $("#redirect").val("Search");
         $("#playerSearchFrm").attr("target","searchResult");
         $("#searchButton").hide();
         $("#waitDiv").show();
         $("#searchButton").attr("disabled",true);
         $("#playerSearchFrm").submit();
         
         return false;
      });	
		
		
//
		$( "#fromDateRoyalty" ).datepicker( "option", "minDate" ,new Date(2017, 03, 01));
		$( "#toDateRoyalty" ).datepicker( "option", "minDate" ,new Date(2017, 03, 01));
		$("#fromDateRoyalty").datepicker({
			  onSelect: function(dateText) {
				  $( "#toDateRoyalty" ).datepicker( "option", "minDate" ,dateText);
			  }
			});
		$("#toDateRoyalty").datepicker({
			  onSelect: function(dateText) {
				  $( "#fromDateRoyalty" ).datepicker( "option", "maxDate" ,dateText);
			  }
			});
});

function ajaxCall(form) {
	var form = $(form);
	var target = form.attr('target');
	var callback = (typeof form.attr('callBack') !== 'undefined') ? form
			.attr('callBack') : '';
	$.ajax( {
		type : "POST",
		url : form.attr('action'),
		data : form.serialize(),
		success : function(result) {
			$('#' + target).html(result);
			eval('createBubble()');
			if (callback != '') {
				eval(callback);
			}
		}
	});
	return false;
}

function attachEvent(divId) {
	$('#' + divId + ' th[data_column="sum"]').each(
			function() {
				var idArr = $(this).attr('id').split('_');
				var tdClassName = '.td_' + idArr[1];
				var sum = 0.0;
				var isLink = $(this).attr('is_link');
				var aLink;
				var jsonParam;
				var checkAmtVar;
				if (isLink == 'true') {
					aLink = $(this).find('a').clone();
					jsonParam = $(this).attr('json_param');
				}
				$('#' + divId).find(tdClassName)
						.each(function() {
							if ($(this).html().split(".").length == 2)
								checkAmtVar = 1;
							else
								checkAmtVar = 0;
							sum += parseFloat($(this).html());
							var html = $(this).html().trim();
							if (aLink && html!='--') {
								// console.log('has link');
								$(this).html('');
								var obj = prepareLink($(this), jsonParam, aLink
										.clone());
								$(this).append(obj.html(html));
							}
						});
				$('#' + divId).find('#sum_' + idArr[1]).html(
						checkAmtVar == 1 ? sum.toFixed(2) : sum);
			});

	$('#' + divId + ' th[is_hidden="true"]').each(function() {
		var idArr = $(this).attr('id').split('_');
		var tdClassName = '.td_' + idArr[1];
		var styleValue = $(this).attr('style');
		$(tdClassName).each(function() {
			$(this).attr('style', styleValue);
		});
	});
	$('#' + divId + ' th[per="Yes"]').each(
			function() {
				var idArr = $(this).attr('class').split('_');
				var tdClassName = '#sum_' + idArr[1] + idArr[2];
				var varType = null;
				if (idArr[2] == "amt") {
					varType = "amt";
				} else {
					varType = "plr";
				}
				var value = (parseFloat($(tdClassName).html()) / parseFloat($(
						'#sum_0' + varType).html())) * 100;
				$('#' + divId).find('#per_' + idArr[1] + idArr[2]).html(
						value.toFixed(2) + "%");
			});
}
function numberFormat() {
	$('.row_total').find('[id*="amt_"]').each(function() {
		$(this).text(parseFloat($(this).text()).toFixed(2));
	});
	$('.row_total').find('[id*="plr_"]').each(function() {
		$(this).text(parseFloat($(this).text()).toFixed(0));
	});
}
function prepareLink(tdObj, jsonParam, aLink) {
	var href = aLink.attr('href');
	var paramArr = (href.split('?')[1]).split('&');
	var param = '';
	for ( var x = 0; x < paramArr.length; x++) {
		var value = paramArr[x];
		if (value.indexOf('reportData') != -1) {
			var valArr = value.split('=')[1].split(',');
			var jsonArr = jsonParam.split(',');
			if (valArr.length == jsonArr.length) {
				var str = 'reportData={';
				for ( var i = 0; i < valArr.length; i++) {
					str += '"' + jsonArr[i] + '":"';
					if (valArr[i].indexOf('.') != -1) {
						str += tdObj.parent('tr').find(valArr[i]).html();
					} else if (valArr[i].indexOf('#') != -1) {
						if ((jsonArr[i].indexOf('Date')) != -1) {
							var valArray = $(valArr[i]).val().split(' ');
							val = $.datepicker.formatDate('yy-mm-dd',
									$.datepicker.parseDate('dd/mm/yy',
											valArray[0]))
									+ ' ' + valArray[1];
							str += val;
						} else {
							str += $(valArr[i]).val();
						}
					}
					str += '",';
				}
				str = str.substring(0, str.length - 1) + "}";
				str = str.replace(/\%/g, '%25');
			}
			param += str + '&';
		} else {
			param += value + '&';
		}
	}
	href = href.split('?')[0] + '?' + param;
	aLink.attr('href', href);
	return aLink;
}


$(document)
		.on(
				"change",
				'input[name="reportCategories"]',
				function() {
					var reportType = $('[id="reportType"]').val();
					var reportData = $('[id="reportDataAjax"]').val();
					var action = "com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReportAjax.action?procName="
							+ reportType
							+ $(this).val()
							+ "&reportData="
							+ reportData;
					var target = "ajaxResponse";
					$('#ajaxResponse').html('<div style="text-align: center;"><img alt="loader4" src="images/4.gif"></div>');
					$.ajax({
						type : "POST",
						url : action,
						async : false,
						success : function(result) {
							$('#' + target).html(result);
						}
					});
				});

function rowTotalAmt() {
	$('.row_total').each(function() {
		var amtTotal = 0.00;
		var plrTotal = 0.00;
		$(this).find('td').each(function() {
			if ($(this).hasClass('amt')) {
				amtTotal += parseFloat($(this).html());
			}
			if ($(this).hasClass('plr')) {
				plrTotal += parseFloat($(this).html());
			}
		});
		$(this).find('.totalamt').html(amtTotal.toFixed(2));
		$(this).find('.totalplr').html(plrTotal);
	});
}

function rowSumAndAvgAmt() {
	var totalSuccess = 0.0;
	var totalReq = 0.0;
	$('.row_total')
			.each(
					function() {
						var amtTotal = 0.00;
						var plrTotal = 0.00;
						var sRate = 0.00;
						var aTime = 0.00;
						var respRequestCount = 0;
						var respRequest = 0;
						
						$(this).find('td').each(function() {
							if ($(this).hasClass('amt')) {
								amtTotal += parseFloat($(this).html());
							}
							if ($(this).hasClass('plr')) {
								respRequestCount = parseFloat($(this).html());
								plrTotal += respRequestCount;
							}
							if ($(this).hasClass('rate_2')) {
								sRate += parseFloat($(this).html());
							}
							if ($(this).hasClass('rate_3')) {
								if(parseFloat($(this).html())>0){
									respRequest+=respRequestCount;
								}
								aTime += parseFloat($(this).html());
							}
						});
						$(this).find('.totalamt').html(amtTotal.toFixed(2));
						$(this).find('.totalplr').html(plrTotal);
						if (plrTotal != '0') {
							$(this).find('.totalsRate').html(
									(sRate == 0) ? '0.00' : ((sRate / plrTotal) *100).toFixed(2)
											+ " %");
							$(this).find('.totalaTime').html(
									(aTime == 0) ? '0.00' : (aTime / respRequest)
											.toFixed(2));
						}
						totalSuccess += sRate;
						totalReq += plrTotal;
						
					});
	$('.totalResult').find('#avgTotal_totalsucc').html(
			(totalSuccess == 0.00 ? 0.00 : ((totalSuccess / totalReq))*100).toFixed(2)+" %");

}

function fromAndToDate() {
	if ($('[id="fromDate"]').val() != "" && $('[id="toDate"]').val() != "") {
		$('.dateData').html(
				"From : " + $('[id="fromDate"]').val() + " To : "
						+ $('[id="toDate"]').val());
	}
}


function setDefaultDate() {
	var date = $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr);
	var currDate = $.datepicker.formatDate('dd/mm/yy', new Date(date));
	hour = "" + date.getHours();
	if (hour.length == 1) {
		hour = "0" + hour;
	}
	minute = "" + date.getMinutes();
	if (minute.length == 1) {
		minute = "0" + minute;
	}
	second = "" + date.getSeconds();
	if (second.length == 1) {
		second = "0" + second;
	}
	var currTime = hour + ":" + minute + ":" + second;
	var lastDate = $.datepicker.formatDate('dd/mm/yy', new Date(date
			.getFullYear(), date.getMonth(), date.getDate() - 1));
	var lastTime = $.datepicker
			.formatTime('HH:mm:ss', new Date(date.getTime()));
	$('#toDate').val(currDate + ' ' + currTime);
	$('#fromDate').val(lastDate + ' ' + lastTime);
}

function getStates(countryCode, stateCode) {
	var countryList = $.parseJSON($('#countryMapJson').val());
	if(countryCode=='-1'){
	 $('#stateList').html('');
		$('#stateList').append($('<option></option>').val(
										"-1").html("---Please Select---"));
										return;
	}
	$.each(countryList, function(index1, value1) {
		$.each(value1, function(index, value) {
			if (value.countryCode == countryCode) {

			 $('#stateList').html('');
			 $('#stateList').append($('<option></option>').val(
										"-1").html("---Please Select---"));
				$.each(value.stateList, function(index1, value1) {
				
					if (stateCode != value1.stateCode)
						$('#stateList').append(
								$('<option></option>').val(
										value1.stateCode).html(value1.name)

						);
					else
						$('#stateList').append(
								$('<option selected ></option>').val(
										value1.stateCode).html(value1.name)

						);
					
				});

				return;

			}
				
		});
	});
	
}

function createTable(tableId){
	$("#"+tableId).dataTable({
		"sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesAction.action',
		"sAjaxDataProp":"resultList",
		"sServerMethod": "POST",
		"deferRender": true,
		"scrollX": "100%",
	});
}

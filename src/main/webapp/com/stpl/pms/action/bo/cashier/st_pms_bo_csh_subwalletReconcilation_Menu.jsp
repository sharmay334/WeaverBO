<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>SubWallet Reconcilation Report</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
		 $(document).ready(function(){
			 $("#batchDiv").hide();
			$(".dateField").datetimepicker({
						dateFormat : 'dd/mm/yy',
						timeFormat : 'HH:mm:ss',
						showSecond : true,
						maxDate :serverDateStr,
						maxDateTime:$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						onClose : function(dateText, inst) {
							if ($(this).attr('id').indexOf('fromDate') != -1) {
								$('#toDate').datetimepicker("option", "minDate",
										dateText);
								$('#toDate').datetimepicker("option", "minDateTime",
										$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
							} else if ($(this).attr('id').indexOf('toDate') != -1) {
								$('#fromDate').datetimepicker("option", "maxDate",
										dateText);
								$('#fromDate').datetimepicker("option", "maxDateTime",
										$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
							}
						}
					});
					
			$("#Search").on("click",function() {
						$("#Search").hide();
						$("#waitDiv").show();
						$("#batchDiv").show();
						$("#noRecordMsgDiv").hide();
						$("#batchDataDiv").hide();
						var domainId = $("#domainId").val();
						var fromDate = $("#fromDate").val();
						var toDate = $("#toDate").val();
						if (domainId != -1) {
							var map = _ajaxCallJson(
									"com/stpl/pms/action/bo/cashier/st_pms_bo_csh_getSubWalletBatch.action",
									"domainId=" + domainId
											+ "&fromDate="
											+ fromDate
											+ "&toDate="
											+ toDate);
							var count = 0;
							$("#Search").show();
							$("#waitDiv").hide();
							$('#subWalletIds').empty().append(
									$('<option></option>').val("-1").html("----Please Select----"));
							$.each(map,	function(key,value) {
										++count;
								$("#subWalletIds").append(
												$('<option></option>').val(value).html(
														key));		
							});							
							if (count == 0) {
								$("#noRecordMsgDiv").show();
							} else {								
								$("#batchDataDiv").show();
							}

						} else {
							alert("Please select domain id");
						}
						//return ajaxCall($("#subwalletRecFrm"));
					});

			
			$("#subWalletIds").change(function() {
				if($(this).val()!=-1){
					return ajaxCall($("#subwalletRecFrm"));
				}else{
					$("#searchResult").empty();
				}
			});
					
					setDefaultDate();

					

		});
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
	</script>
</head>
<body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>SubWallet Reconcilation Report</h4>
		</div>
		<s:form id="subwalletRecFrm"
			action="st_pms_bo_csh_subwalletRec_search" target="searchResult"
			theme="simple">
			
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain </label>
					</div>
					<div class="InputDiv">
						<div class="small-text-box-div">
							<s:if test="%{domainId>1}">
								<s:hidden value="%{domainId}" id="domainId" name="domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select name="domainId" cssClass="select1" headerKey="-1"
									headerValue="-Please Select-" id="domainId" list="%{domainMap}"
									theme="myTheme" applyscript="true"
									value="%{bydefaultSelectedDomain}" />
							</s:else>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> From Date </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield name="fromDate" cssClass="dateField" id="fromDate"
							theme="myTheme" readonly="true" ></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> To Date </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield name="toDate" cssClass="dateField" id="toDate"
							theme="myTheme" readonly="true" ></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>
			</div>
			<div class="box_footer" align="right">
				<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
					<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div>
				<ss:button id ="Search" name="Search" value="Search" cssClass="button"></ss:button>
			</div>
			
			<div id="batchDiv">
				<div id="noRecordMsgDiv">
					<div class="greyStrip">
						<h4>Message</h4>
					</div>
					<div class="innerBox">
						<div class="alert info_msg">
							<span class="alert_close"></span> <strong>Msg: </strong>No Record
							Found.
						</div>
					</div>
				</div>
				<div id="batchDataDiv">
						<div class="greyStrip">
							<h4>Active Weaver Sub Wallet Batch</h4>
						</div>
					<div class="innerBox">
							<div class="FormMainBox">
								<div class="labelDiv">
									<label>Active Subwallet Batch </label>
								</div>
								<div class="InputDiv">
									<div class="small-text-box-div">
										<ss:select name="subWalletIds" cssClass="select1" headerKey="-1"
											headerValue="-Please Select-" id="subWalletIds" list=""
											theme="myTheme" 
											value="-1"/>
									
									</div>
								</div>	
								
							</div>	
							
					</div>
				</div>
				
			</div>
			
		</s:form>
					
		
	</div>
	
	<div id="searchResult"></div>
</body>
</html>

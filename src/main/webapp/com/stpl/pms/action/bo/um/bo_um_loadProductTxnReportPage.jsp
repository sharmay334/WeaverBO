<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Report
</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%-- <script type="text/javascript"
	src="com/stpl/pms/action/bo/reports/js/common_report.js"></script> --%>
	<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">
	
</head>
<script>
$(document).ready(function() {
	$("#fromDate").datetimepicker(
			{
				dateFormat : 'dd-mm-yy',
				showSecond : false,
				showMinute : false,
				showHour : false,
				changeYear : true,
				changeMonth : true,
				changeDate:true,
				minDate : '01-01-1930',
				onSelect : function(selectedDate) {
					if (selectedDate != "") {
						$("#fromDate").datepicker("option",
								"setDate", selectedDate);
					} else {
						var date = new Date().getDate();
						$(function() {
							$("#fromDate").datepicker({
								dateFormat : 'dd-mm-yy'
							}).datepicker("setDate", date);
						});
					}
				}
			});
	$("#toDate").datetimepicker(
			{
				dateFormat : 'dd-mm-yy',
				showSecond : false,
				showMinute : false,
				showHour : false,
				changeYear : true,
				changeMonth : true,
				changeDate:true,
				minDate : '01-01-1930',
				onSelect : function(selectedDate) {
					if (selectedDate != "") {
						$("#fromDate").datepicker("option",
								"setDate", selectedDate);
					} else {
						var date = new Date().getDate();
						$(function() {
							$("#toDate").datepicker({
								dateFormat : 'dd-mm-yy'
							}).datepicker("setDate", date);
						});
					}
				}
			});
	
	
	 $('form').submit(function() {
     	if($('#providerId').val()==-1){
    			 $('errorDiv'.show());
     		 createBubble();
     	}
     	$("#submitBtn").hide();
			$("#waitDiv").show();
			$("#submitBtn").attr("disabled",true);
			return ajaxCall(this);
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
function showBatches(val){
	$("#waitDiv").show();
	var myurl = "<%=basePath%>";
	 myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_ListBatches.action?itemName="
			+ val;
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			
			if(itr.includes("error")){
				var myoption;
				myoption+="<option value='-1'> No Batches </option>";
				document.getElementById("billList").innerHTML = myoption;
			}else{
				var arr = itr.split(";");
				var myoption="<option value='-1'>Please Select</option>";
				for(var i=0;i<arr.length;i++){
					if(arr[i]!="")
					myoption+="<option>" +arr[i] + "</option>";
				}
				document.getElementById("billList").innerHTML = myoption;
			}
			$("#waitDiv").hide();
		},

		error : function(itr) {

		}
	});
}
</script>
<body>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				Product Transaction Report
			</h4>
		</div>
		<s:form id="searchUserFrm" action="/com/stpl/pms/action/bo/um/bo_um_productTxnReportResult.action"
			 target="searchResult" theme="simple">
			<s:hidden name="reportData" id="reportData"></s:hidden>

			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select Transaction </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:select theme="myTheme" cssClass="select1"
								list="{'SALES','PURCHASE','CREDIT NOTE','DEBIT NOTE'}" name="txnType" id="txnType" headerKey="-1"
								headerValue="--Please Select--"></s:select>

						</div>
					</div>
				</div>
				
				<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select Product </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<s:select theme="myTheme" cssClass="select1"
								list="%{productNames}" name="itemName" id="itemName" headerKey="-1"
								headerValue="--Please Select--" onchange="showBatches(this.value)"></s:select>

						</div>
					</div>
				</div>
				
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select Employee </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:select theme="myTheme" cssClass="select1"
								list="%{employeeNames}" name="employeeName" id="employeeName" headerKey="-1"
								headerValue="--Please Select--" ></s:select>

						</div>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select Party </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:select theme="myTheme" cssClass="select1"
								list="%{ledgerNames}" name="ledgerName" id="ledgerName" headerKey="-1"
								headerValue="--Please Select--" ></s:select>

						</div>
					</div>
				</div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Choose Batch </label>
					</div>
					<div class="InputDiv">
						<div>
						
							<select	name="batchNo" class="select1" id="billList">
										
						  </select>
						</div>
					</div>
				</div>
				
				
			<div class="FormMainBox">

						<div class="labelDiv">
							<label>Select Date</label>
						</div>
						<div class="InputDivHalf">
							<s:textfield id="fromDate" name="fromDate" placeholder="From Date" cssClass="dateField" theme="myTheme" readonly="true" cssStyle="width:30%" />
							<s:textfield id="toDate" name="toDate" placeholder="To Date" cssClass="dateField" theme="myTheme" readonly="true" cssStyle="width:30%" />
						
		
						</div>
					</div>
						
				
			</div>
			<div class="box_footer" align="right">
			 <div id="waitDiv" class="animated-button-div"
					style="margin-left: 0px; display: none;">
					<div class="animated-striped" style="padding: 3px 20px 2px 20px;">Wait...</div>
				</div> 
				<%-- <s:submit name="Search" value="Search" id="searchButton"
					cssClass="button"></s:submit> --%>
					<s:submit theme="simple" id="submitBtn" value="Search"></s:submit>
			</div>
		</s:form>
	</div>
	<div id="searchResult"></div>
	<div id="searchResult1"></div>
</body>
</html>

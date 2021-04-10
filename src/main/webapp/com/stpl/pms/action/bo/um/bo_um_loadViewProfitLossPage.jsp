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

<title>Report</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%-- <script type="text/javascript"
	src="com/stpl/pms/action/bo/reports/js/common_report.js"></script> --%>
	<script src="/WeaverBO/js/sweetalert.min.js"></script>
	
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
					if ($('#providerId').val() == -1) {
						$('errorDiv'.show());
						createBubble();
					}
					$("#submitBtn").hide();
					$("#waitDiv").show();
					$("#submitBtn").attr("disabled", true);
					return ajaxCall(this);
				});

			});

	function ajaxCall(form) {
		var form = $(form);
		var target = form.attr('target');
		var callback = (typeof form.attr('callBack') !== 'undefined') ? form
				.attr('callBack') : '';
		$.ajax({
			type : "POST",
			url : form.attr('action'),
			data : form.serialize(),
			success : function(result) {
				$("#waitDiv").hide();
				$("#submitBtn").show();
				$("#submitBtn").attr("disabled", false);
				
				$('#' + target).html(result);
				eval('createBubble()');
				if (callback != '') {
					eval(callback);
				}
			}
		});
		return false;
	} 
	
	function getDistrict(stateName){
		var frm = $('#pomFrm');
		if(empName!="-1"){
			 $.ajax({
			        type: "GET",
			        url: '/WeaverBO/com/stpl/pms/action/bo/um/bo_um_getDistrict.action?stateName='+stateName,
			        success: function (data) {
			        	if(data=="error"){
			        		
			        		swal("No Record Found!");
			        		
			        		
			        	}
			        	else{
			        		
			        		var arr = data.split(";")
			        		var myoption;
			        		myoption = myoption+"<option>Select District</option>"
			        		for(var i=0;i<arr.length-1;i++){
			        			myoption+="<option>" +arr[i] + "</option>";
			        			
			        		}
			        		document.getElementById('districtName').innerHTML = myoption;
			        		
			        		
			        	}
			        },
			        error: function (data) {
			        	swal("Server Error Occured!");
			        },
			    });
			
			
		}
	}
	function showHideFilterDiv(filterType){
		
		document.getElementById('ledgerDiv').style.display='none';
		document.getElementById('empDiv').style.display='none';
		document.getElementById('itemDiv').style.display='none';
		document.getElementById('stateDiv').style.display='none';
		document.getElementById('districtDiv').style.display='none';
		
		if(filterType=='Ledger Wise'){
			document.getElementById('ledgerDiv').style.display='block';
		}
		else if(filterType=='Employee Wise'){
			document.getElementById('empDiv').style.display='block';
		}
		else if(filterType=='Item Wise'){
			document.getElementById('itemDiv').style.display='block';
		}
		else if(filterType=='State Wise'){
			document.getElementById('stateDiv').style.display='block';
		}
		else if(filterType=='District Wise'){
			document.getElementById('stateDiv').style.display='block';
			document.getElementById('districtDiv').style.display='block';
		}
		
	}
</script>
<body>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>View Profit Loss Report</h4>
		</div>
		<s:form id="searchUserFrm"
			action="/com/stpl/pms/action/bo/um/bo_um_viewProfitLossReport_submit.action"
			target="searchResult" theme="simple">

			<div class="innerBox">
			<div class="FormMainBox">
					<div class="labelDiv">
						<label>Select Filter Type</label>
					</div>
					<div class="InputDiv">
						<s:select name="filterType" headerKey="-1" id="filterType"
								headerValue="--Please Select--" list="{'Ledger Wise','Employee Wise','State Wise','District Wise'}"
								cssClass="select1" theme="myTheme" applyscript="true" errorMassage="Select Filter" onchange="showHideFilterDiv(this.value)"/>
						<div id="filterType_error" class="fieldError">
							<s:fielderror>
								<s:param>filterType</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="FormMainBox" id="ledgerDiv" style="display:none;">
					<div class="labelDiv">
						<label>Select Ledger</label>
					</div>
					<div class="InputDiv">
						<s:select name="ledgerName" headerKey="-1" id="ledgerName"
								headerValue="--Please Select--" list="ledgerNames"
								cssClass="select1" theme="myTheme" errorMassage="Select Ledger"/>
						<div id="ledgerName_error" class="fieldError">
							<s:fielderror>
								<s:param>ledgerName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="FormMainBox" id="empDiv" style="display:none;">
					<div class="labelDiv">
						<label>Select Employee</label>
					</div>
					<div class="InputDiv">
						<s:select name="empName" headerKey="-1" id="empName"
								headerValue="--Please Select--" list="employeeNames"
								cssClass="select1" theme="myTheme" errorMassage="Select Employee"/>
						<div id="empName_error" class="fieldError">
							<s:fielderror>
								<s:param>empName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="FormMainBox" id="itemDiv" style="display:none;">
					<div class="labelDiv">
						<label>Select Item</label>
					</div>
					<div class="InputDiv">
						<s:select name="itemName" headerKey="-1" id="itemName"
								headerValue="--Please Select--" list="itemNameList"
								cssClass="select1" theme="myTheme" errorMassage="Select Item"/>
						<div id="itemName_error" class="fieldError">
							<s:fielderror>
								<s:param>itemName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				
				<div class="FormMainBox" id="stateDiv" style="display:none;">
					<div class="labelDiv">
						<label>Select State</label>
					</div>
					<div class="InputDiv">
						<s:select name="stateName" headerKey="-1" id="stateName"
								headerValue="--Please Select--" list="stateNameList"
								cssClass="select1" theme="myTheme" errorMassage="Select State" onchange="getDistrict(this.value)"/>
						<div id="stateName_error" class="fieldError">
							<s:fielderror>
								<s:param>stateName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="FormMainBox" id="districtDiv" style="display:none;">
					<div class="labelDiv">
						<label>Select District</label>
					</div>
					<div class="InputDiv">
					
						<select id="districtName" name="districtName" class="select1">
						
						</select>
						<%-- <s:select name="districtName" headerKey="-1" id="districtName"
								headerValue="--Please Select--" list="districtList"
								cssClass="select1" theme="myTheme" errorMassage="Select District"/> --%>
						
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
				
				
				
				

				

				<div class="box_footer" align="right">
					<div id="waitDiv" class="animated-button-div"
						style="margin-left: 0px; display: none;">
						<div class="animated-striped" style="padding: 3px 20px 2px 20px;">Wait...</div>
					</div>
					<%-- <s:submit name="Search" value="Search" id="searchButton"
					cssClass="button"></s:submit> --%>
					<s:submit theme="simple" id="submitBtn" value="Show"></s:submit>
				</div>
			</div>
		</s:form>
	</div>
	<div id="searchResult"></div>
</body>
</html>

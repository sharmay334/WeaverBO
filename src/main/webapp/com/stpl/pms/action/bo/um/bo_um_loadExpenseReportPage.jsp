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

<title>Attendance Report
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
	
<script>
	$(document).ready(function() {
				//setDefaultDate();
				$(".dateField").datetimepicker({
		dateFormat : 'dd-mm-yy',
		showSecond : false,
		showMinute : false,
		showHour : false,
		changeYear : true,
		changeMonth : true,
		startDate: '01-01-1980',
		minDate : '01-01-1980',
		onSelect : function(selectedDate) {
			if (selectedDate != "") {
				$("#paymentDate").datepicker("option", "setDate", selectedDate);
			} else {
				var date = new Date().getDate();
				$(function() {
					$("#paymentDate").datepicker({
						dateFormat : 'dd-mm-yy'
					}).datepicker("setDate", date);
				});
			}
		}
	});
				
			});
</script>
</head>

<body>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				Expense Report
			</h4>
		</div>
		<s:form id="searchUserFrm" action="/com/stpl/pms/action/bo/um/st_pms_bo_rep_searchReportExpense.action"
			 target="searchResult" theme="simple">
			<s:hidden name="reportData" id="reportData"></s:hidden>

			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Employee Name </label>
					</div>
					<div class="InputDiv">
						<div>
							<ss:select theme="myTheme" cssClass="select1" list="%{employeeList}"
								name="employeeName" id="employeeName" headerKey="-1" headerValue="--Please Select--">
							</ss:select>
						</div>
					</div>
				</div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> From Date </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield name="fromDate" id="fromDate" cssClass="dateField" readonly="true"
							theme="myTheme"></ss:textfield>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> To Date </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield name="toDate" id="toDate" cssClass="dateField" readonly="true"
							theme="myTheme"></ss:textfield>
					</div>
				</div>


			</div>
			<div class="box_footer" align="right">
			 <div id="waitDiv" class="animated-button-div"
					style="margin-left: 0px; display: none;">
					<div class="animated-striped" style="padding: 3px 20px 2px 20px;">Wait...</div>
				</div> 
				<s:submit name="Search" value="Search" id="searchButton"
					cssClass="button"></s:submit>
			</div>
		</s:form>
	</div>
	<div id="searchResult"></div>
</body>
</html>

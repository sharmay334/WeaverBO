<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Employee Payment Hold</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link href="css/facebox.css" media="screen" rel="stylesheet"
	type="text/css" />
<script src="js/facebox.js" type="text/javascript"></script>
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
	
</script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

<SCRIPT type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/cms/js/cms.js"></SCRIPT>
<script type="text/javascript">
	$(document).ready(
			function() {

				$("#salaryDate").datetimepicker(
						{
							dateFormat : 'dd-mm-yy',
							showSecond : false,
							showMinute : false,
							showHour : false,
							changeDate : true,
							changeYear : true,
							changeMonth : true,
							startDate : '01-01-1980',
							minDate : '01-01-1980',
							onSelect : function(selectedDate) {
								if (selectedDate != "") {
									
								} else {
									var date = new Date().getDate();
									$(function() {
										$("#salaryDate").datepicker({
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
	<div id="container">
		<h2>Employee Payment Hold</h2>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Employee Payment Hold</h4>
			</div>
			<s:form id="searchUserFrm"
				action="/com/stpl/pms/action/bo/um/bo_um_getPaymentReport.action"
				target="searchResult" theme="simple">
				<div class="innerBox">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Employee Name: </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select theme="myTheme" cssClass="select1"
								list="%{employeeNames}" name="empName" id="employeeName"
								headerKey="-1" headerValue="--Please Select--"
								applyscript="true"></s:select>
							<div id="empName_error" class="fieldError">
								<s:fielderror>
									<s:param>empName</s:param>
								</s:fielderror>
							</div>

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>Date</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="salaryDate" name="fromDate"
								 placeholder="Date" cssClass="dateField"
								theme="myTheme" readonly="true" applyscript="true"
								cssStyle="width:50%" />
							<div id="salaryDate_error" class="fieldError">
								<s:fielderror>
									<s:param>salaryDate</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>


				</div>
				<div class="box_footer" align="right">
					<!-- 	<button type="button" theme="simple" onclick="getReport()">Submit</button> -->
					<s:submit name="Search" value="Search" id="searchButton"
						cssClass="button"></s:submit>
				</div>
			</s:form>
		</div>
		<div id="searchResult"></div>
	</div>
</body>
</html>

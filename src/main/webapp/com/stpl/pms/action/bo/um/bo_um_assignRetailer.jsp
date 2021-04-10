<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

<Script>
	$(document).ready(
			function() {
				$("#openingDate").datetimepicker(
						{
							dateFormat : 'dd-mm-yy',
							showSecond : false,
							showMinute : false,
							showHour : false,
							changeYear : true,
							changeMonth : true,
							minDate : '01-01-1930',
							onSelect : function(selectedDate) {
								if (selectedDate != "") {
									$("#openingDate").datepicker("option",
											"minDate", selectedDate);
								} else {
									var date = new Date().getDate();
									$(function() {
										$("#openingDate").datepicker({
											dateFormat : 'dd-mm-yy'
										}).datepicker("setDate", date);
									});
								}
							}
						});

			});

	
	
</Script>
<title>Assign Ledger To User</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Assign Retailer 
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Assign Retailer</h4>
		</div>
		<s:form action="/com/stpl/pms/action/bo/um/bo_um_assign_retailer.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>Retailer Name </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="ledgerName" headerKey="-1"
								headerValue="Select Ledger " list="ledgerNamesList"
								cssClass="select1" theme="myTheme"></s:select>
							<div id="ledgerName_error" class="fieldError">
								<s:fielderror>
									<s:param>ledgerName</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
				
					<div class="clearFRM"></div>
					<div class="">

						<div class="labelDiv">
							<label>Employee Under </label>
						</div>
						<div class="">
							<s:select multiple="true" name="employeeNames" headerKey="-1"
								headerValue="Select Employee Name" list="employeeUnderList"
								cssClass="multipleSelect" theme="myTheme"></s:select>

							<div id="employeeNames_error" class="fieldError">
								<s:fielderror>
									<s:param>employeeNames</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

				</s:if>

			</div>
			<div class="box_footer" align="right">
				<input type="submit" value='Assign Ledger' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

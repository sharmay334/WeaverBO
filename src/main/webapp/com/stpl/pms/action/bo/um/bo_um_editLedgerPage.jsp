<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.stpl.pms.javabeans.UserDetailsBean"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Ledger Info</title>
<SCRIPT type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>
	<script>
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
	</script>
</head>
<body>
	
	<h2>Ledger Info</h2>

	<div class="FormSection">

		<div class="greyStrip">
			<h4>Ledger Info</h4>
		</div>

		<div id="errorDiv"></div>
		<div id="sucessMsg"></div>

		<s:form action="/com/stpl/pms/action/bo/um/bo_um_Ledger_Save.action"
			name="editUserInfo" id="editUserInfo" onsubmit="return chkSub();"
			theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<s:hidden name="ledgerCustomBean.ledgerId" value="%{ledgerCustomBean.ledgerId}"></s:hidden>
			<div class="innerBox">


				<!--form section first start-->

				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Ledger Name</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="ledgerCustomBean.ledgerName" value="%{ledgerCustomBean.ledgerName}" id="ledgerName"
							theme="myTheme" readonly="true"></ss:textfield>
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Prop Name</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="ledgerCustomBean.propName" value="%{ledgerCustomBean.propName}" id="propName"
							theme="myTheme"></ss:textfield>
					
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Contact No</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="ledgerCustomBean.contact" value="%{ledgerCustomBean.contact}" id="contact"
							theme="myTheme"></ss:textfield>
					
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Email Address</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="ledgerCustomBean.email" value="%{ledgerCustomBean.email}" id="email"
							theme="myTheme"></ss:textfield>
					
					</div>

				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Ledger Under</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="ledgerCustomBean.ledgerUnder" value="%{ledgerCustomBean.ledgerUnder}" id="ledgerUnder"
							theme="myTheme" readonly="true"></ss:textfield>
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Employee Under</label>
					</div>
					<div class="InputDiv">
						<s:select name="ledgerCustomBean.underEmp" value="%{ledgerCustomBean.underEmp}"
								id="underEmp" list="employeeUnderList" cssClass="select1" theme="myTheme"></s:select>
					
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Credit Period</label>
					</div>
					<div class="InputDiv">
						<ss:textfield pattern="^[0-9]*$" name="ledgerCustomBean.creditPeriod" value="%{ledgerCustomBean.creditPeriod}" id="creditPeriod"
							theme="myTheme" readonly="true"></ss:textfield>
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Credit Limit Eligible</label>
					</div>
					<div class="InputDiv">
						<s:select name="ledgerCustomBean.creditLimitEligible" value="%{ledgerCustomBean.creditLimitEligible}"
								id="creditLimitEligible" list="{'Yes','No'}" cssClass="select1" theme="myTheme"></s:select>
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Credit Limit</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="ledgerCustomBean.credit_limit" pattern="^[0-9]*$" value="%{ledgerCustomBean.credit_limit}" id="credit_limit"
							theme="myTheme" readonly="true"></ss:textfield>
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Opening Date</label>
					</div>
					<div class="InputDiv">
					<ss:textfield name="ledgerCustomBean.openingDate" value="%{ledgerCustomBean.openingDate}" placeholder="Date" cssClass="dateField"
										id="openingDate" readonly="true" theme="myTheme"></ss:textfield>
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Opening Balance</label>
					</div>
					<div class="InputDiv">
						<ss:textfield name="ledgerCustomBean.openingBalance" value="%{ledgerCustomBean.openingBalance}" id="openingBalance"
							theme="myTheme" pattern="^[0-9.]*$" readonly="true"></ss:textfield>
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">

					<div class="labelDiv">
						<label>Balance Type</label>
					</div>
					<div class="InputDiv">
						<s:select name="ledgerCustomBean.balanceType" value="%{ledgerCustomBean.balanceType}"
								id="balanceType" list="{'Cr','Dr'}" cssClass="select1" theme="myTheme"></s:select>
					
					</div>

				</div>
				
				
				</div>


			
			<div class="box_footer" align="right">
						<input class="button" type="button"
					value='<s:text name="global.EDIT"/>' id="editButton"
					onclick="enableLedgerBoxes()" style="float: right;" />

				
				<input type="submit" value='<s:text name="global.login.submit"/>'
					id="submitButton" style="display: none; width: 73px;"
					class="button" /> <a
					style="color: #000000; font-size: 12px; font-weight: bold; float: right; margin-right: 30px; margin-top: 15px;"
					href="bo_um_viewLedger.action"> <s:text
						name="global.scratchWeaver.BackToSearch" /></a>
			</div>
			
		</s:form>

	</div>
</body>
</html>
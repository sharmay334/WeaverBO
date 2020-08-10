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

<title>Create Voucher</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>
<script>
$(document).ready(
		function() {
			$("#startDate").datetimepicker(
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
								$("#startDate").datepicker("option",
										"minDate", selectedDate);
							} else {
								var date = new Date().getDate();
								$(function() {
									$("#startDate").datepicker({
										dateFormat : 'dd-mm-yy'
									}).datepicker("setDate", date);
								});
							}
						}
					});
			$("#endDate").datetimepicker(
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
								$("#endDate").datepicker("option",
										"minDate", selectedDate);
							} else {
								var date = new Date().getDate();
								$(function() {
									$("#endDate").datepicker({
										dateFormat : 'dd-mm-yy'
									}).datepicker("setDate", date);
								});
							}
						}
					});

		});
function checkNumberingType(type){
	
	if(type=="Automatic"){
		$("#advanceNumbering").css("display", "block");
	}
	else{
		$("#advanceNumbering").css("display", "none");

	}
}

function callForNumbering(type){
	
	if(type=="Yes"){
		$("#advnanceConfigBox").css("display", "block");

	}else{
		$("#advnanceConfigBox").css("display", "none");
	}
		
}
</script>
<body>
	<div class="clear2"></div>
	<h2>
		Create Voucher
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Create Voucher</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_create_voucher.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>Voucher Name</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="voucherBean.voucherName" id="voucherName"
								theme="myTheme" applyscript="true"></ss:textfield>
							<div id="voucherName_error" class="fieldError">
								<s:fielderror>
									<s:param>voucherName</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Select type of voucher</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="voucherBean.voucherType" headerKey="-1"
								headerValue="--Please Select--" list="voucherList"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>

							<div id="voucherType_error" class="fieldError">
								<s:fielderror>
									<s:param>voucherType</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Method of voucher numbering </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="voucherBean.voucherNumbering" headerKey="-1"
								headerValue="Select Any One" list="{'Automatic','Manual'}"
								cssClass="select1" theme="myTheme" applyscript="true" onchange="checkNumberingType(this.value)"></s:select>

							<div id="voucherNumbering_error" class="fieldError">
								<s:fielderror>
									<s:param>voucherNumbering</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div id="advanceNumbering" style="display:none">
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Use Advance Numbering </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="voucherBean.advanceNumbering" headerKey="-1"
								headerValue="Select Any One" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme" onchange="callForNumbering(this.value)"></s:select>

							<div id="voucherNumbering_error" class="fieldError">
								<s:fielderror>
									<s:param>voucherNumbering</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					</div>
					<div id="advnanceConfigBox" style="display:none">
					
					<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable" class="transactionTable">
						<thead>
							<tr>
							    <th style="text-align: center;" nowrap="nowrap">Decimal Digit(ex 01/001)</th>
								<th style="text-align: center;" nowrap="nowrap">Starting Number</th>
								<th style="text-align: center;" nowrap="nowrap">Prefix</th>
								<th style="text-align: center;" nowrap="nowrap">Suffix</th>
							</tr>
						</thead>
						<tbody>

							<tr id="rowId1">
							 <td style="text-align: center;" nowrap="nowrap"><ss:textfield maxlength="40"
								name="voucherBean.decimalNumber" pattern="^[0-9]*$" id="decimalNumber"
								theme="myTheme"></ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield maxlength="40"
								name="voucherBean.startingNumber" pattern="^[0-9]*$" id="startingNumber"
								theme="myTheme"></ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
								<ss:textfield maxlength="40"
								name="voucherBean.prefix" id="prefix"
								theme="myTheme"></ss:textfield>
								</td>
								<td style="text-align: center;" nowrap="nowrap">
								<ss:textfield maxlength="40"
								name="voucherBean.suffix" id="suffix"
								theme="myTheme"></ss:textfield>
								</td>

							</tr>


						</tbody>
					</table>
					
					
					</div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Use effective date of voucher </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="voucherBean.effctvDateOfVchr" headerKey="-1"
								headerValue="Select Any One" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>

							<div id="effctvDateOfVchr_error" class="fieldError">
								<s:fielderror>
									<s:param>effctvDateOfVchr</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Voucher Start Date </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield
										name="voucherBean.startDate" placeholder="Date" cssClass="dateField"
										id="startDate" readonly="true" theme="myTheme"></ss:textfield>

							<div id="startDate_error" class="fieldError">
								<s:fielderror>
									<s:param>startDate</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Voucher End Date </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield
										name="voucherBean.endDate" placeholder="Date" cssClass="dateField"
										id="endDate" readonly="true" theme="myTheme"></ss:textfield>

							<div id="endDate_error" class="fieldError">
								<s:fielderror>
									<s:param>endDate</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Allow narration in voucher </label>
						</div>
						<div class="InputDiv">
							<s:select name="voucherBean.narrationAllowed" headerKey="-1"
								headerValue="Select Any One" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>

							<div id="narrationAllowed_error" class="fieldError">
								<s:fielderror>
									<s:param>narrationAllowed</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

				</s:if>

			</div>
			<div class="box_footer" align="right">
				<%-- <s:submit value="Search" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
					 --%>
				<input type="submit" value='Create' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

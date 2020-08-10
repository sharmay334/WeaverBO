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
<title>Edit Voucher Details</title>
<SCRIPT type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>

</head>
<body>
	<h2>Edit Voucher Details</h2>

	<div class="FormSection">

		<div class="greyStrip">
			<h4>Voucher Info</h4>
		</div>

		<div id="errorDiv"></div>
		<div id="sucessMsg"></div>

		<s:form action="/com/stpl/pms/action/bo/um/bo_um_Voucher_Save.action"
			name="editUserInfo" id="editUserInfo" onsubmit="return chkSub();"
			theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			  <s:hidden name="voucherBean.voucherId" value="%{voucherId}"></s:hidden>
			<%--<s:hidden name="companyBean.fyb" value="%{companyBean.fyb}"></s:hidden>
			<s:hidden name="companyBean.bbf" value="%{companyBean.bbf}"></s:hidden>
		 --%>
			<div class="innerBox">


				<!--form section first start-->
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Voucher Name</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="voucherBean.voucherName"
							id="voucherName" theme="myTheme" readOnly="true"
							applyscript="true"></ss:textfield>
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
							id="voucherType" disabled="true" headerValue="--Please Select--"
							list="voucherList" cssClass="select1" theme="myTheme"
							applyscript="true"></s:select>

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
							id="voucherNumbering" disabled="true"
							headerValue="Select Any One" list="{'Automatic','Manual'}"
							cssClass="select1" value="voucherBean.voucherNumbering" theme="myTheme" applyscript="true"></s:select>

						<div id="voucherNumbering_error" class="fieldError">
							<s:fielderror>
								<s:param>voucherNumbering</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">

					<div class="labelDiv">
						<label> Use effective date of voucher </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="voucherBean.effctvDateOfVchr" headerKey="-1"
							headerValue="Select Any One" disabled="true"
							id="effctvDateOfVchr" list="{'Yes','No'}" cssClass="select1"
							theme="myTheme" value="voucherBean.effctvDateOfVchr" applyscript="true"></s:select>

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
						<label> Allow narration in voucher </label>
					</div>
					<div class="InputDiv">
						<s:select name="voucherBean.narrationAllowed" headerKey="-1"
							headerValue="Select Any One" disabled="true"
							id="narrationAllowed" list="{'Yes','No'}" cssClass="select1"
							theme="myTheme" applyscript="true"></s:select>

						<div id="narrationAllowed_error" class="fieldError">
							<s:fielderror>
								<s:param>narrationAllowed</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>

			</div>
			<div class="box_footer" align="right">
				<%-- <a style="color: #000000; font-size:12px;font-weight:bold;float:left;margin-left:15px;margin-top:12px" href="bo_um_searchBoUser_ResetPassBO.action?user_id=<s:property value="userDetailsBean.UserId"/>&&emailId=<s:property value="userDetailsBean.emailId"/>&&firstName=<s:property value="userDetailsBean.firstName"/>&&lastName=<s:property value="userDetailsBean.lastName"/>&&userName=<s:property value="userDetailsBean.userName"/>"
			id="resetPlayerPass_<s:property value="userDetailsBean.firstName"/>"
					name="<s:property value="userDetailsBean.userName"/>">Reset Password</a>	 --%>
				<!--<a href="javaScript:void(0);" class="reset_password"  style="color: #000000; font-size:12px;font-weight:bold;float:left;margin-left:15px;margin-top:12px"
							onclick="resetPasswordBO('bo_um_searchBoUser_ResetPassBO.action?user_id=<s:property value="userDetailsBean.UserId"/>&&emailId=<s:property value="userDetailsBean.emailId"/>&&firstName=<s:property value="userDetailsBean.firstName"/>&&lastName=<s:property value="userDetailsBean.lastName"/>&&userName=<s:property value="userDetailsBean.userName"/>','<s:property value="userDetailsBean.emailId"/>')">Reset
							Password</a>
	-->
				<input class="button" type="button"
					value='<s:text name="global.EDIT"/>' id="editButton"
					onclick="enableBoxesVoucher()" style="float: right;" />

				<%-- <s:submit value="Submit" id="submitButton"
							cssStyle="display: none;width:73px;" cssClass="button" 
							theme="simple" />
				 --%>
				<input type="submit" value='<s:text name="global.login.submit"/>'
					id="submitButton" style="display: none; width: 73px;"
					class="button" /> <a
					style="color: #000000; font-size: 12px; font-weight: bold; float: right; margin-right: 30px; margin-top: 15px;"
					href="bo_um_viewVoucher.action"> <s:text
						name="global.scratchWeaver.BackToSearch" /></a>
			</div>

		</s:form>

	</div>
</body>
</html>
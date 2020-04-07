<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" contentType="text/html"%>
<%@ page import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>Privilege Manager</title>
<SCRIPT type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>
<script type="text/javascript">
	$(function() {
		$("#privForm").submit(function() {
			$("#groupNameCode").val($("#groupNameCode").val().trim());
		});
	})
</script>
</head>
<body>
	<div id="container">
		<h2>Privilege Management</h2>
		<s:form
			action="/com/stpl/pms/action/bo/um/st_pms_bo_um_addPrivilege.action"
			id="privForm" theme="simple" method="POST" name="privilegeForm">
			<s:token name="strutsToken" id="strutsToken" />
			<div id="centerdiv">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>Add new Privileges</h4>
					</div>
					<div class="innerBox">

						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Function Name </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield name="fnName" pattern="^[A-z]+$"
									errorMassage="Only characters allowed" applyscript="true"></ss:textfield>
								<div id="address_error" class="fieldError">
									<s:fielderror>
										<s:param>Function Name </s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Privilege Name Code </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield name="privNameCode" id="privNameCode"
									pattern="^[A-z]+$" errorMassage="Only characters allowed"
									applyscript="true"></ss:textfield>
								<div id="address_error" class="fieldError">
									<s:fielderror>
										<s:param>Function Name</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Group Name Code</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield name="groupNameCode" id="groupNameCode"
									maxlength="55" applyscript="true"></ss:textfield>
								<div id="address_error" class="fieldError">
									<s:fielderror>
										<s:param>Function Name</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>

						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Tier </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="tier" headerKey="-1"
									headerValue="-- Please Select --" cssClass="select1"
									list="#{'BO':'BO','DOMAIN':'DOMAIN'}" applyscript="true" />
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Related To </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="relatedTo" headerKey="-1"
									headerValue="-- Please Select --" cssClass="select1"
									list="#{'COMM_MGMT':'Communication Managememt','USER_MGT':'User Management','ROLE_MGT':'Role Management','PLAYER_MGT':'Player Management','ACT_MGT':'Account Management','GAME_MGT':'Game Management','PLAY_MGT':'Play Management','LOGIN_MGT':'Login Management','HURDLE_MGT':'Hurdle Management','CMS':'Content Management System','RG':'Responsible Gaming','REPORTS':'Reports','MISC':'Miscellaneous','SERVICE_MGMT':'Service Management','DOMAIN_MGT':'Domain Management','RISK_MGT':'Risk Management','CASHIER':'Cashier','BONUS':'Bonus','LOYALTY':'Loyalty'}"
									theme="myTheme" applyscript="true" />
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Check Login </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="checkLogin" headerKey="-1"
									headerValue="-- Please Select --" cssClass="select1"
									list="#{'Y':'Yes','N':'No'}" applyscript="true" />
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Is Default </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="isDefault" headerKey="-1"
									headerValue="-- Please Select --" cssClass="select1"
									list="#{'Y':'Yes','N':'No'}" applyscript="true" />
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Is Default Group</label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select name="isDefaultGroup" headerKey="-1"
									headerValue="-- Please Select --" cssClass="select1"
									id="isDefaultGroup" list="#{'Y':'Yes','N':'No'}"
									applyscript="true" />
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Action name</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield name="actionName" id="actionName"
									pattern="^[A-z]+$" errorMassage="Only characters allowed"
									applyscript="true" applyscript="true"></ss:textfield>
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Action description</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield name="actionDesc" applyscript="true"></ss:textfield>
							</div>
						</div>
						<div class="box_footer" align="right">
							<s:submit name="createPrivilege" value="Create Privilege"
								cssClass="button"></s:submit>
						</div>
					</div>
				</div>
			</div>
		</s:form>
		<div style="margin-bottom: 50px;"></div>
	</div>
	<br />
</body>
</html>
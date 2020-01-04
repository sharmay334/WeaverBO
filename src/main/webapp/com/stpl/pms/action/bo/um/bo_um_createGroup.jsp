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

<title>Create Group</title>
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
		Create Group
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Create Group</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_create_group.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Name
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="groupName" id="groupName"
								theme="myTheme"
								applyscript="true"></ss:textfield>
							<div id="groupName_error" class="fieldError">
								<s:fielderror>
									<s:param>groupName</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Under </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="groupUnder" headerKey="-1"
								headerValue="Select Group Name" list="groupNamesList"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>
								
							<div id="groupUnder_error" class="fieldError">
								<s:fielderror>
									<s:param>groupUnder</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Group behaves like a sub-legers </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="subLedger" headerKey="-1"
								headerValue="Select Any One" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>
								
							<div id="subLedger_error" class="fieldError">
								<s:fielderror>
									<s:param>subLedger</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Nett Debit/Credit balance for report </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="blncForRep" headerKey="-1"
								headerValue="Select Any One" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>
								
							<div id="blncForRep_error" class="fieldError">
								<s:fielderror>
									<s:param>blncForRep</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Used for calculation </label>
						</div>
						<div class="InputDiv">
							<s:select name="forCalc" headerKey="-1"
								headerValue="Select Any One" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>
								
							<div id="forCalc_error" class="fieldError">
								<s:fielderror>
									<s:param>forCalc</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Method to allocate when used in &nbsp;&nbsp;&nbsp;purchase invoice </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="purInvoice" headerKey="-1"
								headerValue="Select Any One" list="{'Applicable','Not Applicable'}"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>
							<div id="purInvoice_error" class="fieldError">
								<s:fielderror>
									<s:param>purInvoice</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
										
					
				</s:if>

			</div>
			<div class="box_footer" align="right">
				<%-- <s:submit value="Search" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
					 --%>
				<input type="submit"
					value='Create Group' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

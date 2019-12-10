<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		
		<title>Search User</title>
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
			<s:text name="global.home.searchuserheader"/>
			<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
		</h2>

		<!--form section first start-->
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					<s:text name="global.searchuser.requiredinformation"/>
				</h4>
			</div>
			<s:form action="/com/stpl/pms/action/bo/um/bo_um_searchBoUser_Search.action" id="searchUserFrm"
				theme="simple" target="searchDiv">
				<div class="innerBox">
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>
								<s:text name="global.searchuser.firstname"/>
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield name="userName" id="userName" theme="myTheme"
								maxlength="25" pattern="^[a-zA-Z]*$"
								errorMassage="Numeric and Special character not allowed">
							</ss:textfield>
							<div class="fieldError">
								<s:fielderror>
									<s:param>userName</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">


						<div class="FormMainBox">

							<div class="labelDiv">
								<label>
									<s:text name="global.searchuser.department"/>
								</label>
							</div>
							<div class="InputDiv">
								<s:select name="roleId" headerKey="-1"
									headerValue="%{getText('global.SELECTHEADER')}" list="roleMap"
									cssClass="select1" theme="myTheme"></s:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">

							<div class="labelDiv">
								<label>
									<s:text name="global.searchuser.Type"/>
								</label>
							</div>
							<div class="InputDiv">
								<s:select name="type" list="{'Sub Users'}"
									cssClass="select1" onchange="" theme="myTheme"></s:select>
							</div>
						</div>
					</s:if>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>
								<s:text name="global.searchuser.Status"/>
							</label>
						</div>
						<div class="InputDiv">

						<%-- 	<s:select name="status"
								list="#{'-1':'--Please Select--','Active':'Active','Inactive':'Inactive','Terminate':'Terminate'}"
								cssClass="select1" theme="myTheme"></s:select> --%>
								
								<select name="status" class="select1">
								<option value="-1"><s:text name="global.SELECTHEADER"/></option>
								<option value="Active"><s:text name="global.searchuser.statusActive"/></option>
								<option value="Inactive"><s:text name="global.searchuser.statusInactive"/></option>
								<option value="Terminate"><s:text name="global.searchuser.statusTerminate"/></option>
								</select>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<%-- <s:submit value="Search" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
					 --%>	
						<input type="submit" value='<s:text name="global.searchuser.search"/>' align="left" style="margin-left:0px"
						class="button"/>
				</div>
			</s:form>
		</div>
		<div id="searchDiv"></div>
		<br />
		<br />
	</body>
</html>

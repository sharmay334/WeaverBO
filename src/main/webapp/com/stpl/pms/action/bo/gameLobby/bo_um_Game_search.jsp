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

<title>Game Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>
<body>
	<div class="clear2"></div>
	<h2><s:text name="global.home.searchgameheader"/></h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4><s:text name="global.searchuser.requiredinformation" /></h4>
		</div>
		<s:form action="/com/stpl/pms/action/bo/gl/st_test_submit_btn.action" id="searchGameFrm"
			theme="simple" target="searchDiv">


			<div class="FormMainBox">
				<div class="labelDiv">
					<label> <s:text name="global.subuserregistration.UserName"/> </label>
				</div>
				<div class="InputDivHalf">
					<ss:textfield id="userName" name="userName" theme="myTheme"
						 maxlength="25" pattern="^[a-zA-Z]*$"
						errorMassage="Numeric and Special character not allowed"></ss:textfield>
				</div>
			</div>
			
			<div class="clearFRM"></div>

			<div class="FormMainBox">
				<div class="labelDiv">
					<label> <s:text name="global.searchgames.GameName"/></label>
				</div>
				<div class="InputDivHalf">
					<ss:textfield id="gameName" name="gameName" theme="myTheme"
						 maxlength="25" pattern="^[a-zA-Z0-9 ]*$"
						errorMassage="Numeric and Special character not allowed"></ss:textfield>
				</div>
			</div>
			<div class="clearFRM"></div>




			<div class="FormMainBox">
				<div class="labelDiv">
					<label> <s:text name="global.searchgames.GameNo"/></label>
				</div>
				<div class="InputDivHalf">
					<ss:textfield id="gameNO" name="gameNO" theme="myTheme"
						theme="myTheme" value="" maxlength="3" pattern="^[0-9]*$"
						errorMassage="Alphabet and Special character not allowed"></ss:textfield>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> <s:text name="global.searchgames.TicketCost"/> </label>
				</div>
				<div class="InputDivHalf">
					<ss:textfield id="ticketPrize" name="ticketPrize" theme="myTheme"
						theme="myTheme" maxlength="10" pattern="^[0-9.]*$"
						errorMassage="Alphabet and Special character not allowed"></ss:textfield>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="box_footer" align="right">
		<input type="submit" value='<s:text name="global.searchuser.search" />' align="left" style="margin-left:0px"
			class="button">
			<%-- <s:submit value="<s:property value="getText('global.searchuser.search')" />" align="left" cssStyle="margin-left:0px"
			cssClass="button" theme="simple"></s:submit> --%>
	</div>
	</s:form>
	</div>
	
	
	
	
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>
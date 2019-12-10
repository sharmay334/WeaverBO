<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.stpl.pms.utility.Utility"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
			 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<title>Forgot Password</title>
		<link href="<%=path %>/css/boLogin.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/js/boLogin.js"></script>
	</head>

	<body>
	<div id="OuterLoginBox" style="text-align: center;">
<img src="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/logo_login.png" alt="logo" />
		<div id="loginBoxmain" style="height: 230px; text-align: left;">
			<div class="greyStrip">
				<p>
					<s:text name="global.FORGOT_PASS"></s:text>
				</p>
			</div>
			
			
			<div class="userbox-login">
				<s:form name="login"
					action="bo_lm_forgotPassword" method="post" namespace="/com/stpl/pms/action/bo/lm">
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<div id="userNameError" class="fieldError" style="font-size: 12px; color: #FF0000; padding-left:22px"><s:property value="errorMsg"/></div>
					<s:text name="global.forgotpass.email"></s:text>:
					<input type="text" name="emailId" id="emailId"/>
					
					<br />
										
					<div style="float: right">
						<input type="submit" value='<s:text name="global.login.submit"/>' class="inpSubmit" />
						
						<a href="<%= request.getContextPath()%>/com/stpl/pms/action/bo/lm/locale.action?request_locale=<%=session.getAttribute("localeValue") %>" class="inpSubmit"><s:text name="global.searchgames.cancel"></s:text></a>
					</div>
					
				</s:form>
				 <div id="copyRight"> <h6><jsp:include page="/com/stpl/pms/action/bo/common/copyright-client-specific.jsp"/></h6></div>
			</div>

		</div>
		</div>
	</body>
</html>







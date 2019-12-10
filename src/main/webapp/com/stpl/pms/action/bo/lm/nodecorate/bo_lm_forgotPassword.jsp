<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.stpl.pms.utility.Utility"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String path = request.getContextPath();
%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Forgot Password</title>
		<link href="<%=path %>/css/boLogin.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/js/boLogin.js"></script>
	</head>

	<body>
	<div id="OuterLoginBox" style="text-align: center;">
 <img src="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/logo_login.png" alt="logo" />
		<div id="loginBoxmain" style="text-align: left;">
			<div class="greyStrip">
				<p>
					<s:text name="global.forgotpass.msg1"></s:text>
				</p>
			</div>
			
			<div class="userbox-login">
				
				<p align="left" style="padding-left:10px">
					<s:text name="global.forgotpass.msg2"></s:text>
				</p>

					<div style="float: right; margin-top:60px">
						<input type="submit" value="Back To Login" class="inpSubmit" 
						onclick="location.href='<%=path%>/backoffice/login/NewLogin/'"/>
					</div>
				
				 <div id="copyRight"> <h6><jsp:include page="/com/stpl/pms/action/bo/common/copyright-client-specific.jsp"/></h6></div>
			
			</div>

		</div>
		</div>
	</body>
</html>







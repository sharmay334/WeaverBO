<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.stpl.pms.utility.Utility"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<title>Weaver::Session Time Out</title>
		<link href="css/boLogin.css" rel="stylesheet"
			type="text/css" />
		<link rel="shortcut icon" href="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/favicon.ico" type="image/x-icon"/>
	</head>

	<body>
		<div id="OuterLoginBox" style="text-align: center">
			<img src="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/logo_login.png"
				alt="logo" />
			<div id="loginBoxmain" style="height: 200px; text-align:left">
				<div class="greyStrip">
					<p>
						<s:text name="global.sessiontimeout"></s:text>
					</p>
				</div>

				<div class="userbox-login">
					<b style="font-size: 16px"> <s:text name="global.sessiontimeoutmsg"></s:text>! </b>
					<a
						href="com/stpl/pms/action/bo/lm/bo_lm_newLogin.action"
						style="text-decoration: underline"><b><s:text name="global.session.login"/></b>
					</a>
				</div>
			</div>
			<div id="copyRight">
				<h6>
					<jsp:include page="/com/stpl/pms/action/bo/common/copyright-client-specific.jsp"/>
				</h6>
			</div>
		</div>
	</body>
</html>






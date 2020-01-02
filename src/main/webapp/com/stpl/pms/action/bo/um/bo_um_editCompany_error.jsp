<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Error editing</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

	</head>

	<body>
		<div class="clear2"></div>
		<!-- error messsge  start -->
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Error Editing
				</h4>
			</div>
			<div class="innerBox">
				<div class="alert error_msg">
					<span class="alert_close"></span><strong>Error Editing Company: </strong> <s:actionerror theme="simple"/>
				</div>
			</div>
		</div>
	</body>
</html>

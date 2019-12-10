<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Success</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	</head>

	<body>
		<div class="clear2"></div>
		<!-- error messsge  start -->
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Message
				</h4>
			</div>
			<div class="innerBox">
				<div class="alert succes_msg">
					<span class="alert_close"></span><strong>Succes: </strong> Player's Wallet Updated Successfully.
				</div>
			</div>
		</div>
	</body>
</html>

<%@page import="com.stpl.pms.utility.Utility"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.stpl.pms.javabeans.UserInfoBean"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "-1");
	String path = request.getContextPath();
	System.out.print(path);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<s:set name="contextPath"
			value="#request.get('javax.servlet.include.context_path')"
			scope="session" />
		<title>Weaver-<decorator:title /> </title>
		
		<link rel="shortcut icon" href="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/favicon.ico" type="image/x-icon"/>
		
		<script type="text/javascript" src="<%=path%>/js/jQuery/jquery-1.8.3.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/jQuery/jquery-ui-1.8.16.custom.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/ajaxCall.js"></script>
		<script type="text/javascript" src="<%=path%>/js/cashier.js"></script>
		<link rel="stylesheet" href="<%=path%>/css/old/jquery-ui.css" />
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/old/new_deposit.css" />
		<decorator:head />
	</head>
	 <body>
		<decorator:body />
	</body>
</html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
	<div class="alert saved_msg">
		<span class="alert_close"></span> <strong>Saved: </strong> .
		<s:if test="%{pushAppToAll}">
 	           	AppVersion Pushed Successfully.
		</s:if>
	</div>
</body>
</html>

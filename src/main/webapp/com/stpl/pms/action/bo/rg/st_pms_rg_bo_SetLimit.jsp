<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Success page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
   <div class="FormSection">
			<div class="greyStrip">
				<h4>
					Update Operator Limit Detail Result
				</h4>
			</div>
			<div class="innerBox">
					<div id="errorDiv" class="fieldError"></div>
					<div class="innerBox">
						<div class="alert saved_msg"><span class="alert_close"></span><strong>Saved: </strong>
						updated RG Operator Limit SuccessFully</div>
					         </div>  
				</div>
					
	</div>
  </body>
</html>

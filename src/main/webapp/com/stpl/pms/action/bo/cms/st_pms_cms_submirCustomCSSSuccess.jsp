<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'st_pms_cms_submirCustomCSSSuccess.jsp' starting page</title>
    
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
					Update Custom CSS Detail Result
				</h4>
			</div>
			<div class="innerBox">
					<div id="errorDiv" class="fieldError"></div>
					<div class="innerBox">
						<div class="alert saved_msg"><span class="alert_close"></span><strong>Saved: </strong>
						custom CSS updated Successfully.</div>
					         </div>  
			</div>
					
	</div>		         
  </body>
</html>

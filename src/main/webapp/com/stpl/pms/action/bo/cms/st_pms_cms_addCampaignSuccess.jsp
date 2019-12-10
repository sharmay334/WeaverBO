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
    
    <title>Add Campaign Success page</title>
    
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
   <div class="FormSection">
			<div class="greyStrip">
				<h4>
					Add Campaign Detail Result
				</h4>
			</div>
			<div class="innerBox">
					<div id="errorDiv" class="fieldError"></div>
					<div class="innerBox">
						<div class="alert saved_msg"><span class="alert_close"></span><strong>Saved: </strong>
						Campaign Added/updated SuccessFully.Please Find Below Details.</div>
					         </div>  
					<table id="payTransaction" class="payTransaction" align="center"
						cellspacing="0" cellpadding="4" border="0">
						<tbody>
							<tr>
								<th height="28" width="4%" align="left" valign="middle">
									Campaign Name
								</th>
								<th height="28" width="28%" align="left" valign="middle">
									Url
								</th>
							</tr>
							<s:iterator value="landingPageUrlDetail" status="landingPageUrlDetail">
								<tr>
									<td align="left" valign="middle">
										<s:property value="%{key}" />
									</td>
									<td align="left" valign="middle">
										<s:property value="%{value}" />
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
					
	</div>
  </body>
</html>

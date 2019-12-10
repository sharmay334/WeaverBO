<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/extended-struts2-tags" prefix="ss" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	

	
  </head>
  
  <body>
  	<div class="plrTicketInfo">
			<div class="FormSection tblBorder">
				<div class="greyStrip">
					<h4>Ticket Information </h4>
				</div>
				<div class="FormMainBox styleBox01">
				 
				
				<%-- <s:if test="ticketDetailBeans != null">
			<s:if test="ticketDetailBeans.size()!= 0"> --%>
				<table class="tableNoStyle01" width="95%"  cellpadding="0" cellspacing="0" align="center" style="margin-left: 40px;font-size: 12px;color: #2b2b2b; line-height:45px">
						
					<tbody>
				<tr>
				<td width="25%" align="center">Ticket No :</td>
				<td width="25%" align="center">11133<s:property value="User Id" /></td>
				</tr>
				<tr class="clearFRM"></tr> 
				<tr>
				<td width="25%" align="center">Game Name :</td>
				<td width="25%" align="center">SBS<s:property value="User Id" /></td>
				</tr>
				<tr class="clearFRM"></tr> 
				<tr>
				<td width="25%" align="center">Purchase Date :</td>
				<td width="25%" align="center">2017-08-02<s:property value="User Id" /></td>
				</tr>
				<tr class="clearFRM"></tr> 
				<tr>
				<td width="25%" align="center">Merchant Name :</td>
				<td width="25%" align="center">MTN<s:property value="User Id" /></td>				
				</tr>
				<tr class="clearFRM"></tr> 
				<tr>
				<td width="25%" align="center">User Id :</td>
				<td width="25%" align="center">11<s:property value="User Id" /></td>
				</tr>
				<tr class="clearFRM"></tr> 
				<tr>
				<td width="25%" align="center">Amount :</td>
				<td width="25%" align="center">1000<s:property value="User Id" /></td>
				</tr>
				<tr class="clearFRM"></tr> 
				<tr>
				<td width="25%" align="center">No Of Draw :</td>
				<td width="25%" align="center">5<s:property value="User Id" /></td>
				</tr>
				</tbody>
				</table>
		<%-- 	</s:if>

		</s:if> --%>
			
				
				</div>
			</div>
		</div>
		
  </body>
</html>

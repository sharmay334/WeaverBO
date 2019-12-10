<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
			
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<title>
		Domain Check List
	</title>

	<body>
		<div class="clear2"></div>
		<div class="FormSection">
		<div class="innerBox" style="margin: 29px auto 0;" >
		<table width="830" cellspacing="0" cellpadding="4" border="1" align="center" class="payTransaction">
			<thead>
				<tr> 
					<th width="25%" valign="middle" align="left" class="name">
						Name
					</th>
					<th width="25%" valign="middle" align="left" class="status">
						Status
					</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="%{domainCheckList}">
					<tr>
						<td> <s:property value="%{key}" /> </td>
						<td> <s:property value="%{value}" /> </td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<br/>
		<br/>
		</div>	
		</div>
	</body>		
</html>
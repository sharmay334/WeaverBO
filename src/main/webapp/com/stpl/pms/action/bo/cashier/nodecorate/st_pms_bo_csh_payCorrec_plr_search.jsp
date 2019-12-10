<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Player Result</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{plrList!=null && plrList.size()>0}">
				<div class="greyStrip">
					<h4 style="float: left">
						Player Information
					</h4>
				</div>
				<div class="innerBox">
					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction">
						<thead>
							<tr>
								<th width="10%" valign="middle" align="left">
									Domain Name
								</th>
								<th width="15%" valign="middle" align="left">
									User Name
								</th>
								<th width="20%" valign="middle" align="left" >
									Player Name
								</th>
								<th width="10%" valign="middle" align="left" >
									VIP Level
								</th>
								<th width="15%" valign="middle" align="left" >
									
								</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{plrList}" status="plrList">
								<tr>
								    <td> <s:property value="%{domainMap.get(domainId)}" /> </td>
								    <td> <s:property value="%{userName}" /> </td>
								    <td><s:property value="%{firstName + ' ' + lastName}" /> </td>
								    <td><s:property value="%{vipLevel}" /> </td>
								    <td>
										<%-- <a
											href="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_plrPaymentCorrection.action?payCorrection.playerId=<s:property value="%{playerId}"/><!-- &payCorrection.aliasId=<s:property value="%{aliasId}"/> -->&payCorrection.domainId=<s:property value="%{domainId}"/>&userName=<s:property value="%{userName}"/>"
											target="correctionForm">Correction</a> --%>
											 <a
											href="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_plrPaymentCorrection.action?payCorrection.playerId=<s:property value="%{playerId}"/>&payCorrection.domainId=<s:property value="%{domainId}"/>&userName=<s:property value="%{userName}"/>"
											target="correctionForm">Correction</a> 
									</td>
								</tr>
						</s:iterator>
						</tbody>
					
						
						
					</table>
				</div>
				<div class="box_footer">
					
				</div>
			</s:if>
			<s:else>
				<div class="greyStrip">
					<h4>
						Error Message
					</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>

		</div>
   <div id="correctionForm">
   		
   </div>
	</body>
</html>


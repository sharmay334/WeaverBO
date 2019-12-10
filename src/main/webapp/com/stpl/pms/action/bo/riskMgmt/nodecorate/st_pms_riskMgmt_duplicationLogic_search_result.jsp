<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

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
    <script type="text/javascript">
      
    
    </script>
  </head>
  
  <body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>
				<s:property value="%{userName}" /> Duplication Score
			</h4>
		</div>
		<div class="innerBox">
			<table width="830" cellspacing="0" cellpadding="4" border="0"
				align="center" class="transactionTable" id="scoreTable1">
					<tr >
					   <th height="28" valign="middle" align="left">
							New Player
						</th>
					   <th height="28" align="left" valign="middle">
									User Name
								</th>
								<th height="28" align="left" valign="middle">
									First Name
								</th>
								<th height="28" align="left" valign="middle">
									Last Name
								</th>
								<th height="28" align="left" valign="middle">
									Registration Date
								</th>
								<th height="28" valign="middle" align="left">
							         Score
						        </th>
								<th height="28" width="200px" align="left" valign="middle">
									Player Status
								</th>
					</tr>
					<tbody>
					<s:iterator value="scoreActionBeansList" status="score">
						<s:if test="%{newPlayerId != null}">
					
						<tr>
							<td valign="middle" height="20" align="left">
							<s:hidden value="%{newPlayerId}" /></td>
								
							<td valign="middle" height="20" align="left">
							<s:property value="userName" /></td>
							
							<td valign="middle" height="20" align="left">
							<s:property value="firstName" /></td>
							
							<td valign="middle" height="20" align="left">
							<s:property value="lastName" /></td>	
							
							<td valign="middle" height="20" align="left">
							<s:property value="registrationDate" /></td>
							
							<td valign="middle" height="20" align="left">
							<s:property value="score" />
							</td>
							<td>
							<ss:select theme="myTheme" cssStyle="width:200px" cssClass="select1"
												list="{'ACTIVE','INACTIVE'}" name="status"
												id="status" headerKey="-1" headerValue="--Please Select--"></ss:select>
							</td>
							
						</tr>
						</s:if>
					</s:iterator>
					</tbody>	
				</table>
					
			<table width="830" cellspacing="0" cellpadding="4" border="0"
				align="center" class="transactionTable" id="scoreTable2">
					<tr>
					   <th height="28" valign="middle" align="left">
							Old Player 
						</th>
					   <th height="28" align="left" valign="middle">
									User Name
								</th>
								<th height="28" align="left" valign="middle">
									First Name
								</th>
								<th height="28" align="left" valign="middle">
									Last Name
								</th>
								<th height="28" align="left" valign="middle">
									Registration Date
								</th>
								<th height="28" valign="middle" align="left">
							         Score
						        </th>
								<th height="28" width="200px" align="left" valign="middle">
									Player Status
								</th>
						
					</tr>
					<tbody>
					<s:iterator value="scoreActionBeansList" status="score">
						<s:if test="%{oldPlayerId != null}">
						<tr>
							<td valign="middle" height="20" align="left">
							<s:hidden value="%{oldPlayerId}" /></td>
								
							<td valign="middle" height="20" align="left">
							<s:property value="userName" /></td>
							
							<td valign="middle" height="20" align="left">
							<s:property value="firstName" /></td>
							
							<td valign="middle" height="20" align="left">
							<s:property value="lastName" /></td>	
							
							<td valign="middle" height="20" align="left">
							<s:property value="registrationDate" /></td>
							
							<td valign="middle" height="20" align="left">
							<s:property value="score" />
							</td>
							<td>
							<ss:select theme="myTheme" cssStyle="width:200px" cssClass="select1"
												list="{'ACTIVE','INACTIVE'}" name="status"
												id="status" headerKey="-1" headerValue="--Please Select--"></ss:select>
							</td>
							
						</tr>
						</s:if>
					</s:iterator>
					</tbody>	
			</table>

		</div>
		</div>
  </body>
</html>
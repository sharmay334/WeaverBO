<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Search Data</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{resultList!=null && resultList.size()>0}">
				<div class="greyStrip">
					<h4 style="float: left">
						Player Balance Report For Domain :
						<s:property value="%{domainName}" />
					</h4>
					<h4 class="dateData" style="text-align: right; background: none">
					</h4>
				</div>
				<div class="innerBox">
					<table cellspacing="0" cellpadding="4" border="0" align="center"
						class="payTransaction" id="misReports">
						<thead>
							<tr class="headerRow">
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Player ID
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									User Name
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Registration Date
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Registered Alias
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Status
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Email ID
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Email Verified
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Mobile Number
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Mobile Verified
								</th>

								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Total Deposit Amount
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Total Bonus
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Total Winning
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Total Wager
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Cash Balance
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Promo Balance
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Subscribed Promo Mail
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Withdrawable Balance
								</th>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									Loyalty Balance
								</th>
								

							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<div class="box_footer">
					<a rel="facebox" id="sendPlrMail" class="button">Send Mail</a>
					<a rel="facebox" id="freeBonus" class="button">Free Bonus</a>
				</div>
				<div id="startIndex" style="display:none"><s:property value="0" /></div>
		 		<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/> </div> 
		  		<div id="nextPageStart" style="display:none"></div> 
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
		<div id="expandIt">
		</div>
	</body>
</html>


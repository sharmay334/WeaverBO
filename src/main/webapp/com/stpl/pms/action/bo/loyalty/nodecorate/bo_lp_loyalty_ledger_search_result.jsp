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

<title>Search Result</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript">
	var _error = '<s:property value="%{errorMessage}"/>';
	var render = '<s:property value="%{render}"/>';
</script>
<script type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/ledger_search_result.js"></script>
<script type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/loyaltybo.js"></script>
</head>

<body>
	<div id="ledgerSearchRes">
		<s:if test="%{render}">
			<s:if test="%{ledgerSearchList.size()>0}">
				<div class="clear2"></div>
				<div class="FormSection" id="formBonus">
					<div class="greyStrip">
						<h4>Ledger Report</h4>
					</div>
					<div class="innerBox">
						<table cellspacing="0" cellpadding="4" border="0" align="center"
							class="payTransaction" id="lpLedgerList">
							<thead>
								<tr>
									<th colspan="6"></th>
									<th colspan="3" valign="middle" style="text-align: center;"
										nowrap="nowrap">Previous Balance</th>
									<th colspan="2"></th>
									<th colspan="3" valign="middle" style="text-align: center;"
										nowrap="nowrap">Post Balance</th>
								</tr>

								<tr>
									<%-- <th valign="middle" style="text-align: center;" nowrap="nowrap">
									<s:checkbox id="allCheckBox" fieldValue="false"
										name="allCheckBox" theme="simple"></s:checkbox></th> --%>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Transaction Date</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Player Id</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Detail</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Type</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Event</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Sub Event</th>

									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Other Points</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Cash Points</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Total Points</th>

									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Amount</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Amount Type</th>

									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Other Points</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Cash Points</th>
									<th valign="middle" style="text-align: center;" nowrap="nowrap">
										Total Points</th>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="%{ledgerSearchList}">
									<tr>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{txDate}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property
												value="%{playerMaster.playerId}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{detail}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{type}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{event}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{subevent}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{preBalance.other}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{preBalance.cash}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{preBalance.total}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{amount}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{amountAs}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{postBalance.other}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{postBalance.cash}" />
										</td>
										<td valign="middle" style="text-align: center;"
											nowrap="nowrap"><s:property value="%{postBalance.total}" />
										</td>
									</tr>
								</s:iterator>
							</tbody>
						</table>

					</div>
					<div class="box_footer"></div>
				</div>
				<div class="clear2"></div>
			</s:if>
			<s:else>
				<div class="FormSection">
					<div class="greyStrip">
						<h4>Error Message</h4>
					</div>
					<div class="innerBox">
						<div class="alert info_msg ">
							<span class="alert_close"></span><strong>Info: </strong> No entry
							found.
						</div>
					</div>
			</s:else>
		</s:if>
		<br />

	</div>
</body>
</html>

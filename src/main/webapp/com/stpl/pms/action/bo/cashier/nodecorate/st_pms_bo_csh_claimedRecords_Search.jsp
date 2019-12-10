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

<title>Player Login Data</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
var element;
$(document).ready(function() {
    $('#subReportTable').DataTable();
    $('#claim_amount_dialog').hide();
} );
</script>
</head>
<body>
	<div>
		<s:if test="%{unclaimedRecords!=null && unclaimedRecords.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Claimed Transactions Report</h4>
			</div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="subReportTable">
					<thead>
						<tr>
							<th  valign="middle" style="text-align: center;">Id</th>
							<th  valign="middle" style="text-align: center;">Domain Id</th>
							<th  valign="middle" style="text-align: center;">Request Id</th>
							<th  valign="middle" style="text-align: center;">Request Mobile Number</th>
							<th  valign="middle" style="text-align: center;">Actual Mobile Number</th>
							<th  valign="middle" style="text-align: center;">Amount</th>
							<th  valign="middle" style="text-align: center;">status</th>
							<th  valign="middle" style="text-align: center;">Request Date</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="%{unclaimedRecords}">
							<tr>
								<td width="5%" valign="middle" style="text-align: center;" ><s:property value="%{id}" /></td>
								<td width="5%" valign="middle" style="text-align: center;" ><s:property value="%{domainId}" /></td>
								<td width="5%" valign="middle" style="text-align: center;" ><s:property value="%{tpTxnId}" /></td>
								<td width="5%" valign="middle" style="text-align: center;" ><s:property value="%{requestMobileNo}" /></td>
								<td width="5%" valign="middle" style="text-align: center;" ><s:property value="%{actualMobileNo}" /></td>
								<td width="5%" valign="middle" style="text-align: center;" ><s:property value="%{amount}" /></td>
								<td width="5%" valign="middle" style="text-align: center;" ><s:property value="%{status}" /></td>
								<td width="5%" valign="middle" style="text-align: center;" ><s:property value="%{requestDate}" /></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>
			<div class="box_footer"></div>
		</s:if>
		<s:else>
			<div class="greyStrip">
				<h4>Error Message</h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>No Record
					Found.
				</div>
			</div>
		</s:else>
	</div>
	<div id="expandIt"></div>
	<br>

	<div id="claim_amount_dialog" title="Claim Deposit">
		<p>
			<input id="player_master_id" type="hidden" />
			Unclaimed Id: <label id="idLabel"></label><br> 
			Domain Id: <label id="domainLabel"></label><br> 
			amount: <label id="amountLabel"></label><br>
			Requested Number: <label id="mobileLabel"></label><br>
			Actual Number: <input id="actual_number"/></br>
			<button id="claim_amount_btn">Add</button>
		</p>
	</div>
	
</body>
</html>

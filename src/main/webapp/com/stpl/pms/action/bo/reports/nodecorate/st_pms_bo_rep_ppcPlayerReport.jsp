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
<script>
	$(document).ready(function() {
		$('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false);
		fromAndToDate();
		createTable("reportTable");
	});
</script>
</head>
<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">
					India Bet Player Report For Domain :
					<s:property value="%{domainName}" />
				</h4>
				<h4 class="dateData" style="text-align: right;background: none">
				</h4>
			</div>
			<div class="dataTbl_top">
				<p>
					<a
						href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=<s:property value="%{procName}"/> ">Download
						Excel</a>
				</p>
			</div>
			<div class="innerBox">
				<table width="830" cellspacing="0" cellpadding="4" border="0"
					align="center" class="payTransaction" id="reportTable">
					<thead>
						<tr class="headerRow">
							<th style="text-align: center;">User Name</th>
							<th valign="middle" style="text-align: center;">FirstName</th>
							<th valign="middle" style="text-align: center;">Last
								Name</th>
							<th valign="middle" style="text-align: center;">Email
								Id</th>
							<th valign="middle" style="text-align: center;">Mobile
								Number</th>
							<th valign="middle" style="text-align: center;">Date
								Of Registration</th>
							<th valign="middle" style="text-align: center;">Total
								Deposit</th>
							<th valign="middle" style="text-align: center;">Total
								Wager</th>
							<th valign="middle" style="text-align: center;">Total
								Winning</th>
							<th valign="middle" style="text-align: center;">Total
								Withdrawal</th>
						</tr>
					</thead>
					<tbody></tbody>
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
</body>
</html>


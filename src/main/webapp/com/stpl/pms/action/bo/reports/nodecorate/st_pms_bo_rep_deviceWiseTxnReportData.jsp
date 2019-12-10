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
	$(document).ready(function(){
		 $('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false); 
  		createTable("repTable");
	});	 
</script>
</head>
<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Device Wise Transaction Report</h4>
			</div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="repTable">
					<thead>
						<tr>
							<th rowspan="2" valign="middle" style="text-align: center;">Device Name</th>
							<th colspan="3" valign="middle" style="text-align: center;">IGE</th>
							<th colspan="3" valign="middle" style="text-align: center;">SLOT</th>
							<th colspan="3" valign="middle" style="text-align: center;">TOTAL</th>
						</tr>
						<tr class="headerRow">
							<!-- <th valign="middle" style="text-align: center;">Device Name</th> -->
							<th valign="middle" style="text-align: center;">Wager</th>
							<th valign="middle" style="text-align: center;">Winning</th>
							<th valign="middle" style="text-align: center;">NGR</th>
							<th valign="middle" style="text-align: center;">Wager</th>
							<th valign="middle" style="text-align: center;">Winning</th>
							<th valign="middle" style="text-align: center;">NGR</th>
							<th valign="middle" style="text-align: center;">Wager</th>
							<th valign="middle" style="text-align: center;">Winning</th>
							<th valign="middle" style="text-align: center;">NGR</th>
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
	<br>
</body>
</html>

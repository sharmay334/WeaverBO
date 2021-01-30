<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
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
<style>
body {font-family: Arial, Helvetica, sans-serif;}

/* The Modal (background) */
</style>
<script>

	$(document).ready(function() {

		$('#payTransactionTable1').DataTable({
			 "scrollX": true,
			lengthMenu: [
		        [ 10, 25, 50, -1 ],
		        [ '10 rows', '25 rows', '50 rows', 'Show all' ]
		    ],
			dom: 'Bfrtip',
	      buttons: [
	          'excel',
	          'csv',
	          'copy',
	          'pageLength'
	      ]
			
			
		});
	});

</script>
</head>

<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if
			test="%{batteryPercentageBean!=null && batteryPercentageBean.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Battery Percentage Data</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top">
				
			</div>
			<div class="innerBox">
			<s:form id="searchUserFrm" action="/com/stpl/pms/action/bo/um/st_pms_bo_rep_searchReportAttendanceVisit.action"
			 target="searchResult" theme="simple">
				<table id="payTransactionTable1" cellspacing="0"
					cellpadding="4" border="0" align="center" class="payTransaction">
					<thead>
						<tr>
						<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">Date Time</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">Battery Percentage</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">Reason</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="batteryPercentageBean" var="resultMapVar">
							<s:set var="attendanceMap" value="#resultMapVar.value" />
							<tr>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.dateTime" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.batteryPercentage" /> %</b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.reason" /> %</b> 
								</td>

							</tr>
						</s:iterator>
					</tbody>
				</table>
				</s:form>
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
	<div id="searchResult"></div>
</body>
</html>
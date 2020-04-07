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
<script>
	$(document).ready(function() {
		// fromAndToDate();
		$('#waitDiv').hide();
		$('#searchButton').show();
		$('#searchButton').attr("disabled", false);
		
		bonusTable = $('#payTransactionTable').dataTable({
			"scrollX" : true,
			"sPaginationType" : "full_numbers"
			
		});
	});
//	$('#payTransactionTable').DataTable();

</script>
</head>

<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if
			test="%{attendanceMapResult!=null && attendanceMapResult.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Employee Attendance Report</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top">
				
			</div>
			<div class="innerBox">
				<table id="payTransactionTable" cellspacing="0"
					cellpadding="4" border="0" align="center" class="payTransaction">
					<thead>
						<tr>
							<th width="5%" valign="middle" id="th_0" is_link="false"
								style="text-align: center;">Employee Id</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">Attendance Date</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Attendance Mark</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Present In</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Present Out</th>	
								<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Working Hour</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Work Type</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Work Area</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Travelling Mode</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Odometer Reading In</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Odometer Reading Out</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Total Reading</th>	
						</tr>
					</thead>
					<tbody>
						<s:iterator value="attendanceMapResult" var="resultMapVar">
							<s:set var="attendanceMap" value="#resultMapVar.value" />
							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.empId" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.attendanceDate" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.attendaceMark" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.presentIn" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.presentout" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.workingHour" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.workType" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.workArea" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.travellingMode" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.odometerReadingIn" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.odometerReadingOut" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.totalReading" />
								</td>
								

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
</body>
</html>
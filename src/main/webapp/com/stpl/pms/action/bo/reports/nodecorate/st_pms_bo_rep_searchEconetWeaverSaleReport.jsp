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
	   jQuery.fn.dataTableExt.oSort['numbercase-asc']=function(x, y){
		    return (new Date(x)- new Date(y));
		};
		jQuery.fn.dataTableExt.oSort['numbercase-desc']=function(x, y){
		    return (new Date(y)-new Date(x));
		}; 
		$('#waitDiv').hide();
  		$('#searchButton').show();
  		$('#searchButton').attr("disabled",false); 
		$("#subReportTable").DataTable({
	       "sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesAction.action',
	       "sAjaxDataProp":"resultList",
		   "sServerMethod": "POST",
		   "scrollX": true,
	       "aaSorting": [] ,		
	          "aoColumns":[{"sType":"numbercase"} ,null,null,null,null,null,null] 
		}); 
	});	 
</script>
</head>
<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{resultList!=null && resultList.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Sale and Commission Due Report</h4>
			</div>
			<div class="dataTbl_top">
					<p>
						<%-- <s:if test="reportType!= 'getWithDrawalTxnReport'">
							<a
								href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=SaleAndCommissionDueReport">Download
								Excel</a>
						</s:if> --%>
					</p>
				</div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="subReportTable">
					<thead>
						<tr>
							<th rowspan="2" valign="middle" style="text-align: center;">Date</th>
							<th colspan="2" valign="middle" style="text-align: center;">Airtime Sales</th>
							<th colspan="2" valign="middle" style="text-align: center;">Weaver Sales</th>
							<th colspan="2" valign="middle" style="text-align: center;"></th>
						</tr>
						<tr class="headerRow">
						<!-- <th></th> -->
							<!-- <th valign="middle" style="text-align: center;">Location Name
							</th>
							<th valign="middle" style="text-align: center;">Device Count</th> -->
							<th valign="middle" style="text-align: center;">Sale Amount</th>
							<th valign="middle" style="text-align: center;">Commision Due</th>
							<th valign="middle" style="text-align: center;">Sale Amount</th>
							<th valign="middle" style="text-align: center;">Commision Due</th>>
							<th valign="middle" style="text-align: center;">Total Commision Due</th>
							<th valign="middle" style="text-align: center;">Amount to Remit</th>
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
	<br>
</body>
</html>

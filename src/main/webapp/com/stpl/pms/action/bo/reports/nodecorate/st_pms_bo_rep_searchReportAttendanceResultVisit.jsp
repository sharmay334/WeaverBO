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
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
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
			test="%{visitMapResult!=null && visitMapResult.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Visit Report</h4>
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
								id="th_1">Visit Id</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">customer type</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">distributor</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">retailer</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">retailer name</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">prop name</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">contact</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">address</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">district</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">visit purpose</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">purpose</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">comment</th> 
							<th width="5%" valign="middle" style="text-align: center;" is_link="false"
								id="th_3">reminder</th>	
						</tr>
					</thead>
					<tbody>
						<s:iterator value="visitMapResult" var="resultMapVar">
							<s:set var="attendanceMap" value="#resultMapVar.value" />
							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									
									<a href="javascript:;" onclick="callPictureReportVisit('<s:property value="#attendanceMap.visitUniqueId" />')">
									<s:property value="#attendanceMap.visitUniqueId" />
									</a>
									
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.customerType" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.distributor" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.retailer" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.retailerName" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.propName" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.contact" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.address" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.district" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.visitPurpose" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.purpose" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.comment" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.reminder" />
								</td>
								

							</tr>
						</s:iterator>
					</tbody>
				</table>
				</s:form>
			</div>
			<div class="box_footer"></div>
			<div id="myModal" class="modal">

  <!-- Modal content -->
  			<div class="modal-content">
 			   <button id="closeme" type="button" class="close" onclick="closeMe()">&times;</button>
 			  <div id="bill_by_bill">
						<div class="FormSectionMenu">
							<div class="greyStrip">
								<h4>Picture Report :<b></h4>
							</div>
							<table width="100%" cellspacing="0" align="center">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Odometer Picture In</th>
								<th style="text-align: center;" nowrap="nowrap">Odometer Picture Out</th>
								<th style="text-align: center;" nowrap="nowrap">Selfie In</th>
								<th style="text-align: center;" nowrap="nowrap">Selfie Out</th>
						
							</tr>
						</thead>
						<tbody>

							<tr>
								<td style="text-align: center;" nowrap="nowrap"><div id="one"></div></td>
								<td style="text-align: center;" nowrap="nowrap"><div id="two"></div></td>
								<td style="text-align: center;" nowrap="nowrap"><div id="three"></div></td>
								<td style="text-align: center;" nowrap="nowrap"><div id="four"></div></td>
								
							</tr>


						</tbody>
					</table>
						</div>
					</div>
 			 </div>

			</div>
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
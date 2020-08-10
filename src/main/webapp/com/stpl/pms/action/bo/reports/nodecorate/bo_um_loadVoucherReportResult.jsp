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
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">
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
	function changeStatus(vcrId,status){
		
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/st_pms_bo_rep_changeVoucherStatus.action?voucheRowId="
				+vcrId+"&status="+status;
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				if(itr=='success')
					swal("Voucher status is changed to "+status+" successfully!!!");
				else
					swal("Failed to update status!");
				setTimeout(function(){
     			   window.location.reload(1);
     			}, 2000);
			},

			error : function(itr) {

			}
		});
	}
	$(document).ready(function() {
		// fromAndToDate();
		$('#waitDiv').hide();
		$('#searchButton').show();
		$('#searchButton').attr("disabled", false);
		
		bonusTable2 = $('#payTransactionTable2').dataTable({
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
			test="%{voucherMap!=null && voucherMap.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Voucher Report</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top">
				
			</div>
			<div class="innerBox">
			
				<table id="payTransactionTable2" cellspacing="0"
					cellpadding="4" border="0" align="center" class="payTransaction">
					<thead>
						<tr>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">Voucher Name</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Voucher Prefix</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Voucher Suffix</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Voucher Numbering</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Voucher Start</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Voucher End</th>
								<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Status</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Enable/Disable</th>
							
						</tr>
					</thead>
					<tbody>
						<s:iterator value="voucherMap" var="resultMapVar">
							<s:set var="attendanceMap" value="#resultMapVar.value" />
							<tr>

								
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.voucherName" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.prefix" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.suffix" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.startingNumber" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.startDate" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.endDate" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.status" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<s:if test='%{#attendanceMap.status=="INACTIVE"}'>
								
					           <button type="button" class="button" onclick="changeStatus('<s:property value="#attendanceMap.voucherId" />','Active')">ACTIVATE</button>
								</s:if>
								<s:else>
								  <button type="button" class="button" onclick="changeStatus('<s:property value="#attendanceMap.voucherId" />','InActive')">INACTIVATE</button>
								</s:else>
									
								</td>
								
								

							</tr>
						</s:iterator>
					</tbody>
				</table>
				
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
	<div id="searchResult1"></div>
</body>
</html>
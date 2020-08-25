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
body {
	font-family: Arial, Helvetica, sans-serif;
}

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
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
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

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
</style>
<script>
function deleteData1(txnType,saleVcr,receiptVcr){
	var voucherNo = receiptVcr+";"+saleVcr;
	var myurl = "<%=basePath%>";
	myurl += "com/stpl/pms/action/bo/um/bo_um_bill_detail_delete.action?txnType="+txn+"&voucherNo="+voucherNo;
	
	swal({
		  title: "Are you sure?",
		  text: "Once Delete, you will not be able to undo the entry!",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
			  $.ajax({
					type : "GET",
					url : myurl,
					success : function(itr) {
						if(itr=="yes"){
							swal("Your Bill Id "+billId+" deleted successfully!");
							setTimeout(function(){
			        			   window.location.reload(1);
			        			}, 2000);
						}
						else{
							swal("Failed to delete bill!");
							
						}

					},
					error : function(itr) {

					}
				});	
			  
		  } else {
		    swal("Request Cancelled Successfully!");
		   
		  }
		});
	
}
	$(document).ready(function() {
		// fromAndToDate();
		$('#waitDiv').hide();
		$('#searchButton').show();
		$('#searchButton').attr("disabled", false);

		bonusTable1 = $('#payTransactionTable1').dataTable({
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
		<s:if test="%{mappingMap!=null && mappingMap.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Report</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top"></div>
			<div class="innerBox">
				<s:form id="searchUserFrm"
					action="/com/stpl/pms/action/bo/um/st_pms_bo_rep_searchReportAttendanceVisit.action"
					target="searchResult" theme="simple">
					<table id="payTransactionTable1" cellspacing="0" cellpadding="4"
						border="0" align="center" class="payTransaction">
						<thead>
							<tr>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_1">SNo.</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Receipt/Credit Note Voucher</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Sale Voucher</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Type of Ref</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Amount</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2"></th>


							</tr>
						</thead>
						<tbody>
							<s:iterator value="mappingMap" var="resultMapVar">
								<s:set var="attendanceMap" value="#resultMapVar.value" />
								<tr>


									<td width="5%" valign="middle" style="text-align: center;">
										<s:property value="#attendanceMap.sNo" />
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.receiptVoucher" />
									</b>
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.saleVoucher" />
									</b>
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.refType" />
									</b>
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.amount" />
									</b>
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<button type="button" class="button"
											onclick="deleteData1('<s:property value="#attendanceMap.txnType"/>','<s:property value="#attendanceMap.saleVoucher"/>','<s:property value="#attendanceMap.receiptVoucher"/>')">&#10006;</button>
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
					<button id="closeme" type="button" class="close"
						onclick="closeMe()">&times;</button>
					<div id="bill_by_bill">
						<div class="FormSectionMenu">
							<div class="greyStrip">
								<h4>
									Picture Report :<b>
								</h4>
							</div>
							<table width="100%" cellspacing="0" align="center">
								<thead>
									<tr>
										<th style="text-align: center;" nowrap="nowrap">Odometer
											Picture In</th>
										<th style="text-align: center;" nowrap="nowrap">Odometer
											Picture Out</th>
										<th style="text-align: center;" nowrap="nowrap">Selfie In</th>
										<th style="text-align: center;" nowrap="nowrap">Selfie
											Out</th>

									</tr>
								</thead>
								<tbody>

									<tr>
										<td style="text-align: center;" nowrap="nowrap"><div
												id="one"></div></td>
										<td style="text-align: center;" nowrap="nowrap"><div
												id="two"></div></td>
										<td style="text-align: center;" nowrap="nowrap"><div
												id="three"></div></td>
										<td style="text-align: center;" nowrap="nowrap"><div
												id="four"></div></td>

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
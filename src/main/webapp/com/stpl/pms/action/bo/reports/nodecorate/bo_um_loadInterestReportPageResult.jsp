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
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css">

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
	font-size: 15px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
</style>
<script>


	$(document).ready(function() {
		// fromAndToDate();
		$('#waitDiv').hide();
		$('#searchButton').show();
		$('#searchButton').attr("disabled", false);
		var partyName = document.getElementById('partyName').value;
		var fDate = document.getElementById('fromDate').value;
		var tDate = document.getElementById('toDate').value;
		
		
		bonusTable = $('#payTransactionTable').DataTable({
			lengthMenu: [
		        [ 25, 50, -1 ],
		        [ '25 rows', '50 rows', 'Show all' ]
		    ],
			dom: 'Bfrtip',
	        buttons: [
	        	
	            { extend: 'excel',footer: true},
	            'csv',
	            {
	                extend: 'pdf',
	                footer: true,	
	                title: 'CRM-Interest Report\nJAMINDARA SEEDS CORPORATION,\nP.B. Road Rane Bannure Distric-HAVERI,KARNATAKA\nREG.ADD. 73,GANESH NAGAR-MURLIPURA JAIPUR\n'+partyName+'\nInterest Account\n'+fDate+' to '+tDate,
	                customize: function(doc) {
	                   
	                    doc.styles.title = {
	                      fontSize: '12',
	                      alignment: 'center'
	                    }   
	                  }  
	            },
	            'copy',
	            'pageLength'
	        ]
		});
	});
	//	$('#payTransactionTable').DataTable();
</script>
</head>

<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if test="%{interestMap!=null && interestMap.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Expense Report</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top"></div>
			<div class="innerBox">
				<s:form id="searchUserFrm2" method="GET"
					action="/com/stpl/pms/action/bo/um/st_pms_bo_rep_txn_details.action"
					target="searchResult1" theme="simple">
					<table id="payTransactionTable" cellspacing="0" cellpadding="4"
						border="0" align="center" class="payTransaction">
						<thead>
							<tr>
								<th width="5%" valign="middle" id="th_0"
									style="text-align: center;">S.No</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_1">Party Id</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Bill Date</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Voucher Number</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Schedular Date</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_3">Bill Amount</th>
								<th width="3%" valign="middle" style="text-align: center;"
									id="th_2">Interest Amount</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_3">Final Balance</th>
								
							</tr>
						</thead>
						<tbody>
						<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;"><a style="display:none;">`</a></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b>Total Interest</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:18px;"><b><s:property value="%{totalInterestAmount}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							</tr>
							<s:iterator value="interestMap" var="resultMapVar">
								<s:set var="attendanceMap" value="#resultMapVar.value" />
								<s:hidden id="partyName" value="%{ledgerName}"></s:hidden>
								<s:hidden id="fromDate" value="%{fromDate}"></s:hidden>
								<s:hidden id="toDate" value="%{toDate}"></s:hidden>
								<tr>

									<td width="5%" valign="middle" style="text-align: center;">
										<s:property value="#attendanceMap.id" />

									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										JSC-<s:property value="#attendanceMap.partyId" />
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.billDate" />
									</b>
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.voucherNo" />
									</b>
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.schedulingDate" />
									</b>
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.billBalance" />
									</b>
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.interestBalance" />
									</b>
									</td>
										<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.partyCurrBalance" />
						
									</b>
									</td>
	
	
										
								</tr>
							</s:iterator>
							
						</tbody>
					</table>
				</s:form>
			</div>

			<div id="myModal" class="modal">

  <!-- Modal content -->
  			<div class="modal-content">
 			   <button id="closeme" type="button" class="close" onclick="closeMe()">&times;</button>
 			  <div id="bill_bybill">
						<div class="FormSectionMenu">
							<div class="greyStrip">
								<h4>Document :<b></h4>
							</div>
							<table width="100%" cellspacing="0" align="center">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Document </th>
							</tr>
						</thead>
						<tbody>

							<tr>
								<td style="text-align: center;" nowrap="nowrap"><div id="one"></div></td>
								
							</tr>


						</tbody>
					</table>
						</div>
					</div>
 			 </div>

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
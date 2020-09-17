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
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css">


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
  font-size: 18px;
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
		var partyName = document.getElementById('partyName').value;
		var fDate = document.getElementById('fromDate').value;
		var tDate = document.getElementById('toDate').value;
		$('#payTransactionTable').DataTable({
			lengthMenu: [
		        [ 10, 25, 50, -1 ],
		        [ '10 rows', '25 rows', '50 rows', 'Show all' ]
		    ],
			dom: 'Bfrtip',
	        buttons: [
	        	
	            'excel',
	            'csv',
	            {
	                extend: 'pdf',
	                title: 'CRM-Transaction Report\nJAMINDARA SEEDS CORPORATION,\nP.B. Road Rane Bannure Distric-HAVERI,KARNATAKA\nREG.ADD. 73,GANESH NAGAR-MURLIPURA JAIPUR\n'+partyName+'\nLedger Account\n'+fDate+' to '+tDate,
	                customize: function(doc) {
	                    doc.styles.title = {
	                      fontSize: '16',
	                      alignment: 'center'
	                    }   
	                  }  
	            },
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
			test="%{beanMap!=null && beanMap.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Ledger Report Result</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top">
				
			</div>
			<div class="innerBox">
			<s:form id="searchUserFrm2" method="GET" action="/com/stpl/pms/action/bo/um/st_pms_bo_rep_txn_details.action"
			 target="searchResult1" theme="simple">
				<table id="payTransactionTable" cellspacing="0"
					cellpadding="4" border="0" align="center" class="payTransaction">
					<thead>
						<tr>
							
						    <th width="5%" valign="middle" id="th_0" 
								style="text-align: center;">Date</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">Particulars</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Transaction Type</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Voucher No</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Debit</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Credit</th>	
								
						</tr>
					</thead>
					<tbody>
						<s:iterator value="beanMap" var="resultMapVar">
							<s:set var="attendanceMap" value="#resultMapVar.value" />
							<s:hidden id="partyName" value="%{ledgerName}"></s:hidden>
							<s:hidden id="fromDate" value="%{fromDate}"></s:hidden>
							<s:hidden id="toDate" value="%{toDate}"></s:hidden>
							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.date" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.subLedger" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.txnType" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.voucherNumber" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.debit" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.credit" />
								</td>
							</tr>
						</s:iterator>
							<tr>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:18px;"><b>Opening Balance</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:18px;"><b><s:property value="%{openingBal}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							</tr>
							<tr>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:18px;"><b>Current Total</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:blue;font-size:18px;"><b><s:property value="%{totDebitAmt}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:blue;font-size:18px;"><b><s:property value="%{totCreditAmt}" /></b></td>
							</tr>
							<tr>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:18px;"><b>Interest Amount</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:18px;"><b><s:property value="%{taxAmount}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							</tr>
							<tr>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:18px;"><b>Closing Balance</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:18px;"><b><s:property value="%{closingBal}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							</tr>
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

</body>
</html>
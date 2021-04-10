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
		function getBillDetails(voucherNo,transactionType){
			
			var myurl = "<%=basePath%>";
			
			var frm = $('#searchUserFrm');
			if(transactionType=="SALE"){
				
				myurl += "/com/stpl/pms/action/bo/um/generate_txn_sales_bill_pdf_document_report.action?salesNoVoucher="+voucherNo;
				$.ajax({
			        type: 'GET',
			        url: myurl,
			        async:false,
			        success: function (data) {
			        
			        		swal("Bill Generated Successfully!!!");
			        		var link=document.createElement('a');
			        		document.body.appendChild(link);
			        		link.href=data ;
			        		link.click();
			        		  
			        },
			        error: function (data) {
			        	swal("Server Error Occured!");
			        },
			    });
			}
			
			else if(transactionType=="Credit Note"){
				
				myurl += "/com/stpl/pms/action/bo/um/generate_txn_credit_note_bill_pdf_document_report.action?salesNoVoucher="+voucherNo;
				$.ajax({
			        type: 'GET',
			        url: myurl,
			        async:false,
			        success: function (data) {
			        
			        		swal("Bill Generated Successfully!!!");
			        		var link=document.createElement('a');
			        		document.body.appendChild(link);
			        		link.href=data ;
			        		link.click();
			        		  
			        },
			        error: function (data) {
			        	swal("Server Error Occured!");
			        },
			    });
			}
			
			else if(transactionType=="PURCHASE"){
				
				myurl += "/com/stpl/pms/action/bo/um/generate_txn_purchase_bill_pdf_document_report.action?salesNoVoucher="+voucherNo;
				$.ajax({
			        type: 'GET',
			        url: myurl,
			        async:false,
			        success: function (data) {
			        
			        		swal("Bill Generated Successfully!!!");
			        		var link=document.createElement('a');
			        		document.body.appendChild(link);
			        		link.href=data ;
			        		link.click();
			        		  
			        },
			        error: function (data) {
			        	swal("Server Error Occured!");
			        },
			    });
			}
			else{
				
				swal("This feature only generates sale bills!!");
			}
			
			
		}
		
		
		
	$(document).ready(function() {
		var partyName = document.getElementById('partyName').value;
		var fDate = document.getElementById('fromDate').value;
		var tDate = document.getElementById('toDate').value;
		
		
		
		
		var table = $('#payTransactionTable').DataTable({
			"orderFixed": [ 0, 'asc' ],
			lengthMenu: [
		        [ 10, 25, 50, -1 ],
		        [ '10 rows', '25 rows', '50 rows', 'Show all' ]
		    ],
			dom: 'Bfrtip',
	        buttons: [
	        	
	            { extend: 'excel',footer: true},
	            'csv',
	            {
	                extend: 'pdf',
	                footer: true,	
	                title: 'CRM-Transaction Report\nJAMINDARA SEEDS CORPORATION,\nP.B. Road Rane Bannure Distric-HAVERI,KARNATAKA\nREG.ADD. 73,GANESH NAGAR-MURLIPURA JAIPUR\n'+partyName+'\nLedger Account\n'+fDate+' to '+tDate,
	                customize: function(doc) {
	                    age = table.column(0).data().toArray();
	                    for (var i = 0; i < age.length; i++) {
	                        doc.content[1].table.body[i+1][0].fillColor = 'white';
	                        doc.content[1].table.body[i+1][1].fillColor = 'white';
	                        doc.content[1].table.body[i+1][2].fillColor = 'white';
	                        doc.content[1].table.body[i+1][3].fillColor = 'white';
	                        doc.content[1].table.body[i+1][4].fillColor = 'white';
	                        doc.content[1].table.body[i+1][5].fillColor = 'white';
	                        
	                    }
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
			 <s:set name="cBal" value="isNegative"/>
			 <s:set name="oBal" value="openingBalanceType"/>
			 
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
					<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;"><s:property value="%{fromDate}"/></td>
 							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;" ><b>Opening Balance</b></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:14px;"><b><s:if test="%{#oBal=='Dr'}"><s:property value="%{openingBal}" /></s:if></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:14px;"><b><s:if test="%{#oBal=='Cr'}"><s:property value="%{openingBal}" /></s:if></b></td>

							</tr>
							<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;"><a style="display:none;">`</a></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b>Over Due Interest Amount</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:14px;"><b><s:property value="%{taxAmount}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							</tr>
							<tr style="display:none">
							<td width="5%" valign="middle" style="text-align: center;">`</td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" >--------------------------</td>
							<td width="5%" valign="middle" >--------------------------</td>
						
							</tr>
							<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;"><a style="display:none;">`</a></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b>Current Total</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:blue;font-size:14px;"><b><s:property value="%{totDebitAmt}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:blue;font-size:14px;"><b><s:property value="%{totCreditAmt}" /></b></td>
							</tr>
							<tr style="display:none">
							<td width="5%" valign="middle" style="text-align: center;">`</td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" >--------------------------</td>
							<td width="5%" valign="middle" >--------------------------</td>
						
							</tr>
							<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;"><a style="display:none;">`</a></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b>Closing Balance</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:18px;"><b><s:if test="%{#cBal=='No'}"><s:property value="%{closingBal}" /> Dr</s:if></b></td>
							<td width="5%" valign="middle" style="text-align: center;"><b><s:if test="%{#cBal=='Yes'}"><s:property value="%{closingBal}" /> Cr</s:if></b></td>
							</tr>
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
										<a href='javascript:;' onclick="getBillDetails('<s:property value="#attendanceMap.voucherNumber" />','<s:property value="#attendanceMap.txnType" />')"><b> <s:property value="#attendanceMap.voucherNumber" /> </b> </a>
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.debit" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.credit" />
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
			<%-- <div class="greyStrip">
				<h4>Error Message</h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>No Record
					Found.
				</div>
			</div> --%>
			
			<div class="greyStrip">
				<h4 style="float: left">Ledger Report Result</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top">
				
			</div>
			<div class="innerBox">
			<s:form id="searchUserFrm3" method="GET" action="/com/stpl/pms/action/bo/um/st_pms_bo_rep_txn_details.action"
			 target="searchResult1" theme="simple">
			 <s:set name="cBal" value="isNegative"/>
			 <s:set name="oBal" value="openingBalanceType"/>
			 
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
					<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;"><s:property value="%{fromDate}"/></td>
 							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;" ><b>Opening Balance</b></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:14px;"><b><s:if test="%{#oBal=='Dr'}"><s:property value="%{openingBal}" /></s:if></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:14px;"><b><s:if test="%{#oBal=='Cr'}"><s:property value="%{openingBal}" /></s:if></b></td>

							</tr>
							<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;"><a style="display:none;">`</a></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b>Interest Amount</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:14px;"><b><s:property value="%{taxAmount}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							</tr>
							<tr style="display:none">
							<td width="5%" valign="middle" style="text-align: center;">`</td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" >--------------------------</td>
							<td width="5%" valign="middle" >--------------------------</td>
						
							</tr>
							<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;"><a style="display:none;">`</a></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b>Current Total</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:blue;font-size:14px;"><b><s:property value="%{totDebitAmt}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:blue;font-size:14px;"><b><s:property value="%{totCreditAmt}" /></b></td>
							</tr>
							<tr style="display:none">
							<td width="5%" valign="middle" style="text-align: center;">`</td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" >--------------------------</td>
							<td width="5%" valign="middle" >--------------------------</td>
						
							</tr>
							<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;"><a style="display:none;">`</a></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b>Closing Balance</b></td>
							<td width="5%" valign="middle" style="text-align: center;color:black;font-size:18px;"><b><s:if test="%{#cBal=='No'}"><s:property value="%{closingBal}" /> Dr</s:if></b></td>
							<td width="5%" valign="middle" style="text-align: center;"><b><s:if test="%{#cBal=='Yes'}"><s:property value="%{closingBal}" /> Cr</s:if></b></td>
							</tr>
						
						
							
							
					</tbody>
						
				</table>
				</s:form>
			</div>
			
			
			<div class="box_footer"></div>
		</s:else>
	
	</div>
	<div id="expandIt"></div>

</body>
</html>
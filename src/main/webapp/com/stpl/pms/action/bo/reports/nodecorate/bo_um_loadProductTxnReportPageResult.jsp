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

	function loadReceiptDetails(txn,billId){
		if(txn=="RECEIPT"){
			
			var frm = $('#searchUserFrm2');

			 $.ajax({
			        type: frm.attr('method'),
			        url: frm.attr('action')+'?txnType='+txn+'&voucherNo='+billId,
			        async:false,
			        data: frm.serialize(),
			        success: function (data) {
			            document.getElementById('searchResult1').innerHTML = data;
			        },
			        error: function (data) {
			        	 document.getElementById('searchResult1').innerHTML = data;
			        },
			    });
		}
		else if(txn=="SALES"){
			
			var myurl = "<%=basePath%>";
			
			var frm = $('#searchUserFrm');
		
				
				myurl += "/com/stpl/pms/action/bo/um/generate_txn_sales_bill_pdf_document_report.action?salesNoVoucher="+billId;
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
		
		else if(txn=="CREDIT NOTE"){
			
			swal("Please select your choice", {
				  buttons: {
				    cancel: "Generate Bill",
				    catch: {
				      text: "Show Agst Ref Data!",
				      value: "catch",
				    },
				   
				  },
				})
				.then((value) => {
				  switch (value) {
				 
				    
				    case "catch":
				    	var frm = $('#searchUserFrm2');

						 $.ajax({
						        type: frm.attr('method'),
						        url: frm.attr('action')+'?txnType='+txn+'&voucherNo='+billId,
						        async:false,
						        data: frm.serialize(),
						        success: function (data) {
						            document.getElementById('searchResult1').innerHTML = data;
						        },
						        error: function (data) {
						        	 document.getElementById('searchResult1').innerHTML = data;
						        },
						    });
				      break;
				 
				    default:
				    	var myurl = "<%=basePath%>";
					var frm = $('#searchUserFrm');
						
						myurl += "/com/stpl/pms/action/bo/um/generate_txn_credit_note_bill_pdf_document_report.action?salesNoVoucher="+billId;
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
				});
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			<%-- swal({
		        title: "Please select?",
		        text: "Please select your choice",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: "Generate Bill",
		        cancelButtonText: "Show Adjustment",
		        closeOnConfirm: false,
		        closeOnCancel: false 
		    },
		    function(isConfirm) {
		        if (isConfirm) {
		        	var myurl = "<%=basePath%>";
					var frm = $('#searchUserFrm');
						
						myurl += "/com/stpl/pms/action/bo/um/generate_txn_credit_note_bill_pdf_document_report.action?salesNoVoucher="+billId;
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
		        } else {
		        	var frm = $('#searchUserFrm2');

					 $.ajax({
					        type: frm.attr('method'),
					        url: frm.attr('action')+'?txnType='+txn+'&voucherNo='+billId,
					        async:false,
					        data: frm.serialize(),
					        success: function (data) {
					            document.getElementById('searchResult1').innerHTML = data;
					        },
					        error: function (data) {
					        	 document.getElementById('searchResult1').innerHTML = data;
					        },
					    });
		        }
		    }
		); --%>
			
			
			
			
			
			
			
			
			
		}
else if(txn=="JOURNAL"){
			
			var frm = $('#searchUserFrm2');

			 $.ajax({
			        type: frm.attr('method'),
			        url: frm.attr('action')+'?txnType='+txn+'&voucherNo='+billId,
			        async:false,
			        data: frm.serialize(),
			        success: function (data) {
			            document.getElementById('searchResult1').innerHTML = data;
			        },
			        error: function (data) {
			        	 document.getElementById('searchResult1').innerHTML = data;
			        },
			    });
			
		}
		else{
			swal("Further Details are for Receipt and Payment Only!");
		}
		
		
	}
	function deleteData(txn,billId,ledgerName){
		
		var myurl = "<%=basePath%>";
		myurl += "com/stpl/pms/action/bo/um/bo_um_bill_delete.action?txnType="+txn+"&voucherNo="+billId+"&ledgerName="+ledgerName;
		if(txn=="PAYMENT"){
			swal("Delete functionality are not for receipt and payment.");
		}
		else{
			
		
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
		
	}
	$(document).ready(function() {
		$("#waitDiv").hide();
		$("#submitBtn").attr("disabled",false);
		$("#submitBtn").show();
		
		var append="";
		var tType = document.getElementById('txnTyp').value;
		var toDt = document.getElementById('toDate').value;
		var frmDt = document.getElementById('fromDate').value;
		var partyN = document.getElementById('ledgerName').value;
		var empN = document.getElementById('employeeName').value;
		if(empN!="-1")
			append = append+"Employee Name - "+empN+'\n';
		if(partyN!="-1")
			append = append+"Party Name - "+partyN+'\n';
		if(frmDt.length>2 && toDt.length>2)
			append = append+"( From Date - "+frmDt+ ', To Date - '+toDt+' )\n';
			
			
		
		var table = $('#payTransactionTable').DataTable({
			"orderFixed": [ 0, 'asc' ],
			"scrollX": true,
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
	                title: 'CRM- '+tType+' Transaction Report\nJAMINDARA SEEDS CORPORATION,\nP.B. Road Rane Bannure Distric-HAVERI,KARNATAKA\nREG.ADD. 73,GANESH NAGAR-MURLIPURA JAIPUR\n'+append,
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
		
		
		/* $('#payTransactionTable').DataTable({
			lengthMenu: [
		        [ 10, 25, 50, -1 ],
		        [ '10 rows', '25 rows', '50 rows', 'Show all' ]
		    ],
			dom: 'Bfrtip',
	        buttons: [
	            'excel',
	            'csv',
	            'pdf',
	            'copy',
	            'pageLength'
	        ]
			
			
		}); */
	});
//	$('#payTransactionTable').DataTable();

</script>
</head>

<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if
			test="%{reportData!=null && reportData.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Product Report</h4>
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
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Bill Date</th>
							<th width="5%" valign="middle" id="th_0" 
								style="text-align: center;">Ledger Name</th>
						    <th width="5%" valign="middle" id="th_0" 
								style="text-align: center;">Txn Type</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">Sub Ledger</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Voucher No</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Item Name</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Batch No</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Item Unit</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Item Qty</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Item Price</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Total Value</th>			
						</tr>
					</thead>
					<tbody>
						<s:iterator value="reportData" var="resultMapVar">
							<s:set var="attendanceMap" value="#resultMapVar.value" />
							<s:hidden id="txnTyp" value="%{txnType}"></s:hidden>
							<s:hidden id="toDate" value="%{toDate}"></s:hidden>
							<s:hidden id="fromDate" value="%{fromDate}"></s:hidden>
							<s:hidden id="employeeName" value="%{employeeName}"></s:hidden>
							<s:hidden id="ledgerName" value="%{ledgerName}"></s:hidden>
							<tr>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.billDate" /> </b> 
								</td>
								
								<td width="5%" valign="middle" style="text-align: center;">
								<s:property value="#attendanceMap.ledgerName" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.txnType" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.subLedger" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								 <a href="javascript:;" onclick="loadReceiptDetails('<s:property value="#attendanceMap.txnType"/>','<s:property value="#attendanceMap.billVoucherNo"/>')"><s:property value="#attendanceMap.billVoucherNo" /> </a>
								</td>
								<td width="5%" valign="middle" style="text-align: center;"><s:property value="%{itemName}" /></td>
								<td width="5%" valign="middle" style="text-align: center;">	<s:property value="#attendanceMap.itemBatch" /></td>
								<td width="5%" valign="middle" style="text-align: center;"><s:property value="#attendanceMap.itemUnit" /></td>
								<td width="5%" valign="middle" style="text-align: center;"><s:property value="#attendanceMap.itemQty" /></td>
								<td width="5%" valign="middle" style="text-align: center;"><s:property value="#attendanceMap.itemPrice" /></td>
								<td width="5%" valign="middle" style="text-align: center;"><s:property value="#attendanceMap.itemTotalValue" /></td>
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

</body>
</html>
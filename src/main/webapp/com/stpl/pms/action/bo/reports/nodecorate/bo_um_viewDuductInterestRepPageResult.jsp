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
  font-size: 12px;
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
var GpartyId="";
var GvoucherNo="";
var GbillId="";

function SaveInformation(){
var rateDeduct = document.getElementById('deductPercent').value;
	
	var myurl = "<%=basePath%>";
	myurl += "com/stpl/pms/action/bo/um/bo_um_bill_deduct_interest.action?deductPercent="
		+ rateDeduct+"&partyId="+GpartyId+"&voucherNo="+GvoucherNo+"&billId="+GbillId;
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			if(itr=="success"){
				swal("Your Interest Percentage has deducted successfully!");
				document.getElementById("myForm").style.display = "none";
				setTimeout(function(){
     			   window.location.reload(1);
     			}, 1000);
			}
			else{
				swal("Failed to update interest amount!");
				
			}

		},
		error : function(itr) {

		}
	});
	
}
function closeDialogue(){
	document.getElementById("myForm").style.display = "none";

}
function openDialogue(partyId,voucherNo,billId){
	GpartyId = partyId;
	GvoucherNo = voucherNo;
	GbillId = billId;
	document.getElementById('deductPercent').value="0";
	document.getElementById("myForm").style.display = "block";
	
}
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
			test="%{reportData!=null && reportData.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Schedular Report</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top">
				
			</div>
			<div class="innerBox">
			<s:form id="searchUserFrm2" method="GET" action="/com/stpl/pms/action/bo/um/st_pms_bo_rep_searchReportAttendanceVisit.action"
			 target="searchResult1" theme="simple">
				<table id="payTransactionTable" cellspacing="0"
					cellpadding="4" border="0" align="center" class="payTransaction">
					<thead>
						<tr>
							<th width="5%" valign="middle" id="th_0" 
								style="text-align: center;">Ledger Name</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">Bill Id</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Bill Voucher Id</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Bill Amount</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Bill Date</th>	
								<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Bill Used</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Type Of Ref</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Interest Amount</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Security Amt</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Adjust Tax</th>				
								
						</tr>
					</thead>
					<tbody>
						<s:iterator value="reportData" var="resultMapVar">
							<s:set var="attendanceMap" value="#resultMapVar.value" />
							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
								<s:property value="#attendanceMap.ledgerName" />
								
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.billId" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.billVoucherNo" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.billAmount" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.billDate" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.billUsed" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.typeOfRef" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.billTaxAmount" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.securityAmt" />
								</td>
								
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="openDialogue('<s:property value="#attendanceMap.ledgerId"/>','<s:property value="#attendanceMap.billVoucherNo"/>','<s:property value="#attendanceMap.billId" />')">Adjust</button>
								</td>
								
									

							</tr>
						</s:iterator>
					</tbody>
				</table>
				</s:form>
			</div>
			
			<div id="myForm" class="modal">

  <!-- Modal content -->
  			<div class="modal-content">
 			   
 			  <div id="bill_by_bill">
 			  
						<div class="FormSectionMenu" id="bill_by_bill_div_acc">
						 			  <button id="closeme" type="button" class="close" onclick="closeDialogue()">&times;</button>
						
							<div class="greyStrip">
								<h4>Set Reminder</h4>
							</div>
							<table width="100%" cellspacing="0" align="center"
						id="payTransactionTableBillWise" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Insert Rate (in %)</th>
								<th></th>
							</tr>
						</thead>
						<tbody>

							<tr>
								<td style="text-align: center;" nowrap="nowrap">
									<s:textfield
										maxlength="30" name="deductPercent" value="0" id="deductPercent"
										theme="myTheme" cssStyle="width:20%">
									</s:textfield>%				
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<button id="closeme" type="button" class="close" onclick="SaveInformation()">Deduct</button>
								</td>		
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
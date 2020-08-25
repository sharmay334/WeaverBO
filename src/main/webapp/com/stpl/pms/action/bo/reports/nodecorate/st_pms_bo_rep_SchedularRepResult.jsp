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
function stopAlert(alertType,partyId,voucherNo,billId){
	var myurl = "<%=basePath%>";
	var status="STOP";
	myurl += "com/stpl/pms/action/bo/um/bo_um_ledger_alert_status.action?alertType="
		+ alertType+"&partyId="+partyId+"&voucherNo="+voucherNo+"&status="+status+"&billId="+billId;
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			if(itr=="success"){
				swal("Your "+alertType+" Alert STOPPED SUCCESSFULLY!");
				setTimeout(function(){
     			   window.location.reload(1);
     			}, 2000);
			}
			else{
				swal("Failed to update status!");
				
			}
		},
		error : function(itr) {

		}
	});
	
}
function startAlert(alertType,partyId,voucherNo,billId){
	var myurl = "<%=basePath%>";
	var status="START";
	myurl += "com/stpl/pms/action/bo/um/bo_um_ledger_alert_status.action?alertType="
		+ alertType+"&partyId="+partyId+"&voucherNo="+voucherNo+"&status="+status+"&billId="+billId;
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			if(itr=="success"){
				swal("Your "+alertType+" Alert STARTED SUCCESSFULLY!");
				setTimeout(function(){
     			   window.location.reload(1);
     			}, 2000);
			}
			else{
				swal("Failed to update status!");
				
			}

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
								id="th_3">Last Schedular Date</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">SMS Alert</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Mail Alert</th> 
							<!-- <th width="5%" valign="middle" style="text-align: center;" 
								id="th_3">Interest Schedular</th>	 -->
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">SMS</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">MAIL</th>	
							<!-- <th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Tax Schedular</th> -->				
								
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
									<s:property value="#attendanceMap.lastSchedularDate" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.smsAlert" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.mailAlert" />
								</td>
								<%-- <td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.taxSchedular" />
								</td> --%>
								<s:if test="%{#attendanceMap.smsAlert=='YES'}">
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="stopAlert('SMS','<s:property value="#attendanceMap.ledgerId"/>','<s:property value="#attendanceMap.billVoucherNo"/>','<s:property value="#attendanceMap.billId" />')">STOP</button>
								</td>
								</s:if>
								<s:else>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="startAlert('SMS','<s:property value="#attendanceMap.ledgerId"/>','<s:property value="#attendanceMap.billVoucherNo"/>','<s:property value="#attendanceMap.billId" />')">START</button>
								</td>
								
								</s:else>
								
								<s:if test="%{#attendanceMap.mailAlert=='YES'}">
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="stopAlert('MAIL','<s:property value="#attendanceMap.ledgerId"/>','<s:property value="#attendanceMap.billVoucherNo"/>','<s:property value="#attendanceMap.billId" />')">STOP</button>
								</td>
								</s:if>
								<s:else>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="startAlert('MAIL','<s:property value="#attendanceMap.ledgerId"/>','<s:property value="#attendanceMap.billVoucherNo"/>','<s:property value="#attendanceMap.billId" />')">START</button>
								</td>
								
								</s:else>
								
								<%-- <s:if test="%{#attendanceMap.taxSchedular=='YES'}">
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="stopAlert('SCHEDULE','<s:property value="#attendanceMap.ledgerId"/>','<s:property value="#attendanceMap.billVoucherNo"/>','<s:property value="#attendanceMap.billId" />')">STOP</button>
								</td>
								</s:if>
								<s:else>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="startAlert('SCHEDULE','<s:property value="#attendanceMap.ledgerId"/>','<s:property value="#attendanceMap.billVoucherNo"/>','<s:property value="#attendanceMap.billId" />')">START</button>
								</td> 
								</s:else>--%>
									

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
</body>
</html>
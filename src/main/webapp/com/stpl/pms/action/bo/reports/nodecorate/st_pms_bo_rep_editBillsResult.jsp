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
			test="%{resultreport!=null}">
			<div class="greyStrip">
				<h4 style="float: left">Bill Report</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top">
				
			</div>
			<div class="innerBox">
				<table id="payTransactionTable" cellspacing="0"
					cellpadding="4" border="0" align="center" class="payTransaction">
					<thead>
						<tr>
							<th width="5%" valign="middle"
								style="text-align: center;">Bill Id</th>
							<th width="5%" valign="middle" style="text-align: center;"
								>Ledger Name</th>
							<th width="5%" valign="middle" style="text-align: center;"
								>Ref Type</th>
							<th width="5%" valign="middle" style="text-align: center;"
								>Balance</th>
							<th width="5%" valign="middle" style="text-align: center;"
								>balance Type</th>	
							<th width="5%" valign="middle" style="text-align: center;"
							>Exhausted</th>	
							<th width="5%" valign="middle" style="text-align: center;"
							>Bill Date</th>
							<th width="5%" valign="middle" style="text-align: center;"
							>Interest Amount</th>
							<th width="5%" valign="middle" style="text-align: center;"
							>Clear Old Interest</th>
							<th width="5%" valign="middle" style="text-align: center;"
							>Stop Future Interest</th>
							<th width="5%" valign="middle" style="text-align: center;"
							></th>
								
						</tr>
					</thead>
					<tbody>
							<tr>

			
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{resultreport.voucherNo}" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="%{resultreport.partyName}" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="%{resultreport.refType}" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="%{resultreport.balance}" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="%{resultreport.balanceType}" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{resultreport.isAdjust}" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{resultreport.billDate}" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="0" />
								</td>
								
								<td width="5%" valign="middle" style="text-align: center;">
								<s:select name="clearOldInterest" headerKey="-1" cssStyle="width:100px"
								id="clearOldInterest" headerValue="Please select"
								list="{'Yes','No'}" cssClass="select1" theme="myTheme"></s:select>						
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<s:select name="clearNewInterest" headerKey="-1"
								id="clearNewInterest" headerValue="Please select" cssStyle="width:100px"
								list="{'Yes','No'}" cssClass="select1" theme="myTheme"></s:select>	
								</td>
								
								<td width="5%" valign="middle" style="text-align: center;">
				    <input type="button" value='Update' align="left"
					style="margin-left: 0px" class="button" />
								</td>
							</tr>
					</tbody>
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
</body>
</html>
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
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css">


<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

</style>
<script>
	function holdAmount(empName,date,type){
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_emp_hold_data.action?empName="
			+empName+"&fromDate="+date+"&type="+type;
		$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			if(itr=='success')
			swal("Amount is Set on Hold Successfully!!!");
			else
				swal("Failed to Set on Hold ");
		},

		error : function(itr) {
			swal("Failed to Set on Hold ");
		}
	});
	
	}
function unHoldAmount(empName,date,type){
		
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/bo_um_emp_unhold_data.action?empName="
		+empName+"&fromDate="+date+"&type="+type;
	$.ajax({
	type : "GET",
	url : myurl,
	success : function(itr) {
		if(itr=='success')
		swal("Amount UnHold Successfully!!!");
		else
			swal("Failed to UnHold ");
	},

	error : function(itr) {
		swal("Failed to UnHold ");
	}
});
	}


</script>
</head>

<body>
	<div class="clear2"></div>
	<div class="FormSection">
			<div class="greyStrip">
				<h4 style="float: left">Salary Information</h4>
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
									style="text-align: center;">Type</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_1">Amount</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Current Status</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2"></th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2"></th>
								
								

							</tr>
						</thead>
						<tbody>

							<s:hidden id="empName" name="empName" value="%{empName}"/>
							<s:hidden id="fromDate" name="fromDate" value="%{fromDate}"/>
							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									<b>Salary</b></td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{empSalary}" /> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{currStatusSal}" /> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="holdAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','Salary')">Hold</button>
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="unHoldAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','Salary')">UnHold</button>
								</td>
						
							</tr>

							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									<b>TA</b></td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{empTA}" /> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{currStatusTA}" /> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="holdAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','TA')">Hold</button>
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="unHoldAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','TA')">UnHold</button>
								</td>
							
							</tr>

							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									<b>DA</b></td>
								<td width="5%" valign="middle" style="text-align: center;">
									 <s:property value="%{empDA}" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{currStatusDA}" /> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="holdAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','DA')">Hold</button>
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="unHoldAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','DA')">UnHold</button>
								</td>
						
							</tr>


							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									<b>Hotel Expense</b></td>
								<td width="5%" valign="middle" style="text-align: center;">
									 <s:property value="%{hotelExpense}" /> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{currStatusHE}" /> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<button type="button" class="button" onclick="holdAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','Hotel Expense')">Hold</button>
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<button type="button" class="button" onclick="unHoldAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','Hotel Expense')">UnHold</button>
								</td>
							
							</tr>
							
							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									<b>Other Expense</b></td>
								<td width="5%" valign="middle" style="text-align: center;">
									 <s:property value="%{otherExpense}" /> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="%{currStatusOE}" /> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<button type="button" class="button" onclick="holdAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','Others Expense')">Hold</button>
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<button type="button" class="button" onclick="unHoldAmount('<s:property value="%{empName}" />','<s:property value="%{fromDate}" />','Others Expense')">UnHold</button>
								</td>
							
							</tr>
							

						</tbody>

					</table>
				</s:form>
			</div>


			<div class="box_footer"></div>


	</div>
	<div id="expandIt"></div>

</body>
</html>
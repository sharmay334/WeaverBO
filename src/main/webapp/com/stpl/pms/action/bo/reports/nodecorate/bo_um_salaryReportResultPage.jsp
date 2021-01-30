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
	                title: 'CRM-Salary Report\nJAMINDARA SEEDS CORPORATION,\nP.B. Road Rane Bannure Distric-HAVERI,KARNATAKA\nREG.ADD. 73,GANESH NAGAR-MURLIPURA JAIPUR\n',
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

</script>
</head>

<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if
			test="%{salaryBeanMap!=null && salaryBeanMap.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Salary Report Result</h4>
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
								id="th_1">Emp Id</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Attendance Type</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Working Hour</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Salary</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Total Reading</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">T.A</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">D.A</th>		
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Hotel Expense</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Other Expense</th>	
								
						</tr>
					</thead>
					<tbody>
						
						<tr class="no-sort">
							<td width="5%" valign="middle" style="text-align: center;">`</td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;"></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b><s:property value="%{totalSalary}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b><s:property value="%{totalOdoReading}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b><s:property value="%{totalTAAmt}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b><s:property value="%{totalDaAmt}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b><s:property value="%{totalHotelExpAmt}" /></b></td>
							<td width="5%" valign="middle" style="text-align: center;color:brown;font-size:14px;"><b><s:property value="%{totalOtherExpAmt}" /></b></td>
							
							</tr>
					
						<s:iterator value="salaryBeanMap" var="resultMapVar">
						<s:set var="attendanceMap" value="#resultMapVar.value" />
							
							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.date" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.empId" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.attendanceType" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.workingHour" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.salary" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.odoReading" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.TA" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.dA" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.hotelExp" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.otherExp" />
								</td>
							</tr>
						</s:iterator>
						
							
							
					</tbody>
						
				</table>
				</s:form>
			</div>
			
			
			<div class="box_footer"></div>
			
			
			
			
		</s:if>
		
	
	</div>
	<div id="expandIt"></div>

</body>
</html>
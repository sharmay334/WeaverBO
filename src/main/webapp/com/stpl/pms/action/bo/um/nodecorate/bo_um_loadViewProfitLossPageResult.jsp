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
function closeMe(){
	
	document.getElementById("myModal").style.display = "none";
		
}
function callPictureReportVisit(visitId){
	var myurl = "<%=basePath%>";
	myurl += "com/stpl/pms/action/bo/um/bo_um_emp_visit_picture_report.action?visitId="
			+ visitId;
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			var list1 = document.getElementById("one");
			document.getElementById('s1').innerHTML = "Visit Image";
			document.getElementById('s2').innerHTML = "";
			document.getElementById('s3').innerHTML = "";
			document.getElementById('s4').innerHTML = "";
				if(typeof(list1.childNodes[0])!="undefined")
				list1.removeChild(list1.childNodes[0]);
					
				
			  var x = document.createElement("IMG");
				  x.setAttribute("src", itr);
				  x.setAttribute("width", "228");
				  x.setAttribute("height", "228");
				  x.setAttribute("alt", "Employee Img");
				  document.getElementById('one').appendChild(x);
			
			 
			document.getElementById("myModal").style.display = "block";
		},
		error : function(itr) {

		}
	});
}

	function getDetailedInfo(distName,visitId){
		
		var myurl = "<%=basePath%>";
		
		//var frm = $('#searchUserFrm');
		myurl += "/com/stpl/pms/action/bo/um/bo_um_viewEmpWiseVisitDetails_submit.action?distributorName="+distName+"&visitId="+visitId;

		
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(result) {
				$('#expandIt').html(result);
				eval('createBubble()');
				if (callback != '') {
					eval(callback);
				}
			}
		});
	}
	
	

	
	
	$(document).ready(function() {
		
		$("#waitDiv").hide();
		$("#submitBtn").attr("disabled",false);
		$("#submitBtn").show();
		
		var append="Profit Loss Report";
		
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
	                title: 'CRM- Report\nJAMINDARA SEEDS CORPORATION,\nP.B. Road Rane Bannure Distric-HAVERI,KARNATAKA\nREG.ADD. 73,GANESH NAGAR-MURLIPURA JAIPUR\n'+append,
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
			test="%{profitLossMap!=null && profitLossMap.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Profit Loss Report</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			<div class="dataTbl_top">
				
			</div>
			<div class="innerBox">
			<s:form id="searchUserFrm2" method="GET" action="/com/stpl/pms/action/bo/um/bo_um_viewEmpWiseVisitDetails_submit.action"
			 target="expandIt" theme="simple">
				<table id="payTransactionTable" cellspacing="0"
					cellpadding="4" border="0" align="center" class="payTransaction">
					<thead>
						<tr>
							
						    <th width="5%" valign="middle" id="th_1" 
								style="text-align: center;">TOTAL SALE VALUE</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">TOTAL CREDIT NOTE VALUE</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_4">TOTAL PURCHASE VALUE</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">GROSS PROFIT </th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">GROSS LOSS</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">NET PROFIT </th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">NET LOSS</th>
								
								
							
							
						</tr>
					</thead>
					<tbody>
						<s:iterator value="profitLossMap" var="resultMapVar">
							<s:set var="attendanceMap" value="#resultMapVar.value" />
							<tr>
								<td width="5%" valign="middle" style="text-align: center;">	<s:property value="#attendanceMap.totalSaleValue" /></td>
								<td width="5%" valign="middle" style="text-align: center;"><s:property value="#attendanceMap.creditNoteValue" /></td>
								<td width="5%" valign="middle" style="text-align: center;"><s:property value="#attendanceMap.totalPurchaseValue" /></td>
								<td width="5%" valign="middle" style="text-align: center;"><b><font color='green' ><s:property value="#attendanceMap.netProfitValue" /></font></b></td>
								<td width="5%" valign="middle" style="text-align: center;"><b><font color='red' ><s:property value="#attendanceMap.netLossValue" /></font></b></td>
								<td width="5%" valign="middle" style="text-align: center;"><b><font color='green' ><s:property value="#attendanceMap.finalProfitValue" /></font></b></td>
								<td width="5%" valign="middle" style="text-align: center;"><b><font color='red' ><s:property value="#attendanceMap.finalLossValue" /></font></b></td>
								
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
 			  <div id="bill_by_bill1">
						<div class="FormSectionMenu">
							<div class="greyStrip">
								<h4>Picture Report :<b></h4>
							</div>
							<table width="100%" cellspacing="0" align="center">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap"><span id="s1">Odometer Picture In</span></th>
								<th style="text-align: center;" nowrap="nowrap"><span id="s2">Odometer Picture Out</span></th>
								<th style="text-align: center;" nowrap="nowrap"><span id="s3">Selfie In</span></th>
								<th style="text-align: center;" nowrap="nowrap"><span id="s4">Selfie Out</span></th>
						
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
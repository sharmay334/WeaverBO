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
function callPictureReport(src){
	var myurl = "<%=basePath%>";
	myurl += "com/stpl/pms/action/bo/um/bo_um_emp_picture.action?docPath="
			+ src;
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			
			var list1 = document.getElementById("one");
				if(typeof(list1.childNodes[0])!="undefined")
				list1.removeChild(list1.childNodes[0]);
					
				
			  var x = document.createElement("IMG");
				  x.setAttribute("src", itr);
				  x.setAttribute("width", "500");
				  x.setAttribute("height", "600");
				  x.setAttribute("alt", "Doc Img");
				  document.getElementById('one').appendChild(x);
			
			
			 
			document.getElementById("myModal").style.display = "block";
		},
		error : function(itr) {

		}
	});
}
function closeMe(){
	document.getElementById("myModal").style.display = "none";
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
		<s:if test="%{expenseMapResult!=null && expenseMapResult.size()>0}">
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
									id="th_1">EmpId</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Date</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_2">Expense Type</th>
								<th width="5%" valign="middle" style="text-align: center;"
									id="th_3">Amount</th>
								<th width="3%" valign="middle" style="text-align: center;"
									id="th_2">Document</th>


							</tr>
						</thead>
						<tbody>
							<s:iterator value="expenseMapResult" var="resultMapVar">
								<s:set var="attendanceMap" value="#resultMapVar.value" />
								<tr>

									<td width="5%" valign="middle" style="text-align: center;">
										<s:property value="#attendanceMap.sNo" />

									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										EMP-<s:property value="#attendanceMap.empId" />
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.date" />
									</b>
									</td>
									
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.expenseType" />
									</b>
									</td>
									<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.amount" />
									</b>
									</td>
									<td width="3%" valign="middle" style="text-align: center;">
										<button type="button" class="button"
											onclick="callPictureReport('<s:property value="#attendanceMap.picturePath"/>')">&#10175;</button>
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
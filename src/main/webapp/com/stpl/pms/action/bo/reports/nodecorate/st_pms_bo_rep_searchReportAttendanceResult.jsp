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
function closeMe(){
	
		document.getElementById("myModal").style.display = "none";
			
}

function getBatteryReport(empId,date){
	var frm = $('#searchUserFrm2');
	
	
	var newUrl = frm.attr('action').replace("AttendanceVisit","BatteryPer");
	
		$.ajax({
	        type: frm.attr('method'),
	        url: newUrl+'?empId='+empId+'&attendanceDate='+date,
	        async:false,
	        data: frm.serialize(),
	        success: function (data) {
	        	 $("#searchResult1").html(data);
	        	 $(document).ready(function() {

	        			$('#payTransactionTable1').DataTable({
	        				 "destroy": true,
	        				 "scrollX": true,
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
	        				
	        			});
	        		});
	        //    document.getElementById('searchResult1').innerHTML = data;
	        },
	        error: function (data) {
	        	 document.getElementById('searchResult1').innerHTML = data;
	        },
	    });
			 
}
function getReport(empId,date){
	var frm = $('#searchUserFrm2');

	 $.ajax({
	        type: frm.attr('method'),
	        url: frm.attr('action')+'?empId='+empId+'&attendanceDate='+date,
	        async:false,
	        data: frm.serialize(),
	        success: function (data) {
	        	 $("#searchResult1").html(data);
	        	 $(document).ready(function() {

	        			$('#payTransactionTable1').DataTable({
	        				 "destroy": true,
	        				 "scrollX": true,
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
	        				
	        				
	        			});
	        		});
	        //    document.getElementById('searchResult1').innerHTML = data;
	        },
	        error: function (data) {
	        	 document.getElementById('searchResult1').innerHTML = data;
	        },
	    });
	
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
function callPictureReport(empId,attDate){
	empIdArr = empId.split("-");
	var myurl = "<%=basePath%>";
	myurl += "com/stpl/pms/action/bo/um/bo_um_emp_picture_report.action?employeeUserName="
			+ empIdArr[1]+"&attendaceDate="+attDate;
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			itrArr = itr.split(";");
			var list1 = document.getElementById("one");
			var list2 = document.getElementById("two");
			var list3 = document.getElementById("three");
			var list4 = document.getElementById("four");
			document.getElementById('s1').innerHTML = "Odometer Picture In";
			document.getElementById('s2').innerHTML = "Odometer Picture Out";
			document.getElementById('s3').innerHTML = "Selfie In";
			document.getElementById('s4').innerHTML = "Selfie Out";
			
				if(typeof(list1.childNodes[0])!="undefined")
				list1.removeChild(list1.childNodes[0]);
				if(typeof(list2.childNodes[0])!="undefined")
					list2.removeChild(list2.childNodes[0]);
				if(typeof(list3.childNodes[0])!="undefined")
					list3.removeChild(list3.childNodes[0]);
				if(typeof(list4.childNodes[0])!="undefined")
					list4.removeChild(list4.childNodes[0]);
					
				
			  var x = document.createElement("IMG");
				  x.setAttribute("src", itrArr[0]);
				  x.setAttribute("width", "228");
				  x.setAttribute("height", "228");
				  x.setAttribute("alt", "Employee Img");
				  document.getElementById('one').appendChild(x);
			
				  var xx = document.createElement("IMG");
				  xx.setAttribute("src", itrArr[1]);
				  xx.setAttribute("width", "228");
				  xx.setAttribute("height", "228");
				  xx.setAttribute("alt", "Employee Img");
				  document.getElementById('two').appendChild(xx);
			
				  var y = document.createElement("IMG");
				  y.setAttribute("src", itrArr[2]);
				  y.setAttribute("width", "228");
				  y.setAttribute("height", "228");
				  y.setAttribute("alt", "Employee Img");
				  document.getElementById('three').appendChild(y);
			
				  var yy = document.createElement("IMG");
				  yy.setAttribute("src", itrArr[3]);
				  yy.setAttribute("width", "228");
				  yy.setAttribute("height", "228");
				  yy.setAttribute("alt", "Employee Img");
				  document.getElementById('four').appendChild(yy);
			
			 
			document.getElementById("myModal").style.display = "block";
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
		
		$('#payTransactionTable').DataTable({
			 "scrollX": true,
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
			
			
		});
	});
//	$('#payTransactionTable').DataTable();

</script>
</head>

<body>
	<div class="clear2"></div>
	<div class="FormSection">
		<s:if
			test="%{attendanceMapResult!=null && attendanceMapResult.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left">Employee Attendance Report</h4>
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
							<th width="5%" valign="middle" id="th_0" is_link="false"
								style="text-align: center;">Employee Id</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_1">Attendance Date</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Attendance Mark</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Present In</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Present Out</th>	
								<th width="5%" valign="middle" style="text-align: center;"
								id="th_2">Working Hour</th>	
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Work Type</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Work Area</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Travelling Mode</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Odometer Reading In</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Odometer Reading Out</th>
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Total Reading</th> 
							<th width="5%" valign="middle" style="text-align: center;"
								id="th_3">Visit Target</th> 	
							<th width="5%" valign="middle" style="text-align: center;" is_link="false"
								id="th_3">Visit Report</th>	
							<th width="5%" valign="middle" style="text-align: center;" is_link="false"
								id="th_3">Battery Percentage</th>		
						</tr>
					</thead>
					<tbody>
						<s:iterator value="attendanceMapResult" var="resultMapVar">
							<s:set var="attendanceMap" value="#resultMapVar.value" />
							<tr>

								<td width="5%" valign="middle" style="text-align: center;">
									<a href="javascript:;" onclick="callPictureReport('<s:property value="#attendanceMap.empId" />','<s:property value="#attendanceMap.attendanceDate" />')"><s:property value="#attendanceMap.empId" /></a>
									<s:hidden value="%{#attendanceMap.empId}"></s:hidden>
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.attendanceDate" />
									<s:hidden  value="%{#attendanceMap.attendanceDate}"></s:hidden>
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.attendaceMark" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.presentIn" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.presentout" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
										<b> <s:property value="#attendanceMap.workingHour" /> </b> 
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.workType" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.workArea" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.travellingMode" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.odometerReadingIn" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.odometerReadingOut" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.totalReading" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
									<s:property value="#attendanceMap.visitLocation" />
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="getReport('<s:property value="#attendanceMap.empId" />','<s:property value="#attendanceMap.attendanceDate" />')">GET</button>
								</td>
								<td width="5%" valign="middle" style="text-align: center;">
								<button type="button" class="button" onclick="getBatteryReport('<s:property value="#attendanceMap.empId" />','<s:property value="#attendanceMap.attendanceDate" />')">GET</button>
								</td>

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
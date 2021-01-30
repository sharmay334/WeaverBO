<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Salary Report</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
<script src="js/facebox.js" type="text/javascript"></script>
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

<SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/cms/js/cms.js"></SCRIPT>
	<SCRIPT type="text/javascript">
	function getEmployeeSalary(empName){
		var frm = $('#pomFrm');
		if(empName!="-1"){
			 $.ajax({
			        type: "GET",
			        url: '/WeaverBO/com/stpl/pms/action/bo/um/bo_um_getSalaryMonthsEmp.action?empName='+empName,
			        success: function (data) {
			        	if(data=="error"){
			        		
			        		swal("No Date of joining found in the record for the employee!");
			        		
			        		
			        	}
			        	else{
			        		
			        		var arr = data.split(";")
			        		var myoption;
			        		myoption = myoption+"<option>Select Month</option>"
			        		for(var i=0;i<arr.length-1;i++){
			        			myoption+="<option>" +arr[i] + "</option>";
			        			
			        		}
			        		document.getElementById('monthYear').innerHTML = myoption;
			        		
			        		
			        	}
			        },
			        error: function (data) {
			        	swal("Server Error Occured!");
			        },
			    });
			
			
		}
	}
	
	</SCRIPT>
	
  </head>
  
   <body>
	<div id="container">
			<h2>
				Salary Report

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Salary Report
					</h4>
				</div>
					 <s:form id="searchUserFrm" action="/com/stpl/pms/action/bo/um/bo_um_generateSalaryReport.action"
			 target="searchResult" theme="simple">
					<div class="innerBox">


						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Employee Name:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="%{employeeNames}"
									name="empName" id="employeeName" onchange="getEmployeeSalary(this.value)" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></s:select>
									<div id="empName_error" class="fieldError">
							<s:fielderror>
								<s:param>empName</s:param>
							</s:fielderror>
						</div>
									
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Select Month:
								</label>
							</div>
							<div class="InputDiv">
							<select name="monthYear" id="monthYear" class="select1">
								
							</select>
							
							</div>
						</div>
						
								
					</div>
					<div class="box_footer" align="right">
				<!-- 	<button type="button" theme="simple" onclick="getReport()">Submit</button> -->
				<s:submit name="Search" value="Search" id="searchButton"
					cssClass="button"></s:submit>
					</div>
				</s:form>
			</div>
			<div id="searchResult"></div>
		</div>
  </body>
</html>

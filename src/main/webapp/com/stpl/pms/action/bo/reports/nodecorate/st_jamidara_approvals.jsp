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

<title>Approval</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

<script>
	
function submitRequest(){
	
	var frm = $('#searchUserFrm2');
	  $.ajax({
	        type: 'POST',
	        async: false,
	        url: '/WeaverBO/com/stpl/pms/action/bo/um/st_jamidara_approval_set_update.action',
	        data: frm.serialize(),
	        success: function (data) {
	        	if(data=="success"){
	        		swal("Approval Request is sucessfully uploaded!");
	        		setTimeout(function(){
	        			   window.location.reload(1);
	        			}, 1000);
	        	}
	        	else if(data=="validation"){
	        		swal("Please Select All Approval Level Before Submit!!");
	        		
	        	}
	        	else{
	        		swal("Some Error Occured!");
	        		setTimeout(function(){
	        			   window.location.reload(1);
	        			}, 1000);
	        	}
	            
	        },
	        error: function (data) {
	        	swal("Server Error Occured!");
	        },
	    });
	  
}
</script>
</head>

<body>
	<div class="clear2"></div>
	<div class="FormSection">
			<div class="greyStrip">
				<h4 style="float: left">Employee Transaction Approval</h4>
				<h4 class="dateData" style="text-align: right"></h4>
			</div>
			
			<s:form id="searchUserFrm2" method="GET" action="/com/stpl/pms/action/bo/um/st_jamidara_approval_set_update.action"
			theme="simple">
			 <s:hidden name="empName" value="%{empName}"></s:hidden>
				<div class="innerBox">
					<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Junior Accountant Approval:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="%{employeeNames}" value="%{juniorAccName}"
									name="juniorAccName" id="juniorAccName" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></s:select>
									<div id="juniorAccName_error" class="fieldError">
							<s:fielderror>
								<s:param>juniorAccName</s:param>
							</s:fielderror>
						</div>
									
							</div>
						</div>
						
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Dispatcher Approval:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="%{employeeNames}" value="%{dispatcherName}"
									name="dispatcherName" id="dispatcherName" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></s:select>
									<div id="dispatcherName_error" class="fieldError">
							<s:fielderror>
								<s:param>dispatcherName</s:param>
							</s:fielderror>
						</div>
									
							</div>
						</div>
						
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Senior Accountant Approval:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="%{employeeNames}" value="%{seniorAccName}"
									name="seniorAccName" id="seniorAccName" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></s:select>
									<div id="seniorAccName_error" class="fieldError">
							<s:fielderror>
								<s:param>seniorAccName</s:param>
							</s:fielderror>
						</div>
									
							</div>
						</div>
				</div>
					<div class="box_footer">
					<button type="button" class="button" onclick="submitRequest()">Submit</button> 
					</div>
				</s:form>
			</div>
	
	<div id="expandIt"></div>
</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Upload</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%-- <script type="text/javascript"
	src="com/stpl/pms/action/bo/reports/js/common_report.js"></script> --%>
	<script src="/WeaverBO/js/sweetalert.min.js"></script>
	
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
	
</script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

</head>
<script>

function validateFile(fileName, id) {
	var file = fileName.value;
	var ext = file.substring(file.length, file.length - 3);
	if (file != "") {
		if (ext != "pdf") {
			document.getElementById(id).value = "";
			alert('only pdf file is allowed!');
		}
	}

}
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

	 $(document).ready(
			function() {
				
				$('form').submit(function() {
					if ($('#providerId').val() == -1) {
						$('errorDiv'.show());
						createBubble();
					}
					$("#submitBtn").hide();
					$("#waitDiv").show();
					$("#submitBtn").attr("disabled", true);
					return ajaxCall(this);
				});

			});

	function ajaxCall(form) {
		var form = $(form);
		var target = form.attr('target');
		
		let photo = document.getElementById("docPicture").files[0];
		let formData = new FormData();
		if(photo!=undefined)
			formData.append("docPicture", photo);
		formData.append("itemName", document.getElementById('itemName').value);
		
		var callback = (typeof form.attr('callBack') !== 'undefined') ? form
				.attr('callBack') : '';
		$.ajax({
			type : "POST",
			url : form.attr('action'),
			data : formData,
			aysnc:false,
			cache : false,
			contentType : false,
			processData : false,
			success : function(result) {
				if(result=="success"){
					
					swal({
						  title: "Good job!",
						  text: "Data uploaded successfully!",
						  icon: "success",
						  button: "Close",
						});
					setTimeout(function(){
	        			   window.location.reload(1);
	        			}, 3000);
				
				}
				else{
					swal({
						  title: "Oops! Failed to upload File",
						  text: "Please try after some time!",
						  icon: "warning",
						  button: "Close",
						});
				}
				
				$("#waitDiv").hide();
				$("#submitBtn").show();
				$("#submitBtn").attr("disabled", false);
				
				//$('#' + target).html(result);
				eval('createBubble()');
				if (callback != '') {
					eval(callback);
				}
			}
		});
		return false;
	} 
</script>
<body>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Upload Brochure</h4>
		</div>
		<s:form id="searchUserFrm"
			action="/com/stpl/pms/action/bo/um/bo_um_uploadBrochure_submit.action"
			target="searchResult" enctype="multipart/form-data" theme="simple">

			<div class="innerBox">
				<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Select Item Name:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="%{itemNamesList}"
									name="itemName" id="itemName"  headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></s:select>
									<div id=itemName_error" class="fieldError">
							<s:fielderror>
								<s:param>itemName</s:param>
							</s:fielderror>
						</div>
									
							</div>
						</div>
						
						
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Upload PDF File:
								</label>
							</div>
							<div class="InputDiv">
	<s:file label="upload" applyscript="true" onmouseout="validateFile(this,'docPicture')" id="docPicture" name="docPicture" cssClass="textfield" theme="myTheme"></s:file>

							
							</div>
						</div>
				
					
				<div class="box_footer" align="right">
					<div id="waitDiv" class="animated-button-div"
						style="margin-left: 0px; display: none;">
						<div class="animated-striped" style="padding: 3px 20px 2px 20px;">Wait...</div>
					</div>
					<%-- <s:submit name="Search" value="Search" id="searchButton"
					cssClass="button"></s:submit> --%>
					<s:submit theme="simple" id="submitBtn" value="Upload"></s:submit>
				</div>
			</div>
		</s:form>
	</div>
	<div id="searchResult"></div>
</body>
</html>

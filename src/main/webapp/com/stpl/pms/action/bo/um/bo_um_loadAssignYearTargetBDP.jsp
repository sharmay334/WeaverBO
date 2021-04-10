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

<title>BDP</title>

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

function getTeamTarget(smName){
	
var myurl = "<%=basePath%>";
	
	var frm = $('#searchUserFrm');
	myurl += "/com/stpl/pms/action/bo/um/getSMTeamTargetAmount.action?smName="+smName+"&subTeamName="+document.getElementById('subTeamName').value;
			
	if(document.getElementById('subTeamName').value=="-1"){
		swal('please select sub team first!');
	}
	else{
		$.ajax({
	        type: 'GET',
	        url: myurl,
	        async:false,
	        success: function (data) {
	        			var result = data.split(",");
	        			
	        		  document.getElementById('teamTarget').value=result[0];
	        		  document.getElementById('teamPendingTarget').value=result[1];
	        		  
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
		var callback = (typeof form.attr('callBack') !== 'undefined') ? form
				.attr('callBack') : '';
		$.ajax({
			type : "POST",
			url : form.attr('action'),
			data : form.serialize(),
			success : function(result) {
				if(result=="success"){
					
					swal({
						  title: "Good job!",
						  text: "Target set successfully!",
						  icon: "success",
						  button: "Close",
						});
					setTimeout(function(){
	        			   window.location.reload(1);
	        			}, 1000);
				
				}
				else{
					swal({
						  title: "Oops! Failed to set target",
						  text: "Duplicate Entry Found",
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
			<h4>Set Yearly Target</h4>
		</div>
		<s:form id="searchUserFrm"
			action="/com/stpl/pms/action/bo/um/bo_um_assignTargetYearly_submit.action"
			target="searchResult" theme="simple">

			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Select Employee</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="empName" headerKey="-1" id="empName"
								headerValue="--Please Select--" list="empNameList"
								cssClass="select1" theme="myTheme" errorMassage="Select Employee"/>
						<div id="empName_error" class="fieldError">
							<s:fielderror>
								<s:param>empName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Select Target Year</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="targetYear" headerKey="-1" id="targetYear"
								headerValue="--Please Select--" list="yearList"
								cssClass="select1" theme="myTheme" errorMassage="Select Year First"/>
						<div id="targetYear_error" class="fieldError">
							<s:fielderror>
								<s:param>targetYear</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Select Product Category</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="productCategory" headerKey="-1" id="productCategory"
								headerValue="--Please Select--" list="productCategoryList"
								cssClass="select1" theme="myTheme" errorMassage="Select Category First"/>
						<div id="productCategory_error" class="fieldError">
							<s:fielderror>
								<s:param>productCategory</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				

				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Target Amount</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" id="target" applyscript="true"
							theme="myTheme" name="target" pattern="^[0-9.]*$"
							errorMassage="Only Numeric Character not allowed"
							theme="myTheme"></ss:textfield>
						<div id="target_error" class="fieldError">
							<s:fielderror>
								<s:param>target</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>

				<div class="box_footer" align="right">
					<div id="waitDiv" class="animated-button-div"
						style="margin-left: 0px; display: none;">
						<div class="animated-striped" style="padding: 3px 20px 2px 20px;">Wait...</div>
					</div>
					<%-- <s:submit name="Search" value="Search" id="searchButton"
					cssClass="button"></s:submit> --%>
					<s:submit theme="simple" id="submitBtn" value="Create"></s:submit>
				</div>
			</div>
		</s:form>
	</div>
	<div id="searchResult"></div>
</body>
</html>

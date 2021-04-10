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

<title>Define Retailer</title>

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
						  text: "Retailer defined successfully!",
						  icon: "success",
						  button: "Close",
						});
					setTimeout(function(){
	        			   window.location.reload(1);
	        			}, 1000);
				
				}
				else{
					swal({
						  title: "Oops! Failed to define Retailer",
						  text: "Duplicate Entry",
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
			<h4>Define Retailer</h4>
		</div>
		<s:form id="searchUserFrm"
			action="/com/stpl/pms/action/bo/um/bo_um_defineRetailer_submit.action"
			target="searchResult" theme="simple">

			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Enter Firm Name</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="50" id="firmName" applyscript="true"
							theme="myTheme" name="firmName"></ss:textfield>
						<div id="firmName_error" class="fieldError">
							<s:fielderror>
								<s:param>firmName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Enter Retailer Name</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="50" id="retName" applyscript="true"
							theme="myTheme" name="retName" pattern="^[a-z A-Z 0-9. ]*$"
							errorMassage="Special Character not allowed"
							theme="myTheme"></ss:textfield>
						<div id="retName_error" class="fieldError">
							<s:fielderror>
								<s:param>retName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Enter Contact</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="50" id="retContact" applyscript="true"
							theme="myTheme" name="retContact" pattern="^[0-9]*$"
							errorMassage="Only Numeric allowed"
							theme="myTheme"></ss:textfield>
						<div id="retContact_error" class="fieldError">
							<s:fielderror>
								<s:param>retContact</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Enter Address</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" id="retAddress" applyscript="true"
							theme="myTheme" name="retAddress"
							theme="myTheme"></ss:textfield>
						<div id="retContact_error" class="fieldError">
							<s:fielderror>
								<s:param>retContact</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Enter Tehsil</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" id="retTehsil" applyscript="true"
							theme="myTheme" name="retTehsil"
							theme="myTheme"></ss:textfield>
						<div id="retTehsil_error" class="fieldError">
							<s:fielderror>
								<s:param>retTehsil</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Enter District</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" id="retDistrict" applyscript="true"
							theme="myTheme" name="retDistrict"
							theme="myTheme"></ss:textfield>
						<div id="retDistrict_error" class="fieldError">
							<s:fielderror>
								<s:param>retDistrict</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Enter Location</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="%{sourceLocationList}"
									name="location" id="location" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></s:select>
									<div id="location_error" class="fieldError">
							<s:fielderror>
								<s:param>location</s:param>
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

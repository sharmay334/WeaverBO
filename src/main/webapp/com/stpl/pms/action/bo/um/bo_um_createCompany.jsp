<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=path%>/css/jquery.ui.theme.min.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript">
	function validateFile(fileName, id) {
		var file = fileName.value;
		var ext = file.substring(file.length, file.length - 3);
		if (file != "") {
			if (ext != "png" && ext != "jpg" && ext != "jpeg" && ext != "doc"
					&& ext != "docx" && ext != "pdf") {
				document.getElementById(id).value = "";
				alert('only image,pdf or doc file is allowed!');
			}
		}

	}
	$(document).ready(function() {
		$("#fyb").datetimepicker({
			dateFormat : 'mm/dd/yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01/01/1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#fyb").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#fyb").datepicker({
							dateFormat : 'dd-mm-yy'
						}).datepicker("setDate", date);
					});
				}
			}
		});
		$("#bbf").datetimepicker({
			dateFormat : 'mm/dd/yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01/01/1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#bbf").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#bbf").datepicker({
							dateFormat : 'dd-mm-yy'
						}).datepicker("setDate", date);
					});
				}
			}
		});		
	});
</script>
<title>Create Company</title>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Create Company
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				Fill Details
			</h4>
		</div>

		<s:form name="newsubuser"
			action="/com/stpl/pms/action/bo/um/bo_um_createCompany_Reg.action"
			theme="simple" enctype="multipart/form-data" method="POST"
			novalidate="true">
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Company Name </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="name" id="name" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="name_error" class="fieldError">
							<s:fielderror>
								<s:param>name</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
								<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.subuserregistration.E-mail" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="42" name="email" id="email"
							theme="myTheme" applyscript="true" />
						<div id="email_error" class="fieldError">
							<s:fielderror>
								<s:param>email</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text
								name="global.subuserregistration.currentAddress" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="currentAddress"
							id="currentAddress" theme="myTheme"></ss:textfield>
						<div id="currentAddress_error" class="fieldError">
							<s:fielderror>
								<s:param>currentAddress</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Country </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="country" id="country"
							theme="myTheme" pattern="^[a-zA-Z]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="country_error" class="fieldError">
							<s:fielderror>
								<s:param>country</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> State </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="state" id="state"
							theme="myTheme" pattern="^[a-zA-Z]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="state_error" class="fieldError">
							<s:fielderror>
								<s:param>state</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Pincode </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="pincode" id="pincode"
							theme="myTheme" pattern="^[0-9]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="pincode_error" class="fieldError">
							<s:fielderror>
								<s:param>pincode</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text
								name="global.subuserregistration.PhoneNumber" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="10" name="contactNo" id="contactNo"
							pattern="^[0-9]{9,10}$" patternOn="blur"
							errorMassage="Please Enter Valid Phone Number" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="contactNo_error" class="fieldError">
							<s:fielderror>
								<s:param>contactNo</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Financial Year begin|Books beg from </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield name="fyb" placeholder="Financial Year begins"
							cssClass="dateField" id="fyb" readonly="true" theme="myTheme"></ss:textfield>
						<ss:textfield name="bbf" placeholder="Books beginning from"
							cssClass="dateField" id="bbf" readonly="true" theme="myTheme"></ss:textfield>
					</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Company GSTIN No. </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="gstNo" id="gstNo" theme="myTheme"
							pattern="^[a-zA-Z0-9]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="gstNo_error" class="fieldError">
							<s:fielderror>
								<s:param>gstNo</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Company License No. </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="license" id="license" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="license_error" class="fieldError">
							<s:fielderror>
								<s:param>license</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Company Seeds License No. </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="csln" id="csln" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="csln_error" class="fieldError">
							<s:fielderror>
								<s:param>csln</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Company Pesticide License No. </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="cpln" id="cpln" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="cpln_error" class="fieldError">
							<s:fielderror>
								<s:param>cpln</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Company Fertilizer License No. </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="cfln" id="cfln" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="cfln_error" class="fieldError">
							<s:fielderror>
								<s:param>cfln</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Company CIN REG No. </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="cinRegNo" id="cinRegNo" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="cinRegNo_error" class="fieldError">
							<s:fielderror>
								<s:param>cinRegNo</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Company PAN No. </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="panNo" id="panNo" theme="myTheme"
							pattern="^[a-zA-Z0-9]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="gstNo_error" class="fieldError">
							<s:fielderror>
								<s:param>panNo</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Bank Details(Bank Name) </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="bankName" id="bankName" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="bankName_error" class="fieldError">
							<s:fielderror>
								<s:param>bankName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Bank Details(Account No) </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="accountNo" id="accountNo" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="accountNo_error" class="fieldError">
							<s:fielderror>
								<s:param>accountNo</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Bank Details(Confirm Account No) </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="accountNoConfirm" id="accountNoConfirm" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="accountNoConfirm_error" class="fieldError">
							<s:fielderror>
								<s:param>accountNoConfirm</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
					<div class="FormMainBox">
					<div class="labelDiv">
						<label>Bank Details(Account Holder Name) </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="accHolderName" id="accHolderName" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="accHolderName_error" class="fieldError">
							<s:fielderror>
								<s:param>accHolderName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
					
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Bank Details(IFSC Code) </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="ifsc" id="ifsc" theme="myTheme"
							pattern="^[a-zA-Z0-9]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="ifsc_error" class="fieldError">
							<s:fielderror>
								<s:param>ifsc</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
								<div class="labelDiv">
									<label> Upload Company Logo </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="companyLogo"
										onmouseout="validateFile(this,'companyLogo')"
										id="companyLogo"></s:file>
								</div>
								<div>
									<div id="companyLogoDiv"></div>
								</div>
							</div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> Upload Signature </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="signature"
										onmouseout="validateFile(this,'signature')"
										id="signature"></s:file>
								</div>
								<div>
									<div id="signatureDiv"></div>
								</div>
							</div>
							
			</div>

			<div class="box_footer" align="right">
				<%-- <s:submit value="Register" align="left" cssClass="button"
				theme="simple" /> --%>
				<input type="submit"
					value='<s:text name="global.subuserregistration.Register"/>'
					align="left" class="button" />
			</div>
		</s:form>
	</div>
</body>
</html>

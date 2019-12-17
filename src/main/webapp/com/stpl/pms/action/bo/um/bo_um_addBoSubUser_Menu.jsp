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
			if (ext != "png" && ext != "jpg" && ext != "jpeg"
				&& ext != "doc" && ext != "docx" && ext != "pdf") {
				document.getElementById(id).value = "";
				alert('only image,pdf or doc file is allowed!');
			}
		}

	}
	$(document).ready(function() {
		$("#dob").datetimepicker({
			dateFormat : 'mm/dd/yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01/01/1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#dob").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#dob").datepicker({
							dateFormat : 'dd-mm-yy'
						}).datepicker("setDate", date);
					});
				}
			}
		});
		$("#doj").datetimepicker({
			dateFormat : 'mm/dd/yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01/01/1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#doj").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#doj").datepicker({
							dateFormat : 'dd-mm-yy'
						}).datepicker("setDate", date);
					});
				}
			}
		});
		$("#dol").datetimepicker({
			dateFormat : 'mm/dd/yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01/01/1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#dol").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#dol").datepicker({
							dateFormat : 'dd-mm-yy'
						}).datepicker("setDate", date);
					});
				}
			}
		});
	});
</script>
<title>Sub User Registration</title>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		<s:text name="global.scratchWeaver.subuserreg" />
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				<s:text name="global.scratchWeaver.info" />
			</h4>
		</div>

		<s:form name="newsubuser"
			action="/com/stpl/pms/action/bo/um/bo_um_addBoSubUser_Save.action"
			theme="simple" novalidate="true">
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.searchuser.firstname" />
						</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="firstName" id="firstName"
							theme="myTheme" pattern="^[a-zA-Z]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="firstName_error" class="fieldError">
							<s:fielderror>
								<s:param>firstName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.subuserregistration.LastName" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="lastName" id="lastName"
							theme="myTheme" pattern="^[a-zA-Z]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="lastName_error" class="fieldError">
							<s:fielderror>
								<s:param>lastName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text
								name="global.subuserregistration.FatherName" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="fatherName" id="fatherName"
							theme="myTheme" pattern="^[a-zA-Z]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="fatherName_error" class="fieldError">
							<s:fielderror>
								<s:param>fatherName</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.subuserregistration.DOB" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield name="dob" cssClass="dateField" id="dob"
							readonly="true" style="cursor:pointer;" theme="myTheme"></ss:textfield>
						<div id="dob_error" class="fieldError">
							<s:fielderror>
								<s:param>dob</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.subuserregistration.panNo" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="panNumber" id="panNumber"
							theme="myTheme" pattern="^[a-zA-Z0-9]*$"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>
						<div id="panNumber_error" class="fieldError">
							<s:fielderror>
								<s:param>panNumber</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.subuserregistration.aadharNo" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="aadharNumber" id="aadharNumber"
							theme="myTheme" pattern="^[0-9]*$"
							errorMassage="Only Numeric Character allowed" applyscript="true"></ss:textfield>
						<div id="aadharNumber_error" class="fieldError">
							<s:fielderror>
								<s:param>aadharNumber</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.subuserregistration.voterNo" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="voterNumber" id="voterNumber"
							theme="myTheme" pattern="^[0-9]*$"
							errorMassage="Only Numeric Character allowed" applyscript="true"></ss:textfield>
						<div id="voterNumber_error" class="fieldError">
							<s:fielderror>
								<s:param>voterNumber</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text
								name="global.subuserregistration.passportNo" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="passportNumber"
							id="passportNumber" theme="myTheme" pattern="^[0-9]*$"
							errorMassage="Only Numeric Character allowed" applyscript="true"></ss:textfield>
						<div id="passportNumber_error" class="fieldError">
							<s:fielderror>
								<s:param>passportNumber</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.subuserregistration.Gender" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<%-- <ss:select name="gender" headerKey="-1"
						headerValue="%{getText('global.SELECTHEADER')}" cssClass="select1" id="gender"
						list="#{'M':'Male','F':'Female'}" theme="myTheme" applyscript="true" />
					 --%>
						<select name="gender" id="gender" applyscript="true"
							class="select1">
							<option value="-1"><s:text name="global.SELECTHEADER" /></option>
							<option value="M"><s:text name="global.408" /></option>
							<option value="F"><s:text name="global.409" /></option>
						</select>

						<div id="gender_error" class="fieldError">
							<s:fielderror>
								<s:param>gender</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.subuserregistration.UserName" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="userName" id="userName"
							theme="myTheme" pattern="^[a-zA-Z._]*$"
							errorMassage="Numeric and Special Character not allowed"
							action="bo_um_validateusername.action" minLength="6"
							applyscript="true"></ss:textfield>
						<div id="userName_error" class="fieldError">
							<s:fielderror>
								<s:param>userName</s:param>
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
							theme="myTheme" onpaste="return false;"
							pattern="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
							errorMassage="Please Enter Valid Email Id" patternOn="blur"
							action="bo_um_validateemail.action" applyscript="true" />
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
								name="global.subuserregistration.PhoneNumber" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="10" name="phone" id="phone"
							pattern="^[0-9]{9,10}$" patternOn="blur"
							errorMassage="Please Enter Valid Phone Number" theme="myTheme"
							applyscript="true"></ss:textfield>
						<div id="phone_error" class="fieldError">
							<s:fielderror>
								<s:param>phone</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<s:hidden label="Status" name="status" value="ACTIVE" />
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text
								name="global.subuserregistration.bloodGroup" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="bloodGroup" id="bloodGroup"
							theme="myTheme"></ss:textfield>
						<div id="bloodGroup_error" class="fieldError">
							<s:fielderror>
								<s:param>bloodGroup</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.subuserregistration.branch" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="branch" id="branch"
							theme="myTheme" pattern="^[a-zA-Z]*$"
							errorMassage="Only Alphabets are allowed" applyscript="true"></ss:textfield>
						<div id="branch_error" class="fieldError">
							<s:fielderror>
								<s:param>branch</s:param>
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
						<ss:textfield maxlength="30" name="currentAddress"
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
						<label> <s:text
								name="global.subuserregistration.permanentAddress" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="permanentAddress"
							id="permanentAddress" theme="myTheme"></ss:textfield>
						<div id="permanentAddress_error" class="fieldError">
							<s:fielderror>
								<s:param>permanentAddress</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Date of Joining | Leaving </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield name="doj" placeholder="Date of joining"
							cssClass="dateField" id="doj" readonly="true" theme="myTheme"></ss:textfield>
						<ss:textfield name="dol" placeholder="Date of leaving"
							cssClass="dateField" id="dol" readonly="true" theme="myTheme"></ss:textfield>
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
						<label> City </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="city" id="city" theme="myTheme"
							pattern="^[a-zA-Z]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
						<div id="city_error" class="fieldError">
							<s:fielderror>
								<s:param>city</s:param>
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
								name="global.subuserregistration.SecretQuestion" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<%-- <ss:select name="secQues" cssClass="select1" headerKey="-1"
						headerValue="%{getText('global.SELECTHEADER')}" id="secQues" theme="myTheme"
						list="{'What is Your Pets Name?','Which is your favourite game?','What is your college name?'}"
						value="gameType" applyscript="true" /> --%>

						<select name="secQues" class="select1" id="secQues"
							theme="myTheme" applyscript="true">
							<option value="-1"><s:text name="global.SELECTHEADER" /></option>
							<option value="What is Your Pets Name?"><s:text
									name="global.subuserregistration.whatisyourpetsname" /></option>
							<option value="Which is your favourite game?"><s:text
									name="global.subuserregistration.whichisyourfavouritegame" /></option>
							<option value="What is your college name?"><s:text
									name="global.subuserregistration.whatisyourcollegename" /></option>

						</select>

						<div id="secQues_error" class="fieldError">
							<s:fielderror>
								<s:param>secQues</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>



				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text
								name="global.subuserregistration.SecretAnswer" />
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield name="secAns" id="secAns" maxlength="30"
							pattern="^[a-zA-Z ]*$" patternOn="blur"
							errorMassage="Numeric and Special character not allowed"
							theme="myTheme" applyscript="true"></ss:textfield>
						<div id="secAns_error" class="fieldError">
							<s:fielderror>
								<s:param>secAns</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div id="subdocform">
					<div class="FormSectionMenu" id="subdocform">
						<div class="greyStrip">
							<h4>Upload Documents</h4>
						</div>
						<div class="innerbox">
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> PHOTO </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="photo_doc" onmouseout="validateFile(this,'photo_doc')"
										id="photo_doc"></s:file>
								</div>
								<div>
									<div id="photo_docDiv"></div>
								</div>
							</div>

							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> OLD SALARY SLIP </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="oldSalarySlip"
										onmouseout="validateFile(this,'oldSalarySlip')"
										id="oldSalarySlip"></s:file>
								</div>
								<div>
									<div id="oldSalarySlipDiv"></div>
								</div>
							</div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> EXPERIENCE CERTIFICATE </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="expCertificate"
										onmouseout="validateFile(this,'expCertificate')"
										id="expCertificate"></s:file>
								</div>
								<div>
									<div id="expCertificateDiv"></div>
								</div>
							</div>

							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> EDUCATION CERTIFICATE </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="eduCertificate"
										onmouseout="validateFile(this,'expCertificate')"
										id="expCertificate"></s:file>
								</div>
								<div>
									<div id="expCertificateDiv"></div>
								</div>
							</div>

							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> PAN CARD </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="panDoc" onmouseout="validateFile(this,'panDoc')"
										id="panDoc"></s:file>
								</div>
								<div>
									<div id="panDocDiv"></div>
								</div>
							</div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> AADHAR CARD </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="aadharDoc" onmouseout="validateFile(this,'aadharDoc')"
										id="aadharDoc"></s:file>
								</div>
								<div>
									<div id="aadharDocDiv"></div>
								</div>
							</div>

							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> VOTER CARD </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="voterDoc" onmouseout="validateFile(this,'voterDoc')"
										id="voterDoc"></s:file>
								</div>
								<div>
									<div id="voterDocDiv"></div>
								</div>
							</div>

							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> DRIVING LICENSE </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="drivingDoc" onmouseout="validateFile(this,'drivingDoc')"
										id="drivingDoc"></s:file>
								</div>
								<div>
									<div id="drivingDocDiv"></div>
								</div>
							</div>

							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> BANK PASSBOOK </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="passbookDoc"
										onmouseout="validateFile(this,'passbookDoc')" id="passbookDoc"></s:file>
								</div>
								<div>
									<div id="passbookDocDiv"></div>
								</div>
							</div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> ADDRESS PROOF </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme" applyscript="true"
										name="addressDoc" onmouseout="validateFile(this,'addressDoc')"
										id="addressDoc"></s:file>
								</div>
								<div>
									<div id="addressDocDiv"></div>
								</div>
							</div>

							<div class="clearFRM"></div>
						</div>
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

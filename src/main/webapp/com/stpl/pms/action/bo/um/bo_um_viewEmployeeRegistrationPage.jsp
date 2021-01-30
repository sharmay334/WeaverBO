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
	<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
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
		$("#dob").datetimepicker({
			dateFormat : 'yy-mm-dd',
			changeYear : true,
			changeMonth : true,
			minDate : '1930-01-01',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#dob").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#dob").datepicker({
							dateFormat : 'yy-mm-dd'
						}).datepicker("setDate", date);
					});
				}
			}
		});
		$("#doj").datetimepicker({
			dateFormat : 'yy-mm-dd',
			changeYear : true,
			changeMonth : true,
			minDate : '1930-01-01',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#doj").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#doj").datepicker({
							dateFormat : 'yy-mm-dd'
						}).datepicker("setDate", date);
					});
				}
			}
		});
		$("#dol").datetimepicker({
			dateFormat : 'yy-mm-dd',
			changeYear : true,
			changeMonth : true,
			minDate : '1930-01-01',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#dol").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#dol").datepicker({
							dateFormat : 'yy-mm-dd'
						}).datepicker("setDate", date);
					});
				}
			}
		});
	});
</script>
<title>Employee Registration</title>
</head>
<body>
	<div class="clear2"></div>
	<h2>Employee Registration</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Fill Form</h4>
		</div>

		<s:form name="newsubuser"
			action="/com/stpl/pms/action/bo/um/bo_um_addBoEmployee_Save.action"
			theme="simple" enctype="multipart/form-data" method="POST"
			novalidate="true">
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Employee Name </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="40" name="empName" id="empName"
							theme="myTheme" pattern="^[a-z A-Z ]*$"
							errorMassage="Numeric and Special Character not allowed"
							applyscript="true"></ss:textfield>
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
						<label> Employee Username </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="empUserName" id="empUserName"
							theme="myTheme" pattern="^[a-zA-Z._]*$"
							errorMassage="Numeric and Special Character not allowed"
							action="bo_um_validateusername.action" minLength="6"
							applyscript="true"></ss:textfield>
						<div id="empUserName_error" class="fieldError">
							<s:fielderror>
								<s:param>empUserName</s:param>
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
						<label> Photo </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<s:file cssClass="textfield" theme="myTheme" applyscript="true"
							name="photoDoc" onmouseout="validateFile(this,'aadharDoc')"
							id="photoDoc"></s:file>
					</div>
					<div>
						<div id="aadharDocDiv"></div>
					</div>
				</div>

				
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Branch </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select list="branchList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" applyscript="true" name="branch"
							id="branch"></ss:select>

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
						<label> Region </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select list="regionList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" applyscript="true" name="region"
							id="region"></ss:select>

						<div id="region_error" class="fieldError">
							<s:fielderror>
								<s:param>region</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Role </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select list="roleList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" applyscript="true" name="role"
							id="role"></ss:select>

						<div id="role_error" class="fieldError">
							<s:fielderror>
								<s:param>role</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Department </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select list="departmentList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" applyscript="true" name="department"
							id="department"></ss:select>

						<div id="role_error" class="fieldError">
							<s:fielderror>
								<s:param>department</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Date of Joining </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield name="doj" cssClass="dateField" id="doj"
							readonly="true" style="cursor:pointer;" theme="myTheme"></ss:textfield>
						<div id="doj_error" class="fieldError">
							<s:fielderror>
								<s:param>doj</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Date of Leaving </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield name="dol" cssClass="dateField" id="dol"
							readonly="true" style="cursor:pointer;" theme="myTheme"></ss:textfield>

					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Week day off </label>
					</div>
					<div class="InputDiv">
						<ss:select list="{'Sunday','Monday','Tuesday','Wedunsday','Thrusday','Friday','Saturday'}" multiple="true" cssStyle="height:40px !important" cssClass="select2" theme="myTheme"
							errorMassage="Please select one" applyscript="true" name="weekDay"
							id="weekDay"></ss:select>

						<div id="role_error" class="fieldError">
							<s:fielderror>
								<s:param>weekDay</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Salary(Calender Year)
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="salary" id="salary"
							theme="myTheme" pattern="^[0-9.]*$" value="0"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>
						<div id="salary_error" class="fieldError">
							<s:fielderror>
								<s:param>salary</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Travelling Allowance(per km)
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="travellingAllowance" id="travellingAllowance"
							theme="myTheme" pattern="^[0-9.]*$" value="0"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>
						<div id="travellingAllowance_error" class="fieldError">
							<s:fielderror>
								<s:param>travellingAllowance</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Average Traveling Per Day (in km)
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="avgTravellingPerDay" id="avgTravellingPerDay"
							theme="myTheme" pattern="^[0-9.]*$" value="0"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>
						<div id="avgTravellingPerDay_error" class="fieldError">
							<s:fielderror>
								<s:param>avgTravellingPerDay</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>City Allowance(per km)
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="cityAllowance" id="cityAllowance"
							theme="myTheme" pattern="^[0-9.]*$" value="0"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>
						<div id="cityAllowance_error" class="fieldError">
							<s:fielderror>
								<s:param>cityAllowance</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Ex-City Allowance(per km)
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="exCityAllowance" id="exCityAllowance"
							theme="myTheme" pattern="^[0-9.]*$" value="0"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>
						<div id="exCityAllowance_error" class="fieldError">
							<s:fielderror>
								<s:param>exCityAllowance</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Daily Allowance(with doc)
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="dailyAllowanceDoc" id="dailyAllowanceDoc"
							theme="myTheme" pattern="^[0-9.]*$" value="0"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>
						<div id="dailyAllowanceDoc_error" class="fieldError">
							<s:fielderror>
								<s:param>dailyAllowanceDoc</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Daily Allowance(without doc)
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="dailyAllowance" id="dailyAllowance"
							theme="myTheme" pattern="^[0-9.]*$" value="0"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>
						<div id="dailyAllowance_error" class="fieldError">
							<s:fielderror>
								<s:param>dailyAllowance</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Attendance Selfie </label>
					</div>
					<div class="InputDiv">
						<ss:select list="{'Yes','No'}" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" applyscript="true" name="attendanceSelfie"
							id="attendanceSelfie"></ss:select>

						<div id="role_error" class="fieldError">
							<s:fielderror>
								<s:param>attendanceSelfie</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Attendance Time </label>
					</div>
					<div class="InputDiv">
						<ss:select list="attendanceTimeList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" applyscript="true" name="attendanceTime"
							id="attendanceTime"></ss:select>

						<div id="attendanceTime_error" class="fieldError">
							<s:fielderror>
								<s:param>attendanceTime</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Total Leaves
						</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="leaves" id="leaves"
							theme="myTheme" pattern="^[0-9]*$" value="0"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>
						<div id="leaves_error" class="fieldError">
							<s:fielderror>
								<s:param>leaves</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Approver Name </label>
					</div>
					<div class="InputDiv">
						<ss:select list="approverList" cssClass="select1" theme="myTheme"
							errorMassage="approver select one" applyscript="true" name="approver"
							id="approver"></ss:select>

						<div id="approver_error" class="fieldError">
							<s:fielderror>
								<s:param>approver</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Authentication Amount </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="authAmount" id="authAmount"
							theme="myTheme" pattern="^[0-9.]*$" value="0"
							errorMassage="Special Character not allowed" applyscript="true"></ss:textfield>

						<div id="authAmount_error" class="fieldError">
							<s:fielderror>
								<s:param>authAmount</s:param>
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





				<s:hidden label="Status" name="status" value="ACTIVE" />


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
						<label> Country </label>
					</div>
					<div class="InputDiv">
						<ss:select cssClass="select1" list="countryList"
							listKey="countryCode" listValue="name" theme="myTheme"
							errorMassage="Please select one" applyscript="true"
							name="country" id="country"></ss:select>
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
						<ss:select list="stateList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" applyscript="true" name="state"
							id="state"></ss:select>

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
						<ss:select list="cityList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" applyscript="true" name="city"
							id="city"></ss:select>

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
				
				<div id="subdocform">
					<div class="FormSectionMenu" id="subdocform">
						<div class="greyStrip">
							<h4>Upload Documents</h4>
						</div>
						<div class="innerbox">
							
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> OLD SALARY SLIP </label>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme"
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
									<label> EXPERIENCE CERTIFICATE </label> 
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme"
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
									<label> EDUCATION CERTIFICATE </label> 
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme"
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
									<label> PAN CARD </label> 
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme"
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
									<label> AADHAR CARD </label> 
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme"
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
									<label> VOTER CARD </label>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme"
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
									<label> DRIVING LICENSE </label>
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme"
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
									<label> BANK PASSBOOK </label> 
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme"
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
									<label> ADDRESS PROOF </label> 
								</div>
								<div class="InputDivHalf">
									<s:file cssClass="textfield" theme="myTheme"
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
				<input type="submit" value='Register' align="left" class="button" />
			</div>
		</s:form>
	</div>
</body>
</html>

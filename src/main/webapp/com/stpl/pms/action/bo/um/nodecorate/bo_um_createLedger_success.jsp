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
			dateFormat : 'dd-mm-yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01-01-1930',
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
		$("#fyb1").datetimepicker({
			dateFormat : 'dd-mm-yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01-01-1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#fyb1").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#fyb1").datepicker({
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
<title>Second Step</title>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Ledger Second Step 
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				Fill Details
			</h4>
		</div>

		<s:form name="newsubuser"
			action="/com/stpl/pms/action/bo/um/bo_um_createLedgerstepLast.action"
			theme="simple" enctype="multipart/form-data" method="POST">
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Customer Name </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.customerName" id="customerName" theme="myTheme"
							></ss:textfield>
						<s:hidden name="ledgerSecondStepBean.ledgerId" value="%{ledger_id}"></s:hidden>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Customer DOB</label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="20" cssClass="dateField" id="fyb1" readonly="true" name="ledgerSecondStepBean.customerDOB" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Firm Name </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.firmName" id="firmName" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Firm Type </label>
					</div>
					<div class="InputDiv">
						<s:select name="ledgerSecondStepBean.firmType" headerKey="-1"
								headerValue="Select Firm Type" list="{'proprietor','partner'}"
								cssClass="select1" theme="myTheme"></s:select>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Address </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.address" id="address" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>State</label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.state" id="state" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>District </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.district" id="district" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Tehsil </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.tehsil" id="tehsil" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Pincode </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.pincode" id="pincode" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Contact Number(without +91 ) </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.contact" id="contact" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Responsible Person Name </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.resPerName" id="resPerName" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>Responsible Person Address </label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="ledgerSecondStepBean.resPerAddr" id="resPerAddr" theme="myTheme"
								></ss:textfield>
							
						</div>
					</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Responsible Person Contact </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.resPerContact" id="resPerContact" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Firm GSTN </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.firmGSTN" id="firmGSTN" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Firm GSTN Type</label>
					</div>
					<div class="InputDiv">
							<s:select name="ledgerSecondStepBean.firmGSTNType" headerKey="-1"
								headerValue="Select Firm Type" list="{'Composition','Consumer','Regular','Unregistered'}"
								cssClass="select1" theme="myTheme"></s:select>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Firm Email </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.firmEmail" id="firmEmail" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Firm Since</label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" cssClass="dateField" id="fyb" readonly="true" name="ledgerSecondStepBean.firmSince" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Firm PAN Card </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.firmPAN" id="firmPAN" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Firm Aadhar Card </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.firmAadhar" id="firmAadhar" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
			<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Branch </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.branch" id="branch" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Landmark </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.landmark" id="landmark" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Seed Licence Number </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.seedLicenceNo" id="seedLicenceNo" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Fertilizer Licence Number </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.fertLicenceNo" id="fertLicenceNo" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Pesticide Licence Number </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.pestLicenceNo" id="pestLicenceNo" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Transport Name </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.transportName" id="transportName" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Bank Name </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.bankName" id="bankName" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Bank Acc Number </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.bankAccNo" id="bankAccNo" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Bank IFSC </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.bankIFSC" id="bankIFSC" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Bank Branch </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.bankBranch" id="bankBranch" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Security Cheque No </label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.secCheqNo1" id="secCheqNo1" theme="myTheme"
							></ss:textfield>
						
						
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.secCheqNo2" id="secCheqNo2" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Firm Annual TernOver</label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.firmTernOver" id="firmTernOver" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Expected Sale Per Year</label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.expectedSalePerYr" id="expectedSalePerYr" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Other Company Detail</label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="100" name="ledgerSecondStepBean.otherCompanyDetail" id="otherCompanyDetail" theme="myTheme"
							></ss:textfield>
						
					</div>
				</div>
								
							
			</div>

			<div class="box_footer" align="right">
				<%-- <s:submit value="Register" align="left" cssClass="button"
				theme="simple" /> --%>
				<input type="submit"
					value='Save My Details'
					align="left" class="button" />
			</div>
		</s:form>
	</div>
</body>
</html>

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
	function validateFile(fileName) {
		var file = fileName.value;
		if (file != "") {
			return true;
		}
		else
			return false;

	}
	
	function checkValidation(id){
		var res = id.match(/\d/g);
		if(Number(document.getElementById('amount'+res).value)>0 && validateFile(document.getElementById('Picture'+res))==true){
			document.getElementById("mybtn").style.display = "block";
		}
		else{
			alert('Please fill Date,Amount and photo before Tick!');
			$("#allCheckBox"+res).prop("checked", false);
			document.getElementById("mybtn").style.display = "none";
		}
		
	}
	$(document).ready(function() {
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
		$("#fyb2").datetimepicker({
			dateFormat : 'dd-mm-yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01-01-1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#fyb2").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#fyb2").datepicker({
							dateFormat : 'dd-mm-yy'
						}).datepicker("setDate", date);
					});
				}
			}
		});
		$("#fyb3").datetimepicker({
			dateFormat : 'dd-mm-yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01-01-1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#fyb3").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#fyb3").datepicker({
							dateFormat : 'dd-mm-yy'
						}).datepicker("setDate", date);
					});
				}
			}
		});
		$("#fyb4").datetimepicker({
			dateFormat : 'dd-mm-yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01-01-1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#fyb4").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#fyb4").datepicker({
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
<title>Expenses</title>
</head>
<body>
	<div class="clear2"></div>
	<h2>Expenses</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Add Expenses</h4>
		</div>

		<s:form name="newsubuser"
			action="/com/stpl/pms/action/bo/um/bo_um_createExpenses.action"
			theme="simple" enctype="multipart/form-data" method="POST">
			<div class="innerBox">
				
				<table width="100%" cellspacing="0" align="center"
					id="payTransactionTable" class="transactionTable">
					<thead>
						<tr>
							<th style="text-align: center;" nowrap="nowrap">Expense Type</th>
							<th style="text-align: center;" nowrap="nowrap">Expense Date</th>
							<th style="text-align: center;" nowrap="nowrap">Amount</th>
							<th style="text-align: center;" nowrap="nowrap">Upload Bill</th>
							<th style="text-align: center;" nowrap="nowrap">Confirm Upload</th>
						</tr>
					</thead>
					<tbody>
						<tr id="rowId">
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="100" readonly="true" name="employeeExpenseBean.expenseType1"
									value="Hotel Expense" theme="myTheme">
								</ss:textfield></td>
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="20" cssClass="dateField" id="fyb1" readonly="true"
									name="employeeExpenseBean.expenseDate1" theme="myTheme">
								</ss:textfield></td>
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="100" name="employeeExpenseBean.amount1" id="amount1" theme="myTheme">
								</ss:textfield></td>


							<td style="text-align: center;" nowrap="nowrap">
								<div class="InputDivHalf">
									<label for="Picture1"> <img
										src="/WeaverBO/images/camera.png" height="25px" width="25px" />
									</label>

									<s:file label="upload" id="Picture1" name="employeeExpenseBean.Picture1"
										cssClass="textfield" theme="myTheme" cssStyle="display:none;"></s:file>
								</div>
							</td>
							
							<td style="text-align: center;" nowrap="nowrap">
							<s:checkbox id="allCheckBox1" fieldValue="false"
										name="employeeExpenseBean.allCheckBox1" theme="simple" onclick="checkValidation(this.id)"></s:checkbox>
							 </td>
						</tr>
				
						<tr id="rowId">
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="100" readonly="true" name="employeeExpenseBean.expenseType2"
									value="Bus/Train/Toll Tikcet" theme="myTheme">
								</ss:textfield></td>
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="20" cssClass="dateField" id="fyb2" readonly="true"
									name="employeeExpenseBean.expenseDate2" theme="myTheme">
								</ss:textfield></td>
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="100" name="employeeExpenseBean.amount2" id="amount2" theme="myTheme">
								</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
								<div class="InputDivHalf">
									<label for="Picture2"> <img
										src="/WeaverBO/images/camera.png" height="25px" width="25px" />
									</label>

									<s:file label="upload" id="Picture2" name="employeeExpenseBean.Picture2"
										cssClass="textfield" theme="myTheme" cssStyle="display:none;"></s:file>
								</div>
							</td>
							<td style="text-align: center;" nowrap="nowrap">
							<s:checkbox id="allCheckBox2" fieldValue="false"
										name="employeeExpenseBean.allCheckBox2" theme="simple"  onclick="checkValidation(this.id)"></s:checkbox>
							 </td>
						</tr>

						<tr id="rowId">
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="100" readonly="true" name="employeeExpenseBean.expenseType3"
									value="Petrol/Deisel Expense" theme="myTheme">
								</ss:textfield></td>
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="20" cssClass="dateField" id="fyb3" readonly="true"
									name="employeeExpenseBean.expenseDate3" theme="myTheme">
								</ss:textfield></td>
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="100" name="employeeExpenseBean.amount3" id="amount3" theme="myTheme">
								</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
								<div class="InputDivHalf">
									<label for="Picture3"> <img
										src="/WeaverBO/images/camera.png" height="25px" width="25px" />
									</label>

									<s:file label="upload" id="Picture3" name="employeeExpenseBean.Picture3"
										cssClass="textfield" theme="myTheme" cssStyle="display:none;"></s:file>
								</div>
							</td>
							<td style="text-align: center;" nowrap="nowrap">
							<s:checkbox id="allCheckBox3" fieldValue="false"
										name="employeeExpenseBean.allCheckBox3" theme="simple" onclick="checkValidation(this.id)"></s:checkbox>
							 </td>
						</tr>

						<tr id="rowId">
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="100" readonly="true" name="employeeExpenseBean.expenseType4"
									value="Others Expense" theme="myTheme">
								</ss:textfield></td>
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="20" cssClass="dateField" id="fyb4" readonly="true"
									name="employeeExpenseBean.expenseDate4" theme="myTheme">
								</ss:textfield></td>
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
									maxlength="100" name="employeeExpenseBean.amount4" id="amount4" theme="myTheme">
								</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
								<div class="InputDivHalf">
									<label for="Picture4"> <img
										src="/WeaverBO/images/camera.png" height="25px" width="25px" />
									</label>

									<s:file label="upload" id="Picture4" name="employeeExpenseBean.Picture4"
										cssClass="textfield" theme="myTheme" cssStyle="display:none;"></s:file>
								</div>
							</td>
							<td style="text-align: center;" nowrap="nowrap">
							<s:checkbox id="allCheckBox4" fieldValue="false"
										name="employeeExpenseBean.allCheckBox4" theme="simple" onclick="checkValidation(this.id)"></s:checkbox>
							 </td>
						</tr>

					</tbody>
				</table>


			</div>

			<div class="box_footer" align="right">
				<%-- <s:submit value="Register" align="left" cssClass="button"
				theme="simple" /> --%>
				<input type="submit" value='Save Details' style="display:none" align="left"
					class="button" id="mybtn"/>
			</div>
		</s:form>
	</div>
</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>Payment</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
var CurrentBalance = 0;
	function callForMoreRow(id) {
		checkForBillByBill(id);
		var rowCount = countTotalRows();
		if (document.getElementById('particularsList' + rowCount).value != "-1") {
			var row = document.getElementById("rowId" + rowCount); // find row to copy
			var table = document.getElementById("payTransactionTable"); // find table to append to
			var clone = row.cloneNode(true); // copy children too
			rowCount += 1;
			clone.id = "rowId" + rowCount; // change id or other attributes/contents
			table.appendChild(clone); // add new row to end of table
			var oInput = document.getElementById("rowId" + rowCount);
			var e = oInput.childNodes[5].childNodes[1];
			var f = oInput.childNodes[1].childNodes[1];
			var g = oInput.childNodes[7].childNodes[1];
			var h = oInput.childNodes[9].childNodes[1];
			var i = oInput.childNodes[3].childNodes[1];
			e.id = "amount" + rowCount;
			f.id = "particularsList" + rowCount;
			g.id = "txnType" + rowCount;
			h.id = "bankName" + rowCount;
			i.id = "currentblnc"+rowCount;
		}
		if (document.getElementById(id).value == "-1") {
			var res = id.substring(15, str.length);
			var amt = document.getElementById('currBalance').value;
			amt = Number(amt)
					- Number(document.getElementById('amount' + res).value);
			if (!isNaN(amt))
				document.getElementById('currBalance').value = amt;
		}

	}
	function checkForBillByBill(particulars){
		
		var particular = document.getElementById(particulars).value;
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_check_bill_by_bill.action?billByBill="
				+ particular;
		var res = particulars.match(/\d/g);
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				if(itr=="true"){
					$("#bill_by_bill").css("display", "block");
					
					document.getElementById('biller_name').innerHTML = particular;
				}
				else{
					$("#bill_by_bill").css("display", "none");
				}
			},

			error : function(itr) {

			}
		});
	}
	function countTotalRows() {

		var rowCount = 0;
		var table = document.getElementById("payTransactionTable");
		var rows = table.getElementsByTagName("tr");
		for (var i = 0; i < rows.length; i++) {
			if (rows[i].getElementsByTagName("td").length > 0) {
				rowCount++;
			}
		}
		return rowCount;
	}
	function adjustTotalAmount(id) {
		var finalAmount = 0;
		var rowCnt = countTotalRows();
		for (var i = 1; i <= rowCnt; i++) {
			finalAmount = Number(finalAmount)
					+ Number(document.getElementById('amount' + i).value);
		}
		document.getElementById('totalAmt').value = finalAmount
	}
	function revertCurrBalance(id) {
		adjustTotalAmount(id);
		var chk = id.substring(6, id.length);
		if (document.getElementById('particularsList' + chk).value != "-1") {
			var rc = countTotalRows();
			document.getElementById('currBalance').value = '0';
			var amt = document.getElementById('currBalance').value;
			for (var i = 1; i <= rc; i++) {
				if (document.getElementById('amount' + i).value != "0") {
					amt = Number(amt)
							+ Number(document.getElementById('amount' + i).value);
					if (!isNaN(amt))
						document.getElementById('currBalance').value = Number(CurrentBalance)-amt;
				}
			}

		}

	}
	function getCurrentBalance(id) {
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_current_balance.action?partyAcc="
				+ document.getElementById(id).value;
		var res = id.match(/\d/g);
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				document.getElementById('currBalance').value = itr;
				CurrentBalance = itr;
			},

			error : function(itr) {

			}
		});
	}
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Payment
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Payment</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_BoEmppayment_create.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Payment No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="paymentNo" name="paymentNo" value="%{paymentNo}"
								theme="myTheme" readonly="true" cssStyle="width:10%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Order No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="orderNo" name="orderNo" value=""
								theme="myTheme" readonly="true" cssStyle="width:10%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Account </label>
						</div>
						<div class="InputDiv">
							<s:select name="account" headerKey="none" id="account"
								headerValue="Select Account" list="accountList"
								cssClass="select1" theme="myTheme" onchange="getCurrentBalance(this.id)"/>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Employee Under </label>
						</div>
						<div class="InputDiv">
							<s:select name="employeeUnder" headerKey="none"
								id="employeeUnder" headerValue="--Please Select--"
								list="employeeUnderList" cssClass="select1" theme="myTheme" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Current Balance </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="currBalance" id="currBalance" value="0"
								theme="myTheme" readonly="true" cssStyle="width:20%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<br />
					<div class="clearFRM"></div>

					<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Particulars</th>
								<th style="text-align: center;" nowrap="nowrap">Current Balance</th>
								<th style="text-align: center;" nowrap="nowrap">Amount</th>
								<th style="text-align: center;" nowrap="nowrap">Transaction
									Type</th>
								<th style="text-align: center;" nowrap="nowrap">Bank Name</th>
							</tr>
						</thead>
						<tbody>

							<tr id="rowId1">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										name="particulars" headerKey="none" id="particularsList1"
										headerValue="End Of List" list="particularsList"
										cssClass="select1" theme="myTheme"
										onchange="callForMoreRow(this.id)" cssStyle="width:150px;" /></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="currentblnc" value="0" id="currentblnc1"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%" readOnly="true">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount1"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%"
										onchange="revertCurrBalance(this.id)">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><s:select
										name="txnType" headerKey="none" id="txnType1"
										headerValue="Please select"
										list="{'Cash','Cheque/DD','e-Fund Transfer','Others'}"
										cssClass="select1" theme="myTheme" cssStyle="width:150px;" /></td>
								<td style="text-align: center;" nowrap="nowrap"><s:select
										name="bankName" headerKey="none" id="bankName1"
										headerValue="Select Bank" list="accountList"
										cssClass="select1" theme="myTheme" cssStyle="width:150px;" /></td>
							</tr>


						</tbody>
					</table>
					
					<!-- mention bill by bill detail -->
					<div id="bill_by_bill" style="display: none;">
						<div class="FormSectionMenu" id="bill_by_bill_div_acc">
							<div class="greyStrip">
								<h4>Bill Wise Details for :	<b><span id="biller_name"></span></b></h4>
							</div>
							<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Type of Ref</th>
								<th style="text-align: center;" nowrap="nowrap">Name</th>
								<th style="text-align: center;" nowrap="nowrap">Due Date limit</th>
								<th style="text-align: center;" nowrap="nowrap">Amount</th>
							</tr>
						</thead>
						<tbody>

							<tr id="rowId1">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										name="typeofRef" headerKey="none" id="typeofRef1"
										headerValue="End Of List" list="{'Advance','Agst Ref','New Ref','On Account'}"
										cssClass="select1" theme="myTheme"
										onchange="callForMoreBillRow(this.id)" cssStyle="width:150px;" /></td>
								<td style="text-align: center;" nowrap="nowrap"><s:select
										name="pendingBill" headerKey="none" id="pendingBill1"
										headerValue="End Of List" list="{'Bill list'}"
										cssClass="select1" theme="myTheme" cssStyle="width:150px;" /></td>
								<td style="text-align: center;" nowrap="nowrap">
								<ss:textfield
										maxlength="30" name="dueDate" id="dueDate1" theme="myTheme"
										cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="billAmt" id="billAmt1" theme="myTheme"
										cssStyle="width:50%"/></td>
							</tr>


						</tbody>
					</table>
						</div>
					</div>
					<!-- end of mention bill by bill -->
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Total Amount </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="totalAmt" cssClass="InpTextBoxBg"
								id="totalAmt" readOnly="true" theme="simple"></s:textfield>
						</div>
					</div>
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Narration </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="narration" cssClass="InpTextBoxBg"
								id="narration" theme="simple" title="Enter Narration"></s:textfield>
						</div>
					</div>


				</s:if>

			</div>
			<div class="box_footer" align="right">
				<%-- <s:submit value="Search" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
					 --%>
				<input type="submit" value='Create' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

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

<title>Journal</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
	function callForMoreRow(id) {
		var rowCount = countTotalRows();
		var res = id.match(/\d/g);
		if (document.getElementById('particularsList' + rowCount).value == "Dr" && document.getElementById(id).readOnly==false && rowCount == res) {
			var row = document.getElementById("rowId" + rowCount); // find row to copy
			var table = document.getElementById("payTransactionTable"); // find table to append to
			var clone = row.cloneNode(true); // copy children too
			rowCount += 1;
			clone.id = "rowId" + rowCount; // change id or other attributes/contents
			table.appendChild(clone); // add new row to end of table
			var oInput = document.getElementById("rowId" + rowCount);
			var e = oInput.childNodes[2].childNodes[1];
			var f = oInput.childNodes[1].childNodes[1];
			var g = oInput.childNodes[4].childNodes[1];
			var h = oInput.childNodes[6].childNodes[1];
			e.id = "txnType" + rowCount;
			f.id = "particularsList" + rowCount;
			g.id = "debitAmt" + rowCount;
			h.id = "creditAmt" + rowCount;
			var selectData = document.getElementById('particularsList'+rowCount);
			var opt = document.createElement('option');
		    opt.value = "Cr";
		    opt.innerHTML = "Cr";
		    selectData.appendChild(opt);
		    opt.setAttribute('selected', true);
		    document.getElementById("debitAmt" + rowCount).value=0;
		    changeFields('particularsList'+rowCount);
		} else if(document.getElementById('particularsList' + rowCount).value == "Cr" && document.getElementById(id).readOnly==false && rowCount == res) {
			var selectData = document.getElementById('particularsList'+rowCount);
			var row = document.getElementById("rowId" + rowCount); // find row to copy
			var table = document.getElementById("payTransactionTable"); // find table to append to
			var clone = row.cloneNode(true); // copy children too
			rowCount += 1;
			clone.id = "rowId" + rowCount; // change id or other attributes/contents
			table.appendChild(clone); // add new row to end of table
			var oInput = document.getElementById("rowId" + rowCount);
			var e = oInput.childNodes[2].childNodes[1];
			var f = oInput.childNodes[1].childNodes[1];
			var g = oInput.childNodes[4].childNodes[1];
			var h = oInput.childNodes[6].childNodes[1];
			e.id = "txnType" + rowCount;
			f.id = "particularsList" + rowCount;
			g.id = "debitAmt" + rowCount;
			h.id = "creditAmt" + rowCount;
			document.getElementById("creditAmt" + rowCount).value=0;
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
	function changeFields(id) {
		var element = document.getElementById(id);
		var strUser = element.options[element.selectedIndex].value;
		var substr = id.substring(15,id.length);
		var i, amount = 0;;
		totalRows = countTotalRows();
		for(i=1; i <= totalRows; i++) {
			if(document.getElementById("debitAmt" + i)) {
				amount += Number(document.getElementById("debitAmt" + i).value);
				console.log(document.getElementById("debitAmt" + i).value);
			}
			
		}
		if(strUser == "Dr") {
			document.getElementById("creditAmt" + substr).readOnly = true;
			document.getElementById("creditAmt" + substr).value = 0;
			document.getElementById("debitAmt" + substr).readOnly = false;
		} else {
			document.getElementById("creditAmt" + substr).readOnly = false;
			document.getElementById("debitAmt" + substr).value = 0;
			document.getElementById("creditAmt" + substr).value = amount;
			document.getElementById("debitAmt" + substr).readOnly = true;
		}
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
	function revertCurrBalance(id) {

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
						document.getElementById('currBalance').value = amt;
				}
			}

		}

	}
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Journal
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Journal</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_BoEmpjournal_create.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Journal No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="journalNo" name="journalNo" value="%{journalNo}"
								theme="myTheme" readonly="true" cssStyle="width:10%" />
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
					<br />
					<div class="clearFRM"></div>

					<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap"></th>
								<th style="text-align: center;" nowrap="nowrap">Particulars</th>
								<th style="text-align: center;" nowrap="nowrap">Debit</th>
								<th style="text-align: center;" nowrap="nowrap">Credit</th>
							</tr>
						</thead>
						<tbody>

							<tr id="rowId1">
								<td style="text-align: center;" nowrap="nowrap">
								<select id="particularsList1" theme="myTheme" name="cr_dr" cssClass="select1" cssStyle="width:50px;" onChange="changeFields(this.id)">
										<option value="Dr">Dr</option>
									</select>
								<td style="text-align: center;" nowrap="nowrap" ><s:select
										name="particulars" id="txnType1" list="particularsList"
										cssClass="select1" theme="myTheme" cssStyle="width:150px;" /></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="debitAmt" value="0" id="debitAmt1"
										theme="myTheme" onchange="callForMoreRow(this.id)" readonly="false" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="creditAmt" value="0" id="creditAmt1"
										theme="myTheme" onchange="callForMoreRow(this.id)" readonly="true" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
							</tr>


						</tbody>
					</table>
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

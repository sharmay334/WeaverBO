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

<title>Contra</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

<script>
var account_old_cr_dr = "";
function promptSave(){
	var frm = $('#searchUserFrm');

		swal({
		  title: "Are you sure?",
		  text: "Once Saved, you will not be able to undo the entry!",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
			  $.ajax({
			        type: frm.attr('method'),
			        url: frm.attr('action'),
			        data: frm.serialize(),
			        success: function (data) {
			        	if(data=="success"){
			        		swal("Entry Successfully Saved..Refreshing for new entry!!!");
			        		setTimeout(function(){
			        			   window.location.reload(1);
			        			}, 1000);
			        	}
			        	else{
			        		swal("Some Error Occured!");
			        	}
			            
			        },
			        error: function (data) {
			        	swal("Server Error Occured!");
			        },
			    });
			  
		  } else {
		    swal("Please Refresh The Page!");
		  }
		});
    
    
}
var CurrentBalance = 0;
$(document).ready(function() {
	$("#paymentDate").datetimepicker({
		dateFormat : 'yy-mm-dd',
		showSecond : false,
		showMinute : false,
		showHour : false,
		changeYear : true,
		changeMonth : true,
		startDate: '1980-01-01',
		minDate : '1930-01-01',
		onSelect : function(selectedDate) {
			if (selectedDate != "") {
				$("#paymentDate").datepicker("option", "minDate", selectedDate);
			} else {
				var date = new Date().getDate();
				$(function() {
					$("#paymentDate").datepicker({
						dateFormat : 'yy-mm-dd'
					}).datepicker("setDate", date);
				});
			}
		}
	});
});
	function getCurrentBalanceOfParticulars(id){
		var res = id.match(/\d/g);
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_current_balance.action?partyAcc="
				+ document.getElementById(id).value;
		var res = id.match(/\d/g);
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				var arr = itr.split(",");
				document.getElementById('pcurBalance'+res).value = arr[0];
				document.getElementById('pcrdr'+res).innerHTML = arr[1];
				document.getElementById('phcrdr'+res).value = arr[1];
				account_old_cr_dr = arr[1];
				
			},

			error : function(itr) {

			}
		});
		
	}
	function callForMoreRow(id) {
		getCurrentBalanceOfParticulars(id);
		var rowCount = countTotalRows();
		if (document.getElementById('particularsList' + rowCount).value != "none") {
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
			var j = oInput.childNodes[3].childNodes[3];
			var k = oInput.childNodes[11].childNodes[1];
			j.id = "pcrdr"+rowCount;
			i.id = "pcurBalance" + rowCount;
			e.id = "amount" + rowCount;
			f.id = "particularsList" + rowCount;
			g.id = "txnType" + rowCount;
			h.id = "bankName" + rowCount;
			k.id = "phcrdr" + rowCount;
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
		if (document.getElementById('particularsList' + chk).value != "none") {
			var rc = countTotalRows();
			var amt = Number(CurrentBalance);
			var res = id.match(/\d/g);
			if(document.getElementById('hcrdr').value='Cr'){
			var tmpAmt = Number(CurrentBalance)-Number(document.getElementById(id).value);	
			if(tmpAmt<0){
				tmpAmt = tmpAmt * (-1);
				document.getElementById('hcrdr').value='Dr'
				document.getElementById('crdr').innerHTML='Dr'
				CurrentBalance = tmpAmt;
				document.getElementById('currBalance').value = CurrentBalance;
			}
			else{
				CurrentBalance = tmpAmt;
				document.getElementById('currBalance').value = CurrentBalance;
				document.getElementById('hcrdr').value='Cr'
					document.getElementById('crdr').innerHTML='Cr'
			}
			}
			else{
				var tmpAmt = Number(CurrentBalance)-Number(document.getElementById(id).value);	
				CurrentBalance = tmpAmt;
				document.getElementById('currBalance').value = CurrentBalance;
				document.getElementById('hcrdr').value='Dr'
					document.getElementById('crdr').innerHTML='Dr'
				
			}
		if(document.getElementById('phcrdr'+res).value='Dr')	{
			var pTmpAmt = Number(document.getElementById('pcurBalance'+res).value)-Number(document.getElementById(id).value);
			if(pTmpAmt<0){
				pTmpAmt = pTmpAmt * (-1);
				document.getElementById('phcrdr'+res).value = 'Cr';
				document.getElementById('pcrdr'+res).innerHTML = 'Cr';	
			}
			else{
				document.getElementById('phcrdr'+res).value = 'Dr';
				document.getElementById('pcrdr'+res).innerHTML = 'Dr';	
			}
			document.getElementById('pcurBalance'+res).value = pTmpAmt;
		}	
		else{
			var pTmpAmt = Number(document.getElementById('pcurBalance'+res).value)+Number(document.getElementById(id).value);
			document.getElementById('phcrdr'+res).value = 'Cr';
			document.getElementById('pcrdr'+res).innerHTML = 'Cr';	
			document.getElementById('pcurBalance'+res).value = pTmpAmt;
			
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
				var arr = itr.split(",");
				document.getElementById('currBalance').value = arr[0];
				document.getElementById('crdr').innerHTML = arr[1];
				CurrentBalance = arr[0];
				document.getElementById('hcrdr').value = arr[1];
				
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
		Contra
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Contra</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_Bocontra_create.action"
			id="searchUserFrm" method="POST" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Contra No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="contraNo" name="contraNo" value="%{contraNo}"
								theme="myTheme" readonly="true" cssStyle="width:10%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>Date</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="paymentDate" name="paymentDate" placeholder="Date" cssClass="dateField" theme="myTheme" readonly="true" applyscript="true" cssStyle="width:50%" />
						<div id="paymentDate_error" class="fieldError">
								<s:fielderror>
									<s:param>paymentDate</s:param>
								</s:fielderror>
							</div>
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
								<span id="crdr"></span>
								<s:hidden id="hcrdr" name="hcrdr"></s:hidden>
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
								<th></th>
								
							</tr>
						</thead>
						<tbody>

							<tr id="rowId1">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										name="particulars" headerKey="none" id="particularsList1"
										headerValue="End Of List" list="particularsList"
										cssClass="select1" theme="myTheme"
										onchange="callForMoreRow(this.id)" cssStyle="width:150px;" /></td>
								<td style="text-align: center;" nowrap="nowrap">
								<ss:textfield
										maxlength="30" readOnly="true" name="pcurBalance" id="pcurBalance1"
										theme="myTheme" cssStyle="width:50%">
									</ss:textfield><span id="pcrdr1"></span>
								</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount1"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%"
										onchange="revertCurrBalance(this.id)">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><s:select
										name="txnType" headerKey="none" id="txnType1"
										headerValue="Please select"
										list="{'Cash','Cheque/DD','e-Fund Transfer','Others'}"
										cssClass="select1" theme="myTheme" cssStyle="width:100px;" /></td>
								<td style="text-align: center;" nowrap="nowrap">
									<s:select
										name="bankName" headerKey="none" id="bankName1"
										headerValue="Please Select" list="bankNameList"
										cssClass="select1" theme="myTheme" cssStyle="width:100px;" />
									</td>
								<td style="text-align: center;" nowrap="nowrap">
									<s:hidden name="phcrdr" id="phcrdr1"></s:hidden>
								</td>
							</tr>


						</tbody>
					</table>
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
				<!-- <input type="submit" value='Create' align="left"
					style="margin-left: 0px" class="button" /> -->
					<button type="button" align="left"
					style="margin-left: 0px" class="button" onclick="promptSave()">Save</button>
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

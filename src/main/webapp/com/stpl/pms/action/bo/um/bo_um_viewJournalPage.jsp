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
<style>
body {font-family: Arial, Helvetica, sans-serif;}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 14px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
</style>
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

<script>
var activerow=0;
var isFirstCreditDebit = false;
var BillWiseActiveRow = 0;
var amtId;
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
			        async:false,
			        data: frm.serialize(),
			        success: function (data) {
			        	if(data=="success"){
			        		swal("Entry Successfully Saved..Refreshing for new entry!!!");
			        		setTimeout(function(){
			        			   window.location.reload(1);
			        			}, 1000);
			        	}
			        	else if(data=="date"){
			        		swal("Error! Receipt date is greater than voucher end date.");
			        		setTimeout(function(){
			        			   window.location.reload(1);
			        			}, 1000);
			        	}
			        	else{
			        		swal("Error! Wrong data entry.");
			        		setTimeout(function(){
			        			   window.location.reload(1);
			        			}, 1000);
			        	}
			            
			        },
			        error: function (data) {
			        	swal("Server Error Occured!");
			        	setTimeout(function(){
		        			   window.location.reload(1);
		        			}, 1000);
			        },
			    });
			  
		  } else {
		    swal("Please Refresh The Page!");
		  }
		});
    
    
}
var modal = document.getElementById("myModal");
function closeMe(){
	
	var rowCountBillWise = countTotalRowsBillWise();

	var tamt = 0;
	for(var i=1;i<=rowCountBillWise;i++){
		if(document.getElementById('ModelDrCr'+i).value=='Cr')
		tamt=tamt+Number(document.getElementById('billAmt'+i).value);
		else
			tamt=tamt-Number(document.getElementById('billAmt'+i).value);	
	}
	if(tamt<0)
	tamt  = tamt * (-1);
	var actAmt = Number(document.getElementById('creditAmt'+activerow).value)+Number(document.getElementById('debitAmt'+activerow).value);
	if(tamt==actAmt){
		for(var i=1;i<=rowCountBillWise;i++){
			document.getElementById('hiddenTypeOfRef'+i).value = document.getElementById('typeofRef'+i).value;
			if(document.getElementById('hiddenTypeOfRef'+i).value=='Agst Ref')
				document.getElementById('hiddenBillWiseName'+i).value = document.getElementById('pendingBills'+i).value;
			else
				document.getElementById('hiddenBillWiseName'+i).value = document.getElementById('pendingBillt'+i).value;
			document.getElementById('hiddenDueDate'+i).value =document.getElementById('dueDate'+i).value;
			document.getElementById('hiddenAmnt'+i).value = document.getElementById('billAmt'+i).value;
			document.getElementById('hiddencrdr'+i).value =document.getElementById('ModelDrCr'+i).value;
				
		}
		document.getElementById("myModal").style.display = "none";
			
	}
	else{
		alert('Please Adjust proper Amount First...');
	}
	
		
}
$(document).ready(function() {
	$("#paymentDate").datetimepicker(
			{
				dateFormat : 'dd-mm-yy',
				showSecond : false,
				showMinute : false,
				showHour : false,
				changeYear : true,
				changeMonth : true,
				minDate : '01-01-1930',
				onSelect : function(selectedDate) {
					if (selectedDate != "") {
						$("#paymentDate").datepicker("option",
								"minDate", selectedDate);
					} else {
						var date = new Date().getDate();
						$(function() {
							$("#paymentDate").datepicker({
								dateFormat : 'dd-mm-yy'
							}).datepicker("setDate", date);
						});
					}
				}
			});
	});
function callForMoreBillRow(id){
	var res = id.match(/\d/g);
	var type = document.getElementById(id).value;
	BillWiseActiveRow = res;
	if(type=="Advance"){
		callToGetAdvance(id,'Advance');
	}
	if(type=="New Ref"){
		callToGetAdvance(id,'New Ref');
	}
	if(type=="On Account"){
		callToGetAdvance(id,'On Account');
	}
	if(type=="Agst Ref"){
		callToGetAgstRef(id,'Agst Ref');
	}
	
}
	
function callToGetAgstRef(id,tor){
	var myurl = "<%=basePath%>";
	var res = id.match(/\d/g);
	var rowCount = countTotalRows();
	var particular = document.getElementById('txnType'+rowCount).value;
	var rowCountBillWise = countTotalRowsBillWise();

	var amt = Number(document.getElementById('debitAmt'+res).value)+Number(document.getElementById('creditAmt'+res).value);
	myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_bill_agst_ref_id_journal.action?partyAcc="
			+ particular+"&typeOfRef="+tor;
	
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			var arr = itr.split(",");
			var optionArr = arr[0].split(";");
			document.getElementById('dueDate'+res).value = arr[1];
			document.getElementById('billAmt'+res).value = amt;
			if(rowCountBillWise>1){
				var finalAmt = 0;
			for(var i=1;i<rowCountBillWise;i++){
				finalAmt = finalAmt+ Number(document.getElementById('billAmt'+i).value);
			}
				document.getElementById('billAmt'+res).value = Number(amt)-finalAmt;
			}
			document.getElementById("pendingBillt"+res).style.display = "none";
			var myoption;
			for(var i=0;i<optionArr.length-1;i++){
				myoption+="<option>" +optionArr[i] + "</option>";
			}
			document.getElementById("pendingBills"+res).innerHTML = myoption;
			document.getElementById("pendingBills"+res).style.display = "block";
			var tearr = document.getElementById("pendingBills"+res).value;
			var tarr = tearr.split(" ");
			document.getElementById("hiddenBilId"+res).value =tarr[0];
			if(tarr[3]=='Dr'){
				document.getElementById("ModelDrCr"+res).value  = 'Cr'
			}
			if(tarr[3]=='Cr'){
				document.getElementById("ModelDrCr"+res).value  = 'Dr'
			}
			if(document.getElementById("ModelDrCr"+res).value=='Cr'){
				callForBillWiseRow(id);
			}
		},

		error : function(itr) {

		}
	});
	
}
function callForBillWiseRow(id){
	var row = id.match(/\d/g);
	var rowCountBillWise = countTotalRowsBillWise();

	var tamt = 0;
	for(var i=1;i<=rowCountBillWise;i++){
		if(document.getElementById('ModelDrCr'+i).value=='Dr'){
			tamt=tamt+Number(document.getElementById('billAmt'+i).value);
		}
		else{
			tamt=tamt-Number(document.getElementById('billAmt'+i).value);
		}
		
	}
	if(tamt<0){
		tamt = tamt * (-1);
	}
	var amt = Number(document.getElementById('debitAmt'+amtId).value)+Number(document.getElementById('creditAmt'+amtId).value);

	if(tamt!=amt){
		callformorebillwiserow(id);
	}
	
}
function callToGetAdvance(id,tor){
	var myurl = "<%=basePath%>";
	var res = id.match(/\d/g);
	var rowCount = countTotalRows();
	
	var particular = document.getElementById('txnType'+rowCount).value;
	var rowCountBillWise = countTotalRowsBillWise();
	var amt = Number(document.getElementById('debitAmt'+res).value)+Number(document.getElementById('creditAmt'+res).value);
	myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_bill_ref_journal_id.action?partyAcc="
			+ particular+"&typeOfRef="+tor;
	
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			var arr = itr.split(",");
			document.getElementById('pendingBillt'+res).value = arr[0];
			document.getElementById('dueDate'+res).value = arr[1];
			document.getElementById('billAmt'+res).value = amt;
			if(rowCountBillWise>1){
				var finalAmt = 0;
			for(var i=1;i<rowCountBillWise;i++){
				finalAmt = finalAmt+ Number(document.getElementById('billAmt'+i).value);
			}
				document.getElementById('billAmt'+res).value = Number(amt)-finalAmt;
			}
			document.getElementById("pendingBills"+res).style.display = "none";
			document.getElementById("pendingBillt"+res).style.display = "block";
			document.getElementById("hiddenBilId"+res).value = arr[0];
			document.getElementById("ModelDrCr"+res).value = 'Dr';

		},

		error : function(itr) {

		}
	});
	
}
function countTotalRowsBillWise() {

	var rowCount = 0;
	var table = document.getElementById("payTransactionTableBillWise");
	var rows = table.getElementsByTagName("tr");
	for (var i = 0; i < rows.length; i++) {
		if (rows[i].getElementsByTagName("td").length > 0) {
			rowCount++;
		}
	}
	return rowCount;
}
function callformorebillwiserow(id){
	var rowCount = countTotalRowsBillWise();
	var row = document.getElementById("BillrowId" + rowCount); // find row to copy
	var table = document.getElementById("payTransactionTableBillWise"); // find table to append to
	var clone = row.cloneNode(true); // copy children too
	rowCount += 1;
	clone.id = "BillrowId" + rowCount; // change id or other attributes/contents
	table.appendChild(clone); // add new row to end of table
	var oInput = document.getElementById("BillrowId" + rowCount);
	var a = oInput.childNodes[1].childNodes[1];
	var b = oInput.childNodes[3].childNodes[1];
	var c = oInput.childNodes[3].childNodes[3];
	var d = oInput.childNodes[5].childNodes[1];
	var e = oInput.childNodes[7].childNodes[1];
	var f = oInput.childNodes[9].childNodes[1];
	var k = oInput.childNodes[10].childNodes[1];
	var l = oInput.childNodes[12].childNodes[1];
	var m = oInput.childNodes[14].childNodes[1];
	var n = oInput.childNodes[16].childNodes[1];
	var o = oInput.childNodes[18].childNodes[1];
	var p = oInput.childNodes[20].childNodes[1];

	a.id = "typeofRef"+rowCount;
	b.id = "pendingBillt"+rowCount;
	c.id = "pendingBills"+rowCount;
	d.id = "dueDate"+rowCount;
	e.id = "billAmt"+rowCount;
	f.id = "ModelDrCr"+rowCount;
	k.id = "hiddenTypeOfRef"+rowCount;
	l.id = "hiddenBillWiseName"+rowCount;
	m.id = "hiddenDueDate"+rowCount;
	n.id = "hiddenAmnt"+rowCount;
	o.id = "hiddencrdr"+rowCount;
	p.id = "hiddenBilId"+rowCount;

	document.getElementById('typeofRef'+rowCount).value = 'On Account';
	callToGetAdvance('typeofRef'+rowCount,'On Account');
	
}
	function checkForBillWiseMenu(id){
		
		var res = id.match(/\d/g);
		var partyName = document.getElementById('txnType' + res).value;
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_party_type.action?partyName="
				+ partyName;
		$.ajax({
			type : "GET",
			async:false,
			url : myurl,
			success : function(itr) {
				if(itr=='eligible'){
					document.getElementById('biller_name').innerHTML = partyName;
					if(isFirstCreditDebit==false)
						document.getElementById("myModal").style.display = "none";
					else
					 document.getElementById("myModal").style.display = "block";
				}
				else{
					 document.getElementById("myModal").style.display = "none";
				}
			},

			error : function(itr) {

			}
		});
	}
	function callForMoreRow(id) {
		var rowCount = countTotalRows();
		var res = id.match(/\d/g);
		checkForBillWiseMenu(id);
		if (document.getElementById('particularsList' + rowCount).value == "Dr" && document.getElementById(id).readOnly==false && rowCount == res) {
			var row = document.getElementById("rowId" + rowCount); // find row to copy
			var table = document.getElementById("payTransactionTable"); // find table to append to
			var clone = row.cloneNode(true); // copy children too
			rowCount += 1;
			clone.id = "rowId" + rowCount; // change id or other attributes/contents
			table.appendChild(clone); // add new row to end of table
			var oInput = document.getElementById("rowId" + rowCount);
			var e = oInput.childNodes[5].childNodes[1];
			var e1 = oInput.childNodes[5].childNodes[3];
			var f = oInput.childNodes[1].childNodes[1];
			var g = oInput.childNodes[7].childNodes[1];
			var h = oInput.childNodes[9].childNodes[1];
			var i = oInput.childNodes[3].childNodes[1];
			var j = oInput.childNodes[1].childNodes[3];
			var k = oInput.childNodes[3].childNodes[3];
			
			i.id = "txnType" + rowCount;
			f.id = "particularsList" + rowCount;
			g.id = "debitAmt" + rowCount;
			h.id = "creditAmt" + rowCount;
			e.id = "currentblnc" + rowCount;
			e1.id = "ccrdr" + rowCount;
			j.id = "DrCrType" + rowCount;
			k.id = "partyOldBal" + rowCount;
			
			var selectData = document.getElementById('particularsList'+rowCount);
			var opt = document.createElement('option');
		    opt.value = "Cr";
		    opt.innerHTML = "Cr";
		    selectData.appendChild(opt);
		    opt.setAttribute('selected', true);
		    document.getElementById("debitAmt" + rowCount).value=0;
		    changeFields('particularsList'+rowCount);
		    revertCurrBalance('particularsList'+rowCount);
		} else if(document.getElementById('particularsList' + rowCount).value == "Cr" && document.getElementById(id).readOnly==false && rowCount == res) {
			var selectData = document.getElementById('particularsList'+rowCount);
			var row = document.getElementById("rowId" + rowCount); // find row to copy
			var table = document.getElementById("payTransactionTable"); // find table to append to
			var clone = row.cloneNode(true); // copy children too
			rowCount += 1;
			clone.id = "rowId" + rowCount; // change id or other attributes/contents
			table.appendChild(clone); // add new row to end of table
			var oInput = document.getElementById("rowId" + rowCount);
			var e = oInput.childNodes[5].childNodes[1];
			var e1 = oInput.childNodes[5].childNodes[3];
			var f = oInput.childNodes[1].childNodes[1];
			var g = oInput.childNodes[7].childNodes[1];
			var h = oInput.childNodes[9].childNodes[1];
			var i = oInput.childNodes[3].childNodes[1];
			i.id = "txnType" + rowCount;
			f.id = "particularsList" + rowCount;
			g.id = "debitAmt" + rowCount;
			h.id = "creditAmt" + rowCount;
			e.id = "currentblnc" + rowCount;
			e1.id = "ccrdr" + rowCount;
			
			document.getElementById("creditAmt" + rowCount).value=0;
			  revertCurrBalance('particularsList'+rowCount);
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
	
	function showCurrentParticularsBalance(id){
	
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_current_balance.action?partyAcc="
				+ document.getElementById(id).value;
		var res = id.match(/\d/g);
		$.ajax({
			type : "POST",
			async:false,
			url : myurl,
			success : function(itr) {
				var arr = itr.split(",");
				document.getElementById('currentblnc'+res).value = arr[0];
				document.getElementById('ccrdr'+res).innerHTML = arr[1];
				document.getElementById('partyOldBal'+res).value = arr[0]+" "+arr[1];
				amtId = res;
				revertCurrBalance(id);
				checkForBillWiseMenu(id);

			},

			error : function(itr) {

			}
		});
	}
	function changeFields(id) {
		var element = document.getElementById(id);
		var strUser = element.options[element.selectedIndex].value;
		
		var substr = id.substring(15,id.length);
		var i, amount = 0;;
		document.getElementById('DrCrType'+substr).value = strUser;
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

		var chk = id.match(/\d/g);	
		activerow = chk;
		if(Number(activerow)==1)
			isFirstCreditDebit = false;
		else
			isFirstCreditDebit = true;

	}
	function callHiddenBillId(id){
		var val = document.getElementById(id).value;
		var arr= val.split(" ");
		document.getElementById('hiddenBilId'+activerow).value = arr[0];
		document.getElementById('ModelDrCr'+activerow).value = arr[3];
		if(arr[3]=='Cr')
			document.getElementById('ModelDrCr'+activerow).value = 'Dr';
		if(arr[3]=='Dr')
			document.getElementById('ModelDrCr'+activerow).value = 'Cr';
		callForBillWiseRow(id);
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
			action="/com/stpl/pms/action/bo/um/bo_um_Bojournal_create.action"
			id="searchUserFrm" theme="simple" method="POST" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Journal No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
						<s:textfield id="journalNoVoucher" name="journalNoVoucher" value="%{journalNoVoucher}"
								theme="myTheme" cssStyle="width:40%" />
							<s:textfield id="journalNo" name="journalNo" value="%{journalNo}"
								theme="myTheme" readonly="true" cssStyle="width:10%;display:none" />
							<s:textfield id="activeVoucherNumber" name="activeVoucherNumber" value="%{activeVoucherNumber}"
								theme="myTheme" readonly="true" cssStyle="width:10%;display:none" />		
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
								<th style="text-align: center;" nowrap="nowrap">Current Balance</th>
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
									<s:hidden name="DrCrType" value="Dr" id="DrCrType1"></s:hidden>
								</td>
								<td style="text-align: center;" nowrap="nowrap" ><s:select
										name="particulars" id="txnType1" headerKey="none" headerValue="--Please Select--" list="particularsList"
										cssClass="select1" theme="myTheme" cssStyle="width:150px;" onchange="showCurrentParticularsBalance(this.id)"/>
									<s:hidden name="partyOldBal" id="partyOldBal1"></s:hidden>	
										</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="currentblnc" value="0" id="currentblnc1"
										theme="myTheme" pattern="^[0-9.]*$" cssStyle="width:50%" readOnly="true">
									</ss:textfield><span id="ccrdr1"></span></td>	
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="debitAmt" value="0" id="debitAmt1"
										theme="myTheme" onchange="callForMoreRow(this.id)" readonly="false" pattern="^[0-9.]*$" cssStyle="width:50%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="creditAmt" value="0" id="creditAmt1"
										theme="myTheme" onchange="callForMoreRow(this.id)" readonly="true" pattern="^[0-9.]*$" cssStyle="width:50%">
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
				<!-- <input type="submit" value='Create' align="left"
					style="margin-left: 0px" class="button" /> -->
					<button type="button" align="left"
					style="margin-left: 0px" class="button" onclick="promptSave()">Save</button>
			</div>
					<div id="myModal" class="modal">

  <!-- Modal content -->
  			<div class="modal-content">
 			   <button id="closeme" type="button" class="close" onclick="closeMe()">Save</button>
 			  <div id="bill_by_bill">
						<div class="FormSectionMenu" id="bill_by_bill_div_acc">
							<div class="greyStrip">
								<h4>Bill Wise Details for :	<b><span id="biller_name"></span></b></h4>
							</div>
							<table width="100%" cellspacing="0" align="center"
						id="payTransactionTableBillWise" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Type of Ref</th>
								<th style="text-align: center;" nowrap="nowrap">Name</th>
								<th style="text-align: center;" nowrap="nowrap">Due Date limit</th>
								<th style="text-align: center;" nowrap="nowrap">Amount</th>
								<th style="text-align: center;" nowrap="nowrap">Dr/Cr</th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
						
							</tr>
						</thead>
						<tbody>

							<tr id="BillrowId1">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										name="typeofRef" id="typeofRef1" list="{'Advance','Agst Ref','New Ref','On Account'}"
										cssClass="select1" theme="myTheme"
										onchange="callForMoreBillRow(this.id)" cssStyle="width:50%;" /></td>
								<td style="text-align: center;" nowrap="nowrap">
								<ss:textfield
										maxlength="30" readOnly="true" name="pendingBill" id="pendingBillt1" theme="myTheme"
										cssStyle="width:20%">
									</ss:textfield>
									<select name="pendingBill" id="pendingBills1" class="select1" style="display:none;" onchange="callHiddenBillId(this.id)">
									
									</select>
								</td>
								<td style="text-align: center;" nowrap="nowrap">
								<ss:textfield
										maxlength="30" readOnly="true" name="dueDate" id="dueDate1" theme="myTheme"
										cssStyle="width:60%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="billAmt" id="billAmt1" theme="myTheme"
										cssStyle="width:40%" onchange="callForBillWiseRow(this.id)"/></td>
								<td style="text-align: center;" nowrap="nowrap">
								<ss:textfield
										maxlength="30" readOnly="true" name="ModelDrCr" id="ModelDrCr1" theme="myTheme"
										cssStyle="width:60%">
								</ss:textfield>
								<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenTypeOfRef" id="hiddenTypeOfRef1"></s:hidden>
								</td>
								<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenBillWiseName" id="hiddenBillWiseName1"></s:hidden>
								</td>
								<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenDueDate" id="hiddenDueDate1"></s:hidden>
								</td>
								<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenAmnt" id="hiddenAmnt1"></s:hidden>
								</td>
								<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddencrdr" id="hiddencrdr1"></s:hidden>
								</td>
								<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenBilId" id="hiddenBilId1"></s:hidden>
								</td>	
							</tr>


						</tbody>
					</table>
						</div>
					</div>
 			 </div>

			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

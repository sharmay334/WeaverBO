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

<title>Receipt</title>
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
  font-size: 28px;
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

var modal = document.getElementById("myModal");
var currentId = 0;
var activerow=0;
var BillWiseActiveRow=0;


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
function checkDocUpload(){
	
	var doc = document.getElementById('docPicture').value;
	if(doc!=""){
		promptSave();
	}
	else{
		
		swal("Please upload document first!");
	}
	
}
function promptSave(){
	var frm = $('#searchUserFrm');
	let photo = document.getElementById("docPicture").files[0];
	let formData = new FormData();
	formData.append("docPicture", photo);
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/upload_receipt_order_document.action?receiptNo="+document.getElementById('receiptNo').value;
	
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
			        		$.ajax({
						        type: 'POST',
						        url: myurl,
						        data: formData,
						        cache : false,
						        async:false,
								contentType : false,
								processData : false,
						        success: function (data) {
						        	
						            
						        },
						        error: function (data) {
						        	
						        },
						    });
			        		
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
	if(tamt==document.getElementById('amount'+activerow).value){
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

//When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
if (event.target == modal) {
 modal.style.display = "none";
}
}

var CurrentBalance = 0;

$(document).ready(function() {
	$("#paymentDate").datetimepicker({
		dateFormat : 'dd-mm-yy',
		showSecond : false,
		showMinute : false,
		showHour : false,
		changeYear : true,
		changeMonth : true,
		startDate: '01-01-1980',
		minDate : '01-01-1980',
		onSelect : function(selectedDate) {
			if (selectedDate != "") {
				$("#paymentDate").datepicker("option", "minDate", selectedDate);
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
		if(type=="Agst Ref"){
			callToGetAgstRef(id,'Agst Ref');
		}
		if(type=="On Account"){
			callToGetAdvance(id,'On Account');
		}
		
	}
		
	function callToGetAgstRef(id,tor){
		var myurl = "<%=basePath%>";
		var res = id.match(/\d/g);
		var rowCount = countTotalRows();
		var idd = Number(rowCount)-1;
		var particular = document.getElementById('particularsList'+idd).value;
		var rowCountBillWise = countTotalRowsBillWise();

		var amt = document.getElementById('amount'+idd).value;
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_bill_agst_ref_id.action?partyAcc="
				+ particular+"&typeOfRef="+tor+"&suffix=_sale";
		
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
				document.getElementById("hiddenBilId"+activerow).value =tarr[0];
				if(tarr[3]=='Dr'){
					document.getElementById("ModelDrCr"+activerow).value  = 'Cr'
				}
				if(tarr[3]=='Cr'){
					document.getElementById("ModelDrCr"+activerow).value  = 'Dr'
				}
				if(document.getElementById("ModelDrCr"+activerow).value=='Cr'){
					callForBillWiseRow(id);
				}
			},

			error : function(itr) {

			}
		});
		
	}
	function callToGetAdvance(id,tor){
		var myurl = "<%=basePath%>";
		var res = id.match(/\d/g);
		var rowCount = countTotalRows();
		var idd = Number(rowCount)-1;
		var particular = document.getElementById('particularsList'+idd).value;
		var rowCountBillWise = countTotalRowsBillWise();
		var amt = document.getElementById('amount'+idd).value;
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_bill_ref_id.action?partyAcc="
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
				document.getElementById("hiddenBilId"+activerow).value = arr[0];
				document.getElementById("ModelDrCr"+activerow).value = 'Dr';

			},

			error : function(itr) {

			}
		});
		
	}
	function callForMoreRow(id) {
		showCurrentParticularsBalance(id);
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
			e.id = "amount" + rowCount;
			f.id = "particularsList" + rowCount;
			g.id = "txnType" + rowCount;
			h.id = "bankName" + rowCount;
			i.id = "currentblnc"+rowCount;
			j.id = "ccrdr"+rowCount;
				
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
	function showCurrentParticularsBalance(id){
		
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_current_balance.action?partyAcc="
				+ document.getElementById(id).value;
		var res = id.match(/\d/g);
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				var arr = itr.split(",");
				document.getElementById('currentblnc'+res).value = arr[0];
				document.getElementById('ccrdr'+res).innerHTML = arr[1];
			},

			error : function(itr) {

			}
		});
	}
	function checkForBillByBill(particulars){
		var res = particulars.match(/\d/g);
		var particular = document.getElementById('particularsList'+res).value;
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_check_bill_by_bill.action?billByBill="+particular;
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				if(itr=="true"){
					
					document.getElementById('biller_name').innerHTML = particular;
					currentId = res;
					 document.getElementById("myModal").style.display = "block";
					var blnc = Number(document.getElementById('currentblnc'+res).value);
					blnc = blnc - Number(document.getElementById('amount'+res).value);
					document.getElementById('currentblnc'+res).value = blnc;
					
				}
				else{
					 document.getElementById("myModal").style.display = "none";

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
		if (document.getElementById('particularsList' + chk).value != "none") {
			var rc = countTotalRows();
			document.getElementById('currBalance').value = '0';
			var amt = document.getElementById('currBalance').value;
			for (var i = 1; i <= rc; i++) {
				if (document.getElementById('amount' + i).value != "0") {
					amt = Number(amt)
							+ Number(document.getElementById('amount' + i).value);
					if (!isNaN(amt))
						if(document.getElementById('hcrdr').value=='Cr')
						document.getElementById('currBalance').value = Number(CurrentBalance)-amt;
						else
						document.getElementById('currBalance').value = Number(CurrentBalance)+amt;	
				}
			}

		}
		activerow = chk;
		 checkForBillByBill(id);

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
				document.getElementById('hcrdr').value = arr[1];
				CurrentBalance = arr[0];
			},

			error : function(itr) {

			}
		});
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
		if(tamt!=document.getElementById('amount'+activerow).value){
			callformorebillwiserow(id);
		}
		
	}
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Receipt
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Receipt</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_BoEmpreceipt_create.action"
			id="searchUserFrm" theme="simple" enctype="multipart/form-data" method="POST" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Receipt No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="receiptNo" name="receiptNo" value="%{receiptNo}"
								theme="myTheme" readonly="true" cssStyle="width:10%" />
						</div>
					</div>
					<div class="FormMainBox" style="display:none;">

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
					<%-- <div class="clearFRM"></div>
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
								<s:hidden id="hcrdr"></s:hidden>
						</div>
					</div>
					<div class="clearFRM"></div> --%>
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
									</ss:textfield><span id="ccrdr1"></span></td>
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
							<s:textfield name="narration" value="receipt" cssClass="InpTextBoxBg"
								id="narration" theme="simple" title="Enter Narration"></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Upload Document </label>
					</div>
					<div class="InputDivHalf">
					
					<s:file label="upload" applyscript="true" onmouseout="validateFile(this,'docPicture')" id="docPicture" name="docPicture" cssClass="textfield" theme="myTheme"></s:file>
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
					style="margin-left: 0px" class="button" onclick="checkDocUpload()">Save</button>
			</div>
			<div id="myModal" class="modal">

  <!-- Modal content -->
  			<div class="modal-content">
 			   <button id="closeme" type="button" class="close" onclick="closeMe()">&times;</button>
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
										name="typeofRef" id="typeofRef1" headerKey="-1" headerValue="-Please Select-" list="{'Advance','Agst Ref','On Account'}"
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

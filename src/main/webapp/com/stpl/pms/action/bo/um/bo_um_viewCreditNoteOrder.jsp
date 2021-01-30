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
.modal1 {
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
.modal-content1 {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}
.modal2 {
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
.modal-content2 {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}
.form-popup {
	display: none;
	position: fixed;
	bottom: 370px;
	right:650px;
	border: 3px solid #f1f1f1;
	z-index: 9;
	background: #FFFF00;
}

/* Add styles to the form container */


/* Full-width input fields */
.form-container input[type=text], .form-container input[type=password] {
	width: 100%;
	padding: 15px;
	margin: 5px 0 22px 0;
	border: none;
	background: #f1f1f1;
}

/* When the inputs get focus, do something */
.form-container input[type=text]:focus, .form-container input[type=password]:focus
	{
	background-color: #ddd;
	outline: none;
}

/* Set a style for the submit/login button */
.form-container .btn {
	background-color: #4CAF50;
	color: white;
	padding: 16px 20px;
	border: none;
	cursor: pointer;
	width: 100%;
	margin-bottom: 10px;
	opacity: 0.8;
}

/* Add a red background color to the cancel button */
.form-container .cancel {
	background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
	opacity: 1;
}
</style>
<title>Credit Note</title>
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
var totalTax = 0;
var current_working_table_row_id = 0;
var item_name_val = 0;
var goDownGlobal;
var old_cr_dr = "";
var BillWiseActiveRow;
var itemNameGlobal;
var totalTax = ["0","0","0","0","0","0","0","0","0","0","0"];

function showtdfornewNo(){
	$("#batchTh").css("display", "none");
	$("#batchTd").css("display", "none");
	$("#QtyTd").css("display", "none");
	$("#QtyTh").css("display", "none");
	if(document.getElementById('batchList').value=="New Number"){
		$("#batchTh").css("display", "block");
		$("#batchTd").css("display", "block");
		
		
	}
	else if(document.getElementById('batchList').value!="Not Applicable"){
		$("#QtyTd").css("display", "block");
		$("#QtyTh").css("display", "block");
		var btch = document.getElementById('batchList').value;
		document.getElementById('hiddenBatchNumber'+current_working_table_row_id).value = btch;
		document.getElementById('batchNewNo').value = btch;
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_BatchDates.action?goDown="
				+ goDownGlobal+"&itemName="+itemNameGlobal+"&hiddenBatchNumber="+document.getElementById('batchList').value;
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				
				var arr = itr.split(",");
				document.getElementById('mfg').value = arr[0];
				document.getElementById('exp').value = arr[1];
				document.getElementById('BatchQty').value = arr[2];
			},

			error : function(itr) {

			}
		});
		
	}
}
$(document).ready(function() {
	$("#mfg").datetimepicker({
		dateFormat : 'mm/dd/yy',
		showSecond : false,
		showMinute : false,
		showHour : false,
		changeYear : true,
		changeMonth : true,
		minDate : '01/01/1930',
		onSelect : function(selectedDate) {
			if (selectedDate != "") {
				$("#mfg").datepicker("option", "minDate", selectedDate);
			} else {
				var date = new Date().getDate();
				$(function() {
					$("#mfg").datepicker({
						dateFormat : 'dd-mm-yy'
					}).datepicker("setDate", date);
				});
			}
		}
	});
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
$("#reminderDate").datetimepicker({
	dateFormat : 'mm/dd/yy',
	showSecond : false,
	showMinute : false,
	showHour : false,
	changeYear : true,
	changeMonth : true,
	minDate : '01/01/1930',
	onSelect : function(selectedDate) {
		if (selectedDate != "") {
			$("#reminderDate").datepicker("option", "minDate", selectedDate);
		} else {
			var date = new Date().getDate();
			$(function() {
				$("#reminderDate").datepicker({
					dateFormat : 'dd-mm-yy'
				}).datepicker("setDate", date);
			});
		}
	}
});
	$("#exp").datetimepicker({
		dateFormat : 'mm/dd/yy',
		showSecond : false,
		showMinute : false,
		showHour : false,
		changeYear : true,
		changeMonth : true,
		minDate : '01/01/1930',
		onSelect : function(selectedDate) {
			if (selectedDate != "") {
				$("#exp").datepicker("option", "minDate", selectedDate);
			} else {
				var date = new Date().getDate();
				$(function() {
					$("#exp").datepicker({
						dateFormat : 'dd-mm-yy'
					}).datepicker("setDate", date);
				});
			}
		}
	});
	
});
function callForSweetAlertPopUp(id){
	
	 document.getElementById("myForm").style.display = "block";
}
function closeMe(){
	document.getElementById("myModal1").style.display = "none";
	
}

function closeMeCNAdjust(){
	
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
	if(tamt==document.getElementById('totalAmt').value){
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
		document.getElementById("myModal2").style.display = "none";
		promptSave();
			
	}
	else{
		alert('Please Adjust proper Amount First...');
	}
	
		
}
function callToGetAgstRef(id,tor){
	var myurl = "<%=basePath%>";
	var res = id.match(/\d/g);
	var particular = document.getElementById('partyAcc').value;
	var rowCountBillWise = countTotalRowsBillWise();

	var amt = document.getElementById('totalAmt').value;
	myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_bill_agst_ref_id.action?partyAcc="
			+ particular+"&typeOfRef="+tor+"&suffix=_sale";
	
	$.ajax({
		type : "GET",
		url : myurl,
		async:false,
		success : function(itr) {
			var arr = itr.split(",");
			var optionArr = arr[0].split(";");
			
			document.getElementById('dueDate'+res).value = arr[1];
			var optionArrSub = optionArr[0].split(" ");
			var datearr = optionArrSub[1].split("-");
			var conversionDate = datearr[2]+"-"+datearr[1]+"-"+datearr[0];
			var d = new Date(conversionDate);
		
			d.setDate(d.getDate() + Number(arr[1]));
			limit_days = Number(arr[1]);
			 var dd = d.getDate();
			    var mm = d.getMonth()+1;
			    var y = d.getFullYear();
			 var _dt = dd+"-"+mm+"-"+y+" ( "+arr[1]+" days)" ;
			 document.getElementById('dueDate'+res).value = _dt;
			if(Number(optionArrSub[2])>Number(amt) || Number(optionArrSub[2])==Number(amt))
			document.getElementById('billAmt'+res).value = Number(amt);
			else
				document.getElementById('billAmt'+res).value = optionArrSub[2];

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
function countTotalRowsBillWise() {

	var rowCount = 0;
	var table = document.getElementById("payTransactionTableBillWise1");
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
	var table = document.getElementById("payTransactionTableBillWise1"); // find table to append to
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
	var q = oInput.childNodes[22].childNodes[1];
	var r = oInput.childNodes[24].childNodes[1];
	

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
	q.id = "deleteRow"+rowCount;
	r.id = "addRow"+rowCount;

	document.getElementById('typeofRef'+rowCount).value = 'On Account';
	callToGetAdvance('typeofRef'+rowCount,'On Account');
	
}
function deleteBillRow(id){
	var idNum = id.match(/\d/g);
	$('table#payTransactionTableBillWise1 tr#BillrowId'+idNum).remove();

}
function AddBillRow(id){
	var idNum = id.match(/\d/g);
	var rowCount = countTotalRowsBillWise();
	var row = document.getElementById("BillrowId" + rowCount); 
	var table = document.getElementById("payTransactionTableBillWise1");
	var clone = row.cloneNode(true);
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
	var q = oInput.childNodes[22].childNodes[1];
	var r = oInput.childNodes[24].childNodes[1];
	

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
	q.id = "deleteRow"+rowCount;
	r.id = "addRow"+rowCount;

	document.getElementById('typeofRef'+rowCount).value = 'On Account';
	callToGetAdvance('typeofRef'+rowCount,'On Account');
}
function saveCreditNoteBill(){
	
	checkForBillByBill(document.getElementById('partyAcc'));
	
}
function checkForBillByBill(particulars){
	var particular = particulars.value;
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_check_bill_by_bill.action?billByBill="+particular;
	$.ajax({
		type : "GET",
		url : myurl,
		async:false,
		success : function(itr) {
			if(itr=="true"){
				
				document.getElementById('biller_name').innerHTML = particular;
				currentId = 1;
				 document.getElementById("myModal2").style.display = "block";				
				
			}
			else{
				currentId = 1;
				 document.getElementById("myModal2").style.display = "none";
				 promptSave();
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
	if(tamt!=document.getElementById('amount'+row).value){
		callformorebillwiserow(id);
	}
	
}
function callToGetAdvance(id,tor){
	var myurl = "<%=basePath%>";
	var res = id.match(/\d/g);
	var particular = document.getElementById('partyAcc').value;
	var rowCountBillWise = countTotalRowsBillWise();
	var amt = document.getElementById('totalAmt').value;
	myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_bill_ref_id.action?partyAcc="
			+ particular+"&typeOfRef="+tor+"&isSale=Yes";
	
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
			document.getElementById("ModelDrCr"+res).value = 'Cr';

		},

		error : function(itr) {

		}
	});
	
}
	
function closeDialogue(){
	
	var batch = document.getElementById('batchNewNo').value;
	var mfg = document.getElementById('mfg').value;
	var exp = document.getElementById('exp').value;
	var expAlrt = document.getElementById('expAlert').value;
	var expAlrtDate = document.getElementById('reminderDate').value;
	
	document.getElementById('hiddenBatchNumber'+current_working_table_row_id).value = batch;
	document.getElementById('hiddenMfgDate'+current_working_table_row_id).value = mfg;
	document.getElementById('hiddenExpDate'+current_working_table_row_id).value = exp;
	document.getElementById('hiddenExpAlert'+current_working_table_row_id).value = expAlrt;
	document.getElementById('hiddenExpAlertDate'+current_working_table_row_id).value = expAlrtDate;
	document.getElementById("myForm").style.display = "none";
}
	function getTaxes(id){
		var idNum = id.match(/\d/g);
		current_working_table_row_id = idNum;
		var itemName = document.getElementById('salesStockItems'+idNum).value;
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_tax.action?itemName="
				+ itemName;
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				if(itr!="none"){
					var res = itr.split(";");
					var original = document.getElementById('amount'+idNum).value;
					document.getElementById('igstpercent').innerHTML = res[0]+"%";
					document.getElementById('igst').value = (Number(document.getElementById('amount'+idNum).value)*Number(res[0]))/100;
					document.getElementById('cgstpercent').innerHTML = res[1]+"%";
					document.getElementById('cgst').value = (Number(document.getElementById('amount'+idNum).value)*Number(res[1]))/100;
					document.getElementById('sgstpercent').innerHTML = res[2]+"%";
					document.getElementById('sgst').value = (Number(document.getElementById('amount'+idNum).value)*Number(res[2]))/100;
					totalTax = 	document.getElementById('igst').value;
				}
				else{
					document.getElementById('igstpercent').innerHTML = "0%";
					document.getElementById('igst').value="0";
					document.getElementById('cgstpercent').innerHTML = "0%";
					document.getElementById('cgst').value="0";
					document.getElementById('sgstpercent').innerHTML = "0%";
					document.getElementById('sgst').value="0";
					
				}
				adjustTotalAmount('none');

			},

			error : function(itr) {

			}
		});
		
	}
	

	function showhideEmployee(data) {
		$("#showEmployeeDiv").css("display", "none");
		if (data == "Applicable") {
			$("#showEmployeeDiv").css("display", "block");
		}
	}
	function showBatchesPopup(id){
		var myurl = "<%=basePath%>";
		var res = id.match(/\d/g);
		goDownGlobal =  document.getElementById(id).value;
		var itemName = document.getElementById('salesStockItems'+res).value;
		 itemNameGlobal = itemName;
		 myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_availableBatches.action?goDown="
				+ document.getElementById(id).value+"&itemName="+itemName;
		var res = id.match(/\d/g);
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				var arr = itr.split(",");
				var myoption;
				for(var i=0;i<arr.length;i++){
					myoption+="<option>" +arr[i] + "</option>";
				}
				document.getElementById("batchList").innerHTML = myoption;
			},

			error : function(itr) {

			}
		});
	}
	function showGodownQty(id){
		var myurl = "<%=basePath%>";
		var res = id.match(/\d/g);
		current_working_table_row_id = res;
		var itemName = document.getElementById('salesStockItems'+res).value;
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_availableQtyPuchase.action?goDown="
				+ document.getElementById(id).value+"&itemName="+itemName;
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				
				document.getElementById('godownQty' + res).value = itr;
				showBatchesPopup(id);
				callForSweetAlertPopUp(id);
			},

			error : function(itr) {

			}
		});
	}
	function getTotalQty(id){
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_totalQtyPuchase.action?itemName="
				+ document.getElementById(id).value;
		var res = id.match(/\d/g);
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				
				document.getElementById('totalQty' + res).value = itr;
			},

			error : function(itr) {

			}
		});
	}
	function callForMoreRow(id) {
		getUnitByItem(id);
		getTotalQty(id);
		adjustTotalAmount(id);
		getTaxes(id);
		var rowCount = countTotalRows();
		if (document.getElementById('salesStockItems' + rowCount).value != "-1") {
			var row = document.getElementById("rowId" + rowCount); // find row to copy
			var table = document.getElementById("payTransactionTable"); // find table to append to
			var clone = row.cloneNode(true); // copy children too
			rowCount += 1;
			clone.id = "rowId" + rowCount; // change id or other attributes/contents
			table.appendChild(clone); // add new row to end of table
			var oInput = document.getElementById("rowId" + rowCount);
			var e = oInput.childNodes[9].childNodes[1];
			var f = oInput.childNodes[1].childNodes[1];
			var g = oInput.childNodes[11].childNodes[1];
			var h = oInput.childNodes[15].childNodes[1];
			var i = oInput.childNodes[13].childNodes[1];
			var j = oInput.childNodes[3].childNodes[1];
			var k = oInput.childNodes[5].childNodes[1];
			var q = oInput.childNodes[7].childNodes[1];
			var l = oInput.childNodes[17].childNodes[1];
			var m = oInput.childNodes[19].childNodes[1];
			var n = oInput.childNodes[21].childNodes[1];
			var o = oInput.childNodes[23].childNodes[1];
			var p = oInput.childNodes[25].childNodes[1];
			e.id = "Qty" + rowCount;
			f.id = "salesStockItems" + rowCount;
			g.id = "rate" + rowCount;
			h.id = "amount" + rowCount;
			i.id = "unit"+rowCount;
			j.id = "totalQty"+rowCount;
			k.id = "goDown"+rowCount;
			q.id = "godownQty"+rowCount;
			l.id = "hiddenBatchNumber"+rowCount;
			m.id = "hiddenMfgDate"+rowCount;
			n.id = "hiddenExpDate"+rowCount;
			o.id = "hiddenExpAlert"+rowCount;
			p.id = "hiddenExpAlertDate"+rowCount;
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
function getUnitByItem1(id,val) {
		
		var totalRow = countTotalRows();
		var myurl1="<%=basePath%>";
		for(var i=1;i<=totalRow;){
			myurl = myurl1+"/com/stpl/pms/action/bo/um/bo_um_tm_get_sales.action?var="
				+ document.getElementById('salesStockItems'+i).value;
		var res = id.match(/\d/g);
		$.ajax({
			type : "GET",
			async: false,
			url : myurl,
			success : function(itr) {
				document.getElementById('unit' + i).value = ''+itr;
				
			},

			error : function(itr) {

			}
		});
		i++;
		}
			
	}
	function getUnitByItem(id) {
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_sales.action?var="
				+ document.getElementById(id).value;
		var res = id.match(/\d/g);
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				
				document.getElementById('unit' + res).value = itr;
			},

			error : function(itr) {

			}
		});
	}
	function checkConsignee(val){
		$("#consigneeDiv").css("display", "none");
		if(val=="Yes"){
			$("#consigneeDiv").css("display", "block");
		}
		
	}
	
	function callPictureReport(src){
		var myurl = "<%=basePath%>";
		myurl += "com/stpl/pms/action/bo/um/bo_um_emp_picture.action?docPath="
				+ src;
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				
				var list1 = document.getElementById("one");
					if(typeof(list1.childNodes[0])!="undefined")
					list1.removeChild(list1.childNodes[0]);
						
					
				  var x = document.createElement("IMG");
					  x.setAttribute("src", itr);
					  x.setAttribute("width", "500");
					  x.setAttribute("height", "600");
					  x.setAttribute("alt", "Doc Img");
					  document.getElementById('one').appendChild(x);
				
				
				 
				document.getElementById("myModal1").style.display = "block";
			},
			error : function(itr) {

			}
		});
	}
	function adjustTotalAmount(id) {
		var finalAmount = 0;
		var rowCnt = countTotalRows();
		for (var i = 1; i <= rowCnt; i++) {
			if (document.getElementById('salesStockItems' + i).value != "-1")
				finalAmount = Number(finalAmount)
						+ Number(document.getElementById('amount' + i).value);
		}
		var taxAmt =0;
		for(var j=0;j<totalTax.length;j++){
			taxAmt = Number(taxAmt)+Number(totalTax[j]);
			
		}
		document.getElementById('totalAmt').value = finalAmount+Number(taxAmt);
		var blnc_type = old_cr_dr;
		
		var tAmt = finalAmount+Number(totalTax);
		if(blnc_type=='Dr'){
			var fAmt = Number(document.getElementById('totalAmt').value) - Number(CurrentBalance);
			if(fAmt<0){
				fAmt = fAmt * (-1);
				document.getElementById('crdr').innerHTML = 'Cr';
				document.getElementById('hcrdr').value = 'Cr';
			}
			document.getElementById('currBalance').value = fAmt;
			
		}
		else{
			var fAmt = Number(document.getElementById('totalAmt').value)+ Number(CurrentBalance);
			document.getElementById('currBalance').value = fAmt;
		}
		
	}
function getTotalQty1(id,val){
		
		var myurl1 = "<%=basePath%>";
		var totalRow = countTotalRows();
		for(var i=1;i<=totalRow;i++){
			myurl =myurl1+"/com/stpl/pms/action/bo/um/bo_um_tm_get_totalQtyPuchase.action?itemName="
				+ document.getElementById('salesStockItems'+i).value;
		var res = id.match(/\d/g);
		$.ajax({
			type : "GET",
			async: false,
			url : myurl,
			success : function(itr) {
				
				document.getElementById('totalQty' + i).value = itr;
			},

			error : function(itr) {

			}
		});
			
		}
		
		
	}
function reflectCurrentBalance(){
	
	var currBal = Number(document.getElementById('currBalance').value);
	var blncType= old_cr_dr;
	var totAmt = Number(document.getElementById('totalAmt').value);
	
	if(blncType=="Dr"){
		var bal = currBal+totAmt;
		document.getElementById('currBalance').value = bal;
	}
	else{
		var bal = currBal-totAmt;
		if(Number(bal)<0){
			bal = bal*(-1);
			document.getElementById('hcrdr').value = 'Dr';
			document.getElementById('crdr').innerHTML  = 'Dr';
			document.getElementById('currBalance').value = bal;
		}
		else{
			document.getElementById('hcrdr').value = 'Cr';
			document.getElementById('crdr').innerHTML  = 'Cr';
			document.getElementById('currBalance').value = bal;
	
		}

	}
	
	
	getTaxes1('id','val');
}
function getTaxes1(id,val){
	var idNum = id.match(/\d/g);
	var totalRow = countTotalRows();
	var myurl1 = "<%=basePath%>";
	for(var i=1;i<=totalRow;i++){
		var itemName = document.getElementById('salesStockItems'+i).value;
		
		 myurl = myurl1+"/com/stpl/pms/action/bo/um/bo_um_tm_get_tax.action?itemName="
				+ itemName;
		$.ajax({
			type : "GET",
			async: false,
			url : myurl,
			success : function(itr) {
				if(itr!="none"){
					var res = itr.split(";");
					document.getElementById('igstItem'+i).value = res[0]+"%";
					document.getElementById('igstItemAmt'+i).value = (Number(document.getElementById('amount'+i).value)*Number(res[0]))/100;
				}
				else{
					document.getElementById('igstItem'+i).value = "0%";
					document.getElementById('igstItemAmt'+i).value = "0";
					
				}
			},

			error : function(itr) {

			}
		});
		
	}
	
	
}
	function calAmount(id) {
		
		var res = id.match(/\d/g);
		var qty = document.getElementById('Qty' + res).value;
		var rate = document.getElementById('rate' + res).value;
		document.getElementById('amount' + res).value = qty * rate;
		getUnitByItem1(id);
		getTotalQty1(id);
		reflectCurrentBalance();
		getTaxesOnChange(id);
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
				document.getElementById('partyOldBalance').value = arr[0]+" "+arr[1];
				document.getElementById('crdr').innerHTML = arr[1];
				CurrentBalance = arr[0];
				old_cr_dr = arr[1];
				document.getElementById('hcrdr').value = arr[1];
				if(document.getElementById('salesStockItems1').value!='-1'){
					
					calAmount('salesStockItems1');
					}
			},

			error : function(itr) {

			}
		});
	}
	function showhideEmployee(data){
		$("#showEmployeeDiv").css("display", "none");
		if(data=="Applicable"){
			$("#showEmployeeDiv").css("display", "block");
		}
	}
	
	function getTaxesOnChange(id){
		var idNum = id.match(/\d/g);
		var myurl1 = "<%=basePath%>";
		var rowCnt = countTotalRows();
		for(var i=1;i<=rowCnt;i++){
			var itemName = document.getElementById('salesStockItems'+i).value;
			
			var myurl =myurl1+"/com/stpl/pms/action/bo/um/bo_um_tm_get_tax.action?itemName="
					+ itemName;
			$.ajax({
				type : "GET",
				async:false,
				url : myurl,
				success : function(itr) {
					if(itr!="none"){
						var res = itr.split(";");
						var original = document.getElementById('amount'+i).value;
						var tx = (Number(document.getElementById('amount'+i).value)*Number(res[0]))/100;
						totalTax[i] = tx;
						document.getElementById('igstItemAmt'+i).value = tx;
					}
					else{
						totalTax[i] = "0";
						document.getElementById('igstItemAmt'+i).value = "0";
						
					}
					
				},

				error : function(itr) {

				}
			});
			
		}
		
		adjustTotalAmount('none');
	}
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
function promptRejectedReason(){
		
		var reason = document.getElementById('rejectedReason').value;
		swal("Your have rejected this order because - "+reason);
	}
	function promptReason(){
		swal({
			  text: "Enter Reason of Rejection!",
			  content: { element: "textarea" },
			  buttons: "Ok"
			}).then((value) => {
			  if (!value) throw null;
			  value = document.querySelector(".swal-content__textarea").value;
			  var n = value.length;
			  if(n<3){
				  alert("Rejection Reason is Mandatory to minimun 5 characters!!");  
			  }
			  else{
				  var myurl = "<%=basePath%>";
				  myurl += "/com/stpl/pms/action/bo/um/bo_um_reject_creditNote.action?orderNo="+document.getElementById('orderNo').value+"&rejectReason="+value;
				  swal({
					  title: "Are you sure?",
					  text: "Once Reject, you will not be able to undo the entry!",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})
					.then((willDelete) => {
					  if (willDelete) {
						  $.ajax({
						        type: 'GET',
						        url: myurl,
						        success: function (data) {
						        	if(data=="success"){
						        		swal("Order Successfully Rejected..Refreshing Page!!!");
						        		setTimeout(function(){
						        			   window.location.reload(1);
						        			}, 1000);
						        	}
						        	else{
						        		swal("Some Error Occured While Rejecting!");
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
			  
			});
		
	}		
	
	
	function promptPartialSaveDispatcher(){
		var frm = $('#searchUserFrm');
		let formData = new FormData();
		var myurl = "<%=basePath%>";
		
		var ddn= document.getElementById('ddn').value;
		var tn=document.getElementById('tn').value;
		var des=document.getElementById('des').value;
		var vn =document.getElementById('vn').value;
		var billt = document.getElementById('billt').value;
		var tf = document.getElementById('transportFreight').value;
		var localf = document.getElementById('localFrieght').value;
		var loadf = document.getElementById('loadUnloadCharge').value;
		var unloadf = document.getElementById('loadUnloadCharge').value;
		var deliverycharge = document.getElementById('deliveryCharge').value;
		
		
		var luf = loadf+","+unloadf;
		myurl += "/com/stpl/pms/action/bo/um/upload_creditNote_txn_approve_stage_document.action?orderNo="+document.getElementById('orderNo').value+"&tn="+tn+"&des="+des+"&vn="+vn+"&transportFreight="+tf+"&localFrieght="+localf+"&ddn="+ddn+"&billt="+billt+"&partyAcc="+document.getElementById('partyAcc').value+"&deliveryCharge="+deliverycharge+"&loadCharge="+loadf+"&unloadCharge="+unloadf;
		
		if(localf.length>1 && loadf.length>1 && unloadf.length>1 && deliverycharge.length>1 && tn.length>1 && billt.length>1)
		{
				
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
								  type: 'POST',
							        url: myurl,
							        data: formData,
							        cache : false,
									contentType : false,
									processData : false,
									async:false,
							        success: function (data) {
							        	if(data=="success"){
							        		swal("Entry Successfully Saved..Refreshing for new entry!!!");
							        		
							        		
							        		setTimeout(function(){
							        			var myurlRedirect = "<%=basePath%>";
							    				window.location.href = myurlRedirect;
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
		else{
			swal("Please fill all following entry first\n\n1.) BillT\n2.) Transport Name\n3.) Local Freight\n4.) Load/Unload Freight\n5.) Delivery Charge\n");
				
		}
		
		
	}

	function checkGodownSelect(){
		var rowCnt = countTotalRows();
		var tcount = 0 ;
		for(var i=1;i<=rowCnt;i++){
			var godownValue = document.getElementById('goDown'+i).value;
			if(godownValue!="-1"){
				tcount++;
			}
		}
		if(tcount!=rowCnt){
			swal("Error! Please Select Godown for items first!");
		}
		else{
			//checkForOrderStatus();
			saveCreditNoteBill();
		}
		
	}
function promptPartialSave(){
		
		var myurl = "<%=basePath%>";
		myurl = myurl+"/com/stpl/pms/action/bo/um/bo_um_approve_creditNote.action?orderNo="+document.getElementById('orderNo').value;
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
			        type: 'POST',
			        url: myurl,
			        success: function (data) {
			        	if(data=="success"){
			        		swal("Entry Successfully Saved..Refreshing for new entry!!!");
			        		setTimeout(function(){
			        			var myurlRedirect = "<%=basePath%>";
			    				window.location.href = myurlRedirect;
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
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Credit Note
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Credit Note</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_BocreditNote_create.action"
			id="searchUserFrm" method="POST" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Credit Note No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="salesNoVoucher" name="cnNoVoucher" value="%{cnNoVoucher}"
								theme="myTheme" readonly="true" cssStyle="width:30%" />
							<s:textfield id="cnNo" name="cnNo" value="%{cnNo}"
								theme="myTheme" readonly="true" cssStyle="width:10%;display:none" />
								<s:textfield id="activeVoucherNumber" name="activeVoucherNumber" value="%{activeVoucherNumber}"
								theme="myTheme" readonly="true" cssStyle="width:10%;display:none" />	
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Order No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="orderNo" name="orderNo" value="%{orderNo}"
								theme="myTheme" readonly="true" cssStyle="width:10%" />
						</div>
					</div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Original Invoice No.:</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="referenceNo" name="referenceNo" theme="myTheme"
								cssStyle="width:10%" />
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
							<label> Party A/c Name </label>
						</div>
						<div class="InputDiv">
							<s:select name="partyAcc" headerKey="none" value="%{partyAccNameSO}"
								id="partyAcc" headerValue="--Please Select--"
								list="partyAccName" onchange="getCurrentBalance(this.id)" cssClass="select1" theme="myTheme" />
						</div>
					</div>

					<div class="FormMainBox" style="display:none;">

						<div class="labelDiv">
							<label> Assign Employee </label>
						</div>
						<div class="InputDiv">
							<s:select name="isEmployee" headerKey="-1"
								id="isEmployee" headerValue="--Please Select--"
								list="{'Applicable','Not Applicable'}" onchange="showhideEmployee(this.value)" cssClass="select1" theme="myTheme" />
						</div>
					</div>
					<div id="showEmployeeDiv" style="display:none;">
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
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>Sales Ledger</label>
						</div>
						<div class="InputDiv">
							<s:select name="salesAccount" headerKey="none"
								id="salesAccount" headerValue="--Please Select--"
								list="salesAccountList" cssClass="select1" theme="myTheme" />
						</div>
					</div>
					<div class="clearFRM"></div>
					
					
					<div id="consigneeDiv" style="display:none;">
					
					<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable1" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Dealer Name</th>
								<th style="text-align: center;" nowrap="nowrap">Prop Name</th>
								<th style="text-align: center;" nowrap="nowrap">Contact</th>
								<th style="text-align: center;" nowrap="nowrap">Address</th>
								<th style="text-align: center;" nowrap="nowrap">GSTN No</th>	
							</tr>
						</thead>
						<tbody>
					
					<tr>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="50" name="Dname" value="%{Dname}"
										theme="myTheme" readOnly="true"
										cssStyle="width:90%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="50" name="propName" value="%{propName}"
										theme="myTheme" readOnly="true"
										cssStyle="width:90%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="contact" value="%{contact}"
										theme="myTheme" readOnly="true"
										cssStyle="width:80%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="address" value="%{address}"
										theme="myTheme" readOnly="true"
										cssStyle="width:100%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="50" name="gstnNo" readOnly="true" value="%{gstnNo}"
										theme="myTheme" readOnly="true"
										cssStyle="width:90%">
									</ss:textfield></td>
									

							</tr>
					
							


						</tbody>
					</table>
					</div>
					
					
					
					
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Current Balance </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="currBalance" id="currBalance" value="0"
								theme="myTheme" readonly="true" cssStyle="width:20%" />
								<span id="crdr"></span>
								<s:hidden id="hcrdr" name="hcrdr"></s:hidden>
								<s:hidden name="partyOldBalance" id="partyOldBalance"></s:hidden>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					
					<table width="100%" cellspacing="0" align="center"
					class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Dispatch Doc No</th>
								<th style="text-align: center;" nowrap="nowrap">Transport Name</th>
								<th style="text-align: center;" nowrap="nowrap">Destination</th>
							</tr>
						</thead>
						<tbody>
					
					<tr>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="ddn" id="ddn" value="%{ddn}"
								theme="myTheme" cssStyle="width:40%" />
								
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="tn" id="tn" value="%{tn}"
								theme="myTheme" cssStyle="width:50%" />
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="des" id="des" value="%{des}"
								theme="myTheme" cssStyle="width:50%" />
								</td>
									
							</tr>
					
						</tbody>
					</table>
					
					<div class="clearFRM"></div>
					
					<table width="100%" cellspacing="0" align="center"
					class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Bill-T No.</th>
								<th style="text-align: center;" nowrap="nowrap">Vehical No.</th>
								<th style="text-align: center;" nowrap="nowrap">Transport Freight</th>
							</tr>
						</thead>
						<tbody>
					
					<tr>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="billt" id="billt" 
								theme="myTheme"  cssStyle="width:40%" value="%{billt}"/>
								
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="vn" id="vn" value="%{vn}"
								theme="myTheme" cssStyle="width:50%" />
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="transportFreight" id="transportFreight" value="%{transportFreight}"
								theme="myTheme" pattern="^[0-9.]*$" cssStyle="width:50%" />
								</td>
									
							</tr>

						</tbody>
					</table>
					
					
					<table width="100%" cellspacing="0" align="center"
					class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Local Freight</th>
								<th style="text-align: center;" nowrap="nowrap">Load Freight</th>
								<th style="text-align: center;" nowrap="nowrap">Unload Freight</th>
								<th style="text-align: center;" nowrap="nowrap">Delivery Charge</th>
							</tr>
						</thead>
						<tbody>
					
					<tr>
								
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="localFrieght" id="localFrieght" value="%{localFrieght}"
								theme="myTheme"  pattern="^[0-9.]*$"  cssStyle="width:50%" />
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="loadUnloadCharge" id="loadUnloadCharge" value="%{loadCharge}"
								theme="myTheme" pattern="^[0-9.]*$" cssStyle="width:50%" />
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="loadUnloadCharge1" id="loadUnloadCharge1" value="%{unloadCharge}"
								theme="myTheme" pattern="^[0-9.]*$" cssStyle="width:50%" />
								</td>
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="deliveryCharge" id="deliveryCharge" value="%{deliveryCharge}"
								theme="myTheme" pattern="^[0-9.]*$" cssStyle="width:50%" />
								</td>	
							</tr>

						</tbody>
					</table>
					
					
					
					<div class="clearFRM"></div>
					<br />
					<div class="clearFRM"></div>

					<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Name of
									item</th>
								<th style="text-align: center;" nowrap="nowrap">Total Qty.</th>
								<th style="text-align: center;" nowrap="nowrap">GoDown</th>
								<th style="text-align: center;" nowrap="nowrap">Available</th>
								<th style="text-align: center;" nowrap="nowrap">Billed Qty.</th>
								<th style="text-align: center;" nowrap="nowrap">Rate</th>
								<th style="text-align: center;" nowrap="nowrap">unit</th>
								<th style="text-align: center;" nowrap="nowrap">Amount</th>
								<th style="text-align: center;" nowrap="nowrap">IGST</th>
								<th style="text-align: center;" nowrap="nowrap">Tax Amount</th>
							
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
							</tr>
						</thead>
						<tbody>

							<s:iterator value="itemBeans" var="data">
					<tr id="rowId<s:property value="#data.rowId"/>">
								<td style="text-align: center;" nowrap="nowrap">
										<ss:textfield
										maxlength="30" name="salesStockItems" readOnly="true" value="%{#data.itemName}" id="%{'salesStockItems' + #data.rowId}"
										theme="myTheme" readOnly="true"
										cssStyle="width:120px">
									</ss:textfield>
										
										</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="%{'totalQty' + #data.rowId}"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="Please Select"
										name="goDown" id="%{'goDown' + #data.rowId}" onchange="showGodownQty(this.id)"
										list="goDownList" cssClass="select1" theme="myTheme"
										cssStyle="width:100px;" /></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="godownQty" readOnly="true" value="0" id="%{'godownQty' + #data.rowId}" theme="myTheme"
										 cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" value="%{#data.itemQty}" id="%{'Qty' + #data.rowId}" theme="myTheme"
										pattern="^[0-9.]*$" readOnly="true"
										onfocusout="calAmount(this.id)" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate" value="%{#data.itemRate}" id="%{'rate' + #data.rowId}"
										theme="myTheme" pattern="^[0-9.]*$" readOnly="true"
										onfocusout="calAmount(this.id)" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="%{'unit' + #data.rowId}"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="%{#data.itemAmount}" id="%{'amount' + #data.rowId}"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="igstItem" value="0" id="%{'igstItem' + #data.rowId}"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="igstItemAmt" value="0" id="%{'igstItemAmt' + #data.rowId}"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenBatchNumber" id="%{'hiddenBatchNumber' + #data.rowId}"></s:hidden>
									</td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenMfgDate" id="%{'hiddenMfgDate' + #data.rowId}"></s:hidden></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenExpDate" id="%{'hiddenExpDate' + #data.rowId}"></s:hidden></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenExpAlert" id="%{'hiddenExpAlert' + #data.rowId}"></s:hidden></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenExpAlertDate" id="%{'hiddenExpAlertDate' + #data.rowId}"></s:hidden></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenBatchApplicable" id="%{'hiddenBatchApplicable' + #data.rowId}"></s:hidden></td>
							</tr>
					</s:iterator>


						</tbody>
					</table>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> IGST (<span id="igstpercent"></span>)
							</label>
						</div>
						<div class="InputDiv" align="right">
							<s:textfield name="igst" cssClass="InpTextBoxBg" id="igst"
								readOnly="true" theme="simple" style="width:30%;"></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> CGST (<span id="cgstpercent"></span>)
							</label>
						</div>
						<div class="InputDiv" align="right">
							<s:textfield name="cgst" cssClass="InpTextBoxBg" id="cgst"
								readOnly="true" theme="simple" style="width:30%;"></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> SGST (<span id="sgstpercent"></span>)
							</label>
						</div>
						<div class="InputDiv" align="right">
							<s:textfield name="sgst" cssClass="InpTextBoxBg" id="sgst"
								readOnly="true" theme="simple" style="width:30%;"></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Total Amount </label>
						</div>
						<div class="InputDiv" align="right">
							<s:textfield name="totalAmt" value="%{totalAmt}" cssClass="InpTextBoxBg"
								id="totalAmt" style="margin-left: 0px" align="left"
								readOnly="true" theme="simple" style="width:30%"></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<s:set name="statusOrder" value="status"/>
					<s:set name="rejectReasonCase" value="rejectReason"/>
					<s:set name="checkApprovalStage" value="isLastApproval"/>
					
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Narration </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="narration" cssClass="InpTextBoxBg"
								id="narration" theme="simple" title="Enter Narration"></s:textfield>
						</div>
					</div>
					
					<s:if test="%{#rejectReasonCase=='undefined'}">
					<div class="FormMainBox" style="display:none">

						<div class="labelDiv">
							<label> Senior Accountant Return Reason </label>
						</div>
						<div class="InputDiv">
							<s:textfield  value="%{rejectReason}" cssClass="InpTextBoxBg"
								id="narration"  theme="simple" readOnly="true"></s:textfield>
						</div>
					</div>
				</s:if>
				<s:else>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Senior Accountant Return Reason </label>
						</div>
						<div class="InputDiv">
							<s:textfield  value="%{rejectReason}" cssClass="InpTextBoxBg"
								id="narration" theme="simple" readOnly="true"></s:textfield>
						</div>
					</div>
					
				</s:else>
				<div class="FormMainBox">

						<div class="labelDiv">
							<label> Dispatch Document </label>
						</div>
						<div class="InputDiv">
			<a href="javascript:;" onclick="callPictureReport('<s:property value="docPictureDDFileName" />')">VIEW DOCUMENT</a>
						
						</div>
					</div>
					
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Bill-T Document </label>
						</div>
						<div class="InputDiv">
			<a href="javascript:;" onclick="callPictureReport('<s:property value="docPictureTBFileName" />')">VIEW DOCUMENT</a>
						
						</div>
					</div>
					
					
					
				</s:if>

			</div>
			<div class="box_footer" align="right">
				
				<button type="button"  style="margin-left: 0px" class="button" onclick="downloadBill()">Download Bill</button>
				<s:if test="%{#checkApprovalStage=='NO'}">
					
					
					<s:if test="%{#statusOrder=='pending'}">
					<button type="button" align="left"
					style="margin-left: 0px" class="button" onclick="promptPartialSave()">Accept</button>
					<button type="button" align="left"
					style="margin-left: 0px" class="button" onclick="promptReason()">Reject</button>
					</s:if>
					<s:else>
					<s:hidden id="rejectedReason" value="%{rejectReason}"/>
					<button type="button" align="left"
					style="margin-left: 0px;color:red !important;" class="button" onclick="promptRejectedReason()">This Order is already Rejected! Click to view Reason</button>
					</s:else>
					</s:if>
			
			<s:else>
					<s:if test="%{#statusOrder=='pending'}">
					<button type="button" 
					style="margin-left: 0px" class="button" onclick="promptPartialSaveDispatcher()">Accept</button>
					<button type="button" 
					style="margin-left: 0px" class="button" onclick="promptReason()">Reject</button>
					</s:if>
					<s:elseif test="%{#statusOrder=='rejected'}">
					<s:hidden id="rejectedReason" value="%{rejectReason}"/>
					<button type="button" 
					style="margin-left: 0px;color:red !important;" class="button" onclick="promptRejectedReason()">This Order is already Rejected! Click to view Reason</button>
					</s:elseif>
					<s:else>
					<s:if test="%{#statusOrder=='accepted'}">
					<button type="button" 
					style="margin-left: 0px;color:green !important;" class="button">This Order is already Accepted!</button>
					<button type="button"  style="margin-left: 0px" class="button" onclick="downloadBillInvoice()">Download Invoice</button>
					
					</s:if>
					<s:else>
				<button type="button" id="saleBtn"  style="margin-left: 0px" class="button" onclick="checkGodownSelect()">Accept</button>
				<button type="button" id="saleBtn"  style="margin-left: 0px" class="button" onclick="promptReason()">Reject</button>
				<button type="button" id="saleBtn"  style="margin-left: 0px" class="button" onclick="promptReasonReturn()">Return</button>
					
					</s:else>
					
					</s:else>
					
					</s:else>
					<!-- <button type="button" align="left"
					style="margin-left: 0px" class="button" onclick="promptSave()">Return</button> -->
			</div>
			
			<div id="myModal2" class="modal2">

  <!-- Modal content -->
  			<div class="modal-content2">
 			   <button id="closeme1" type="button" class="close1" onclick="closeMeCNAdjust()">SAVE</button>
 			  <div id="bill_by_bill">
						<div class="FormSectionMenu" id="bill_by_bill_div_acc">
							<div class="greyStrip">
								<h4>Bill Wise Details for :	<b><span id="biller_name"></span></b></h4>
							</div>
							<table width="100%" cellspacing="0" align="center"
						id="payTransactionTableBillWise1" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Type of Ref</th>
								<th style="text-align: center;" nowrap="nowrap">Name</th>
								<th style="text-align: center;" nowrap="nowrap">Due Date (limit)</th>
								<th style="text-align: center;" nowrap="nowrap">Amount</th>
								<th style="text-align: center;" nowrap="nowrap">Dr/Cr</th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;" nowrap="nowrap">Delete</th>
								<th style="text-align: center;" nowrap="nowrap">Add</th>
						
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
										cssStyle="width:80%">
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
								<td style="text-align: center;" nowrap="nowrap">
									  <button id="deleteRow1" name="deleteRow" type="button" class="close1" onclick="deleteBillRow(this.id)">&#10006;</button>
								</td>
								<td style="text-align: center;" nowrap="nowrap">
									  <button id="addRow1" name="addRow" type="button" class="close1" onclick="AddBillRow(this.id)">&#10010;</button>
								</td>	
								
							</tr>


						</tbody>
					</table>
						</div>
					</div>
 			 </div>

		</div>
		</s:form>
		<div id="myForm" class="modal">

  <!-- Modal content -->
  			<div class="modal-content">
 			   <button id="closeme" type="button" class="close" onclick="closeDialogue()">&times;</button>
 			  <div id="bill_by_bill">
						<div class="FormSectionMenu" id="bill_by_bill_div_acc">
							<div class="greyStrip">
								<h4>Godown</h4>
							</div>
							<table width="100%" cellspacing="0" align="center"
						id="payTransactionTableBillWise" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Batch No.</th>
								<th style="text-align:center;display:none;" nowrap="nowrap" id="batchTh">Number</th>
								<th style="text-align:center;display:none;" nowrap="nowrap" id="QtyTh">Qty</th>
								<th style="text-align: center;" nowrap="nowrap">Mfg Dt.</th>
								<th style="text-align: center;" nowrap="nowrap">Expiry
											Dt.</th>
								<th style="text-align: center;" nowrap="nowrap">Remind Expiry</th>
								<th style="text-align: center;" nowrap="nowrap">Remind Date</th>
								
						
							</tr>
						</thead>
						<tbody>

							<tr>
								<td style="text-align: center;" nowrap="nowrap">
										
										<select	name="batchList" id="batchList" onchange="showtdfornewNo()">
										
										</select>		
												</td>
										<td  id="batchTd" style="text-align: center;display:none;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="batchNewNo" value="0" id="batchNewNo"
										theme="myTheme" cssStyle="width:50%">
									</ss:textfield></td>
									
									<td id="QtyTd" style="text-align: center;display:none;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="BatchQty" value="0" id="BatchQty"
										theme="myTheme" cssStyle="width:50%">
									</ss:textfield></td>
										<td style="text-align: center;" nowrap="nowrap"><ss:textfield
												name="mfg" cssStyle="width:40%" placeholder="Date" cssClass="dateField"
												id="mfg" readonly="true" theme="myTheme"></ss:textfield></td>
										<td style="text-align: center;" nowrap="nowrap"><ss:textfield
												name="exp" cssStyle="width:40%" placeholder="Date" cssClass="dateField"
												id="exp" readonly="true" theme="myTheme"></ss:textfield></td>
										<td style="text-align: center;" nowrap="nowrap"><s:select
												name="expAlert" id="expAlert"
												list="{'No','Yes'}" cssClass="select1" theme="myTheme"
												cssStyle="width:120px;"/></td>
										<td style="text-align: center;" nowrap="nowrap"><ss:textfield
												name="reminderDate" cssStyle="width:40%" placeholder="Date" cssClass="dateField"
												id="reminderDate" readonly="true" theme="myTheme"></ss:textfield></td>
										
							</tr>


						</tbody>
					</table>
						</div>
					</div>
 			 </div>

		</div>
		
		
		<div id="myModal1" class="modal1">

  <!-- Modal content -->
  			<div class="modal-content1">
 			   <button id="closeme" type="button" class="close" onclick="closeMe()">&times;</button>
 			  <div id="bill_bybill">
						<div class="FormSectionMenu">
							<div class="greyStrip">
								<h4>Document :<b></h4>
							</div>
							<table width="100%" cellspacing="0" align="center">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Document </th>
							</tr>
						</thead>
						<tbody>

							<tr>
								<td style="text-align: center;" nowrap="nowrap"><div id="one"></div></td>
								
							</tr>


						</tbody>
					</table>
						</div>
					</div>
 			 </div>

			</div>
			
			
			
			
			<!-- agst ref bill adjust credit note -->
			
			
			
			<!-- end of this section -->
			
	
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
	
	<script>
if(document.getElementById('partyAcc').value!='none'){
	getCurrentBalance('partyAcc');
	showhideEmployee('Applicable');
	//checkConsignee(document.getElementById('consignee').value);
}

	
</script>
</body>
</html>

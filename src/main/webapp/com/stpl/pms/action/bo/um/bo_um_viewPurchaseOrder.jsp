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
<title>Purchase</title>
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
var CurrentBalance = 0;
var totalTax = 0;
var current_working_table_row_id = 0;
var item_name_val = 0;
var goDownGlobal;
var itemNameGlobal;
var creditLimit = -1;
var limitPopup = false;
var periodResult = false;
var old_cr_dr = "";
var totalTax = ["0","0","0","0","0","0","0","0","0","0","0"];

function checkForOrderStatus(){
	var frm = $('#searchUserFrm');
	 $.ajax({
	        type: 'POST',
	        async: false,
	        url: '/WeaverBO/com/stpl/pms/action/bo/um/bo_um_Bopurchase_order_status.action',
	        data: frm.serialize(),
	        success: function (data) {
	        	if(data=="pending"){
	        		promptSave();
	        	}
	        	else if(data=="reject"){
	        		swal("This order is rejected by your parent user!");
	        	}
	        	else if(data=="accept"){
	        		swal("This order is already processed!");
	        	}
	        	else{
	        		swal("Some Error Occured!");
	        	}
	            
	        },
	        error: function (data) {
	        	swal("Server Error Occured!");
	        },
	    });
}
function promptSave(){
	var frm = $('#searchUserFrm');
	if(limitPopup==false){
		checkForLimitPeriod();
		setTimeout(function(){
			}, 2000);
		if(periodResult==false){
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
	}
	else{
		swal("Credit Limit Amount "+creditLimit+" Exceeded...Please Pay below amount!");
	}
		
    
    
}

function promptReject(){
	var frm = $('#searchUserFrm');
				swal({
					  title: "Are you sure?",
					  text: "Once Reject, you will not be able to undo the data!",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})
					.then((willDelete) => {
					  if (willDelete) {
						  $.ajax({
						        type: frm.attr('method'),
						        url: '/WeaverBO/com/stpl/pms/action/bo/um/bo_um_Bopurchase_create_reject.action',
						        data: frm.serialize(),
						        success: function (data) {
						        	if(data=="success"){
						        		swal("Entry Successfully Rejected..Refreshing for new entry!!!");
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
function checkForLimitPeriod(){
	var partyAccName = document.getElementById('partyAcc').value;
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/bo_um_chech_period_limit_purchase.action?partyName="
			+partyAccName+"&paymentDate="+document.getElementById('paymentDate').value;
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			if(itr=='skip')
				periodResult = false;
			else{
				periodResult = true;
				var arr = itr.split(";");
				var msg ="";
				for(var i=0;i<arr.length;i++){
					msg=msg+arr[i]+"\n";
				}
				swal("Following Bills are pending..Please Pay First Before New Sale!"+"\n"+msg);
					
			}
			
		},

		error : function(itr) {

		}
	});
}
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
				$("#mfg").datepicker("option", "minDate", selectedDate);
			} else {
				var date = new Date().getDate();
				$(function() {
					$("#mfg").datepicker({
						dateFormat : 'yy-mm-dd'
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
			$("#reminderDate").datepicker("option", "minDate", selectedDate);
		} else {
			var date = new Date().getDate();
			$(function() {
				$("#reminderDate").datepicker({
					dateFormat : 'yy-mm-dd'
				}).datepicker("setDate", date);
			});
		}
	}
});
	$("#exp").datetimepicker({
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
				$("#exp").datepicker("option", "minDate", selectedDate);
			} else {
				var date = new Date().getDate();
				$(function() {
					$("#exp").datepicker({
						dateFormat : 'yy-mm-dd'
					}).datepicker("setDate", date);
				});
			}
		}
	});
	
});
	function getTaxes(id){
		var idNum = id.match(/\d/g);
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
function reflectCurrentBalance(){
		
		var currBal = Number(document.getElementById('currBalance').value);
		var blncType= old_cr_dr;
		var totAmt = Number(document.getElementById('totalAmt').value);
		
		if(blncType=="Cr"){
			var bal = currBal+totAmt;
			document.getElementById('currBalance').value = bal;
		}
		else{
			var bal = currBal-totAmt;
			if(Number(bal)<0){
				bal = bal*(-1);
				document.getElementById('hcrdr').value = 'Cr';
				document.getElementById('crdr').innerHTML  = 'Cr';
				document.getElementById('currBalance').value = bal;
			}
			else{
				document.getElementById('hcrdr').value = 'Dr';
				document.getElementById('crdr').innerHTML  = 'Dr';
				document.getElementById('currBalance').value = bal;
		
			}

		}
		
		var limitchk = Number(document.getElementById('currBalance').value);
		if(creditLimit!='Not Specified' && Number(creditLimit)!=-1 && limitchk>creditLimit){
			limitPopup = true;
		}
		else{
			limitPopup = false;
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
function getItemRateIfStandardCheck(id) {
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_sales_item_rate.action?itemName="
			+ document.getElementById(id).value;
	var res = id.match(/\d/g);
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			
			document.getElementById('rate' + res).value = itr;
		},

		error : function(itr) {

		}
	});
}
	function callForMoreRow(id) {
		var res = id.match(/\d/g);
		if (document.getElementById('salesStockItems' + res).value != "-1") {
			
			getUnitByItem(id);
			getItemRateIfStandardCheck(id);
			//getTotalQty(id);
			getTaxes(id);
			document.getElementById('rate'+res).readOnly = false;
			document.getElementById('Qty'+res).readOnly = false;
			//adjustTotalAmount(id);
					
		}
		else{
			document.getElementById('Qty'+res).value = '0';
			document.getElementById('rate'+res).value = '0';
			document.getElementById('amount'+res).value = '0';
			document.getElementById('unit'+res).value = '';
			document.getElementById('rate'+res).readOnly = true;
			document.getElementById('Qty'+res).readOnly = true;
			getTaxes1(id,'adjust');
			
		}
		
	}
	

	function callForSweetAlertPopUp(id){
		
		 document.getElementById("myForm").style.display = "block";
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
	
	function getUnitByItem(id) {
		var res = id.match(/\d/g);
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_sales.action?var="
				+ document.getElementById('salesStockItems'+res).value;
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
	function getTotalQty(id){
		var res = id.match(/\d/g);
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_totalQtyPuchase.action?itemName="
				+ document.getElementById('salesStockItems'+res).value;
		
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
	function showGodownQty(id){
		var myurl = "<%=basePath%>";
		var res = id.match(/\d/g);
		current_working_table_row_id = res;
		var itemName = document.getElementById('salesStockItems'+res).value;
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_availableQtyPuchase.action?goDown="
				+ document.getElementById(id).value+"&itemName="+itemName;
		var res = id.match(/\d/g);
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

	function adjustTotalAmount(id) {
		var finalAmount = 0;
		var oldCurrBlnc = CurrentBalance;
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
		if(blnc_type=='Dr'){
			var curBlnc = Number(document.getElementById('totalAmt').value) - Number(CurrentBalance);
			if(curBlnc<0)
			curBlnc = curBlnc * (-1);
		document.getElementById('currBalance').value = curBlnc;
		if(oldCurrBlnc < Number(document.getElementById('totalAmt').value)){
			document.getElementById('hcrdr').value='Cr'
				document.getElementById('crdr').innerHTML='Cr'
		}
		else{
			document.getElementById('hcrdr').value='Dr'
				document.getElementById('crdr').innerHTML='Dr'
		}
		}
		else{
			var curBlnc = Number(document.getElementById('totalAmt').value) + Number(CurrentBalance);
			document.getElementById('currBalance').value = curBlnc;
		}
		var limitchk = Number(document.getElementById('currBalance').value);
		if(creditLimit!='Not Specified' && Number(creditLimit)!=-1 && limitchk>creditLimit && document.getElementById('hcrdr').value=='Cr' ){
			limitPopup = true;
		}
		else{
			limitPopup = false;
		}
	}
	function calAmount(id) {
		
		var res = id.match(/\d/g);
		var qty = document.getElementById('Qty' + res).value;
		var rate = document.getElementById('rate' + res).value;
		document.getElementById('amount' + res).value = qty * rate;
		getUnitByItem(id);
		getTotalQty(id);
		getTaxesOnChange(id);
		
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
				getCreditLimit(id);
			},
			error : function(itr) {

			}
		});
	}
	function getCreditLimit(id){
		var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_credit_limit.action?partyAcc="
				+ document.getElementById(id).value;
		var res = id.match(/\d/g);
		$.ajax({
			type : "GET",
			url : myurl,
			success : function(itr) {
				if(itr=="-1")
				document.getElementById('creditLimit').value = 'Not Specified';
				else if(itr!="Not Specified"){
					creditLimit = Number(itr);
					document.getElementById('creditLimit').value = itr;
				}
				else{
					document.getElementById('creditLimit').value = 'Not Specified';
				}
				getUnitByItem1(id,'val');
				getTotalQty1(id,'val');
				reflectCurrentBalance();	
				
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
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Purchase
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Purchase</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_Bopurchase_create.action"
			id="searchUserFrm" theme="simple" method="POST" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Purchase No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="purchaseNoVoucher" name="purchaseNoVoucher" value="%{purchaseNoVoucher}"
								theme="myTheme" cssStyle="width:30%" />
							<s:textfield id="purchaseNo" name="purchaseNo"
								value="%{purchaseNo}" theme="myTheme" readonly="true"
								cssStyle="width:10%;display:none" />
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
							<s:textfield id="orderNo" name="orderNo" value="%{orderNo}" theme="myTheme"
								readonly="true" cssStyle="width:10%" />
						</div>
					</div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Supplier Invoice No.:</font></b>
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
							<s:select name="partyAcc" headerKey="none" id="partyAcc"
								headerValue="--Please Select--" list="partyAccName"
								cssClass="select1" theme="myTheme" value="%{partyAccNamePO}"
								onchange="getCurrentBalance(this.id)" />
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Assign Employee </label>
						</div>
						<div class="InputDiv">
							<s:select name="isEmployee" headerKey="-1" id="isEmployee"
								headerValue="--Please Select--"
								list="{'Applicable','Not Applicable'}"
								onchange="showhideEmployee(this.value)" cssClass="select1"
								theme="myTheme" />
						</div>
					</div>
					<div id="showEmployeeDiv" style="display: none;">
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
							<label>Purchase Ledger</label>
						</div>
						<div class="InputDiv">
							<s:select name="salesAccount" headerKey="none" id="salesAccount"
								headerValue="--Please Select--" list="salesAccountList"
								cssClass="select1" theme="myTheme" />
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
							<s:hidden name="partyOldBalance" id="partyOldBalance"></s:hidden>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Credit Limit </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="creditLimit" id="creditLimit" value="0"
								theme="myTheme" readonly="true" cssStyle="width:20%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Dispatch Doc No. </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="ddn" id="ddn"
								theme="myTheme" cssStyle="width:50%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Transport Name </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="tn" id="tn"
								theme="myTheme" cssStyle="width:50%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Destination </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="des" id="des" 
								theme="myTheme" cssStyle="width:50%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Bill-T No.</label>
						</div>
						<div class="InputDiv">
							<s:textfield name="billt" id="billt" 
								theme="myTheme"  cssStyle="width:50%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Vehical No. </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="vn" id="vn"
								theme="myTheme" cssStyle="width:50%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Transport freight </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="transportFreight" id="transportFreight"
								theme="myTheme" cssStyle="width:50%" />
						</div>
					</div>
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
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" id="%{'salesStockItems' + #data.rowId}" value="#data.itemName"
										list="salesStockItemList" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;" onchange="getUnitByItem(this.id)" /></td>
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
										pattern="^[0-9.]*$"
										onfocusout="calAmount(this.id)" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate" value="%{#data.itemRate}" id="%{'rate' + #data.rowId}"
										theme="myTheme" pattern="^[0-9.]*$"
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
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Narration </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="narration" value="%{narration}" cssClass="InpTextBoxBg"
								id="narration" theme="simple" title="Enter Narration"></s:textfield>
						</div>
					</div>
					
					
					
				</s:if>

			</div>
			<div class="box_footer" align="right">
				
				<!-- <input type="submit" value='Create' align="left"
					style="margin-left: 0px" class="button" /> -->
						<button type="button" id="saleBtn" align="left" style="margin-left: 0px" class="button" onclick="checkForOrderStatus()">Accept</button>
				<button type="button" id="saleBtn" align="left" style="margin-left: 0px" class="button" onclick="promptReject()">Reject</button>
			
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
			
			
			
			<%-- <div class="form-popup" id="myForm">
						<div class="form-container">
							<table width="100%" cellspacing="0" align="center"
								id="payTransactionTable" class="transactionTable">
								<thead>
									<tr>
										<th style="text-align: center;" nowrap="nowrap">Batch No.</th>
										<th id="batchTh" style="text-align:center;display:none;" nowrap="nowrap">Number</th>
										<th id="QtyTh" style="text-align:center;display:none;" nowrap="nowrap">Qty</th>			
										<th style="text-align: center;" nowrap="nowrap">Mfg Dt.</th>
										<th style="text-align: center;" nowrap="nowrap">Expiry
											Dt.</th>
										<th style="text-align: center;" nowrap="nowrap">Remind Expiry</th>
											<th></th>
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
										<td><input type="button" value='close' align="left"
											style="margin-left: 0px" class="button" onclick="closeDialogue()"/></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>	 --%>	
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
	<script>
if(document.getElementById('partyAcc').value!='none'){
	getCurrentBalance('partyAcc');
}
	
</script>
</body>

</html>

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
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

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
<title>Sales</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
var totalTax = 0;
var CurrentBalance = 0;
var current_working_table_row_id = 0;
var old_cr_dr = "";
var item_name_val = 0;
var goDownGlobal;
var itemNameGlobal;
var creditLimit = -1;
var limitPopup = false;
var periodResult = false;
var totalTax = ["0","0","0","0","0","0","0","0","0","0","0"];


function checkForOrderStatus(){
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
			        type: 'POST',
			        async: false,
			        url: '/WeaverBO/com/stpl/pms/action/bo/um/bo_um_Bosale_order_status.action',
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
			  
		  } else {
		    swal("Please Refresh The Page!");
		   
		  }
		});
}

function downloadBill(){
	
	var myurl = "<%=basePath%>";
	
	var frm = $('#searchUserFrm');
	
	myurl += "/com/stpl/pms/action/bo/um/generate_txn_sales_bill_pdf_document.action";
	$.ajax({
        type: frm.attr('method'),
        url: myurl,
        async:false,
        data: frm.serialize(),
        success: function (data) {
        
        		swal("Bill Generated Successfully!!!");
        		var link=document.createElement('a');
        		document.body.appendChild(link);
        		link.href=data ;
        		link.click();
        		  
        },
        error: function (data) {
        	swal("Server Error Occured!");
        },
    });
	
}
function promptSave(){
	var frm = $('#searchUserFrm');
	let photo = document.getElementById("docPictureDD").files[0];
	let photo1 = document.getElementById("docPictureTB").files[0];
	let formData = new FormData();
	if(photo!=undefined)
		formData.append("docPictureDD", photo);
		if(photo1!=undefined)
		formData.append("docPictureTB", photo1);
		
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/upload_sales_txn_document.action?salesNoVoucher="+document.getElementById('salesNoVoucher').value+"&activeVoucherNumber="+document.getElementById('activeVoucherNumber').value;
	
		if(limitPopup==false){
			checkForLimitPeriod();
			
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
						        async:false,
						        data: frm.serialize(),
						        success: function (data) {
						        	if(data=="success"){
						        		swal("Entry Successfully Saved..Refreshing for new entry!!!");
						        		$.ajax({
									        type: 'POST',
									        url: myurl,
									        data: formData,
									        async:false,
									        cache : false,
											contentType : false,
											processData : false,
									        success: function (data) {
									        	
									        	downloadBill();
									        },
									        error: function (data) {
									        	downloadBill();
									        },
									    });
						        	
						        		setTimeout(function(){
						        			   window.location.reload(1);
						        			}, 2000);
						        		
						        	}
						        	else if(data=="block"){
						        		
						        		swal("This party is blocked! Please contact your admin");
						        		setTimeout(function(){
						        			   window.location.reload(1);
						        			}, 2000);
						        	}
						        	else if(data=="date"){
						        		swal("Error! Sale date is greater or less than voucher end date.");
						        		setTimeout(function(){
						        			   window.location.reload(1);
						        			}, 2000);
						        	}
						        	else{
						        		swal("Error! Please fill all details (date or godown).");
						        		setTimeout(function(){
						        			   window.location.reload(1);
						        			}, 2000);
						        	}
						            
						        },
						        error: function (data) {
						        	swal("Server Error Occured!");
						        	setTimeout(function(){
					        			   window.location.reload(1);
					        			}, 2000);
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
						        url: '/WeaverBO/com/stpl/pms/action/bo/um/bo_um_Bosale_create_reject.action',
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
function showSuperCashPopUp(){
	 document.getElementById("supercashmarque").style.display = "none";
	swal({
		  title: "Is SuperCash Sale?",
		  text: "Once submit, your item rate will be supercash eligible!",
		  icon: "success",
		  closeOnClickOutside: false,
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
			  document.getElementById('superCashEligible').value ="yes";
			  swal("Wonderful your bill is supercash eligible now!");
			  document.getElementById("supercashmarque").style.display = "block";
		  } 
		});
	
	
}
function getSecurityAmt(id){
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_security_balance.action?partyAcc="
			+ document.getElementById(id).value;
	var res = id.match(/\d/g);
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			document.getElementById('secuityAmt').value = itr;
			showSuperCashPopUp();
			
		},

		error : function(itr) {

		}
	});
}
function checkForLimitPeriod(){
	var partyAccName = document.getElementById('partyAcc').value;
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/bo_um_chech_period_limit.action?partyName="
			+partyAccName+"&paymentDate="+document.getElementById('paymentDate').value;
	$.ajax({
		type : "GET",
		url : myurl,
		async:false,
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

$(document).ready(function() {
	/* $("#mfg").datetimepicker({
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
	}); */
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
	/* $("#exp").datetimepicker({
		dateFormat : 'yy-mm-dd',
		showSecond : false,
		showMinute : false,
		showHour : false,
		changeYear : true,
		changeMonth : true,
		minDate : '1930-01-01',
		startDate: '1980-01-01',
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
	}); */
	
});
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
function closeDialogue(){
	var batch = document.getElementById('batchNewNo').value;
	var mfg = document.getElementById('mfg').value;
	var exp = document.getElementById('exp').value;
	
	document.getElementById('hiddenBatchNumber'+current_working_table_row_id).value = batch;
	document.getElementById('hiddenMfgDate'+current_working_table_row_id).value = mfg;
	document.getElementById('hiddenExpDate'+current_working_table_row_id).value = exp;
	document.getElementById("myForm").style.display = "none";
}
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
				totalTax[idNum] = document.getElementById('igst').value;
				document.getElementById('igstItemAmt'+idNum).value = document.getElementById('igst').value;
			}
			else{
				document.getElementById('igstpercent').innerHTML = "0%";
				document.getElementById('igst').value="0";
				document.getElementById('cgstpercent').innerHTML = "0%";
				document.getElementById('cgst').value="0";
				document.getElementById('sgstpercent').innerHTML = "0%";
				document.getElementById('sgst').value="0";
				totalTax[idNum] = document.getElementById('igst').value;
				document.getElementById('igstItemAmt'+idNum).value = document.getElementById('igst').value;
				
			}
			adjustTotalAmount('none');
		},

		error : function(itr) {

		}
	});
	
}
function getTaxesOnChange(id){
	var idNum = id.match(/\d/g);
	var myurl1 = "<%=basePath%>";
	var rowCnt = countTotalRows();
	for(var i=1;i<=rowCnt;i++){
		var itemName = document.getElementById('salesStockItems'+i).value;
		if(itemName!="-1"){
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
					document.getElementById('igstItem'+i).value = res[0]+" %"
					document.getElementById('igstItemAmt'+i).value = tx;
				}
				else{
					totalTax[i] = "0";
					document.getElementById('igstItem'+i).value = "0 %";
					document.getElementById('igstItemAmt'+i).value = "0";
					
				}
				
			},

			error : function(itr) {

			}
		});
		
	}
	}
	adjustTotalAmount('none');
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
				if(!arr[i].includes("New Number"))
				myoption+="<option>" +arr[i] + "</option>";
			}
			document.getElementById("batchList").innerHTML = myoption;
		},

		error : function(itr) {

		}
	});
}
function getItemRateIfStandardCheck(id) {
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_sales_item_rate.action?itemName="
			+ document.getElementById(id).value+"&isSuperCash="+document.getElementById('superCashEligible').value;
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
			getTotalQty(id);
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
				checkForBatchApplicable(id);
				
				
			},

			error : function(itr) {

			}
		});
	}
	
	function checkForBatchApplicable(id){
		var res = id.match(/\d/g);
		var myurl = "<%=basePath%>";
		var itemName = document.getElementById('salesStockItems'+res).value;
		myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_batch_applicable.action?itemName="+itemName;
	$.ajax({
		type : "GET",
		url : myurl,
		async:false,
		success : function(itr) {
			if(itr=="Yes"){
				document.getElementById('hiddenBatchApplicable'+res).value="Yes";
				showBatchesPopup(id);
				callForSweetAlertPopUp(id);
			}
			else{
				
				document.getElementById('hiddenBatchApplicable'+res).value="No";
			}
			
		},

		error : function(itr) {

		}
	});
	}
	function callForSweetAlertPopUp(id){
		
		 document.getElementById("myForm").style.display = "block";
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
function getAlterUnit1(id,val) {
	
	var totalRow = countTotalRows();
	var myurl1="<%=basePath%>";
	for(var i=1;i<=totalRow;){
		myurl = myurl1+"/com/stpl/pms/action/bo/um/bo_um_tm_get_alter_unit.action?var="
			+ document.getElementById('salesStockItems'+i).value;
	var res = id.match(/\d/g);
	$.ajax({
		type : "GET",
		async: false,
		url : myurl,
		success : function(itr) {
			if(itr.includes(";")){
				var arr = itr.split(";");
				var unit1 = arr[0];
				var unit2 = arr[2];
				var qty = document.getElementById('Qty'+i).value;
				var finalQt = (Number(unit1)*Number(qty))/Number(unit2);
				document.getElementById('Alunit' + i).value = finalQt.toFixed(1)+' '+arr[1];
			}
			
			
		},

		error : function(itr) {

		}
	});
	i++;
	}
		
}
function getAlterUnit(id) {
	var res = id.match(/\d/g);
	var myurl1="<%=basePath%>";
		myurl = myurl1+"/com/stpl/pms/action/bo/um/bo_um_tm_get_alter_unit.action?var="
			+ document.getElementById('salesStockItems'+res).value;
	
	$.ajax({
		type : "GET",
		async: false,
		url : myurl,
		success : function(itr) {
			if(itr.includes(";")){
				var arr = itr.split(";");
				var unit1 = arr[0];
				var unit2 = arr[2];
				var qty = document.getElementById('Qty'+res).value;
				var finalQt = (Number(unit1)*Number(qty))/Number(unit2);
				document.getElementById('Alunit' + res).value = finalQt.toFixed(1)+' '+arr[1];
			}
			
		},

		error : function(itr) {

		}
	});
	
		
}
function getUnitByItem(id) {
	var res = id.match(/\d/g);
	var myurl="<%=basePath%>";
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
		var oldCurrBlnc = CurrentBalance;
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
		
		if(blnc_type=='Cr'){
			var curBlnc = Number(document.getElementById('totalAmt').value) - Number(CurrentBalance);
			if(curBlnc<0)
			curBlnc = curBlnc * (-1);
		document.getElementById('currBalance').value = curBlnc;
		if(oldCurrBlnc < Number(document.getElementById('totalAmt').value)){
			document.getElementById('hcrdr').value='Dr'
				document.getElementById('crdr').innerHTML='Dr'
		}
		else{
			document.getElementById('hcrdr').value='Cr'
				document.getElementById('crdr').innerHTML='Cr'
		}
		}
		else{
			var curBlnc = Number(document.getElementById('totalAmt').value) + Number(CurrentBalance);
			document.getElementById('currBalance').value = curBlnc;
		}
		
		//document.getElementById('currBalance').value = Number(CurrentBalance)+(finalAmount+Number(totalTax));
		var limitchk = Number(document.getElementById('currBalance').value);
		if(creditLimit!='Not Specified' && Number(creditLimit)!=-1 && limitchk>creditLimit && document.getElementById('hcrdr').value=='Dr' ){
			limitPopup = true;
		}
		else{
			limitPopup = false;
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
			async:false,
			success : function(itr) {
				var arr = itr.split(","); 
				document.getElementById('currBalance').value = arr[0];
				document.getElementById('partyOldBalance').value = arr[0]+" "+arr[1];
				document.getElementById('crdr').innerHTML = arr[1];
				CurrentBalance = arr[0];
				document.getElementById('hcrdr').value = arr[1];
				old_cr_dr = arr[1];
				$("#payTransactionTable").css("display", "block");
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
			async:false,
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
				getSecurityAmt(id);
				/* getUnitByItem1(id,'val');
				
				getTotalQty1(id,'val');
				reflectCurrentBalance(); */
			},
			error : function(itr) {

			}
		});
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
		
		var limitchk = Number(document.getElementById('currBalance').value);
		if(creditLimit!='Not Specified' && Number(creditLimit)!=-1 && limitchk>creditLimit){
			limitPopup = true;
		}
		else{
			limitPopup = false;
		}
		
		getTaxes1('id','val');
	}
	function calAmount(id) {
		var res = id.match(/\d/g);
		var qty = document.getElementById('Qty' + res).value;
		var rate = document.getElementById('rate' + res).value;
		document.getElementById('amount' + res).value = qty * rate;
		getUnitByItem(id);
		getAlterUnit(id);
		getTaxesOnChange(id);
	}
	
	function showhideEmployee(data) {
		$("#showEmployeeDiv").css("display", "none");
		if (data == "Applicable") {
			$("#showEmployeeDiv").css("display", "block");
		}
	}
	function checkConsignee(val){
		$("#consigneeDiv").css("display", "none");
		if(val=="Yes"){
			$("#consigneeDiv").css("display", "block");
		}
		
	}
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
	function redirectLedgerCreate(){
		
		var myurl = "<%=path%>";
		var myurlRedirect = "<%=path%>";
		myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_createLedger.action";
		window.location.href = myurlRedirect;
	}
	function redirectItemCreate(){
		
		var myurl = "<%=path%>";
		var myurlRedirect = "<%=path%>";
		myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_createStockItem.action";
		window.location.href = myurlRedirect;
	}
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Sales
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Sales</h4>
		</div>
		<s:form action="/com/stpl/pms/action/bo/um/bo_um_Bosale_create.action"
			id="searchUserFrm" theme="simple" method="POST" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Sales No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
								<s:textfield id="salesNoVoucher" name="salesNoVoucher" value="%{salesNoVoucher}"
								theme="myTheme" cssStyle="width:30%" />
							<s:textfield id="salesNo" name="salesNo" value="%{salesNo}"
								theme="myTheme" readonly="true" cssStyle="width:10%;display:none" />
								<s:textfield id="activeVoucherNumber" name="activeVoucherNumber" value="%{activeVoucherNumber}"
								theme="myTheme" readonly="true" cssStyle="width:10%;display:none" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox" style="display:none">

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
							<label> <b><font color='red'>Reference No.:</font></b>
							</label>
						</div>
						
						<div class="InputDivHalf">
						
							<s:textfield id="referenceNo" name="referenceNo" theme="myTheme"
								cssStyle="width:10%" />
						</div>
						<div class="labelDiv">
							<label> <b><font color='green'>Set Default OverDue Reminder</font></b>
							</label>
						</div>
						<div class="InputDivHalf">
						
						
							<s:checkbox name="checkOverDueRem" fieldValue="true" value="true" label="Set Default OverDue Reminder"/>
							<s:hidden id="superCashEligible" name="superCashEligible" value="no"></s:hidden>
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
							<s:select name="partyAcc" headerKey="none" id="partyAcc" value="%{partyAccNameSO}"
								headerValue="--Please Select--" list="partyAccName"
								cssClass="select1" theme="myTheme" onchange="getCurrentBalance(this.id)"/>
							<a href="javascript:;" style='font-size:30px;' onclick="redirectLedgerCreate()">&#43;</a>
						</div>
						
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Is Consignee </label>
						</div>
						<div class="InputDiv">
							<s:select name="consignee" headerKey="none" id="consignee"
								headerValue="--Please Select--" list="{'No','Yes'}"
								cssClass="select1" theme="myTheme" onchange="checkConsignee(this.value)"/>
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
										maxlength="50" name="Dname"
										theme="myTheme"
										cssStyle="width:90%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="50" name="propName"
										theme="myTheme"
										cssStyle="width:90%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="contact"
										theme="myTheme"
										cssStyle="width:80%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="address"
										theme="myTheme"
										cssStyle="width:100%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="50" name="gstnNo"
										theme="myTheme"
										cssStyle="width:90%">
									</ss:textfield></td>
									

							</tr>
					
							


						</tbody>
					</table>
					</div>
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
							<label>Sales Ledger</label>
						</div>
						<div class="InputDiv">
							<s:select name="salesAccount" headerKey="none" id="salesAccount"
								headerValue="--Please Select--" list="salesAccountList"
								cssClass="select1" theme="myTheme" />
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<table width="100%" cellspacing="0" align="center"
					class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Current Balance</th>
								<th style="text-align: center;" nowrap="nowrap">Security Amount</th>
								<th style="text-align: center;" nowrap="nowrap">Credit Limit</th>
							</tr>
						</thead>
						<tbody>
					
					<tr>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="currBalance" id="currBalance" value="0"
								theme="myTheme" readonly="true" cssStyle="width:60%;text-align: center;" />
								<span id="crdr"></span>
								<s:hidden name="hcrdr" id="hcrdr"></s:hidden>
								<s:hidden name="partyOldBalance" id="partyOldBalance"></s:hidden>
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="secuityAmt" id="secuityAmt" value="0"
								theme="myTheme" readonly="true" cssStyle="width:60%;text-align: center;" />
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="creditLimit" id="creditLimit" value="0"
								theme="myTheme" readonly="true" cssStyle="width:60%;text-align: center;" />
								</td>
					
							</tr>
					
						</tbody>
					</table>
					
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
								<s:textfield name="ddn" id="ddn"
								theme="myTheme" cssStyle="width:40%" />
					<s:file label="upload" applyscript="true" onmouseout="validateFile(this,'docPicture')" id="docPictureTB" name="docPictureTB" cssClass="textfield" theme="myTheme"></s:file>
								
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="tn" id="tn"
								theme="myTheme" cssStyle="width:50%" />
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="des" id="des" 
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
								theme="myTheme"  cssStyle="width:40%" />
			<s:file label="upload" applyscript="true" onmouseout="validateFile(this,'docPicture')" id="docPictureDD" name="docPictureDD" cssClass="textfield" theme="myTheme"></s:file>
								
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="vn" id="vn"
								theme="myTheme" cssStyle="width:50%" />
								</td>
								
								<td style="text-align: center;" nowrap="nowrap">
								<s:textfield name="transportFreight" id="transportFreight"
								theme="myTheme" value="0" cssStyle="width:50%" />
								</td>
									
							</tr>

						</tbody>
					</table>
					
					
					<br />
					<marquee width="60%" direction="right" height="30px" style="display:none;" id="supercashmarque">
						<font color="green">Superb! You have selected SUPERCASH Sale.</font>
				</marquee>
					<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable" class="transactionTable" style="display:none;">
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
								<th style="text-align: center;" nowrap="nowrap">Alt. unit</th>
								<th style="text-align: center;" nowrap="nowrap">Amount</th>
								<th style="text-align: center;" nowrap="nowrap">IGST</th>
									<th style="text-align: center;" nowrap="nowrap">Tax Amount</th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
								<th style="text-align: center;display:none;" nowrap="nowrap"></th>
							</tr>
						</thead>
						<tbody>
					<s:iterator begin="1" end="10" status="data">
					<tr id="rowId<s:property value="#data.count"/>">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" id="%{'salesStockItems' + #data.count}" value="#data.itemName"
										list="salesStockItemList" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;" onchange="callForMoreRow(this.id)" /><a href="javascript:;" style='font-size:20px;' onclick="redirectItemCreate()">&#43;</a></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="%{'totalQty' + #data.count}"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="Please Select"
										name="goDown" id="%{'goDown' + #data.count}" onchange="showGodownQty(this.id)"
										list="goDownList" cssClass="select1" theme="myTheme"
										cssStyle="width:100px;" /></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="godownQty" readOnly="true" value="0" id="%{'godownQty' + #data.count}" theme="myTheme"
										 cssStyle="width:90%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" value="%{#data.itemQty}" id="%{'Qty' + #data.count}" theme="myTheme"
										pattern="^[0-9.]*$"
										onfocusout="calAmount(this.id)" cssStyle="width:80%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate" value="%{#data.itemRate}" id="%{'rate' + #data.count}"
										theme="myTheme" pattern="^[0-9.]*$"
										onfocusout="calAmount(this.id)" cssStyle="width:80%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="%{'unit' + #data.count}"
										theme="myTheme" readOnly="true" cssStyle="width:80%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="Alunit" value="" id="%{'Alunit' + #data.count}"
										theme="myTheme" readOnly="true" cssStyle="width:80%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="%{#data.itemAmount}" id="%{'amount' + #data.count}"
										theme="myTheme" readOnly="true"
										cssStyle="width:90%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="igstItem" value="0" id="%{'igstItem' + #data.count}"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="igstItemAmt" value="0" id="%{'igstItemAmt' + #data.count}"
										theme="myTheme" readOnly="true"
										cssStyle="width:80%">
									</ss:textfield></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenBatchNumber" id="%{'hiddenBatchNumber' + #data.count}"></s:hidden>
									</td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenMfgDate" id="%{'hiddenMfgDate' + #data.count}"></s:hidden></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenExpDate" id="%{'hiddenExpDate' + #data.count}"></s:hidden></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenExpAlert" id="%{'hiddenExpAlert' + #data.count}"></s:hidden></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenExpAlertDate" id="%{'hiddenExpAlertDate' + #data.count}"></s:hidden></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
									<s:hidden name="hiddenBatchApplicable" id="%{'hiddenBatchApplicable' + #data.count}"></s:hidden></td>

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
			<!-- 	<input type="submit" id="saleBtn" value='Create' align="left"
					style="margin-left: 0px" class="button" /> -->
				<button type="button" id="saleBtn" align="left" style="margin-left: 0px" class="button" onclick="promptSave()">Save</button>
				<!--  <button type="button" id="saleBtn" align="left" style="margin-left: 0px" class="button" onclick="promptReject()">Reject</button>-->
				
			</div>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		</s:form>
		
		<div id="myForm" class="modal">

  <!-- Modal content -->
  			<div class="modal-content">
 			   
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
								<th style="text-align: center; display:none;" nowrap="nowrap">Remind Expiry</th>
								<th style="text-align: center; display:none;" nowrap="nowrap">Remind Date</th>
								<th></th>
						
							</tr>
						</thead>
						<tbody>

							<tr>
								<td style="text-align: center;" nowrap="nowrap">
										
										<select	name="batchList" id="batchList" onchange="showtdfornewNo()">
										
										</select>		
												</td>
										<td  id="batchTd" style="text-align: center;display:none;" nowrap="nowrap">
										<ss:textfield
										maxlength="30" name="batchNewNo" value="0" id="batchNewNo"
										theme="myTheme" cssStyle="width:50%">
									</ss:textfield></td>
									
									<td id="QtyTd" style="text-align:center;display:none;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="BatchQty" value="0" id="BatchQty"
										theme="myTheme" cssStyle="width:50%">
									</ss:textfield></td>
										<td style="text-align: center;" nowrap="nowrap"><ss:textfield
												name="mfg" cssStyle="width:40%" placeholder="Date" cssClass="dateField"
												id="mfg" readonly="true" theme="myTheme"></ss:textfield></td>
										<td style="text-align: center;" nowrap="nowrap"><ss:textfield
												name="exp" cssStyle="width:40%" placeholder="Date" cssClass="dateField"
												id="exp" readonly="true" theme="myTheme"></ss:textfield></td>
										<td style="text-align: center; display:none;" nowrap="nowrap"><s:select
												name="expAlert" id="expAlert"
												list="{'No','Yes'}" cssClass="select1" theme="myTheme"
												cssStyle="width:120px;"/></td>
										<td style="text-align: center; display:none;" nowrap="nowrap"><ss:textfield
												name="reminderDate" cssStyle="width:40%" placeholder="Date" cssClass="dateField"
												id="reminderDate" readonly="true" theme="myTheme"></ss:textfield></td>
									<td><button id="closeme" type="button" class="close" onclick="closeDialogue()">SAVE</button></td>		
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


	
</script>
</body>
</html>

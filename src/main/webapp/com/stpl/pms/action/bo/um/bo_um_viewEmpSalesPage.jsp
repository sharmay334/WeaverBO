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
var totalTax = ["0","0","0","0","0","0","0","0","0","0","0"];
var CurrentBalance = 0;
var old_cr_dr = "";
var current_working_table_row_id = 0;
var item_name_val = 0;
var goDownGlobal;
var itemNameGlobal;
var creditLimit = -1;
var limitPopup = false;
var periodResult = false;

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
	myurl += "/com/stpl/pms/action/bo/um/upload_sales_order_document.action?salesNo="+document.getElementById('salesNo').value;
	
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
						        async:false,
						        url: frm.attr('action'),
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
			
			
		}
		else{
			swal("Credit Limit Amount "+creditLimit+" Exceeded...Please Pay below amount!");
			setTimeout(function(){
 			   window.location.reload(1);
 			}, 1000);
		}
		
    
    
}
function validateFile(fileName, id) {
	var file = fileName.value;
	var ext = file.substring(file.length, file.length - 3);
	if (file != "") {
		if (ext != "png" && ext != "jpg" && ext != "jpeg" && ext != "peg" && ext != "jpe" && ext != "doc"
				&& ext != "docx" && ext != "pdf") {
			document.getElementById(id).value = "";
			alert('only image,pdf or doc file is allowed!');
		}
	}

}
function checkForLimitPeriod(){
	var partyAccName = document.getElementById('partyAcc').value;
	var myurl = "<%=basePath%>";
	myurl += "/com/stpl/pms/action/bo/um/bo_um_chech_period_limit.action?partyName="
			+partyAccName+"&paymentDate="+document.getElementById('paymentDate').value;
	$.ajax({
		type : "GET",
		async:false,
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

$(document).ready(function() {
	$("#mfg").datetimepicker({
		dateFormat : 'yy-mm-dd',
		showSecond : false,
		showMinute : false,
		showHour : false,
		changeYear : true,
		changeMonth : true,
		changeDate : true,
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
		changeDate : true,
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
	changeDate : true,
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
		changeDate : true,
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
	});
	
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
		async:false,
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
			}
			else{
				document.getElementById('igstpercent').innerHTML = "0%";
				document.getElementById('igst').value="0";
				document.getElementById('cgstpercent').innerHTML = "0%";
				document.getElementById('cgst').value="0";
				document.getElementById('sgstpercent').innerHTML = "0%";
				document.getElementById('sgst').value="0";
				totalTax[idNum] = document.getElementById('igst').value;
			}
		},

		error : function(itr) {

		}
	});
	
}
function getTaxes1(id,val){
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
				totalTax[idNum] = document.getElementById('igst').value;
			}
			else{
				document.getElementById('igstpercent').innerHTML = "0%";
				document.getElementById('igst').value="0";
				document.getElementById('cgstpercent').innerHTML = "0%";
				document.getElementById('cgst').value="0";
				document.getElementById('sgstpercent').innerHTML = "0%";
				document.getElementById('sgst').value="0";
				totalTax[idNum] = document.getElementById('igst').value;
			}
			adjustTotalAmount(id);
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
	function showGodownQty(id){
		var myurl = "<%=basePath%>";
		var res = id.match(/\d/g);
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
	function callForSweetAlertPopUp(id){
		
		 document.getElementById("myForm").style.display = "block";
	}
	function getUnitByItem(id) {
	var myurl="<%=basePath%>";
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
	function adjustTotalAmount(id) {
		var finalAmount = 0;
		var rowCnt = countTotalRows();
		var oldCurrBlnc = Number(CurrentBalance);
		for (var i = 1; i <= rowCnt; i++) {
			if (document.getElementById('salesStockItems' + i).value != "-1")
				finalAmount = Number(finalAmount)
						+ Number(document.getElementById('amount' + i).value);
		}
		var taxAmt =0;
		for(var j=0;j<totalTax.length;j++){
			taxAmt = Number(taxAmt)+Number(totalTax[j]);
			
		}
		
		document.getElementById('totalAmt').value = Number(finalAmount)+Number(taxAmt);
		var totAmt = Number(document.getElementById('totalAmt').value);
		var blncType= old_cr_dr;
		var currBal = Number(CurrentBalance);
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
		var limitchk = Number(document.getElementById('totalAmt').value);
		if(creditLimit!='Not Specified' && Number(creditLimit)!=-1 && (Number(document.getElementById('currBalance').value)>creditLimit || limitchk>creditLimit)){
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
			success : function(itr) {
				var arr = itr.split(","); 
				document.getElementById('currBalance').value = arr[0];
				document.getElementById('crdr').innerHTML = arr[1];
				CurrentBalance =  arr[0];
				document.getElementById('hcrdr').value = arr[1];
				old_cr_dr = arr[1];
				getCreditLimit(id);
				$("#payTransactionTable").css("display", "block");
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
				getSecurityAmt(id);
			},
			error : function(itr) {

			}
		});
	}
	
	function calAmount(id) {
		var res = id.match(/\d/g);
		var qty = document.getElementById('Qty' + res).value;
		var rate = document.getElementById('rate' + res).value;
		document.getElementById('amount' + res).value = qty * rate;
		getTaxes(id);
		adjustTotalAmount(id);
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
		Sales
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Sales</h4>
		</div>
		<s:form action="/com/stpl/pms/action/bo/um/bo_um_BoEmpsale_create.action"
			id="searchUserFrm" theme="simple" method="POST" enctype="multipart/form-data" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Sales No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield id="salesNo" name="salesNo" value="%{salesNo}"
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
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Party A/c Name </label>
						</div>
						<div class="InputDiv">
							<s:select name="partyAcc" headerKey="none" id="partyAcc"
								headerValue="--Please Select--" onchange="getCurrentBalance(this.id)" list="partyAccName"
								cssClass="select1" theme="myTheme"/>
						</div>
					</div>
					
					
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
					
					<br />
					<div class="clearFRM"></div>

					<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable" class="transactionTable" style="display:none">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Name of
									item</th>
								<th style="text-align: center;display:none" nowrap="nowrap">Total Qty.</th>
								 <th style="text-align: center;" nowrap="nowrap">Billed Qty.</th>
								<th style="text-align: center;" nowrap="nowrap">Rate</th>
								<th style="text-align: center;" nowrap="nowrap">unit</th>
								<th style="text-align: center;" nowrap="nowrap">Amount</th>
							</tr>
						</thead>
						<tbody>

							<tr id="rowId1">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" id="salesStockItems1"
										list="salesStockItemList" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;" onchange="callForMoreRow(this.id)"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty1"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true" readOnly="true" onfocusout="calAmount(this.id)"   value="0" id="Qty1" theme="myTheme"
										pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true"  readOnly="true" onfocusout="calAmount(this.id)" value="0" id="rate1"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit1"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount1"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$"
										cssStyle="width:50%">
									</ss:textfield></td>
									

							</tr>
							
							<!-- row 2 -->
							
							<tr id="rowId2">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" id="salesStockItems2"
										list="salesStockItemList" cssClass="select1" onchange="callForMoreRow(this.id)" theme="myTheme"
										cssStyle="width:120px;"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty2"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true"   readOnly="true" onfocusout="calAmount(this.id)"   value="0" id="Qty2" theme="myTheme"
										pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true" onfocusout="calAmount(this.id)"   value="0" id="rate2"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit2"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount2"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$"
										cssStyle="width:50%">
									</ss:textfield></td>

							</tr>
							<!-- end row 2 -->
							
							<!-- row 3 -->
							<tr id="rowId3">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" id="salesStockItems3"
										list="salesStockItemList" onchange="callForMoreRow(this.id)" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty3"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true"   readOnly="true" onfocusout="calAmount(this.id)"   value="0" id="Qty3" theme="myTheme"
										pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true"    readOnly="true" onfocusout="calAmount(this.id)"   value="0" id="rate3"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit3"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount3"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$"
										cssStyle="width:50%">
									</ss:textfield></td>
									

							</tr>
							<!-- end row 3 -->
							
							<!-- row 4 -->
							<tr id="rowId4">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" id="salesStockItems4"
										list="salesStockItemList" onchange="callForMoreRow(this.id)" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty4"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true"  onfocusout="calAmount(this.id)"   value="0" id="Qty4" theme="myTheme"
										pattern="^[0-9.]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true"   onfocusout="calAmount(this.id)"   value="0" id="rate4"
										theme="myTheme" pattern="^[0-9.]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit4"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount4"
										theme="myTheme" readOnly="true" pattern="^[0-9.]*$"
										cssStyle="width:50%">
									</ss:textfield></td>
									<td style="text-align: center;display:none;" nowrap="nowrap">
								

							</tr>
							<!-- end row 4 -->
							
						
							<!-- row 5 -->
							
							<tr id="rowId5">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" id="salesStockItems5"
										list="salesStockItemList" onchange="callForMoreRow(this.id)" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty1"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true" onfocusout="calAmount(this.id)"   value="0" id="Qty5" theme="myTheme"
										pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true"   onfocusout="calAmount(this.id)"   value="0" id="rate5"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit5"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount5"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$"
										cssStyle="width:50%">
									</ss:textfield></td>
									

							</tr>
							<!-- end row 5 -->
							
							<!-- row 6 -->
							
							<tr id="rowId6">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" id="salesStockItems6"
										list="salesStockItemList" onchange="callForMoreRow(this.id)" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty6"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true" value="0"  onfocusout="calAmount(this.id)"   id="Qty6" theme="myTheme"
										pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true"  value="0"  onfocusout="calAmount(this.id)"   id="rate6"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit6"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount6"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$"
										cssStyle="width:50%">
									</ss:textfield></td>
									

							</tr>
							<!-- end row 6 -->
							
							
							<!-- row 7 -->
							
							<tr id="rowId7">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" onchange="callForMoreRow(this.id)" id="salesStockItems7"
										list="salesStockItemList" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty7"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true"  onfocusout="calAmount(this.id)"   value="0" id="Qty7" theme="myTheme"
										pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true"   onfocusout="calAmount(this.id)"   value="0" id="rate7"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit7"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount7"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$"
										cssStyle="width:50%">
									</ss:textfield></td>
									

							</tr>
							<!-- end row 7 -->
							
							<!-- row 8 -->
							
							<tr id="rowId8">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" onchange="callForMoreRow(this.id)" id="salesStockItems8"
										list="salesStockItemList" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty8"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true"  onfocusout="calAmount(this.id)"   value="0" id="Qty8" theme="myTheme"
										pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true"   onfocusout="calAmount(this.id)"   value="0" id="rate8"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit8"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount8"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$"
										cssStyle="width:50%">
									</ss:textfield></td>
									
							</tr>
							<!-- end row 8 -->
							
							<!-- row 9 -->
							
							<tr id="rowId9">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" onchange="callForMoreRow(this.id)" id="salesStockItems9"
										list="salesStockItemList" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty9"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true" value="0"  onfocusout="calAmount(this.id)"   id="Qty9" theme="myTheme"
										pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true"  value="0"  onfocusout="calAmount(this.id)"   id="rate9"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit9"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount9"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$"
										cssStyle="width:50%">
									</ss:textfield></td>
											</tr>
							<!-- end row 9 -->
							
							<!-- row 10 -->
							
							<tr id="rowId10">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="End Of List"
										name="salesStockItems" id="salesStockItems10"
										list="salesStockItemList" onchange="callForMoreRow(this.id)" cssClass="select1" theme="myTheme"
										cssStyle="width:120px;"/></td>
								<td style="text-align: center;display:none" nowrap="nowrap"><ss:textfield
										maxlength="30" name="totalQty" readOnly="true" value="0" id="totalQty10"
										theme="myTheme" readOnly="true"
										cssStyle="width:50%">
									</ss:textfield></td>
								
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="Qty" readOnly="true" value="0"  onfocusout="calAmount(this.id)"   id="Qty10" theme="myTheme"
										pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="rate"  readOnly="true"   onfocusout="calAmount(this.id)"   value="0" id="rate10"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap">
									<ss:textfield
										maxlength="30" name="unit" value="" id="unit10"
										theme="myTheme" readOnly="true" cssStyle="width:40%">
									</ss:textfield>
									</td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount" value="0" id="amount10"
										theme="myTheme" readOnly="true" pattern="^[0-9]*$"
										cssStyle="width:50%">
									</ss:textfield></td>
								
							</tr>
							<!-- end row 10 -->
							
							


						</tbody>
					</table>
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
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Total Amount </label>
						</div>
						<div class="InputDiv" align="right">
							<s:textfield name="totalAmt" cssClass="InpTextBoxBg"
								id="totalAmt" style="margin-left: 0px" align="left"
								readOnly="true" theme="simple" style="width:30%"></s:textfield>
						</div>
					</div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Narration </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="narration" value="Sale" cssClass="InpTextBoxBg"
								id="narration" theme="simple" title="Enter Narration"></s:textfield>
						</div>
					</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Upload Document </label><em class="Req">*</em>
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
			<!-- 	<input type="submit" id="saleBtn" value='Create' align="left"
					style="margin-left: 0px" class="button" /> -->
				<button type="button" id="saleBtn" align="left" style="margin-left: 0px" class="button" onclick="checkDocUpload()">Save</button>
			</div>
		</s:form>
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
</body>
</html>

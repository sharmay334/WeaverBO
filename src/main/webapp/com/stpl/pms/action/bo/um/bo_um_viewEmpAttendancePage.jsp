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
<base href="<%=basePath%>">

<title>Employee Attendance</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=path%>/css/jquery.ui.theme.min.css" rel="stylesheet"
	type="text/css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

<script type="text/javascript">

//const fileInput = document.getElementById('file-input');

//fileInput.addEventListener('change', (e) => doSomethingWithFiles(e.target.files));
var wTYPE="";
var aType="";
$(document).ready(
			function() {
				$("#reminder1").datetimepicker(
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
									$("#reminder1").datepicker("option",
											"minDate", selectedDate);
								} else {
									var date = new Date().getDate();
									$(function() {
										$("#reminder1").datepicker({
											dateFormat : 'dd-mm-yy'
										}).datepicker("setDate", date);
									});
								}
							}
						});
				
				$("#reminder2").datetimepicker(
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
									$("#reminder2").datepicker("option",
											"minDate", selectedDate);
								} else {
									var date = new Date().getDate();
									$(function() {
										$("#reminder2").datepicker({
											dateFormat : 'dd-mm-yy'
										}).datepicker("setDate", date);
									});
								}
							}
						});
				
				$("#reminder3").datetimepicker(
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
									$("#reminder3").datepicker("option",
											"minDate", selectedDate);
								} else {
									var date = new Date().getDate();
									$(function() {
										$("#reminder3").datepicker({
											dateFormat : 'dd-mm-yy'
										}).datepicker("setDate", date);
									});
								}
							}
						});
				
				$("#reminder4").datetimepicker(
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
									$("#reminder4").datepicker("option",
											"minDate", selectedDate);
								} else {
									var date = new Date().getDate();
									$(function() {
										$("#reminder4").datepicker({
											dateFormat : 'dd-mm-yy'
										}).datepicker("setDate", date);
									});
								}
							}
						});
				
				$("#reminder5").datetimepicker(
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
									$("#reminder5").datepicker("option",
											"minDate", selectedDate);
								} else {
									var date = new Date().getDate();
									$(function() {
										$("#reminder5").datepicker({
											dateFormat : 'dd-mm-yy'
										}).datepicker("setDate", date);
									});
								}
							}
						});

			});
var flag = 0;
	function showFields(value){
		$("#showPresentDiv").css("display", "none");
		$("#leave_div").css("display", "none");
		flag = 0;
		aType = value;
		if(value=='PI'){
			$("#showPresentDiv").css("display", "block");
			document.getElementById('attendanceType').value='PI';
			document.getElementById("markBut").style.display = "block";
		}
		else if(value=='PO'){
			flag =1 ;
			$("#showPresentDiv").css("display", "block");
			$("#visit_div").css("display", "block");
			document.getElementById('attendanceType').value='PO';
			document.getElementById("markBut").style.display = "none";
		}
		else if(value=='L'){
			$("#leave_div").css("display", "block");
			document.getElementById('attendanceType').value='L';
			document.getElementById("markBut").style.display = "block";
		}
		else{
			document.getElementById('attendanceType').value='W';
			document.getElementById("markBut").style.display = "block";
		}
		
		
	}
	function showdivType(type){
		$("#private_div").css("display", "none");
		$("#public_div").css("display", "none");
		if(type=="private"){
			$("#private_div").css("display", "block");
		}
		else if(type=="public"){
			$("#public_div").css("display", "block");
		}
	}
	function showHideDiv(val){
		$("#working_area_div").css("display", "none");
	    $("#travelling_mode_div").css("display", "none");
	    $("#odometer_read_div").css("display", "none");
	    $("#odometer_div").css("display", "none");
	    wTYPE = val;
			if(val=="Office_setting")
			{
			$("#working_area_div").css("display", "none");
		    $("#travelling_mode_div").css("display", "none");
		    $("#odometer_read_div").css("display", "none");
		    $("#odometer_div").css("display", "none");
		    $("#visit_div").css("display", "none");	
		    document.getElementById("markBut").style.display = "block";
			}
		else{
			$("#odometer_read_div").css("display", "block");
		    $("#odometer_div").css("display", "block");
			$("#working_area_div").css("display", "block");
			$("#travelling_mode_div").css("display", "block");
			
			if(flag==1)
			$("#visit_div").css("display", "block");
			else
				$("#visit_div").css("display", "none");
		    }
	}
	function openVisitTab(val){
		
		if(Number(val)>0){
			document.getElementById("visitHidden").value = Number(val);
			document.getElementById("myForm").style.display = "block";
			document.getElementById("markBut").style.display = "block";
			
		}
		else{
			document.getElementById("myForm").style.display = "none";
			document.getElementById("markBut").style.display = "none";
			
		}
	}
	function closeDialogue(){
		var count = document.getElementById('visit').value;
		var flg = 0;
		for(var i=1;i<=count;i++){
			var value = document.getElementById('propName'+i).value;
			var value1 = document.getElementById('contact'+i).value; 
			if((value===null || value=="" || value==" ") || (value1===null || value1=="" || value1==" ")){
				flg = 1;
				
			}
		}
		if(flg==1){
			alert('Please enter '+count+' visit before close');
		}
		else{
			document.getElementById("myForm").style.display = "none";
		}
		
	}
	function checkCusType(val){
		var res = val.match(/\d/g);
		var value = document.getElementById(val).value;
		document.getElementById("distributors"+res).style.display = "none";
		document.getElementById("distributort"+res).style.display = "none";
		
		if(value=="Old"){
			document.getElementById("distributors"+res).style.display = "block";
		}
		else{
			document.getElementById("distributort"+res).style.display = "block";
		}
	}
	function purposeMore(id){
		
		if(document.getElementById(id).value=="Others"){
			document.getElementById("visitP").style.display = "block";
		}
		else{
			document.getElementById("visitP").style.display = "none";
		}
	}
	function checkVisitDetail(){
		var w_type= wTYPE;
		var visit_no = document.getElementById('visit').value;
		var myurl = "<%=basePath%>";
		myurl =myurl+"/com/stpl/pms/action/bo/um/bo_um_tm_get_username.action";
		if(w_type=="Field_work" && aType=="PO"){
			if(visit_no<=0){
				$.ajax({
					type : "GET",
					url : myurl,
					success : function(itr) {
						
							swal("Dear "+itr+". Please Fill number of visit. Otherwise company will not pay you any TA, DA and others bill of current day!!!");
								
						
					},

					error : function(itr) {

					}
				});
				
			}
			
		}
	}
	function showRetailer(id){
		var res = val.match(/\d/g);
		
		var retType = document.getElementById(id).value;
		if(retType=="Yes"){
			document.getElementById("retName"+res).style.display = "block";
		}
		else{
			document.getElementById("retName"+res).style.display = "none";
		}
		
	}
</script>
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
  overflow-y: scroll; /* Enable scroll if needed */
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
  font-size: 18px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

.btnp {
  background-color: #75ff75;
  border: none;
  color: white;
  padding: 8px 10px;
  font-size: 12px;
  cursor: pointer;
}
.btny {
  background-color: #902B15;
  border: none;
  color: white;
  padding: 8px 10px;
  font-size: 12px;
  cursor: pointer;
}
.btna {
  background-color: red;
  border: none;
  color: white;
  padding: 8px 10px;
  font-size: 12px;
  cursor: pointer;
}.btnl {
  background-color: DodgerBlue;
  border: none;
  color: white;
  padding: 8px 10px;
  font-size: 12px;
  cursor: pointer;
}

/* Darker background on mouse-over */
.btnp:hover {
  background-color: #3bf73b;}
  .btny:hover {
  background-color: #A9432D;}
  .btna:hover {
  background-color: #E32636;}
  .btnl:hover {
  background-color: RoyalBlue;
}
</style>
</head>

<body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>Employee Attendance</h4>
		</div>
		<s:form action="/com/stpl/pms/action/bo/um/bo_um_BoEmploye_attendance.action"
			 theme="simple" enctype="multipart/form-data" method="POST">
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Employee Name </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
							<s:property value="%{userName}" />
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Attendance</label><em class="Req">*</em>
					</div>
				<div class="InputDiv inpRadio">
						<a class="btnp" onclick="showFields('PI')"><i class="fa fa-user"></i> Present</a>
						<a class="btny" onclick="showFields('PO')"><i class="fa fa-user"></i> Day Over</a>
						<a class="btna" onclick="showFields('L')"><i class="fa fa-exclamation-triangle"></i> Leave</a>
						<a class="btnl" onclick="showFields('W')"><i class="fa fa-home"></i> Weekly Off</a>
						<s:hidden name="attendanceType" id="attendanceType"></s:hidden>
					</div>
					
				</div>
				<div id="showPresentDiv" style="display:none;">
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> What you will be doing today?</label><em class="Req">*</em>
					</div>
					<div class="InputDiv inpRadio">
							<s:radio list="#{'Field_work':'Field Work','Office_setting':'Office Setting'}" name="workType"
									id="tw" value="%{'YES'}" onclick="showHideDiv(this.value)"></s:radio>
					
					</div>
				</div>
				<div id="working_area_div" style="display:none;">
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Working Area </label>
					</div>
					<div class="InputDiv inpRadio">
						<s:radio list="#{'city':'City','ex_city':'Ex City','tour':'Tour'}" name="workArea"
									id="wa" value="%{'YES'}" ></s:radio>
							
						</div>

				</div>
				</div>
				<div id="travelling_mode_div" style="display:none;">
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Travelling mode </label>
					</div>
					<div class="InputDiv inpRadio">
						<s:radio list="#{'private':'Private','public':'Public'}" name="travellingMode"
									id="tm" value="%{'YES'}" onchange="showdivType(this.value)"></s:radio>
									
						<div id="private_div" style="display:none;">			
						<s:radio list="#{'two_wheeler':'Two Wheeler','four_wheeler':'Four Wheeler'}" name="travellingModeVia"
									id="tm" value="%{'YES'}" ></s:radio>
						</div>
						<div id="public_div" style="display:none;">			
						<s:radio list="#{'bus':'Bus','train':'Train'}" name="travellingModeVia"
									id="tm" value="%{'YES'}" ></s:radio>
						</div>
									
					
						</div>

				</div>
				</div>
				
				<div class="FormMainBox">
					<div class="InputDiv inpRadio">
						<div id="private_div" style="display:none;">			
						<s:radio list="#{'two_wheeler':'Two Wheeler','four_wheeler':'Four Wheeler'}" name="travellingModeVia"
									id="tm" value="%{'YES'}" ></s:radio>
						</div>
						<div id="public_div" style="display:none;">			
						<s:radio list="#{'bus':'Bus','train':'Train'}" name="travellingModeVia"
									id="tm" value="%{'YES'}" ></s:radio>
						</div>
									
					
						</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox" id="visit_div" style="display:none;">
					<div class="labelDiv">
						<label> Number of visit </label>
					</div>
					<div class="InputDivHalf">
					<s:textfield id="visit" value="0" onchange="openVisitTab(this.value)" pattern="^[0-9]*$" name="visitFormBean.visitNumber"
								theme="myTheme" cssStyle="width:40%" />
					<s:hidden name="visitHidden" id="visitHidden" value="0" />
					
						</div>

				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox" id="selfie_div">
					<div class="labelDiv">
						<label> Selfie Picture </label><em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
					<label for="selfiePicture">
					    <img src="/WeaverBO/images/camera.png" height="35px" width="35px" onclick="checkVisitDetail()"/>
					 </label>
					<s:file label="upload" id="selfiePicture" name="selfiePicture" cssClass="textfield" theme="myTheme" cssStyle="display:none;"></s:file>
						</div>

				</div>
				<div id="odometer_div" style="display:none">
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> take Odometer Picture </label>
					</div>
					<div class="InputDivHalf">
					<label for="odoMeterPicture">
					    <img src="/WeaverBO/images/camera.png" height="35px" width="35px"/>
					 </label>
					
					<s:file label="upload" id="odoMeterPicture" name="odoMeterPicture" cssClass="textfield" theme="myTheme" cssStyle="display:none;"></s:file>
						</div>

				</div>
				</div>
				<div id="odometer_read_div" style="display:none;">
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Write Odometer Reading </label><em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
					<s:textfield id="odometer_reading" value="0" name="odometer_reading"
								theme="myTheme" cssStyle="width:40%" />
					
						</div>

				</div>
				
				</div>
				</div>
				<div id="leave_div" style="display:none">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Leave Details</label>
					</div>
					<div class="InputDivHalf">
					<s:textfield id="leave_reason" name="leave_reason"
								theme="myTheme"/>
					
						</div>

				</div>
				
				</div>
				
				<div class="box_footer" align="right">
				
					 <s:submit value="Mark" id="markBut" align="left" cssStyle="margin-left:0px;display:none;"
						cssClass="button" theme="simple"></s:submit> 
					
				</div>
			</div>
			
			
			<!-- modal div start -->
			
			<div id="myForm" class="modal">

  <!-- Modal content -->
  			<div class="modal-content">
 			   <button id="closeme" type="button" class="close" onclick="closeDialogue()">Save</button>
 			  <div id="bill_by_bill">
						<div class="FormSectionMenu" id="bill_by_bill_div_acc">
							<div class="greyStrip">
								<h4>Visit Form</h4>
							</div>
					<table width="100%" cellspacing="0" align="center"
						id="payTransactionTableBillWise" class="transactionTable">
					<s:iterator begin="1" end="5" status="ctr">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Customer Type</label>
							</div>
								<div class="InputDivHalf">
									<s:select
												name="visitFormBean.customerType" id="%{'customerType' + #ctr.count}"
												list="{'Old','New'}" cssClass="select1" theme="myTheme"
												cssStyle="width:100%;" onchange="checkCusType(this.id)"/>
					
								</div>

						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Distributors Name</label>
							</div>
								<div class="InputDivHalf">
									<s:select
												name="visitFormBean.distributor" id="%{'distributors' + #ctr.count}"
												list="underledgersList" cssClass="select1" theme="myTheme"
												cssStyle="width:100%"/>
										<ss:textfield
												name="visitFormBean.distributor" cssStyle="width:100%;display:none"
												id="%{'distributort' + #ctr.count}" theme="myTheme"></ss:textfield>
					
								</div>

						</div>
						
						
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Retailer</label>
							</div>
								<div class="InputDivHalf">
									<s:select
												name="visitFormBean.retailer"
												list="{'Yes','No'}" id="%{'retailer' + #ctr.count}" cssClass="select1" theme="myTheme"
												cssStyle="width:100%;" onchange="showRetailer(this.id)"/>
								</div>

						</div>
						
						
						<div class="clearFRM"></div>
						<div class="FormMainBox" id="retName<s:property value="#ctr.count"/>" style="display:none;">
							<div class="labelDiv">
								<label> Retailer Name</label>
							</div>
								<div class="InputDivHalf">
									<ss:textfield
										maxlength="30" name="visitFormBean.retailerName" id="%{'retailerName' + #ctr.count}"
										theme="myTheme" cssStyle="width:100%">
									</ss:textfield>
					
								</div>

						</div>
						
						
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Prop. Name</label><em class="Req">*</em>
							</div>
								<div class="InputDivHalf">
									<ss:textfield
										maxlength="30" name="visitFormBean.propName" id="%{'propName' + #ctr.count}"
										theme="myTheme" cssStyle="width:100%">
									</ss:textfield>
					
								</div>

						</div>
						
						
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Contact Number</label><em class="Req">*</em>
							</div>
								<div class="InputDivHalf">
									<ss:textfield
												name="visitFormBean.contact" id="%{'contact' + #ctr.count}" cssStyle="width:100%"
												 theme="myTheme"></ss:textfield>
					
								</div>

						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Address</label>
							</div>
								<div class="InputDivHalf">
									<ss:textfield
												name="visitFormBean.address" id="%{'address' + #ctr.count}" cssStyle="width:100%"
												theme="myTheme"></ss:textfield>
					
								</div>

						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>District</label>
							</div>
								<div class="InputDivHalf">
									<ss:textfield
										maxlength="30" name="visitFormBean.district" id="%{'district' + #ctr.count}" 
										theme="myTheme" cssStyle="width:100%">
									</ss:textfield>
					
								</div>

						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Visit Purpose</label>
							</div>
								<div class="InputDivHalf">
									<s:select
												name="visitFormBean.visitPurpose" id="%{'visitPurpose' + #ctr.count}"
												list="{'New Distributor Planning','Sales Order','Sales return','Collection','Others'}" cssClass="select1" theme="myTheme"
												cssStyle="width:100%;" onchange="purposeMore(this.id)"/>
					
								</div>

						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox" id="visitP" style="display:none">
							<div class="labelDiv">
								<label>Purpose(if visit purpose: Others)</label>
							</div>
								<div class="InputDivHalf">
									<ss:textfield
										maxlength="30" name="visitFormBean.purpose" id="%{'purpose' + #ctr.count}"
										theme="myTheme" cssStyle="width:100%">
									</ss:textfield>
					
								</div>

						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>comments</label>
							</div>
								<div class="InputDivHalf">
									<ss:textfield
										maxlength="30" name="visitFormBean.comment" id="%{'comment' + #ctr.count}"
										theme="myTheme" cssStyle="width:100%">
									</ss:textfield>
					
								</div>

						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Visitor Photo</label>
							</div>
								<div class="InputDivHalf">
									<label for="visitorPicture<s:property value="#ctr.count"/>">
					    <img src="/WeaverBO/images/camera.png" height="35px" width="35px"/>
					 </label>
					
					<s:file label="upload" id="%{'visitorPicture' + #ctr.count}" name="visitFormBean.visitorPicture" cssClass="textfield" theme="myTheme" cssStyle="display:none;"></s:file>
					
								</div>

						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Reminder</label>
							</div>
								<div class="InputDivHalf">
									<ss:textfield
										name="visitFormBean.reminder" placeholder="Date" cssClass="dateField"
										id="%{'reminder' + #ctr.count}" readonly="true" theme="myTheme"></ss:textfield>
					
								</div>

						</div>
						<div class="clearFRM"></div>
						<div class="greyStrip">
								<h4>Visit Form</h4>
							</div>
							</s:iterator>	
						
					</table>
						</div>
					</div>
 			 </div>

		</div>
			
			<!-- end -->
			
		</s:form>
	</div>
	<div id="searchResult" class="FormSection"></div>
	</body>
</html>

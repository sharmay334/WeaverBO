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

	function showFields(value){
		$("#showPresentDiv").css("display", "none");
		$("#leave_div").css("display", "none");
		
		if(value=='PI'){
			$("#showPresentDiv").css("display", "block");
			document.getElementById('attendanceType').value='PI';
		}
		else if(value=='PO'){
			$("#showPresentDiv").css("display", "block");
			document.getElementById('attendanceType').value='PO';
		}
		else if(value=='L'){
			$("#leave_div").css("display", "block");
			document.getElementById('attendanceType').value='L';
		}
		else{
			document.getElementById('attendanceType').value='W';
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
</script>
<style>

.btnp {
  background-color: #75ff75;
  border: none;
  color: white;
  padding: 8px 10px;
  font-size: 12px;
  cursor: pointer;
}
.btny {
  background-color: #FFFF00;
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
  background-color: #CCCC00x;}
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
									id="tw" value="%{'YES'}" ></s:radio>
					
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Working Area </label>
					</div>
					<div class="InputDiv inpRadio">
						<s:radio list="#{'city_alwar':'City - Alwar','ex_city':'Ex City','tour':'Tour'}" name="workArea"
									id="wa" value="%{'YES'}" ></s:radio>
							
						</div>

				</div>
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
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Selfie Picture </label>
					</div>
					<div class="InputDivHalf">
					<label for="selfiePicture">
					    <img src="/WeaverBO/images/camera.png" height="35px" width="35px"/>
					 </label>
					<s:file label="upload" id="selfiePicture" name="selfiePicture" cssClass="textfield" theme="myTheme" cssStyle="display:none;"></s:file>
						</div>

				</div>
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
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Write Odometer Reading </label>
					</div>
					<div class="InputDivHalf">
					<s:textfield id="odometer_reading" name="odometer_reading"
								theme="myTheme" cssStyle="width:40%" />
					
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
				
					<s:submit value="Mark" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
				</div>
			</div>
		</s:form>
	</div>
	<div id="searchResult" class="FormSection"></div>
	</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Upload Player Document</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=path%>/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/jquery.dataTables.mis.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
	type="text/css" />
	<script type="text/javascript" src="<%=path%>/js/datatable/jquery.dataTables.js"></script>
	<script type="text/javascript"
		src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
	<script src="com/stpl/pms/action/bo/pm/managePaging/js/docUpload.js" type="text/javascript"></script>
	<SCRIPT type="text/javascript">
	var submitFlag=false;
		$(document).ready(function(){
			var domainId=$("#domainId").val();
			$("#searchBtn").hide();
			$('#domainId').change(function(){
				 $("#tableDiv").hide();
				$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
				if($(this).val()=="-1")
					$('#aliasId').attr('disabled','true');
				else{
				$('#aliasId').removeAttr('disabled');
	  			var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  			$.each(aliasMap,function(index, value) {
	  				$('#aliasId').append($('<option></option>').val(index).html(value));
	  			});
	  			}
	  		});	
			
			if(domainId!="" &&domainId!=-1){
				displayTable(domainId,0,'','','',$("#status").val());
			}
			
			$("#playerSearchFrm").submit(function(){
				if(submitFlag)
				{
					var startDateValue,endDateValue;
					var startArr = $("#uploadStartDate").val().split(' ');
					var endArr = $("#uploadEndDate").val().split(' ');
					startDateValue = $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', startArr[0]))+ ' ' + startArr[1];
					endDateValue = $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', endArr[0]))+ ' ' + endArr[1];
					displayTable($("#domainId").val(), $("#aliasId").val(),$("#userName").val(),$("#firstName").val(),$("#lastName").val(),$("#status").val(),startDateValue,endDateValue);				
				}
					
				return false;
			});
			//setDefaultDate();
		});
	
		function displayTable(domainId,aliasId,userName,firstName,lastName,status,uploadStartDate,uploadEndDate){
			$("#expandIt").html('');
			var flag = 0;
			$("#uploadDoc").DataTable({
				"bDestroy": true,
				"deferRender": true,
				"sAjaxSource" : 'com/stpl/pms/action/bo/pm/bo_pm_search_plr.action?domainId='+domainId+'&aliasId='+aliasId+'&userName='+userName+'&firstName='+firstName+'&lastName='+lastName+'&status='+status+'&uploadStartDate='+uploadStartDate+'&uploadEndDate='+uploadEndDate,
				"sAjaxDataProp":"dataList",
				"sServerMethod": "POST",
				"scrollX": true,
				"aoColumnDefs": [{
					"aTargets": [7],
					"mRender": function (data, type, full) {
						return '<a href="com/stpl/pms/action/bo/pm/bo_pm_plr_document_detail.action?playerId='+data+'&userName='+full[1]+'&ageVerified='+full[4]+'&addressVerified='+full[5]+'&taxationIdVerified='+full[6]+'" target="expandIt" callback="editUploadPlrDocs()" >Edit</a>';
					}
				}],
				"fnDrawCallback": function ( oSettings ) {
					if(oSettings.aiDisplay.length>0 ){
						$("#tableDiv").attr("style","display: block");
						$("#errorDiv").attr("style","display: none");
					} else if(flag == 1 && $("#search").val()==''){
						$("#errorDiv").attr("style","display: block");
						$("#tableDiv").attr("style","display: none");
					} else if(flag == 0){
						flag = 1;
					}
				},
				 "fnInitComplete": function(oSettings, json) {
				 	submitFlag=true; 			
     				$("#searchBtn").show();
   				 }
			});
		}
	
	</SCRIPT>
</head>

<body>
	<s:form id="playerSearchFrm" theme="simple">
		<div class="FormSection">

			<div class="greyStrip">
				<h4>Upload Player Document</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:if test="%{domainId>1 }">
							<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
							<s:property value="%{domainName}" />
						</s:if>
						<s:else>
							<s:select theme="myTheme" cssClass="select1" name="domainId"
								list="%{domainMap}" id="domainId" headerKey="-1"
								headerValue="--Please Select--" listKey="%{key}"
								listValue="%{value}" value="%{bydefaultSelectedDomain}" applyscript="true"></s:select>
						</s:else>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Alias Name </label>
					</div>
					<div class="InputDiv">
							<s:select theme="myTheme" cssClass="select1" name="aliasId"
								list="%{aliasMap}" id="aliasId" headerKey="-1"
								headerValue="--Please Select--" ></s:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> User Name </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="userName" name="userName" theme="myTheme"
							 style="width:51%;"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> First Name </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="firstName" name="firstName" theme="myTheme"
							style="width:51%;"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Last Name </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="lastName" name="lastName" theme="myTheme"
							style="width:51%;"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Upload Start Date
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield theme="myTheme" name="uploadDate" id="uploadStartDate"
								cssClass="dateField" readonly="true" style="width:51%;"></ss:textfield>
						</div>
					</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							Upload End Date
						</label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield theme="myTheme" name="uploadDate" id="uploadEndDate"
							cssClass="dateField" readonly="true" style="width:51%;"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Status </label>
					</div>
					<div class="InputDiv">
						<s:select theme="myTheme" cssClass="select1" name="status"
							id="status" headerKey="ALL"
							list="{'UPLOADED','PENDING','VERIFIED'}" headerValue="--All--"
							value="%{'UPLOADED'}"></s:select>
					</div>
				</div>
				<div class="clearFRM"></div>


			</div>
			<div class="box_footer" align="right">
			<span style="float: left;margin-top: 17px;margin-left: 10px;"><span style="margin-right: 2px; font-weight: bold;">Note: </span>Data is shown for last 7 days.</span>
				<ss:submit id="searchBtn" value="Search" cssClass="button" formnovalidate="true"></ss:submit>
			</div>
			<div id="searchResult"></div>
		</div>
	</s:form>
	<div id="tableDiv" style="display: none;">
		<div class="clear2"></div>
		<div class="FormSection">
			<div class="greyStrip">
				<h4 style="float: left">Player Information</h4>
			</div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="uploadDoc">
					<thead>
						<tr>
						
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Uploaded Date</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								User Name</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								First Name</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Last Name</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Age Verified</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Address Verified</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Tax Id Verified</th>
							
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Update</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<div class="box_footer" align="right"></div>
		</div>
	</div>
	<div id="errorDiv" style="display: none;">
		<div class="clear2"></div>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Error Message</h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>No Record
					Found.
				</div>
			</div>
		</div>
	</div>
	<br />
	<div id="expandIt"></div>
</body>
</html>

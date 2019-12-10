<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Player Payment Correction</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
		<script type="text/javascript"
			src="com/stpl/pms/action/bo/reports/js/common_report.js"></script>
<script type="text/javascript">

var totalAmount = 0;
var totalPlr = 0;
$(document).ready(function() {
	$("#uploadsettle").click(
			function() {
			
				
				var file = $( "input:file" );
				if (file.size > 2000000) {
					alert("File size must be smaller than 2MB");
					return false;
				}
				  if($('#domainId').val()==-1){
					  alert("Please select atleast one Domain");
						return false;
						}
		                if($('#aliasId').val()==-1){
		              	  alert("Please select atleast one Alias");
							return false;
							} 
		            	$("#uploadsettle").attr("disabled","disabled");
						$('#infostrip_payCorrection').hide();
				var formData = new FormData($("#payCorrectionSearchFrm")[0]);
				var domainId = $("#domainId").val();
				var aliasId = $("#aliasId").val();
				var correctionType = $("input[type='radio'][name='payCorrection.correctionType']:checked").val();
				var withdrawableImpact = $("input[type='radio'][name='payCorrection.withdrawableImpact']:checked").val();
				var callURl="com/stpl/pms/action/bo/cashier/st_pms_bo_csh_payCorrec_decission.action?payCorrection.domainId="+domainId+"&payCorrection.correctionType="+correctionType+"&payCorrection.withdrawableImpact="+withdrawableImpact;

				$.ajax({
					type : "POST",
					url : callURl,
					data : formData,
					cache : false,
					contentType : false,
					processData : false,
					success : function(results) {
						var payMap=$.parseJSON(results);
						//console.log(payMap.correctionList);
						/*  $.each(payMap, function(key, value) {
						if(key=="totalAmount")
						totalAmount =  payMap.totalAmount;
						else if (key=="totalPlr")
						totalPlr = value;		      
		        }); */

						if(payMap.status == 200){
							var dynamicDialog = $('<div id="conformBox">'+
									'<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
							'</span>Do you want to continue?</div>');
							dynamicDialog.dialog({
								title : "Total Amount to be Settled  : "+(Math.round((payMap.totalAmount)*100)/100)+ " Total Player Count is :"+payMap.totalPlr,
								closeOnEscape: true,
								modal : true,
								width: 'auto',
								close : function(){
									$(this).dialog("destroy");
									$('#grace_dialog').dialog("destroy");
									$("#uploadsettle").removeAttr("disabled");
								},
								buttons : 
									[{
										text : "Yes",
										click : function() {
											$(this).dialog("close");
											var subUrl = "com/stpl/pms/action/bo/cashier/st_pms_bo_csh_bulkPlrPaymentCorrection_save.action";
											var data = "payCorrection.domainId="+domainId+"&payCorrection.aliasId="+aliasId+"&payCorrection.correctionType="+correctionType+"&payCorrection.withdrawableImpact="+withdrawableImpact+"&correctionList="+encodeURIComponent(JSON.stringify(payMap.correctionList));
											console.log(subUrl);
											$.ajax({
												type : "POST",
												url : subUrl,
												/* cache : false,
												contentType : false,
												processData : false, */
												data:data,
												success : function(results) {
												
												var _result=$.parseJSON(results);
												var $infostrip_payCorrection = $('#infostrip_payCorrection');
												$infostrip_payCorrection.find('#message').text(_result.message);
												$infostrip_payCorrection.show();
												$('#excelUploadForm').hide();
												} 
											});
											
											$(this).dialog("destroy");
											$('#grace_dialog').dialog("destroy");
											$("#uploadsettle").removeAttr("disabled");
										}
									},
									{
										text : "No",
										click : function() {
											$(this).dialog("destroy");
											$('#grace_dialog').dialog("destroy");
											$("#uploadsettle").removeAttr("disabled");
										}
									}]
							});
						}else if(payMap.status == 400){
							var $infostrip_payCorrection = $('#infostrip_payCorrection');
							$infostrip_payCorrection.find('#message').html(payMap.message);
							$infostrip_payCorrection.show();
							$("#uploadsettle").removeAttr("disabled");
						}
						return false;
					}
				});
			});
});

		 $(document).ready(function(){
		loadAliasName($("#domainId").val());
		$('#domainId').change(function() {
		if($("#domainId").val()=="-1"){
				$('#aliasId').attr('disabled','true');
		}
		else{
				$('#aliasId').removeAttr('disabled');
				$("#aliasId").html("");
				loadAliasName($(this).val());
			}
		});
		function loadAliasName(domainId){
			var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
			$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			$.each(aliasMap,function(index, value) {
				$('#aliasId').append($('<option></opplayerSearchMenution>').val(index).html(value));
		  	});
		}
		});
		</script>
<style>
.ui-dialog-title{
word-break: break-word;
width: 80%;
}
</style>

	<body>
		<div class="FormSection" id="excelUploadForm">

			<div class="greyStrip">
				<h4>
					Player Payment Correction
				</h4>
			</div>
				 	
				<s:token name="strutsToken" id="strutsToken"></s:token>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div>
								<s:if test="%{domainId>1}">
									<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
									<s:property value="%{domainName}"/>
								</s:if>
								<s:else>
									<s:select theme="myTheme" cssClass="select1" name="payCorrection.domainId"
										list="%{domainMap}"
										 headerKey="-1"
									headerValue="--Please Select--"
										id="domainId" listKey="%{key}"
										listValue="%{value}"  value="%{bydefaultSelectedDomain}" ></s:select>
								</s:else>
							</div>
						</div>
					</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Alias </label><em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<div>
		<ss:select theme="myTheme" cssClass="select1" list="%{}" id="aliasId" headerKey="-1"
									headerValue="--Please Select--"  >
								</ss:select>


					</div>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Correction Type
							</label>
						</div>
						<div class="InputDivHalf inpRadio">
							<ss:radio list="#{'DEBIT':'Debit','CREDIT':'Credit'}"
								name="payCorrection.correctionType" id="correctionType" value="%{'DEBIT'}"/>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Impact On Withdrawable
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:radio list="#{'YES':'Yes','NO':'No'}"
								name="payCorrection.withdrawableImpact" id="withdrawableImpact" value="%{'NO'}"/>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Upload Sheet
							</label>
						</div>
						<s:form id="payCorrectionSearchFrm" 
				 theme="simple" enctype="multipart/form-data" method="post">
						<div class="InputDiv">
							<s:file name="settlementSheet" id="settlementSheet" applyscript="true" accept=".xls,.xlsx" theme="myTheme"></s:file>
						</div>
						</s:form>
						<div class="FormMainBox" style="height: 10px;">
							<p style="float: left;color:black">
								<b style="color: green;"> Note :</b> <b> <span> Accept excel file format only </span> </b>
							</p>
						</div>
					</div>
					
					<div class="clearFRM"></div>
				

				</div>
				<div class="box_footer" align="right">
					<s:submit name="Search" value="upload" cssClass="button"  id="uploadsettle"></s:submit>
				</div>
		</div>
		
		<div class="FormSection" id="infostrip_payCorrection" style="display:none">
				<div class="greyStrip">
					<h4>Message</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Info: </strong> <span id="message"></span>
					</div>
				</div>
		</div>
			
		<div id="searchResult">

		</div>
	</body>
</html>

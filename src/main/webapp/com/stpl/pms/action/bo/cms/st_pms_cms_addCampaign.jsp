<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Add Campaign page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="com/stpl/pms/action/bo/cms/js/cms.js"
			type="text/javascript"></script>
	<SCRIPT type="text/javascript">
		$(document).ready(function(){
     		$('#domainId').change(function(){
				$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  			var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  			$.each(aliasMap,function(index, value) {
	  				$('#aliasId').append($('<option></option>').val(index).html(value));
	  			});
	  		});	
     
	     	$(document).on("change", "#aliasId", function(){
				fetchContentType("addCamp");
			});	
			$(document).on("change", "#device", function(){
				fetchLandingPageDetail();
			});
			
			$(document).on("change", "#campType", function(){
				removeAddMoreButton();
			});
			$(document).on("click","#addParam",function(){
				addParams();
			});	
			$(document).on("click","#addMoreCamp",function(){
				addCamp();
			});
			$(document).on("submit","#addCapmaignForm",function(){
				prepareCampData();
			});
	   	  	$( "#fromDate_1" ).datetimepicker({
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				minDate: serverDateStr,
				minDateTime:$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
				onClose: function( selectedDate ) {
					$( "#toDate_1" ).datetimepicker( "option", "minDate", selectedDate);
					$( "#toDate_1" ).datetimepicker( "option", "minDateTime", $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',selectedDate));
				}
			});
			$( "#toDate_1" ).datetimepicker({
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				minDate: serverDateStr,
				minDateTime:$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
				onClose: function( selectedDate ) {
					$( "#fromDate_1" ).datetimepicker( "option", "maxDate", selectedDate);
					$( "#fromDate_1" ).datetimepicker( "option", "maxDateTime", $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',selectedDate));
				}
			}); 
		});	
		
    </SCRIPT>

  </head>
  
  <body>
	<s:form id="addCapmaignForm" theme="simple"
		action="st_pms_cms_submitCampaignDetail">
		<s:token name="strutsToken" id="strutsToken"></s:token>
		<s:hidden name="campDetailString" id="campDetailString"></s:hidden>
		<s:hidden id="landingPageDetail"></s:hidden>
		<s:hidden name="aliascontentType" id = "contentType" />
		<div id="container">
			<h2>Add Campaign</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>Campaign Information</h4>
				</div>
				<div class="innerbox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<s:label value="Domain Name:" theme="simple" />
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden name="domainId" id="domainId" value="%{domainId}"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select theme="myTheme" cssClass="select1" applyscript="true"
									list="%{domainMap}" name="domainId" id="domainId"
									headerKey="-1" headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" />
							</s:else>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<s:label value="Alias Name:" theme="simple" />
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<ss:select theme="myTheme" cssClass="select1" applyscript="true"
									list="%{}" name="aliasId" id="aliasId"
									headerKey="-1" headerValue="--Please Select--"/>
						</div>
					</div>
					<div id="deviceDiv" style="display: none;">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<s:label value="Device Type:" theme="simple" />
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:select name="device" headerKey="-1"
									headerValue="-- Please Select --" cssClass="select1" id="device"
									list="#{'PC':'PC','MOBILE':'Mobile','TAB':'Tab','ALL':'All'}"
									theme="myTheme" applyscript="true" />
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<s:label value="Campaign Type:" theme="simple" />
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select name="campType" headerKey="-1"
								headerValue="-- Please Select --" cssClass="select1"
								id="campType"
								list="#{'REFER_FRIEND':'Refer Friend','SOCIAL_REFER':'Social Refer','PPC':'PPC','AFFILIATE':'Affiliate'}"
								theme="myTheme" applyscript="true" />
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Campaign Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield id="campName" name="campName"
								pattern="^[0-9a-zA-Z_,\- ]*$"
								errorMassage="Only alphanumeric character allowed"
								applyscript="true" theme="myTheme"></ss:textfield>
						</div>
					</div>
					<div id="paramDiv">
						<s:hidden id="paramCount" value="0"></s:hidden>
					</div>
					<div class="box_footer" align="right" style="display: none"
						id="addParam">
						<input type="button" class="button" value="Add Parameters">
					</div>

				</div>
				<s:hidden id="count" value="1"></s:hidden>
				<div id="subCampDetail">
					<div class="FormSectionMenu" id="subCamp_1">
						<div class="greyStrip">
							<h4>Sub Campaign Information</h4>
						</div>
						<div class="innerbox">
							<s:hidden id="subCampaignId_1" value="0"></s:hidden>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> Sub Campaign Name: </label> <em class="Req">*</em>
								</div>
								<div class="InputDiv">
									<ss:textfield id="subCampName_1" name="subCampName_1"
										applyscript="true" theme="myTheme" pattern="^[0-9a-zA-Z_,\- ]*$"
										errorMassage="Only alphanumeric character allowed"></ss:textfield>
								</div>
							</div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> Rummy Url: </label> 
								</div>
								<div class="InputDiv" style="height: 55px;">
									<ss:textfield id="deepRummyUrl_1" name="deepRummyUrl_1" theme="myTheme"></ss:textfield>
									<div>
										<b>Note:</b> - Please Specify With # KeyWord
									</div>
								</div>
							</div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<s:label value="Landing Page:" theme="simple" />
									<em class="Req">*</em>
								</div>
								<div class="InputDiv">
									<ss:select name="landingPage_1" headerKey="-1"
										headerValue="-- Please Select --" cssClass="select1"
										id="landingPage_1" list="{}" theme="myTheme" applyscript="true" />
								</div>
							</div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> Valid From Date </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<ss:textfield id="fromDate_1" readonly="true" theme="myTheme"
										applyscript="true"></ss:textfield>
								</div>
							</div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label> Valid To Date </label> <em class="Req">*</em>
								</div>
								<div class="InputDivHalf">
									<ss:textfield id="toDate_1" readonly="true" theme="myTheme"
										applyscript="true"></ss:textfield>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="camp"></div>
				<div class="box_footer" align="right">
					<input type="button" class="button" id="addMoreCamp"
						value="Add More">
					<s:submit value="Submit" align="right" theme="simple"></s:submit>
				</div>
			</div>
		</div>
	</s:form>
</body>
</html>
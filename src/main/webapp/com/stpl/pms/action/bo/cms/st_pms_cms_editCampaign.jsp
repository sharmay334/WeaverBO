<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Edit Campaign</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="com/stpl/pms/action/bo/cms/js/cms.js" type="text/javascript"></script>
    <SCRIPT type="text/javascript">
		$(document).ready(function(){
      		$('#domainId').change(function(){
				$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  			var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  			$.each(aliasMap,function(index, value) {
	  				$('#aliasId').append($('<option></option>').val(index).html(value));
	  			});
	  		});	
			$("#aliasId, #domainId").change(function(){
				$("#campType").val("-1");
          		$("#campId").empty().append(
             		$('<option></option>').val("-1").html("----Please Select----"));
          		$("#campDiv").html("");
          		fetchContentType("editCamp");
       		});
		});
    </SCRIPT>
  </head>

<body>
	<s:form id="editCapmaignForm" theme="simple"
		action="st_pms_cms_submitEditCampaignDetail">
		<s:token name="strutsToken" id="strutsToken"></s:token>
		<s:hidden name="aliascontentType" id = "contentType" />
		<div id="container">
			<h2>Edit Campaign</h2>
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
								<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
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
									headerKey="-1" headerValue="--Please Select--" />
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
									theme="myTheme" applyscript="true" onchange="fetchCampNames()" />
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
							<ss:select headerKey="-1" headerValue="-- Please Select --"
								cssClass="select1" id="campType"
								list="#{'REFER_FRIEND':'Refer Friend','SOCIAL_REFER':'Social Refer','PPC':'PPC','AFFILIATE':'Affiliate'}"
								theme="myTheme" applyscript="true" onchange="fetchCampNames()" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<s:label value="Campaign Name:" theme="simple" />
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select name="campId" headerKey="-1"
								headerValue="-- Please Select --" cssClass="select1" id="campId"
								list="{}" theme="myTheme" applyscript="true"
								ajaxAction="com/stpl/pms/action/bo/cms/st_pms_fetchCampDetail.action"
								ajaxParam="aliasId,campId,device" target="campDiv" />
						</div>
					</div>
				</div>
			</div>
			<div id="campDiv"></div>
		</div>
	</s:form>
</body>
</html>

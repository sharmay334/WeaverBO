<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Update SEO Tags</title>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script>
	$(document).ready(function() {
		$('#domainId').change(function(){
			$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  		var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  		$.each(aliasMap,function(index, value) {
	  			$('#aliasId').append($('<option></option>').val(index).html(value));
	  		});
	  	});	
	
		$("#device").change(function(){ 
			$("#searchresult").html('');
			$('#contentId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			var domainId = $("#domainId").val();
			var device = $("#device").val();
			var aliasId = $("#aliasId").val();
			if(domainId !="" && domainId !="-1" && aliasId!=-1 && aliasId != "") {
				var resp = _ajaxCallText("com/stpl/pms/action/bo/cms/st_pms_cms_fetchDynamicPages.action?aliasId="+aliasId+"&device="+device,"");
	 			$.each($.parseJSON(resp), function(index, value) {
					$('#contentId').append($('<option></option>').val(value).html(index));
				});
			}	
		});
		$("#contentId").change(function(){
			var domainId = $("#domainId").val();
			var aliasId = $("#aliasId").val();
			var contentId = $(this).val(); 
			if(domainId !="" && domainId !="-1" && contentId !="" && contentId !="-1" && aliasId!=-1 && aliasId != "" ) 
				_ajaxCallDiv("com/stpl/pms/action/bo/cms/st_pms_cms_fetchMetaData.action?aliasId="+aliasId+"&contentId="+contentId,"","searchresult");
		});
	});
</script>
</head>
<body>
	<s:form id="saveData" theme="simple" action="st_pms_cms_saveMetaData">
		<s:token name="strutsToken" id="strutsToken"></s:token>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Update SEO Tags</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:if test="%{domainId>1}">
							<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
							<s:property value="%{domainName}" />
						</s:if>
						<s:else>
							<ss:select theme="myTheme" cssClass="select1" list="%{domainMap}"
								name="domainId" id="domainId" headerKey="-1" 
								headerValue="--Please Select--" listKey="%{key}"
								listValue="%{value}" applyscript="true"></ss:select>
						</s:else>
					</div>
				</div>
				<div class="clearFRM"></div>
		
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Alias Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1" list="%{}"
								name="aliasId" id="aliasId" headerKey="-1" 
								headerValue="--Please Select--" applyscript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>
					<div class="FormMainBox">
       					 <div class="labelDiv">
       					  <label> Device: </label>
       					  <em class="Req">*</em>
      						  </div>
      						  <div class="InputDiv">
   					 	 <ss:select theme="myTheme" cssClass="select1"
									list="{'PC','TAB','MOBILE'}"
									name="device" id="device" headerKey="-1" applyscript="true" 
									headerValue="--Please Select--"></ss:select></div>
      					  </div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Page Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1" applyscript="true"
							list="{}" name="contentId" id="contentId" headerKey="-1"
							headerValue="--Please Select--"></ss:select>
					</div>
				</div>
			</div>
		</div>
		<div id="searchresult"></div>
	</s:form>
</body>
</html>

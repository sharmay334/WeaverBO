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
<title>Edit PlaceHolder Criteria</title>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
<script src="com/stpl/pms/action/bo/cms/js/cms.js" type="text/javascript"></script>
<script>
	$(document).ready(function() {
		$('#domainId').change(function(){
			$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  		var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  		$.each(aliasMap,function(index, value) {
	  			$('#aliasId').append($('<option></option>').val(index).html(value));
	  		});
		});	
		
	
		$("#aliasId").change(function() {
			$("#searchresult").html('');
			$('#criId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			var aliasId = $(this).val(); 
			var domainId = $('#domainId').val();
			if(aliasId !="" && aliasId !="-1" && domainId !="" && domainId !="-1") {
				var resp = _ajaxCallText("com/stpl/pms/action/bo/cms/st_pms_cms_fetchPHCriName.action?aliasId="+aliasId,"");
	 	 			$.each($.parseJSON(resp), function(index, value) {
						$('#criId').append($('<option></option>').val(index).html(value));
					});
				}	
			});
		
		$("#criId").change(function(){
			$("#searchresult").html('');
			var domainId = $("#domainId").val();
			var aliasId = $("#aliasId").val();
			var criId = $(this).val(); 
			if(domainId !="" && domainId !="-1" && aliasId !="" && aliasId !="-1" && criId !="" && criId !="-1" ) 
				_ajaxCallDiv("com/stpl/pms/action/bo/cms/st_pms_cms_fetchPHCriteria.action?domainId="+domainId+"&aliasId="+aliasId+"&placeHolderCriteria.phCriteriaId="+criId,"","searchresult");
		});
		
		$("#editCriteria").submit(function(){
			var crVal = $("input[id*=criWiseRadio]:checked").val();
			if(crVal!='NONE'){
				if(typeof document.getElementById('fileInput').files[0] == 'undefined')
				 	values = $("#criteriaSelect_"+crVal).val();
				if(values!=""){
					var valArr = values.split(",");
					$("#jsonData").val(	JSON.stringify(values));
					/* $.each(valArr,function(index,value){
						$("#editCriteria").append($('<input type="hidden" name="placeHolderCriteria.criteriaSelect" value="'+value+'">'));
					}); */
				}
			}
		});
		

		
	});
var values="";
	
function setBrowseFileData(data){
	values=data;
}
	
</script>
</head>
<body>
	<s:form id="editCriteria" theme="simple" action="st_pms_cms_editPlaceHolderCriteria">
		<s:token name="strutsToken" id="strutsToken"></s:token>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Edit PlaceHolder Criteria</h4>
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
						<label> Criteria Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1" applyscript="true"
							list="{}" name="placeHolderCriteria.phCriteriaId" id="criId" headerKey="-1"
							headerValue="--Please Select--"></ss:select>
					</div>
				</div>
			</div>
		</div>
		<div id="searchresult"></div>
	</s:form>
</body>
</html>

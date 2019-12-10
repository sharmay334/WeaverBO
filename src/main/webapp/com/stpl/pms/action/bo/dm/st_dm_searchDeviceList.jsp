<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>List Devices</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<script>
		$(document).ready(function() {
			$('#domainId').change(function(){
				$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
		  		var aliasMap = _ajaxCallJson("<%=basePath%>/com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
		  		$.each(aliasMap,function(index, value) {
		  			$('#aliasId').append($('<option></option>').val(index).html(value));
		  		});
		  	});
		  	paramArr=window.location.search.replace("?","").split("=");
	  		if(paramArr.length==2 && ""!=paramArr[1].trim() && paramArr[0]==="lastView"){
				var valArr=decodeURIComponent(paramArr[1]).split("#");
				console.log(valArr);
				$("#domainId").val(valArr[0]);
	  			$("#domainId").change();
	  			$("#aliasId").val(valArr[1]);
	  			$("#aliasId").change();
	  		}
		});
	</script>
  </head>
  <body>
    <div class="FormSection">
		<div class="greyStrip">
			<h4>Device Search</h4>
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
						ajaxAction="st_dm_fetchDeviceList.action"
						target="searchresult" headerValue="--Please Select--" ajaxParam="domainId,aliasId"
						applyscript="true"></ss:select>
				</div>
			</div>
		</div>
	</div>
	<div id="searchresult"></div>
  </body>
</html>

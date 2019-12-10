<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<html>
<head>
<title>Edit Domain Registration</title>
<base href="<%=basePath%>">
<script>
	$(document).ready(function(){
		$('#domainId').change(function(){
			$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  		var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  		$.each(aliasMap,function(index, value) {
	  			$('#aliasId').append($('<option></option>').val(index).html(value));
	  		});
	  	});	
	});	  	
</script>
</head>
<body>
	<s:form id="UploadCssDiv" action="st_dm_uploadCss_Save" method="POST" theme="simple" enctype="multipart/form-data">
		<s:token name="strutsToken" id="strutsToken" />
		<div class="clear2"></div>
		<h2> Domain Edit </h2>
		<div class="FormSection">
			<div class="greyStrip">
				<h4> Required Information </h4>
			</div>
		
			<div class="innerBox" >
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain Name </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select name="domainId" headerKey="-1"
								headerValue="-- Please Select --" cssClass="select1"
								 id="domainId" list="%{domainMap}" listKey="%{key}"
								listValue="%{value}"  theme="myTheme" />
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Alias Name </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select name="aliasId" headerKey="-1"
								headerValue="-- Please Select --" cssClass="select1"
								 id="aliasId" list="%{}"  theme="myTheme" />
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>CSS Path</label><em class="Req">*</em>
						</div>
						<div class="InputDiv" >
							<s:file name="uploadCss"  cssStyle="select1" theme="myTheme" id="uploadCss" applyscript="true" accept=".css" ></s:file>
							<div id="uploadCssDiv" style="color:#777777; font-size:12px;">
							( .css file are allowed.) </div>
							<div id="uploadCss_error" class="fieldError">
							<s:fielderror><s:param>fileSize</s:param></s:fielderror>
						</div>
						</div>
					
					</div>
				
				</div>
			</div>
			<div class="box_footer" align="right">
					<s:submit name="Upload" value="Upload" cssClass="button"></s:submit>
				</div>
		</div>
		
	</s:form>
	
</body>
</html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<html>
<head>
<title>Cms Upload Zip Css</title>
<base href="<%=basePath%>">
<script type="text/javascript">
	$(document).ready(function() {
		$("#domainId").change(function(){
			var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
			$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			$.each(aliasMap,function(index, value) {
				$('#aliasId').append($('<option></option>').val(index).html(value));
	  		});
		});
	});
</script>
</head>
<body>
	<s:form id="UploadCssDiv" action="st_pms_cms_uploadCssZipSave" method="POST" theme="simple" enctype="multipart/form-data">
		<s:token name="strutsToken" id="strutsToken" />
		<div class="clear2"></div>
		<h2> Upload Domain Specific Css </h2>
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
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Alias Name </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select name="aliasId" headerKey="-1"
								headerValue="-- Please Select --" cssClass="select1"
								 id="aliasId" list="%{}" theme="myTheme" />
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Css Name </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield name="cssName" id="cssName"  applyscript="true" cssStyle="width:51%;"
							action="com/stpl/pms/action/bo/cms/st_pms_cms_availabalCssZipName.action" ajaxParam="aliasId,cssName"></ss:textfield>
						<div id="cssName_error" class="fieldError" >
							<s:fielderror><s:param>cssName </s:param></s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Css Path </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:textfield name="cssPath" id="cssPath"  applyscript="true" cssStyle="width:51%;"></s:textfield>
						<div id="cssPath_error" class="fieldError" >
							<s:fielderror><s:param>cssPath </s:param></s:fielderror>
						</div>
					</div>
				</div>
			<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>Upload Zip</label><em class="Req">*</em>
						</div>
						<div class="InputDiv" >
							<s:file name="uploadZipCss"  cssStyle="select1" theme="myTheme" id="uploadCss" applyscript="true" accept=".zip" ></s:file>
							<div id="uploadCssDiv" style="color:#777777; font-size:12px;">
							( .zip file are allowed.) </div>
							<div id="uploadCss_error" class="fieldError">
							<s:fielderror><s:param>fileSize</s:param></s:fielderror>
						</div>
						</div>
				</div>
				<div class="FormMainBox">
					 <p style="float: left;color:black"><b style="color: red;"> Note</b></p><br>
					 <b>
					 <ol style='padding-left:45px'>
					 <li>In CSS Path field folder/file name should be same as the zipped folder/filename.</li>
				     <li>"/" should not be included before the CSS path.</li>
				     <li>In zipped folder in addition to a .css file there should be a folder named "font" containing font files and a folder named "images" containing image files.</li>
					 </ol>
					 </b>
				</div>
				
			</div>
			<div class="box_footer" align="right" style="margin-top:40px">
					<s:submit name="Upload" value="Upload" cssClass="button"></s:submit>
				</div>
		</div>
	</s:form>
	
</body>
</html>
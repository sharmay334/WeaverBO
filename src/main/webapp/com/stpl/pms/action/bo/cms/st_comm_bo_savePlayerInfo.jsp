<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Player Info</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="css/facebox.css" media="screen" rel="stylesheet"
	type="text/css" />
<script src="js/facebox.js" type="text/javascript"></script>
<script src="com/stpl/pms/action/bo/cms/js/cms.js"
	type="text/javascript"></script>
<script src="js/tiny_mce/tiny_mce_src.js" type="text/javascript"></script>
<script type="text/javascript">
		$(document).ready(
			function() {
				$('#domainId').change(
						function() {
							$("#pageName").prop('selectedIndex', 0);
							$('#aliasId').empty().append(
									$('<option></option>').val("-1").html(
											"----Please Select----"));
							var aliasMap = _ajaxCallJson(
									"com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="
											+ $(this).val(), "");
							$.each(aliasMap, function(index, value) {
								$('#aliasId').append(
										$('<option></option>').val(index).html(
												value));
							});
				});
		 });
</script>
</head>
<body>
	<s:form name="savePlrInfo" id="savePlrInfo" theme="simple"
		action="st_comm_bo_savePlayerInfo">

		<s:token name="strutsToken" id="strutsToken"></s:token>
		<s:hidden name="contentPath" id="contentPath"></s:hidden>
		<s:hidden name="pageType" id="pageType"></s:hidden>

		<div class="FormSection">
			<div class="greyStrip">
				<h4>Required Info</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:if test="%{domainId>1}">
							<s:hidden name="savePlrInfo.domainId" value="%{domainId}"
								id="domainId"></s:hidden>
							<s:property value="%{domainName}" />
						</s:if>
						<s:else>
							<ss:select theme="myTheme" cssClass="select1" list="%{domainMap}"
								name="savePlrInfo.domainId" id="domainId" headerKey="-1"
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
							name="savePlrInfo.aliasId" id="aliasId" headerKey="-1"
							headerValue="--Please Select--" applyscript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="box_footer" align="right">
					<s:submit value="Submit" align="right" cssClass="button"
						theme="simple" />
				</div>
			</div>
		</div>
	</s:form>
</body>
</html>
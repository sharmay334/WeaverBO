<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Insert fields</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript">
	$(document).ready(function(){
		var fieldsBeanList = $.parseJSON($("#fieldsBeanList").val());
		$.each(fieldsBeanList, function(i, value) {
				$("#fieldsDiv").append('<a href="#" onclick="insertField(this); close_facebox(); return false;" value="'+value.fieldName+'" >'+value.fieldDispCode+'</a><br/>');
				
		});
	});	
	</script>
  </head>
  <body>
	<div id="container" style="min-height: 0px; width: auto;">
		<div style="width: 100%; height: 0.1px;"></div>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Select Fields</h4>
			</div>
		</div>
		<div class="FormSection">
			<div class="innerBox">
				<div style="float: left;">
					<strong><u>Fields Name</u>
					</strong>
				</div>
				<br>
				<div id="fieldsDiv"></div>
			</div>
		</div>
	</div>
</body>
</html>

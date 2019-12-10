<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>

<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>

<body>
	<div id="container" style="min-height: 0px; width: auto">
		<div style="width: 100%; height: 0.1px;"></div>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Select Links</h4>
			</div>
			<s:hidden id="pageLinkList"
				value="%{pageLinkStr}"></s:hidden>

			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv" style="width: 35%">
						<label> Content Type: </label><em class="Req">*</em>
					</div>
					<div class="InputDiv" style="width: 62%"><!-- code added for adding forgot password widget in drop down on 1/12/2014 -->
						<s:select theme="simple" cssClass="select1"
							cssStyle="width: 150px;"
							list="#{'STATIC_PAGE':'Static Page','LOGIN_WIDGET':'Login Widget','REGISTRATION_WIDGET':'Registration Widget','FORGOT_PWD_WIDGET':'Forgot Password Widget'}"
							name="contentType" id="linkContentType" headerKey="-1"
							headerValue="--Please Select--" onchange="getLinkType()"></s:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv" style="width: 35%">
						<label> Open Link In: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv" style="width: 62%">
						<s:select theme="myTheme" cssClass="select1" cssStyle="width: 150px;"
							list="{}" name="linkType" id="linkType"
							headerKey="-1" applyscript="true" headerValue="--Please Select--" onchange="getPageLinks()"></s:select>
					</div>
				</div>
			</div>
		</div>
		<div class="FormSection">
			<div class="innerBox">
				<div style="float: left;">
					<strong><u>Links</u>
					</strong>
				</div>
				<br />

				<div id="linksDiv"></div>

			</div>
		</div>
	</div>
</body>
</html>

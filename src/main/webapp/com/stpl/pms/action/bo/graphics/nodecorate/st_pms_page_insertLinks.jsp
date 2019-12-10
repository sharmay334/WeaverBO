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
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/graphics/js/graphics.js"></SCRIPT>
	<script type="text/javascript">
	$(document).ready(function(){
	var domainId = '<s:property value="%{domainId}"/>';
	if(domainId == "-1"){
		alert("No Domain Selected !");
	 		}
	});
	</script>
  </head>
  
  <body>
  <div id="container" style="min-height: 0px; width: auto;">
  <div style="width: 100%; height: 0.1px;"></div>
  <div class="FormSection">
				<div class="greyStrip">
					<h4>				Select Links
					
					</h4>
				</div>
				  	<s:hidden id="pageLinkList" value="%{pageLinkStr}"></s:hidden>
				
			<div class="innerBox">
			<div class="FormMainBox">
				<div class="labelDiv" style="width: 35%">
								<label>
									Content Type:
								</label>
							</div>
							<div class="InputDiv" style="width: 62%">
								<s:select theme="myTheme" cssClass="select1" cssStyle="width: 150px;"
									list="#{'STATIC':'Static','DYNAMIC':'Dynamic','INTERNAL_LOBBY':'Internal Lobby','EXTERNAL_LOBBY':'External Lobby'}"
									name="contentType" id="contentType" headerKey="-1"
									headerValue="--Please Select--" onchange="getLinks(this.value)"
									></s:select>
							</div>
			</div>
			</div>
  </div>	
  			<div class="FormSection">
  					<div class="innerBox">
  								<div style="float: left;"><strong><u>Links</u></strong></div><div style="float: right;"><strong><u>Description</u></strong></div><br/>
  					
			<div id="linksDiv"></div>
			
  </div>
  </div>
  </div>
  </body>
</html>

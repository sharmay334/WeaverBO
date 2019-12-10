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
    
    <title>edit custom css</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script src="com/stpl/pms/action/bo/cms/js/cms.js" type="text/javascript"></script>
  </head>
  
  <body>
    <s:form id="editCustomCSSForm" theme="simple" 
			action="st_pms_cms_submitCustomCSS" enctype="multipart/form-data">
   <div id="container">
			<h2>
				Edit Custom CSS
			</h2>
			<div class="FormSection">
			<div class="greyStrip">
			<h4>
				Custom CSS
			</h4>
		</div>
		<div class="innerbox">
        <div class="FormMainBox">
          <div class="labelDiv"><s:label value="Domain Name:" theme="simple"/><em class="Req">*</em></div>
          <div class="InputDiv">
         <ss:select theme="myTheme" cssClass="select1" applyscript="true"
									list="%{domainMap}"
									name="domainId" id="domainId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}"/>
                               </div></div>
                               <div class="clearFRM"></div>
              <div class="FormMainBox">

						 <div class="labelDiv"><label><s:label value="Device:" cssStyle="margin-left: 22px" theme="simple"/></label><em class="Req">*</em></div>
			                <div class="InputDiv">
								<ss:select name="device" headerKey="-1" onchange="return fetchCustomCSSDetail()"
									headerValue="-- Please Select --" cssClass="select1"
									id="device" list="{'PC','TAB','MOBILE'}" theme="myTheme" applyscript="true"/>
							</div></div>       
							<div class="clearFRM"></div>   
				 <div class="FormMainBox" style="height: 270px; display: none" id = "cssArea">

						 <div class="labelDiv"><label><s:label value="CSS:" cssStyle="margin-left: 33px" theme="simple"/></label><em class="Req">*</em></div>
			                <div class="InputDiv">
								<ss:textarea name="cssDetail" id = "customCSS" rows="15" cols="80" theme="myTheme" applyscript="true"/>
							</div></div> 			        
    	  </div>
      <div class="box_footer" align="right">
      		<s:submit value="Submit" align="right" theme="simple"></s:submit>
      </div>
      </div>
      
		</div>
	</s:form>
  </body>
</html>

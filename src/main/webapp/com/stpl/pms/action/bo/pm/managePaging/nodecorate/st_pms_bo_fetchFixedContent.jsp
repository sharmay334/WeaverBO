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
    <title>Edit Static Content</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <SCRIPT type="text/javascript">
	 $(document).ready(function() {
	   
	
  	 var defaultContentPath = $.parseJSON($("#defaultContentPath").val());
        var css = defaultContentPath['DEFAULT_CONTENT_PATH']+"/css/default/pc/LR/common.css";
		 tinyMCE.init({
         mode : "specific_textareas",
        editor_deselector : "mceNoEditor",
        content_css : css,
        theme : "advanced",
         height : "320",
         convert_urls : false,
          submit_patch : false,
        init_instance_callback : "addNewEditor",
        schema:"html5",
		setup : function(ed) {
        // Add a custom button
       editor = ed;
        
        } 
});		
	   
	
	
	$('a[rel*="facebox"]').click(function(event){
	
	if($("#domainId").val() == "-1"){
		alert("No Domain Selected !");
		event.stopImmediatePropagation();
		}
	
	});
	
	 $('a[rel*="facebox"]').facebox({
	 		
			closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
  	 		});
  	 
	  
		 
	  
	});
	
</SCRIPT>
</head>
<body>
    <s:hidden id="jsonObjVariableId" name="jsonObjVariableId" ></s:hidden>
    <s:hidden id="variablesBeans" value=""></s:hidden>
    <!--<s:hidden id="variablesBeanList" value="%{new com.stpl.pms.utility.Utility().convertJSON(variablesBeanList)}"></s:hidden>
     --><s:hidden id="defaultContentPath"
						value="%{new com.stpl.pms.utility.Utility().convertJSON(@com.stpl.pms.utility.Utility@sysProperties)}"></s:hidden>
    <div class="clearFRM"></div>	
                      <div class="FormMainBox" style="height: 360px;">
                            <div class="labelDiv">
								<label>
									Content:
								</label>
							</div>
							<div class="InputDiv">
							<div>
								<!--<a id="addVariable" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertVariables.action?" ></a>
								<a id="addGraphics" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertGraphics.action?" ></a>
								<a id="addLinks" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertLinks.action?"></a>
								<a id="addPlaceHolders" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertPlaceHolder.action?"></a>
								<a id="addWidget" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertWidget.action?"></a>
								<input type="button" style="display: none;" id="previewPage" value="Preview Page" onclick="getPreview('pageHTML')"/>-->
								</div>
							<div>
							
								<ss:textarea value="%{content}" name="content" id="pageHTML" cols="93" cssStyle="width:98%" theme="myTheme"
															rows="10" readonly="true"></ss:textarea></div>
							</div>
					</div>
		<div id="tempDIv" style="display: none;"></div>	
		
</body>
</html>
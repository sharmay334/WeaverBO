<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
	String path = request.getContextPath();
	String basePath =(String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'st_pms_page_insertGraphics.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	 $(document).ready(function(){
	      var domainId = $("#domainId").val();
	      var jsonList = '["languageList","currencyList"]';
		  var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
	  	  var html = '<div class="FormMainBox"><div class="labelDiv"><label>Language:</label></div><div class="InputDiv"><select class="select1" theme="myTheme" applyscript="true" name="language" id="languageG" applyscript="true"></select></div></div><div class="FormMainBox"><div class="labelDiv"><label>Currency:</label></div><div class="InputDiv"><select class="select1" name="currency" applyscript="true" id="currency" applyscript="true"></select></div></div>';
	  	  $("#graphics_new_div").append(html);

		  $('#languageG').empty().append($('<option></option>').val("-1").html("----Please Select----"));
		  $('#currency').empty().append($('<option></option>').val("-1").html("----Please Select----"));
		  $.each(jsonmap["currencyList"], function(index, value) {
						$('#currency').append($('<option></option>').val(value.currencyId).html(value.currName));
		   });
		  
		  $.each(jsonmap["languageList"], function(index, value) {
						$('#languageG').append($('<option></option>').val(value.languageId).html(value.languageName));
		   });
		  
		 
		    createBubble();
	      $('a[rel="reloadFacebox"]').facebox({
			closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
  	 		});
		    
	 });
	 
	 
	
		
	 
	
	 
	</script>
  </head>
  
  <body>
  
  <div id="container" >
			<div style="width: 100%; height: 0.1px;"></div>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>				Select Graphics
					
					</h4>
				</div>
			<div class="innerBox">
			<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
			<s:hidden name="aliasId" value="%{aliasId}" id="aliasId"></s:hidden>
			<s:hidden name="pageType" value="%{pageType}" id="pageType"></s:hidden>
		<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Graphics Type:
								</label>
							</div>
							<div class="InputDiv">
								<ss:select theme="myTheme" cssClass="select1" applyscript="true"
									list="{'Image','Flash','Video','Image_Gif','Others'}"
									name="graphicsType" id="graphicsType" headerKey="-1"
									headerValue="--Please Select--" 
									></ss:select>
							</div>
						</div>
						
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Size:
								</label>
							</div>
							<div class="InputDiv">
								<ss:select theme="myTheme" applyscript="true" cssClass="select1"
									list="{'50x50','100x100','100x200','200x200'}"
									name="size" id="size" headerKey="-1"
									headerValue="--Please Select--" 
									></ss:select>
							</div>
						</div>
						<div id="graphics_new_div"></div>
						
						
						</div>
						<div class="box_footer" align="right">
					     <a rel="reloadFacebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertGraphics.action?textAreaId=<s:property value='%{textAreaId}'/>" onclick="return reloadFaceBox(this);"><s:submit theme="simple" id="submitBtn" value="Search"></s:submit></a>
					</div>
			
			
			<div></div>
			
			
			</div>
			<div class="FormSection">
			<s:form theme="simple" id="pomFrm" method="POST" enctype="multipart/form-data" action="st_pms_page_createStaticPage">
			<div id="loadDiv" style="max-height: 500px; overflow: scroll">
				<s:iterator value="graphicsPathString">
				<s:if test="%{graphicsType=='Image' || graphicsType=='Image_Gif'}">
				<img src="<s:property />" style="width:100px; height:100px; cursor: pointer" onclick="changeCss(this); return false;" value="<s:property />"/>
				</s:if><s:else>
				<object width="100" height="100" onclick="changeCss(this); return false;"
					classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
					codebase="http://fpdownload.macromedia.com/
							pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0">
						<param name="SRC" value="<s:property />">
						<embed src="<s:property />" width="100" height="100" onclick="changeCss(this); return false;">
						</embed>
				</object>
				</s:else>
				</s:iterator>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Alt - Tag:
								</label>
							</div>
							<div class="InputDiv">
								<ss:textfield id="altTag"></ss:textfield>
							</div>
						</div>
			<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Title-Tag:
								</label>
							</div>
							<div class="InputDiv">
								<ss:textfield id="titleTag"></ss:textfield>
							</div>
						</div>
			<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Image-Link:
								</label>
							</div>
							<div class="InputDiv">
								<ss:textfield id="imgLink"></ss:textfield>
							</div>
						</div>
			<div class="box_footer" align="right">
					     <s:submit theme="simple" id="submitBtn" value="Insert" onclick="insertGraphics(this); close_facebox(); return false;"></s:submit>
					</div>
					
					</s:form>
					</div>
		</div>
  
  </body>
</html>

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
	  if(domainId == "-1"){
		alert("No Domain Selected !");
		     				 			 $(document).trigger('close.facebox');
		
	 		}
	 	      var jsonList = '["languageList","currencyList"]';
		      var jsonmap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,""); 
		  	  var html = '<div class="FormMainBox"><div class="labelDiv"><label>Language:</label></div><div class="InputDiv"><select class="select1" name="language" id="language"></select></div></div><div class="FormMainBox"><div class="labelDiv"><label>Currency:</label></div><div class="InputDiv"><select class="select1" name="currency" id="currency"></select></div></div>';
		  	  $("#graphics_new_div").append(html);
		  
		      $('#language').empty().append($('<option></option>').val("-1").html("----Please Select----"));
		      $('#currency').empty().append($('<option></option>').val("-1").html("----Please Select----"));
		      $.each(jsonmap["currencyList"], function(index, value) {
					$('#currency').append($('<option></option>').val(value.currencyId).html(value.currName));
			  });
				
			  $.each(jsonmap["languageList"], function(index, value) {
					$('#language').append($('<option></option>').val(value.languageId).html(value.languageName));
			  });
		  
		    
		    
	  $('a[rel="reloadFacebox"]').facebox({
			closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
  	 		});
		    
	 });
	 
	 
	 function close_facebox() { $(document).trigger('close.facebox'); }
	
		function insertVariable(){
		
		var value = "";
		$(".aHover").each(function(){
	
		value = value+ $(this).attr("value");
	
	});
	
		setCaretPosition(value,'<%=request.getAttribute("textAreaId")%>');
	
	
	}
	 
	function changeCss(ele){
		
		if($(ele).attr("class")!="aHover"){
		
		$(".aHover").each(function(){
	
			$(this).css("opacity","");
			$(this).removeClass("aHover");
		
	});
		
		$(ele).css("opacity","0.4");
		$(ele).addClass("aHover");
		}
		else{
			
		
		}
	} 
	 
	 function reloadFaceBox(ele){
	 	
	 	 var  anchorElem = $(ele);
  	 	 var hrefAttr = anchorElem.attr('href');
  	 	// hrefAttr = hrefAttr.split("&")[0];
  	 	 hrefAttr = hrefAttr+ "&domainId="+ $("#domainId").val()+ "&currency="+ $("#currency").val()+ "&language="+ $("#language").val()+"&graphicsType="+$("#graphicsType").val()+"&size="+$("#size").val()+"&device="+$("#device").val();
  	 	 anchorElem.attr('href',hrefAttr);
   	 	 return false;
	 	
	 }
	 
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
		<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Graphics Type:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="simple" cssClass="select1"
									list="{'Image','Flash','Video','Image Gif','Others'}"
									name="graphicsType" id="graphicsType" headerKey="-1"
									headerValue="--Please Select--"
									></s:select>
							</div>
						</div>
						
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Size:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="simple" cssClass="select1"
									list="{'50x50','100x100','100x200','200x200'}"
									name="size" id="size" headerKey="-1"
									headerValue="--Please Select--"
									></s:select>
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
			<div id="loadDiv">
				<s:iterator value="graphicsPathString">
				<img src="<s:property />" style="width:100px; height:100px;" onclick="changeCss(this); return false;" value="<img src='<s:property />'></img>"/>
				</s:iterator>
			</div>
			
			<div class="box_footer" align="right">
					     <s:submit theme="simple" id="submitBtn" value="Insert" onclick="insertVariable(this); close_facebox(); return false;"></s:submit>
					</div>
					
					</s:form>
					</div>
		</div>
  
  </body>
</html>

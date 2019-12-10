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
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
<script src="js/facebox.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
	
	$(document).ready(function() {

/*	var toolbar_1 =	["separator","cut","copy","paste","separator","bold","italic","underline"];
	var toolbar_2 = ["separator","undo","redo","separator","left","right","center","justify"];
	$("#pageHTML").htmlbox({
   		toolbars:[toolbar_1, toolbar_2]
	});*/
	
	 $('a[rel*="facebox"]').facebox({
	 		
			closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
  	 		});
  	 });
	</script>

  </head>
  
  <body>
	<div id="container">
			<h2>
				Add Static Page

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Add Static Page Form
					</h4>
				</div>
				<s:form theme="simple" id="pomFrm" method="POST" enctype="multipart/form-data" action="st_pms_page_addPage">
					
					<div class="innerBox">


						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="simple" cssClass="select1"
									list="%{domainMap}"
									name="domainId" id="domainId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}"></s:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Page Name:
								</label>
							</div>
							<div class="InputDiv">
								<s:textfield name="pageName" id="pageName" value="">
								</s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Page Title:
								</label>
							</div>
							<div class="InputDiv">
								<s:textfield name="pageTitle" value="" id="pageTitle"></s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Meta-Tag :
								</label>
							</div>
							<div class="InputDiv">
								<s:textfield name="pageMetaTag"></s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Keyword:
								</label>
							</div>
							<div class="InputDiv">
								<s:textfield name="pageKeyword"></s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
							<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Description:
								</label>
							</div>
							<div class="InputDiv">
								<s:textfield name="pageDescription"></s:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
							<div class="FormMainBox" style="height: 220px;">
							<div class="labelDiv">
								<label>
									HTML:
								</label>
							</div>
							<div class="InputDiv"><div>
								<a id="addVariable" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertVariables.action?textAreaId=pageHTML" onclick="return openFaceBox(this);"><input type="button" id="addPage" value="Insert Variable" onclick="doGetCaretPosition(pageHTML)"/></a>
								<a id="addGraphics" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertGraphics.action?textAreaId=pageHTML" onclick="return openFaceBox(this);"><input type="button" id="addPage" value="Insert Graphics" onclick="doGetCaretPosition(pageHTML)"/></a>
								<a id="addLinks" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertLinks.action?textAreaId=pageHTML" onclick="return openFaceBox(this);"><input type="button" id="addPage" value="Insert Links" onclick="doGetCaretPosition(pageHTML)"/></a>
								<input type="button" id="previewPage" value="Preview Page" onclick="getPreview('pageHTML')"/>
								</div><div><s:textarea name="pageHTML" id="pageHTML" cols="93"
															rows="5" cssStyle="width:98%;"></s:textarea></div>
							</div>
						</div>
						
					</div>
					<div id="page_new_div"></div>
					<div class="box_footer" align="right">
						 <input type="button" id="addPage" value="Add Page For Other Language" onclick="addPageNew()"/>
					     <s:submit theme="simple" id="submitBtn" value="submit" onclick="return checkForm()"></s:submit>
					</div>
				</s:form>
			</div>
			
		</div>
  </body>
</html>

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
    
    <title>Banner Upload</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
<script src="js/facebox.js" type="text/javascript"></script>
<SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/cms/js/cms.js"></SCRIPT>
	<SCRIPT type="text/javascript">
	$(document).ready(function() {
	 $('a[rel*="facebox"]').facebox({
			closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
  	 		});
	});
	</SCRIPT>
	
  </head>
  
   <body>
	<div id="container">
			<h2>
				Banner Upload

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Banner Upload Form
					</h4>
				</div>
				<s:form theme="simple" id="pomFrm" method="POST" enctype="multipart/form-data" action="st_pms_cms_bo_saveBanner">
					 
					 <s:hidden id="campaignMap" value="%{campaignMap}"></s:hidden>
					<div class="innerBox">


						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="%{domainMap}"
									name="domainId" id="domainId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" applyscript="true"></s:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Related Campaign:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="{}"
									name="relatedCampaign" id="campaignList" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"
									></s:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Banner Context:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="{'Pre Registration','Registration','Game Play'}"
									name="bannerContext" id="bannerContext" headerKey="-1"
									headerValue="--Please Select--" 
									applyscript="true"></s:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Banner Name:
								</label>
							</div>
							<div class="InputDiv">
								<ss:textfield name="bannerName" id="bannerName" value="" applyscript="true" theme="myTheme"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Banner Type:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="{'Text','Image','Flash'}"
									name="bannerType" id="bannerType" headerKey="-1"
									headerValue="--Please Select--" 
									applyscript="true"></s:select>
							</div>
						</div>
						<div class="clearFRM"></div>
							<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Banner Description:
								</label>
							</div>
							<div class="InputDiv">
								<ss:textfield name="bannerDescrip" id="bannerDescrip" value="" applyscript="true" theme="myTheme">
								</ss:textfield>
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
								<a id="addVariable" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertVariables.action?textAreaId=content" onclick="return openFaceBox(this);"><input type="button" id="addPage" value="Insert Variable" onclick="doGetCaretPosition(content)"/></a>
								<a id="addGraphics" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertGraphics.action?textAreaId=content" onclick="return openFaceBox(this);"><input type="button" id="addPage" value="Insert Graphics" onclick="doGetCaretPosition(content)"/></a>
								<a id="addLinks" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertLinks.action?textAreaId=content" onclick="return openFaceBox(this);"><input type="button" id="addPage" value="Insert Links" onclick="doGetCaretPosition(content)"/></a>
								<input type="button" id="previewPage" value="Preview Page" onclick="getPreview('content')"/>
								</div><div><ss:textarea name="content" id="content" cols="93"
															rows="5" cssStyle="width:98%;" theme="myTheme"></ss:textarea></div>
							</div>
						</div>
						
					</div>
					<div class="box_footer" align="right">
					     <s:submit theme="simple" id="submitBtn" value="submit"  ></s:submit>
					</div>
				</s:form>
			</div>
			
		</div>
  </body>
</html>

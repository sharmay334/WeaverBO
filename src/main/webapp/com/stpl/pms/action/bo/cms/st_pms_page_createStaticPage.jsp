<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Add Content</title>
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
		<script src="com/stpl/pms/action/bo/cms/js/addStaticPage.js"
			type="text/javascript"></script>
	</head>
	<body>
		<div id="container">
			<h2>
				Add Content

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Add Content Form
					</h4>
				</div>
				<s:form theme="simple" id="createPageFrm" method="POST"
					enctype="multipart/form-data" action="st_pms_page_addPage">
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<s:hidden id="variablesBeans" value=""></s:hidden>
					<s:hidden id="columnName" value=""></s:hidden>
					<s:hidden id="specificCssPath" value="" name="specificCssPath"></s:hidden>
					<s:hidden id="editorCss"></s:hidden>
					<s:hidden id="defaultContentPath" value="%{defaultContentPath}"></s:hidden>
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<s:if test="%{domainId>1}">
										<s:hidden name="domainId" value="%{domainId}"
											id="domainId"></s:hidden>
										<s:property value="%{domainName}" />
									</s:if>
									<s:else>
										<ss:select theme="myTheme" cssClass="select1"
											list="%{domainMap}" name="domainId" id="domainId"
											headerKey="-1" headerValue="--Please Select--"
											listKey="%{key}" listValue="%{value}" applyscript="true"></ss:select>
									</s:else>
								</div>
								<div id="domainId_error" class="fieldError">
									<s:fielderror>
										<s:param>domainId</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Alias Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div>
								<ss:select theme="myTheme" cssClass="select1" list="%{}"
									name="aliasId" id="aliasId" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></ss:select>
							</div>
							<div id="domainId_error" class="fieldError">
								<s:fielderror>
									<s:param>aliasId</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Language:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<ss:select theme="myTheme" cssClass="select1"
										list="%{languageBeanList}" listKey="languageId"
										listValue="languageName" name="language" id="languageList"
										headerKey="-1" headerValue="--Please Select--" applyscript="true"></ss:select>
								</div>
								<div id="error" class="fieldError">
									<s:fielderror>
										<s:param>language</s:param>
									</s:fielderror>
								</div>
							</div>
							</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
        					 <div class="labelDiv">
        					  <label> Device: </label>
        					  <em class="Req">*</em>
       						  </div>
       						  <div class="InputDiv">
	   					 	 <ss:select theme="myTheme" cssClass="select1"
										list="{'PC','TAB','MOBILE'}" onChange="disableCommonCSS();"
										name="device" id="device" headerKey="-1" applyscript="true"
										headerValue="--Please Select--"></ss:select></div>
       					  </div><div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Content Type:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<ss:select theme="myTheme" cssClass="select1"
										list="#{'STATIC_PAGE':'STATIC PAGE','LANDING_PAGE':'LANDING PAGE','PLACE_HOLDER_WEB':'PLACE HOLDER WEB','PLACE_HOLDER_CLIENT':'PLACE HOLDER CLIENT','EMAIL':'BO EMAIL TEMPLATES','SMS':'BO SMS TEMPLATES'}"
										name="pageType" id="pageType" headerKey="-1" applyscript="true"
										headerValue="--Please Select--"></ss:select>
								</div>
								<div id="pageType_error" class="fieldError">
									<s:fielderror>
										<s:param>pageType</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div id="pageNameDiv">
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label id="pageNameLabel">
										Content Name:
									</label>
									<em class="Req">*</em>
								</div>
								<div class="InputDiv">
									<div>
										<ss:textfield name="pageName" id="pageName" value=""
											maxlength="50" theme="myTheme" applyscript="true"
											action="com/stpl/pms/action/bo/cms/st_pms_page_checkAvailability.action"
											ajaxParam="pageName,aliasId,pageType,device"
											pattern="^[a-zA-Z0-9]*$" errorMassage="AlphaNumeric Only">
										</ss:textfield>
									</div>
									<div id="pageName_error" class="fieldError">
										<s:fielderror>
											<s:param>pageName</s:param>
										</s:fielderror>
									</div>
								</div>
							</div>
						</div>
						
						<!-- template name div for template-->
						
					<div id="pageAndTemplateTitle" style="display: none;">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label id="pageAndTemplateTitleLbl">
									Page Title:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<input type="text" name="pageTitle" value="" id="pageTitle"></input>
								</div>
								<div id="pageTitle_error" class="fieldError"></div>
							</div>
						</div>
					</div>
					<div id="requiredInfoPage" style="display: none">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Meta-Name : </label>
							</div>
							<div class="InputDiv">
								<div>
								    <input type="text" name="metaNames" id="pageMetaTag"></input>
								</div>
								<div id="pageMetaTag_error" class="fieldError"></div>
							</div>
						</div>
						
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Meta-Content: </label>
							</div>
							<div class="InputDiv" style="height:50px">
								<div>
								<input type="text" name="metaContents" value="" id="pageKeyword" ></input>
								</div>
								<div id="pageKeyword_error" class="fieldError"></div>
								<div id="moreTags"><a onclick="moreTags(this,'Meta')">Add More Meta Tags</a></div>
							</div>
						</div>
						
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Link-Type :
								</label>
							</div>
							<div class="InputDiv">
								<div>
								    <input type="text" name="linkTypes" id="pageMetaTag" ></input>
								</div>
								<div id="pageMetaTag_error" class="fieldError"></div>
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Link-Rel:
								</label>
							</div>
							<div class="InputDiv" style="height:50px">
								<div>
									<input type="text" name="linkRels" value="" id="pageKeyword" ></input>
								</div>
								<div id="pageKeyword_error" class="fieldError"></div>
							</div>
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Link-Href:
								</label>
							</div>
							<div class="InputDiv" style="height:50px">
								<div>
								<input type="text" name="linkHrefs" value="" id="pageKeyword"></input>
								</div>
									<div id="pageKeyword_error" class="fieldError"></div>
									<div id="moreTags"><a onclick="moreTags(this,'Link')">Add More Links</a></div>
							</div>
						</div>
			
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									URL:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<input type="text" name="contentUrl" id="contentUrl"
										maxlength="100"  pattern="^[a-zA-Z0-9/-]*$"
										errorMassage="Alphabets and \'/\' Only"
										action="com/stpl/pms/action/bo/cms/st_pms_page_checkURLAvailability.action"
										ajaxParam="contentUrl,aliasId,device" patternOn="both"></input>
								</div>
								<div id="contentUrl_error" class="fieldError"></div>
							</div>
						</div>
			
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Is Link:
								</label>
							</div>
							<div class="InputDiv">
								<div>
									<input id="isLinkY" class="inpSpan" type="radio" value="Y" checked="checked" name="isLink">
									<label for="isPreLoginY">Yes</label>
								 	<input id="isLinkN" class="inpSpan" type="radio" value="N" name="isLink">
								 	<label for="isPreLoginN">No</label>			
							 	</div>
								<div id="urlDisplayName_error" class="fieldError"></div>
							</div>
						</div>
						<div id="nonLandingContent">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Is Pre Login:
								</label>
							</div>
							<div class="InputDiv">
								<div>
								 <input id="isPreLoginY" class="inpSpan" type="radio" value="Y" checked="checked" name="isPreLogin">
								 <label for="isPreLoginY">Yes</label>
								 <input id="isPreLoginN" class="inpSpan" type="radio" value="N" name="isPreLogin">
								 <label for="isPreLoginN">No</label>
								</div>
									<div id="pageKeyword_error" class="fieldError"></div>
							</div>
						</div>
						
						<div class="clearFRM"></div>
						<div class="FormMainBox" id="isPostLogin">
							<div class="labelDiv">
								<label>
									Is Post Login:
								</label>
							</div>
							<div class="InputDiv">
								<div>
								<input id="isPostLoginY" class="inpSpan" type="radio" value="Y" checked="checked" name="isPostLogin">
								 <label for="isPostLoginY">Yes</label>
								 <input id="isPostLoginN" class="inpSpan" type="radio" value="N" name="isPostLogin">
								 <label for="isPostLoginN">No</label>
								</div>
									<div id="pageKeyword_error" class="fieldError"></div>
							</div>
						</div>
						</div>
						<div id="requiredInfoLandingPage" style="display: none">
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label>Is Common CSS:</label>
								</div>
								<div class="InputDiv">
									<div>
										<input id="isCommonCSSY" class="inpSpan" type="radio" value="Y"  name="isCommonCSS" onclick="refreshEditorCss()">
										 <label for="isCommonCSSY">Yes</label>
										 <input id="isCommonCSSN" class="inpSpan" type="radio" value="N" checked="checked" name="isCommonCSS" onclick="refreshEditorCss()">
										 <label for="isCommonCSSN">No</label>
									</div>
									<div id="pageKeyword_error" class="fieldError"></div>
								</div>
							</div>
							
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label>Is Custom CSS:</label>
								</div>
								<div class="InputDiv">
									<div>
									<input id="isCustomCSSY" class="inpSpan" type="radio" value="Y"  name="isCustomCSS" onclick="refreshEditorCss()">
									 <label for="isCustomCSSY">Yes</label>
									 <input id="isCustomCSSN" class="inpSpan" type="radio" value="N" checked="checked" name="isCustomCSS" onclick="refreshEditorCss()">
									 <label for="isCustomCSSN">No</label>
									</div>
										<div id="pageKeyword_error" class="fieldError"></div>
								</div>
					  		</div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
								<label>Specific CSS:</label>
								</div>
								<div class="InputDiv">
									<div>
										<select name="specificCssId" id="specificCssId" class="select1"></select>
									</div>
									<div id="pageKeyword_error" class="fieldError"></div>
								</div>
							</div>
							<div id="landingStatus">
								<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>Status:</label>
									</div>
									<div class="InputDiv">
										<div>
											<input id="statusY" class="inpSpan" type="radio" value="PUBLISHED"  name="status" checked="checked">
											 <label for="statusY">Published</label>
											 <input id="statusN" class="inpSpan" type="radio" value="UNPUBLISHED"  name="status">
											 <label for="statusN">Unpublished</label>
										</div>
										<div id="pageKeyword_error" class="fieldError"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
						
					<div id="requiredInfoPH" style="display: none;">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>Content Size :</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<select name="contentSize" id="contentSize" class="select1">										
									</select>
								
								</div>
								<div id="contentSize_error" class="fieldError"></div>
							</div>
						</div>
					</div>
						
							<div id="requiredInfoTemplate" style="display: none">
								<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
									<label>	Template Subject:</label>
										<em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<div>
									<input type="text" name="tmpltBean.templateSubject" value=""
										id="templateSubject"
										action="com/stpl/pms/action/bo/cms/st_pms_page_checkAvailability.action"
										ajaxParam="templateSubject,aliasId,pageType"
										></input>
								</div>
										<div id="templateSubject_error" class="fieldError"></div>
									</div>
							   </div>
							   <div class="clearFRM"></div>
							   <div class="FormMainBox">
								  <div class="labelDiv">
										<label>Template From Name:</label>
										<em class="Req">*</em>
								</div>
							     	 <div class="InputDiv">
									 <div>
									<input type="text" name="tmpltBean.templateFromName" value=""
										id="templateFromName" ></input>
								</div>
								 	<div id="templateFromName_error" class="fieldError"></div>
								 </div>
							 </div>
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label>
										Template From Email:
									</label>
									<em class="Req">*</em>
								</div>
								<div class="InputDiv">
									<div>
									<input type="text" name="tmpltBean.templateFromEmail" value=""
										id="templateFromEmail" 
										pattern="^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$"
										errorMassage="Email Id only" patternon="blur"></input>
								</div>
									<div id="templateFromEmail_error" class="fieldError"></div>
								</div>
							</div>
						</div>
					<div  id="description">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Description:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<ss:textfield name="pageDescription" id="pageDescription"
										maxlength="200" theme="myTheme" applyscript="true"></ss:textfield>
								</div>
								<div id="pageDescription_error" class="fieldError">
									<s:fielderror>
										<s:param>pageDescription</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
					</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox" style="height: 360px;">
							<div class="labelDiv">
								<label>
									Content:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div id="content_web">
									<div>
										<a id="TinyMCEwidgetLink"  rel="facebox"></a>
										<!--
											<input type="button" id="previewPage" value="Preview Page" onclick="getPreview('pageHTML')"/>
										-->
									</div>
									<div>
										<s:textarea name="content" id="pageHTML0" cols="93" rows="10"
											cssStyle="width:98%;" value="%{content}" ></s:textarea>
									</div>
									
								</div>
								<div id="content_client" style="display:none">
								<s:file name="contentFile" id="contentFile" 
										accept=".swf,.flv,.JPG,.jpg,.jpeg,.gif,.png,.bmp,.tiff" applyscript="true"></s:file>
								</div>
							</div>
							<s:hidden name="jsonObjVariableId" id="jsonObjVariableId"></s:hidden>
						</div>
					</div>
					<div id="requiredInfoPHClient" style="display: none">
					<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Page Type:
								</label>
							</div>
							<div class="InputDiv">
								<div>
									<ss:select theme="myTheme" cssClass="select1"
										list="#{'STATIC_PAGE':'STATIC PAGE','DYNAMIC':'DYNAMIC PAGE','Android':'ANDROID DEEPLINK','iOS':'IOS DEEPLINK'}"
										name="pageTypeClient" id="contentTypeClient" headerKey="-1" 
										headerValue="--Please Select--"></ss:select>
								</div>
								<div id="pageType_error" class="fieldError"></div>
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
								<div>
									<ss:select theme="myTheme" cssClass="select1" list="#{}"
										name="pageUrl" id="pageUrl" headerKey="-1" 
										headerValue="--Please Select--"></ss:select>
								</div>
								<div id="pageUrl_error" class="fieldError"></div>
							</div>
						</div>
					</div>
					
					<div id="helpString" style="display: none">
						<div class="FormMainBox">
						 <p style="float: left;color:black"><b style="color: red;"> Note</b></p><br>
						 <b>
						  Copy & Paste only the HTML code inside the &lt;Body&gt; tag in the HTML editor.
						 </b>
						</div>
					</div>
					<div id="page_new_div"></div>
					<div id="phAttr"></div>
					<div class="box_footer" align="right">
						<!-- <input type="button" id="addPage"
							value="Add Page For Other Language"/> -->
						<s:submit theme="simple" id="submitBtn" value="Submit"
							onclick="if(checkFormCreatePage()){ prepareVariableContent() }else{ return false}"></s:submit>
							<input id="Preview" name="saveContent" class="button" type="button" value="Preview" onclick="if(checkFormCreatePage()){getPreview('createPageFrm');}else{ return false}">
					</div>
					
					
				</s:form>
			</div>
		</div>
		<div id="tempDIv" style="display: none;"></div>
	</body>
</html>

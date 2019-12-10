<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="com/stpl/pms/action/bo/cms/js/editStaticPage.js"
			type="text/javascript"></script>
  </head>
  
  <body>
  <div class="FormSection">
  <div class="greyStrip">
					<h4>
						Content Edit Form
					</h4>
				</div>
				<s:if test="pageDetailBean != null">
				<s:form theme="simple" id="editPageDetailFrm" action="st_pms_page_editPageSave" onsubmit="return formSubmitEditPage('editPageDetailFrm','loadDiv');" enctype="multipart/form-data">
					<s:hidden id="domainSpCss" value="%{domainCssStr}"></s:hidden>
					<div class="innerBox">

					<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
					<s:hidden name="aliasId" value="%{aliasId}" id="aliasId"></s:hidden>
					<s:hidden name="device" value="%{device}"></s:hidden>
					<s:hidden name="language" value="%{language}" id="languageList"></s:hidden>
					<s:hidden name="contentId" value="%{contentId}"></s:hidden>
					<s:hidden name="pageType" value="%{pageType}"></s:hidden>
					<s:hidden id="specificCssPath" name="specificCssPath" value="%{specificCssPath}"></s:hidden>
					<s:hidden name="templateType" value="%{pageDetailBean.templateType}"></s:hidden>
					<s:hidden name="pageName" value="%{(pageType=='EMAIL' || pageTYpe=='SMS')?pageDetailBean.path:pageDetailBean.contentName}" id="pageName"></s:hidden>
					<s:hidden id="variablesBeans" value="%{variablesBeanStr}"></s:hidden>
					<s:hidden id="editorCss" name="editorCss"></s:hidden>
					<s:hidden id="defaultContentPath" value="%{defaultContentPath}"></s:hidden>
					<s:hidden id="pageUrl1" name="pageUrl1" value="%{pageUrl}"></s:hidden>
					
				<!--
					 <s:hidden id="defaultContentPath"
						value="%{new com.stpl.pms.utility.Utility().convertJSON(%{defaultContentPath})}"></s:hidden>
					
						-->
						
						<s:if test="%{pageType=='STATIC_PAGE' ||  pageType=='LANDING_PAGE'}">
						<div id="pageAndTemplateTitle">
							<div class="FormMainBox">
								<div class="labelDiv">
									<label id="pageAndTemplateTitleLbl">
									Page Title:
									</label>
								</div>
								<div class="InputDiv">
									<div>
										<input type="text" name="pageTitle" value="<s:property value="%{pageTitle}"/>" id="pageTitle" ></input>
									</div>
									<div id="pageTitle_error" class="fieldError"></div>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>Page URL:</label>
									</div>
									<div class="InputDiv">
										<div>
											<input type="text" name="contentUrl" value="<s:property value="%{pageDetailBean.url}"/>" id="contentUrl" readonly="true" ></input>
										</div>
										<div id="pageTitle_error" class="fieldError"></div>
									</div>
								</div>
							<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>Meta-Name :</label>
									</div>
								<div class="InputDiv">
									<div>
										<input type="text" name="metaNames" id="pageMetaTag" value="<s:property value="%{metaNames[0]}"/>" ></input>
									</div>
									<div id="pageMetaTag_error" class="fieldError"></div>
								</div>
							</div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label>Meta-Content:</label>
								</div>
								<div class="InputDiv" style="height:50px">
									<div>	
										<input type="text" name="metaContents" value="<s:property value="%{metaContents[0]}"/>" id="pageKeyword" ></input>
									</div>
									<div id="pageKeyword_error" class="fieldError"></div>
										<s:if test="metaNames.length<=1"><div id="moreTags"><a onclick="moreTags(this,'Meta')">Add More Meta Tags</a></div></s:if>
								</div>
							</div>
								<s:if test="metaNames!=null"><s:iterator value="%{metaNames}" status="metaNames" begin="1">
									<div class="FormMainBox">
										<div class="labelDiv">
											<label>Meta-Name :</label>
										</div>
										<div class="InputDiv">
											<div>
												<input type="text" name="metaNames" id="pageMetaTag" value="<s:property value="%{top}"/>" ></input>
											</div>
											<div id="pageMetaTag_error" class="fieldError"></div>
										</div>
									</div>
									<div class="FormMainBox">
										<div class="labelDiv">
												<label>Meta-Content:</label>
										</div>
										<div class="InputDiv" style="height:50px">
											<div>
												<input type="text" name="metaContents" value="<s:property value="%{metaContents[#metaNames.index+1]}"/>" id="pageKeyword" ></input>
											</div>
											<div id="pageKeyword_error" class="fieldError"></div>
											<div id="moreTags"><a onclick="moreTags(this,'Meta')">Add More Meta Tags</a></div>
										</div>
									</div>
									</s:iterator></s:if>
										<div class="clearFRM"></div>
											<div class="FormMainBox">
												<div class="labelDiv">
													<label>Link-Type :</label>
												</div>
												<div class="InputDiv">
													<div>
				    									<input type="text" name="linkTypes" value="<s:property value="%{linkTypes[0]}"/>" id="pageMetaTag" ></input>
													</div>
													<div id="pageMetaTag_error" class="fieldError"></div>
												</div>
											</div>
										<div class="FormMainBox">
											<div class="labelDiv">
												<label>Link-Rel:</label>
											</div>
											<div class="InputDiv">
													<div>
													<input type="text" name="linkRels" value="<s:property value="%{linkRels[0]}"/>" id="pageKeyword" ></input>
													</div>
												<div id="pageKeyword_error" class="fieldError"></div>
											</div>
										</div>
									<div class="FormMainBox">
										<div class="labelDiv">
											<label>Link-Href:</label>
										</div>
										<div class="InputDiv" style="height:50px">
											<div>
												<input type="text" name="linkHrefs" value="<s:property value="%{linkHrefs[0]}"/>" id="pageKeyword" ></input>
											</div>
											<div id="pageKeyword_error" class="fieldError"></div>
												<s:if test="linkHrefs.length<=1"><div id="moreTags"><a onclick="moreTags(this,'Link')">Add More Links</a></div></s:if>
										</div>
									</div>
									<s:if test="linkHrefs!=null">
										<s:iterator value="%{linkHrefs}" status="linkHrefs" begin="1">
											<div class="FormMainBox">
												<div class="labelDiv">
													<label>Link-Type :</label>
												</div>
												<div class="InputDiv">
													<div>
			    										<input type="text" name="linkTypes" value="<s:property value="%{linkTypes[#linkHrefs.index]}"/>" id="pageMetaTag" ></input>
													</div>
													<div id="pageMetaTag_error" class="fieldError"></div>
												</div>
											</div>
											<div class="FormMainBox">
												<div class="labelDiv">
													<label>Link-Rel:</label></div>
												<div class="InputDiv">
													<div>
														<input type="text" name="linkRels" value="<s:property value="%{linkRels[#linkHrefs.index]}"/>" id="pageKeyword"></input>
													</div>
													<div id="pageKeyword_error" class="fieldError"></div>
												</div>
											</div>
											<div class="FormMainBox">
												<div class="labelDiv">
													<label>Link-Href:</label>
												</div>
												<div class="InputDiv" style="height:50px">
													<div>
														<input type="text" name="linkHrefs" value="<s:property value="%{top}"/>" id="pageKeyword" ></input>
													</div>
													<div id="pageKeyword_error" class="fieldError"></div>
													<div id="moreTags"><a onclick="moreTags(this,'Link')">Add More Links</a></div>
												</div>
											</div>
									   </s:iterator>
									</s:if>
									<div class="clearFRM"></div>
										<div class="FormMainBox">
											<div class="labelDiv">
												<label>Is Link:</label>
											</div>
											<div class="InputDiv">
												<div>
													<input id="isLinkY" class="inpSpan" type="radio" value="Y" <s:if test="%{pageDetailBean.isLink==\"Y\"}">checked="checked"</s:if> name="isLink">
														 <label for="isPreLoginY">Yes</label>
				 										 <input id="isLinkN" class="inpSpan" type="radio" value="N" <s:if test="%{pageDetailBean.isLink==\"N\"}">checked="checked"</s:if> name="isLink">
														 <label for="isPreLoginN">No</label>
												</div>
												<div id="urlDisplayName_error" class="fieldError"></div>
											</div>	
									  </div>
									  <div id="nonLandingContent">
									  <div class="clearFRM"></div>
										<div class="FormMainBox">
											<div class="labelDiv">
												<label>Is Pre Login:</label>
											</div>
											<div class="InputDiv">
												<div>
													 <input id="isPreLoginY" class="inpSpan" type="radio" value="Y" <s:if test="%{pageDetailBean.isPreLogin==\"Y\"}">checked="checked"</s:if> name="isPreLogin">
														 <label for="isPreLoginY">Yes</label>
													 <input id="isPreLoginN" class="inpSpan" type="radio" value="N" <s:if test="%{pageDetailBean.isPreLogin==\"N\"}">checked="checked"</s:if> name="isPreLogin">
													 <label for="isPreLoginN">No</label>
												</div>
												<div id="pageKeyword_error" class="fieldError"></div>
											</div>
										</div>
									<div class="clearFRM"></div>
									<div class="FormMainBox">
										<div class="labelDiv">
											<label>Is Post Login:
											</label>
										</div>
										<div class="InputDiv">
											<div>
												<input id="isPostLoginY" class="inpSpan" type="radio" value="Y" <s:if test="%{pageDetailBean.isPostLogin==\"Y\"}">checked="checked"</s:if> name="isPostLogin">
													 <label for="isPostLoginY">Yes</label>
													 <input id="isPostLoginN" class="inpSpan" type="radio" value="N" <s:if test="%{pageDetailBean.isPostLogin==\"N\"}">checked="checked"</s:if> name="isPostLogin">
													 <label for="isPostLoginN">No</label>
											</div>
											<div id="pageKeyword_error" class="fieldError"></div>
											</div>
									</div>
									</div>
									
										<s:if test="%{pageType=='LANDING_PAGE'}">
										
										<div class="clearFRM"></div>
										<div class="FormMainBox">
											<div class="labelDiv">
												<label>Is Common CSS:</label>
											</div>
											<div class="InputDiv">
												<div>
												<input id="isCommonCSSY" class="inpSpan" type="radio" value="Y"  <s:if test="%{pageDetailBean.isCommonCSS==\"Y\"}">checked="checked" </s:if> name="isCommonCSS" onclick="refreshEditorCss()">
												 <label for="isCommonCSSY">Yes</label>
												 <input id="isCommonCSSN" class="inpSpan" type="radio" value="N"  <s:if test="%{pageDetailBean.isCommonCSS==\"N\"}">checked="checked" </s:if> name="isCommonCSS" onclick="refreshEditorCss()">
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
												<input id="isCustomCSSY" class="inpSpan" type="radio" value="Y"  <s:if test="%{pageDetailBean.isCustomCSS==\"Y\"}">checked="checked" </s:if> name="isCustomCSS" onclick="refreshEditorCss()">
												 <label for="isCustomCSSY">Yes</label>
												 <input id="isCustomCSSN" class="inpSpan" type="radio" value="N"  <s:if test="%{pageDetailBean.isCustomCSS==\"N\"}">checked="checked" </s:if> name="isCustomCSS" onclick="refreshEditorCss()">
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
												<s:select list="domainCssMap" name="specificCssId" cssClass="select1"
													id="specificCssId" headerKey="-1"
													headerValue="--Please Select--" listKey="%{key}"
													listValue="%{value.cssName}" value="%{pageDetailBean.specificCssId}"/>
										</div>
												<div id="pageKeyword_error" class="fieldError"></div>
											</div>
										</div>
										<div class="clearFRM"></div>
										<div class="FormMainBox">
											<div class="labelDiv">
												<label>Status:</label>
											</div>
											<div class="InputDiv">
												<div>
												<input id="statusY" class="inpSpan" type="radio" value="PUBLISHED"  <s:if test="%{pageDetailBean.status==\"PUBLISHED\"}">checked="checked" </s:if> name="status">
												 <label for="statusY">Published</label>
												 <input id="statusN" class="inpSpan" type="radio" value="UNPUBLISHED"  <s:if test="%{pageDetailBean.status==\"UNPUBLISHED\"}">checked="checked" </s:if> name="status">
												 <label for="statusN">Unpublished</label>
												</div>
													<div id="pageKeyword_error" class="fieldError"></div>
											</div>
								  		</div>
									</s:if>
							</s:if>
							
							<s:elseif test="%{pageType=='SMS' || pageType=='EMAIL'}">
									<div id="pageAndTemplateTitle">
									<div class="FormMainBox">
										<div class="labelDiv">
											<label id="pageAndTemplateTitleLbl">
											Template Title:
											</label>
										</div>
										<div class="InputDiv">
											<div>
												<input type="text" name="pageTitle" value="<s:property value="%{pageTitle}"/>" id="pageTitle" ></input>
											</div>
											<div id="pageTitle_error" class="fieldError"></div>
										</div>
									</div>
								</div>
								<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>Template Subject:</label>
											<em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<div>
											<input type="text" name="tmpltBean.templateSubject" value="<s:property value="%{pageDetailBean.tmpBean.templateSubject}"/>" id="templateSubject" readonly="true" ></input>
										</div>
										<div id="pageTitle_error" class="fieldError"></div>
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
												<input type="text" name="tmpltBean.templateFromName" value="<s:property value="%{pageDetailBean.tmpBean.templateFromName}"/>" id="templateFromName" ></input>
											</div>
										<div id="pageTitle_error" class="fieldError"></div>
										</div>
									</div>
									<div class="clearFRM"></div>
									<div class="FormMainBox">
										<div class="labelDiv">
											<label>Template From Email:</label>
											<em class="Req">*</em>
										</div>
										<div class="InputDiv">
											<div>
												<input type="text" name="tmpltBean.templateFromEmail" value="<s:property value="%{pageDetailBean.tmpBean.templateFromEmail}"/>" id="templateFromEmail" pattern="^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$" errorMassage="Email Id only" patternon="blur"></input>
											</div>
											<div id="pageTitle_error" class="fieldError"></div>
										</div>
								  </div>
							</s:elseif>
						
							<s:elseif test="%{pageType=='PLACE_HOLDER_WEB' || pageType=='PLACE_HOLDER_CLIENT'}">
								<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>Content Height :</label>
										<em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<div>
											<input type="text" name="contentHeight" readonly="readonly" id="contentHeight"  applyscript="true" value="<s:property value="%{pageDetailBean.contentHeight}"/>" maxlength="100"  pattern="^[0-9]*$" errorMassage="Numeric Only" patternOn="both"></input>
										</div>
										<div id="contentHeight_error" class="fieldError"></div>
										</div>
								</div>
								<div class="clearFRM"></div>
									<div class="FormMainBox">
										<div class="labelDiv">
											<label>Content Width:</label>
											<em class="Req">*</em>
										</div>
										<div class="InputDiv">
											<div>
												<input type="text" name="contentWidth" readonly="readonly" id="contentWidth" applyscript="true" value="<s:property value="%{pageDetailBean.contentWidth}"/>" maxlength="100"  pattern="^[0-9]*$" errorMassage="Numeric Only" patternOn="both"></input>
											</div>
											<div id="contentWidth_error" class="fieldError"></div>
										</div>
									</div>
									<div class="clearFRM"></div>
										<div class="FormMainBox">
											<div class="labelDiv">
												<label>Status:</label>
											</div>
											<div class="InputDiv">
												<div>
												<input id="statusY" class="inpSpan" type="radio" value="PUBLISHED"  <s:if test="%{pageDetailBean.status==\"PUBLISHED\"}">checked="checked" </s:if> name="status">
												 <label for="statusY">Published</label>
												 <input id="statusN" class="inpSpan" type="radio" value="UNPUBLISHED"  <s:if test="%{pageDetailBean.status==\"UNPUBLISHED\"}">checked="checked" </s:if> name="status">
												 <label for="statusN">Unpublished</label>
												</div>
													<div id="pageKeyword_error" class="fieldError"></div>
											</div>
								  		</div>
									
							</s:elseif>
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
								<ss:textfield name="pageDescription" value="%{pageDetailBean.description}" id="pageDescription" maxlength="200" theme="myTheme" applyscript="true"></ss:textfield>
								</div>
									<div id="error" class="fieldError"><s:fielderror><s:param>pageDescription</s:param></s:fielderror></div>
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
							<div class="InputDiv"><div id="content_web"><div>
								<a id="TinyMCEwidgetLink" style="display: none;" rel="facebox"></a>
								<!-- <input type="button" style="display: none;" id="previewPage" value="Preview Page" onclick="getPreview('pageHTML')"/>
								 --></div><div><ss:textarea name="content" id="pageHTML0" cols="93"
															rows="5" cssStyle="width:98%;" value="%{pageDetailBean.pageHTML}" ></ss:textarea>
															
															</div>
							</div>
							<div id="content_client" style="display: none;" applyscript="true"><s:file name="contentFile" id="contentFile"  accept=".swf,.flv,.JPG" ></s:file></div>
						</div>
						<s:hidden name="jsonObjVariableId" id="jsonObjVariableId"></s:hidden>
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
									<s:if test="pageLinkList.size()>0">
									<ss:select theme="myTheme" cssClass="select1"  list="pageLinkList"
										name="pageUrl" id="pageUrl"  headerKey="-1" 
										headerValue="--Please Select--"  listKey="url"
										listValue="contentName"></ss:select>
									</s:if>	
									<s:else>
									<select name="pageUrl" id="pageUrl" class="select1">
										<option value="-1">--Please Select--</option>
										</select>
									</s:else>
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
										</div>
					
					<div class="box_footer" align="right">
					     <s:submit theme="simple" id="submitBtn" value="Save" onclick="if(checkFormEditPage()){ prepareVariableContent()}else{ return false;}"></s:submit>
					     <s:if test="%{pageType!='PLACE_HOLDER_CLIENT'}">
							<input id="Preview" name="saveContent" class="button" type="button" value="Preview" onclick="if(checkFormEditPage()){getPreview('editPageDetailFrm')}else{ return false;}">
						</s:if>
					</div>
				</s:form>
				<div id="tempDIv" style="display: none;"><s:text name="%{pageDetailBean.pageHTML}"/></div>
				</s:if>
				<s:else>
				<div class="innerBox" style="height: 40px;" align="center">
				<h4>No Records Found !</h4></div>
				</s:else>
			</div>
  </body>
</html>
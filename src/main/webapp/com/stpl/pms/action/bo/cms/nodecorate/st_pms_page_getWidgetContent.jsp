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
		<title>Widget Content</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
			$(document).ready(function(){
		
			if ($('#device').val() == 'MOBILE') {
									$('#validstyle').css('display', 'none');
									$("#validationStyle").val('downValidate');
								} else {
									$('#validstyle').css('display', 'block');
								}
								var css = $("#editorCss").val();
								tinyMCE
										.init({
											mode : "specific_textareas",
											editor_deselector : "mceNoEditor",
											content_css : css,
											theme : "advanced",
											height : "320",
											convert_urls : false,
											forced_root_block : false,
											theme_advanced_buttons1 : "addField,anchor,|,save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect",
											theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor,|,fontsizeselect",
											submit_patch : false,
											// 							    init_instance_callback : "addNewEditor",
											schema : "html5",
											init_instance_callback : function(
													editor) {
												tinyMCE.activeEditor.dom
														.loadCSS($("#editorCss")
																.val());
											},

											setup : function(ed) {
												editor = ed;
												// Add a custom button
												ed
														.addButton(
																'addField',
																{
																	title : 'Insert Fields',
																	image : 'images/field.jpg',
																	onclick : function() {
																		setupLink(
																				ed,
																				"st_pms_page_insertFields",
																				"domainId="
																						+ $(
																								'#domainId')
																								.val()
																						+ "&widgetType="
																						+ $(
																								'#widgetType')
																								.val());
																	}
																});
												ed
														.addButton(
																'anchor',
																{
																	title : 'Insert Links',
																	// image : 'images/link.png',
																	onclick : function() {
																		setupLink(
																				ed,
																				"st_pms_page_insertWidgetLinks",
																				"aliasId="
																						+ $(
																								'#aliasId')
																								.val()
																						+ "&language=1&device="
																						+ $(
																								'#device')
																								.val());
																	}
																});
											}

										});

								$('a[rel*="facebox"]').click(function(event) {
									if ($("#domainId").val() == "-1") {
										alert("No Domain Selected !");
										event.stopImmediatePropagation();
									} else if ($("#aliasId").val() == "-1") {
										alert("No Alias Name Selected !");
										event.stopImmediatePropagation();
									} else if ($("#widgetType").val() == "-1") {
										alert("No Widget Type Selected !");
										event.stopImmediatePropagation();
									}
								});
								$('a[rel*="facebox"]').facebox({
									closeImage : 'images/closelabel.png',
								});

								$("#specificCssId")
										.change(
												function() {
													if ($(this).val() != '0') {
														var cssMap = $
																.parseJSON($(
																		"#specificCssMap")
																		.val());
														$("#specificCssPath")
																.val(
																		cssMap[$(
																				this)
																				.val()].cssPath);
													} else {
														$("#specificCssPath")
																.val("");
													}
													refreshEditorCss();
												});
								//code added for making submit url div visible or none on forgot password selection on 2/12/2014
								$("#widgetType")
										.ready(
												function() {
													if ($("#widgetType").val() == "FORGOT_PWD_WIDGET") {
														$("#submitUrlDiv").css(
																"display",
																"none");
													}
												});
								$("#widgetType")
										.click(
												function() {
													if ($(this).val() == "LOGIN_WIDGET") {
														$("#submitUrlDiv").css(
																"display",
																"block");
													} else if ($(this).val() == "REGISTRATION_WIDGET") {
														$("#submitUrlDiv").css(
																"display",
																"block");
													} else {
														$("#submitUrlDiv").css(
																"display",
																"none");
													}
												});

							});
		</script>
	</head>
	<body>
	<s:hidden id="specificCssMap"
				value="%{specificCssStr}"></s:hidden>
	<s:hidden name="editorCss" id="editorCss" value="%{editorCss}"></s:hidden>
	<s:hidden id="fieldsBeanList" value="%{fieldsStr}"></s:hidden>
	<%-- <s:hidden id="portalUrl"
				value="%{new com.stpl.pms.utility.Utility().convertJSON(portalUrl)}"></s:hidden> --%>
	<s:hidden id="specificCssPath"></s:hidden>
   					   <div class="clearFRM"></div>
						<div class="FormMainBox">
        					 <div class="labelDiv">
        					  <label> Apply Common CSS: </label>
        					  <em class="Req">*</em>
       						  </div>
       						  <div class="InputDiv">
       							<s:radio name="isCommonCSS" id="isCommonCSS" list="#{'Y':'Y','N':'N'}" onclick="refreshEditorCss()"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
        					 <div class="labelDiv">
        					  <label> Apply Custom CSS: </label>
        					  <em class="Req">*</em>
       						  </div>
       						  <div class="InputDiv">
       							<s:radio name="isCustomCSS" id="isCustomCSS" list="#{'Y':'Y','N':'N'}" onclick="refreshEditorCss()"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
							<div class="FormMainBox">
        					 <div class="labelDiv">
        					  <label> Apply Specific CSS: </label>
       						  </div>
       						  <div class="InputDiv">
	   					 <ss:select theme="myTheme" cssClass="select1"
										list="%{specificCssMap}" listKey="%{key}" listValue="%{value.cssName}"
										name="specificCssId" id="specificCssId" headerKey="0"
										headerValue="--Please Select--"></ss:select>
						</div>
						</div>
						<div id = "submitUrlDiv"><!-- change list name for ispostlogin 'Y' parameter on 2/12/2014 -->
						<div class="clearFRM"></div>
							<div class="FormMainBox">
        					 <div class="labelDiv">
        					  <label> Submit URL: </label>
       						  </div>
       						  <div class="InputDiv">
	   					 <ss:select theme="myTheme" cssClass="select1"
	   					 				list="%{submitUrlList}" listKey="%{'/'+url}" listValue="%{contentName}"
										name="redirectUrl" id="redirectUrl" value="%{redirectUrl}" headerKey="-1"
										headerValue="Default Page"></ss:select>
						</div>
						</div></div>
						<div class="clearFRM"></div>
						<div id="validstyle">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Validation Style:
								</label>
								<em class="Req">*</em>
							</div>
						<div class="InputDiv">
	   					  <ss:select theme="myTheme" cssClass="select1"
										list="#{'leftValidate':'Left-side validation','downValidate':'Down-side validation','rightValidate':'Right-side validation'}"
										name="validationStyle" id="validationStyle" value="%{validationStyle}" headerKey="-1" applyscript="true"
										headerValue="--Please Select--" ></ss:select></div>
						</div>
						<div class="clearFRM"></div>
						</div>
						<div class="FormMainBox" style="height: 360px;">
							<div class="labelDiv">
								<label>
									Content:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div id="content_div">
									<div>
										<a id="TinyMCEwidgetLink" style="display: none;" rel="facebox"></a>
									</div>
									<div>
										<s:textarea  name="content" id="content" cols="93" rows="10"
											cssStyle="width:98%;"></s:textarea>
									</div>
								</div>
							</div>
						</div>
						<div id="helpString" >
							<div class="FormMainBox">
							 <p style="float: left;color:black"><b style="color: red;"> Note</b></p><br>
							 <b>
							   Do not include &lt;form&gt; tag in the HTML editor.
							 </b>
							</div>
						</div>
  </body>
</html>

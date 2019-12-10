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
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script type="text/javascript" src="<%=path %>/js/commonfunctions.js"></script>-->
	<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
			type="text/css" />
	<script type="text/javascript" src="<%=path%>/com/stpl/pms/action/bo/pm/js/email.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
	
  </head>
  
  <body>
		<div class="clear2"></div>
		<h2>
			Send Email
		</h2>
		 
		<s:hidden id="languageListJson"
						value="%{languageStr}"></s:hidden>
		<s:if test="%{domainId!=null && domainId!=-1}">

			<%-- <s:form id="tempFrm" action="/com/stpl/pms/action/bo/pm/st_pms_inbox_saveTemplateContent.action" theme="simple" enctype="multipart/form-data" > --%>
			<s:form id="tempFrm"  theme="simple" enctype="multipart/form-data" >
			<s:hidden id="pageType" name="plrEmailBean.pageType" value="EMAIL"></s:hidden>
			<s:hidden id="domainVal" name="plrEmailBean.domainVal"></s:hidden>
			<s:hidden id="searchedCriteria" name="searchedCriteria" ></s:hidden>
			<s:hidden id="reportData" name="reportData" value="%{reportData}"></s:hidden>
			<s:hidden id="reportDataType" name="reportDataType" value="%{reportDataType}"></s:hidden>
				<s:token theme="simple"></s:token>
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Send Email
						</h4>
					</div>
					<div class="innerBox">

						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Select Player
								</label>
								<!-- <em class="Req">*</em> -->
							</div>
							<div class="InputDiv" style="height:auto">
								<s:select theme="myTheme" cssClass="select1" list="%{playerMap}"
									multiple="true" data-placeholder="Select Player Here"
									name="playerIdArr" id="playerIdArr" cssStyle="height:auto" ></s:select>
							</div>
						</div>
							<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
								Alias Name
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<s:select theme="myTheme" cssClass="select1" list="%{aliasMap}"
										name="plrEmailBean.aliasId" id="regalias" headerKey="-1"
										headerValue="--Please Select--" ></s:select>
								</div>
								<div id="error" class="fieldError">
									<s:fielderror>
										<s:param>alias</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<s:hidden name="contentType" id="contentType" />
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Email Type
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:radio list="#{'manually':'Manually','temp':'Template'}" id="emailType" name="plrEmailBean.emailType" cssClass="emailType"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Sent Type
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
									<%-- <s:radio list="#{'internal':'Internal','External':'External','both':'Both'}" name="plrEmailBean.int_ext_mail" cssClass = "sentType" id="int_ext_mail"></s:radio> --%>
									<s:radio list="#{'internal':'Internal','external':'External'}" name="plrEmailBean.int_ext_mail" cssClass = "sentType" id="int_ext_mail"></s:radio>
							</div>
							<s:hidden name="errorCode" id="errorCode"></s:hidden>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Send Mail
								</label>
							</div>
							<div class="InputDiv">
							
							<s:checkbox name="plrEmailBean.sentToAll" id="sentToAll" value="sentToAll"></s:checkbox>
							All Players
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Language
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<s:select theme="myTheme" cssClass="select1" list="#{}"
										name="plrEmailBean.language" id="language" headerKey="-1"
										headerValue="--Please Select--" ></s:select>
								</div>
								<div id="error" class="fieldError">
									<s:fielderror>
										<s:param>language</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox" >
							<div class="labelDiv">
								<label>
									Select Template
								</label>
								
							</div>
							<%-- <s:if test="%{tempList!=null && tempList.size()>0}">
								<div class="InputDiv">
									<s:hidden id="tempList"
										value="%{new com.stpl.pms.utility.Utility().convertJSON(tempList)}"></s:hidden>
									<ss:select theme="simple" cssClass="select1" list="%{tempList}"
										id="templateTypeList" headerKey="-1" name="templateTypeList"
										headerValue="--Please Select--" listKey="%{templateSubject}" 
										listValue="%{templateSubject}" key="%{templateSubject}" ></ss:select>
										<!--<s:hidden id="templateType" name="templateType"></s:hidden>
								--></div>
							</s:if>
							--%>
								<!--  error messsge  start -->
								
								<!-- error messsge  end -->
						 
							
							
							<div class="InputDiv">
							<div>
								<ss:select theme="myTheme" cssClass="select1" list="%{}"
									name="tempAvailable" id="tempAvailable" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></ss:select>
								<a id ="imgBtn" href="#" onclick="javascript:return openWindow();" ><img src="<%=path %>/images/exit-top-right.png" alt="logo" style= "vertical-align: middle; margin-left: 10px; width: 13px; height: 13px;   margin-top: -3px;"></a>	
									
							</div>
							<div class="InputDiv" id="notemplate" style="display:none">
								</div>	
							<div id="domainId_error" class="fieldError">
								<s:fielderror>
									<s:param>template</s:param>
								</s:fielderror>
							</div>
						</div>
							
							
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Subject
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield id="subject" name="plrEmailBean.subject" maxlength='150'></ss:textfield>
							</div>
						</div>
							<div class="clearFRM"></div>
						<div id="contentDiv">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Content:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv" style="height: auto">
							<s:textarea name="plrEmailBean.content" id="pageHTML" cols="93"
															rows="5" cssStyle="width:98%;" ></s:textarea>
															
															</div>
						</div>
							</div>
							<!--<div class="FormMainBox" style="height: 360px;">
							<div class="labelDiv">
								<label>
									Content:
								</label>
							</div>
							<div class="InputDiv"><div id="content_web"><div>
								<a id="addVariable" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertVariables.action?" ><input type="button" id="addPage" value="Insert Variable" onclick="doGetCaretPosition(pageHTML)"/></a>
								<a id="addGraphics" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertGraphics.action?" ><input type="button" id="addPage" value="Insert Graphics" onclick="doGetCaretPosition(pageHTML)"/></a>
								<a id="addLinks" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertLinks.action?" ><input type="button" id="addPage" value="Insert Links" onclick="doGetCaretPosition(pageHTML)"/></a>
								<a id="addPlaceHolders" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertPlaceHolder.action?"></a>
								<a id="addWidget" style="display: none;" rel="facebox" href="com/stpl/pms/action/bo/cms/st_pms_page_insertWidget.action?"></a>
								<input type="button" style="display: none;" id="previewPage" value="Preview Page" onclick="getPreview('pageHTML')"/>
								</div><div><s:textarea name="content" id="pageHTML" cols="93"
															rows="5" cssStyle="width:98%;" value="%{content}"></s:textarea>
															
															</div>
									<div id="error" class="fieldError"><s:fielderror><s:param>pageHTML</s:param></s:fielderror></div>
							</div>
							<div id="content_client" style="display: none;"><s:file name="contentFile" id="contentFile"  accept=".swf,.flv,.JPG" ></s:file></div>
						</div>
						<s:hidden name="jsonObjVariableId" id="jsonObjVariableId"></s:hidden>
					</div>
					--><div id="page_new_div"></div>
					<div id="phAttr"></div>
										</div>
					
					<div class="box_footer" align="right">
					     <s:submit theme="simple" id="submitBtn" value="Send" ></s:submit>
					</div>
					</div>
				</s:form>
				
				
			
			</s:if>
		<s:else>
			<div class="clear2"></div>
			<!-- error messsge  start -->
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Message
					</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg " style="width: 90%">
						<span class="alert_close"></span><strong>Info: </strong>No Domain
						Selected !!
					</div>
				</div>
			</div>
			<!-- error messsge  end -->
		</s:else>
  </body>
</html>

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

		<title>Edit Content</title>

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

		<SCRIPT type="text/javascript">
		var pageLinkList;
			$(document).ready(function() {
	 			$('a[rel*="facebox"]').facebox({
					closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
  	 			});
  	 			
  	 			$('#domainId').change(function(){
					$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  				var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  				$.each(aliasMap,function(index, value) {
	  					$('#aliasId').append($('<option></option>').val(index).html(value));
	  				});
	  			});	
  	 			
  	 			$('#aliasId').change(function(){
  	 				var jsonList = '["languageList"]';
				    var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+$('#domainId').val()+"&jsonList="+jsonList,"");
  	 				$('#language').empty().append($('<option></option>').val("-1").html("----Please Select----"));
  	 				$.each(map["languageList"], function(index, value) {
						$('#language').append($('<option></option>').val(value.languageId).html(value.languageName));
					});
					$("#loadDiv").html('');
					pageLinkList = undefined;
  	 			});
  	 			
  	 			$('#language').change(function(){
  	 			if($(this).val()!="-1"){
  	 				pageLinkList = _ajaxCallJson("com/stpl/pms/action/bo/cms/st_pms_page_getLinks.action","aliasId="+ $('#aliasId').val() +"&pageType="+$('#pageType').val()+"&language="+$(this).val()+"&device="+$('#device').val());
  	 				$('#contentId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
  	 				for ( var i = 0; i < pageLinkList.length; i++) {
  	 				var id = pageLinkList[i].contentId;
						$("#contentId").append(
								'<option value="' +id  + '">'
										+ pageLinkList[i].contentName + '</option>');
					}
					}else
						$('#contentId').empty();
					$("#loadDiv").html('');
  	 			});
  	 			$('#pageType').change(function(){
  	 				$('#contentId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
  	 				$("#loadDiv").html('');
  	 				pageLinkList = undefined;
  	 				$('#language').val("-1");
  	 				if($(this).val()=="EMAIL"){
  	 					$("#device").val("PC");
  	 				  //$("#device").attr("disabled","disabled");
  	 				}else if($(this).val()=="SMS"){
  	 					$("#device").val("MOBILE");
  	 					$("#device").attr("disabled","disabled");
  	 				}else{
  	 					$("#device").removeAttr("disabled");
  	 				}
  	 			});
  	 			$('#device').change(function(){
  	 			if($(this).val()!="-1"){
  	 				$('#contentId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
  	 				if(pageLinkList != undefined )
  	 				for ( var i = 0; i < pageLinkList.length; i++) {
  	 				var id = pageLinkList[i].contentId;
  	 				if(pageLinkList[i].device == $(this).val())
						$("#contentId").append(
								'<option value="' +id  + '">'
										+ pageLinkList[i].contentName + '</option>');
					}
					}else
						$('#contentId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
  	 				$("#loadDiv").html('');
  	 			});  	 			
  	 			 window.onbeforeunload = function(){
	 _ajaxCallText("com/stpl/pms/action/bo/cms/st_pms_page_closePreview.action");
	 }
  	 		});
		</SCRIPT>

	</head>

	<body>
		<div id="container">
			<h2>
				Edit Content

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Content Search Form
					</h4>
				</div>
				<s:form theme="simple" id="editPageFrm" method="POST"
					enctype="multipart/form-data"
					action="st_pms_page_editPageDetailsLoad" target="loadDiv">
					<s:hidden id="pageList" value=""></s:hidden>
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
								<div id="error" class="fieldError">
									<s:fielderror>
										<s:param>domainId</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Alias Name:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
										<ss:select theme="myTheme" cssClass="select1"
											list="%{}" name="aliasId" id="aliasId"
											headerKey="-1" headerValue="--Please Select--" applyscript="true"></ss:select>
								</div>
								<div id="error" class="fieldError">
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
								<div id="error" class="fieldError">
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
								<label>
									Language:
								</label>
								<em class="Req">*</em>
							</div>
								<div class="InputDiv">
									<div>
										<ss:select theme="myTheme" cssClass="select1"
											list="%{languageBeanList}" listKey="languageId"
											listValue="languageName" name="language" id="language"
											headerKey="-1" headerValue="--Please Select--"
											applyscript="true"></ss:select>
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
									<label>
										Device:
									</label>
									<em class="Req">*</em>
								</div>
								<div class="InputDiv">
									<ss:select theme="myTheme" cssClass="select1"
										list="{'PC','TAB','MOBILE'}" name="device" id="device"
										headerKey="-1" applyscript="true" headerValue="--Please Select--"></ss:select>
								</div>
							</div><div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Content Name/Template Type:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<ss:select theme="myTheme" cssClass="select1" list="#{}"
										name="contentId" id="contentId" headerKey="-1" applyscript="true"
										headerValue="--Please Select--"></ss:select>
								</div>
								<div id="error" class="fieldError">
									<s:fielderror>
										<s:param>contentId</s:param>
									</s:fielderror>
								</div>
							</div>
						</div>
						</div>
						
					</div>
					<div class="box_footer" align="right">
						<s:submit theme="simple" id="submitBtn" value="Get Details"></s:submit>
					</div>
				</s:form>
			</div>
			<div id="loadDiv"></div>
		</div>


	</body>
</html>

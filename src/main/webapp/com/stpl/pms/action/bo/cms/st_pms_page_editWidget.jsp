<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath =(String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Edit Widget</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="css/facebox.css" media="screen" rel="stylesheet"
			type="text/css" />
		<script src="js/facebox.js" type="text/javascript"></script>
		<script src="js/tiny_mce/tiny_mce_src.js" type="text/javascript"></script>
		<script src="com/stpl/pms/action/bo/cms/js/widget.js"
			type="text/javascript"></script>
			<script type="text/javascript" >
				$(document).ready(function(){
					$("#domainId, #aliasId #device").change(function(){
						$("#widgetType").val(-1);
						$("#widgetName").val(-1);
						$("#contentDiv").html('');
						$("#buttonDiv").css("display","none");
						if($(this).attr('id')=="domainId") {
							var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
							$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
							$.each(aliasMap,function(index, value) {
								$('#aliasId').append($('<option></option>').val(index).html(value));
	  						});
						}
					});
				});
			 </script>
	</head>
	<body>
		<div id="container">
			<h2>
				Edit Widget

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Edit Widget Form
					</h4>
				</div>
				<s:form theme="simple" id="editWidget" method="POST"
					enctype="multipart/form-data" action="st_pms_page_saveWidget" onsubmit="return prepareContent();">
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<s:hidden id="widgetId" name="widgetId"></s:hidden>
					<s:hidden id="widgetList" value=""></s:hidden>
					<s:hidden id="widgetContent" name="widgetContent"></s:hidden>
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
									<ss:select theme="myTheme" cssClass="select1"
										list="%{domainMap}"
										name="domainId" id="domainId" headerKey="-1"
										headerValue="--Please Select--"
										listKey="%{key}"
										listValue="%{value}" applyscript="true"></ss:select>
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
										list="%{}"
										name="aliasId" id="aliasId" headerKey="-1"
										headerValue="--Please Select--" applyscript="true"></ss:select>
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
											list="{'PC','TAB','MOBILE'}"
											name="device" id="device" headerKey="-1" applyscript="true"
											headerValue="--Please Select--"></ss:select></div>
	       					  </div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
        					 <div class="labelDiv">
        					  <label> Widget Type: </label>
        					  <em class="Req">*</em>
       						  </div>
       						  <div class="InputDiv"><!-- code added for adding forgot password widget in drop down on 1/12/2014 -->
	   					  <ss:select theme="myTheme" cssClass="select1"
										list="#{'LOGIN_WIDGET':'LOGIN','REGISTRATION_WIDGET':'REGISTRATION','FORGOT_PWD_WIDGET':'FORGOT PASSWORD'}"
										name="widgetType" id="widgetType" headerKey="-1" applyscript="true"
										headerValue="--Please Select--" onchange="getWidgetName()"></ss:select>
       					 </div>
       					 </div>
						 <div class="clearFRM"></div>
						 <div class="FormMainBox">
								<div class="labelDiv">
									<label>
										Widget Name:
									</label>
									<em class="Req">*</em>
								</div>
								<div class="InputDiv">
									<div>
										<ss:select theme="myTheme" cssClass="select1"
										list="{}"
										name="widgetName" id="widgetName" headerKey="-1" applyscript="true"
										headerValue="--Please Select--" onchange="getWidgetContent()">
										</ss:select></div>
										
									</div>
								</div>
							<div id="contentDiv"></div>
						</div>
						<div id="buttonDiv" style="display: none" class="box_footer" align="right">
							<input type="submit" id="submitBtn" value="Submit">
						</div>
				</s:form>
			</div>
		</div>
	</body>
</html>

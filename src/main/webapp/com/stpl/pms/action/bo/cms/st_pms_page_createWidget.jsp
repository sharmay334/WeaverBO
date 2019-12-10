<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Create Widget</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css" />
		<script src="js/facebox.js" type="text/javascript"></script>
		<script src="js/tiny_mce/tiny_mce_src.js" type="text/javascript"></script>
		<script src="com/stpl/pms/action/bo/cms/js/widget.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#domainId").change(function(){
					var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
					$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$.each(aliasMap,function(index, value) {
						$('#aliasId').append($('<option></option>').val(index).html(value));
	  				});
				});
			});
		</script>
		
	</head>
	<body>
		<div id="container">
			<h2>
				Create Widget

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Create Widget Form
					</h4>
				</div>
				<s:form theme="simple" id="createWidget" method="POST"
					enctype="multipart/form-data" action="st_pms_page_saveWidget" onsubmit="return prepareContent();">
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<s:hidden id="widgetContent" name="widgetContent"></s:hidden>
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
											list="{'PC','TAB','MOBILE'}" onchange="hideValidationStyle();"
											name="device" id="device" headerKey="-1" applyscript="true" ajaxAction="com/stpl/pms/action/bo/cms/st_pms_page_getWidgetDetails.action"
										 target="contentDiv" ajaxParam="aliasId,device"
											headerValue="--Please Select--"></ss:select></div>
	       					  </div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
        					 <div class="labelDiv">
        					  <label> Widget Type: </label>
        					  <em class="Req">*</em>
       						  </div>
       						  <!-- added new field to the drop down of forgot password on 28/11/2014 -->
       						  <div class="InputDiv">
	   					  <ss:select theme="myTheme" cssClass="select1"
										list="#{'LOGIN_WIDGET':'Login Widget','REGISTRATION_WIDGET':'Registration Widget','FORGOT_PWD_WIDGET':'Forgot Password Widget'}"
										name="widgetType" id="widgetType" headerKey="-1" applyscript="true"
										headerValue="--Please Select--" ></ss:select></div>
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
										<ss:textfield name="widgetName" id="widgetName" 
											action="com/stpl/pms/action/bo/cms/st_pms_page_checkWidgetNameAval.action"
											ajaxParam="aliasId,widgetType,widgetName"
											maxlength="50" theme="myTheme" applyscript="true"
											pattern="^[a-zA-Z0-9]*$" errorMassage="AlphaNumeric Only">
										</ss:textfield>
								</div>
							</div>

						<div class="clearFRM"></div>
							<div class="FormMainBox">
        					 <div class="labelDiv">
        					  <label> URL Link: </label>
        					  <em class="Req">*</em>
       						  </div>
       						  <div class="InputDiv">
	   					 <ss:textfield name="contentUrl" id="contentUrl" maxlength="100"
											action="com/stpl/pms/action/bo/cms/st_pms_page_checkURLAvailability.action"
											ajaxparam="contentUrl,aliasId,device" pattern="^[a-zA-Z0-9/-]*$"
											maxlength="50" theme="myTheme" applyscript="true"
											errormassage="Alphabets and '/' Only">
										</ss:textfield>
						</div>
						</div>
						
						<div id="contentDiv"></div>
					</div>
					<div style="display: none" id="buttonDiv" class="box_footer" align="right">
							<input type="submit" id="submitBtn" value="Submit">
					</div>
				</s:form>
			</div>
		</div>
	</body>
</html>

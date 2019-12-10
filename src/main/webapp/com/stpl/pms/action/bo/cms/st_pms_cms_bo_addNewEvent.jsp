<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Add New Communication Event</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript">
	$(document).ready(
			function() {
				$('#domainId').change(
						function() {
							$("#pageName").prop('selectedIndex', 0);
							$('#aliasId').empty().append(
									$('<option></option>').val("-1").html(
											"----Please Select----"));
							var aliasMap = _ajaxCallJson(
									"com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="
											+ $(this).val(), "");
							$.each(aliasMap, function(index, value) {
								$('#aliasId').append(
										$('<option></option>').val(index).html(
												value));
							});
						});

				$('#aliasId').change(
						function() {
							$("#pageName").prop('selectedIndex', 0);
							var jsonList = '["languageList"]';
							var map = _ajaxCallJson(
									"com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="
											+ $('#domainId').val()
											+ "&jsonList=" + jsonList, "");
							$('#language').empty().append(
									$('<option></option>').val("-1").html(
											"----Please Select----"));
							$.each(map["languageList"], function(index, value) {
								$('#language').append(
										$('<option></option>').val(
												value.languageId).html(
												value.languageName));
							});
						});
			});

	$("#language").change(function() {
		$("#pageName").prop('selectedIndex', 0);
	});
</script>
</head>
<body>
	<s:form name="addNewEvent" id="addNewEvent" theme="simple"
		action="st_pms_cms_bo_saveNewEvent">

		<s:token name="strutsToken" id="strutsToken"></s:token>
		<s:hidden name="contentPath" id="contentPath"></s:hidden>
		<s:hidden name="pageType" id="pageType"></s:hidden>

		<!-----------------------------------Part 1------------------------------------------------- -->

		<div class="FormSection">
			<div class="greyStrip">
				<h4>Domain Information</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:if test="%{domainId>1}">
							<s:hidden name="addNewEvent.domainId" value="%{domainId}"
								id="domainId"></s:hidden>
							<s:property value="%{domainName}" />
						</s:if>
						<s:else>
							<ss:select theme="myTheme" cssClass="select1" list="%{domainMap}"
								name="addNewEvent.domainId" id="domainId" headerKey="-1"
								headerValue="--Please Select--" listKey="%{key}"
								listValue="%{value}" applyscript="true"></ss:select>
						</s:else>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Alias Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1" list="%{}"
							name="addNewEvent.aliasId" id="aliasId" headerKey="-1"
							headerValue="--Please Select--" applyscript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>
			</div>
		</div>

		<!-- -------------------------------------Part 2------------------------------------------------------ -->

		<div class="FormSection">
			<div class="greyStrip">
				<h4>Add New Communication Event</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Event Type: </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="eventType" name="addNewEvent.eventType"
							theme="myTheme" style="width:51%;" applyscript="true"
							pattern="^[A-Z_]*$" errorMassage="Enter only capital alphabet and underscore(_)"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Channel Type: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1"
							list="{'SMS','Email'}" name="addNewEvent.channelType"
							id="channelType" headerKey="-1" headerValue="--Please Select--"
							applyscript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Charge To: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1"
							list="{'PLAYER','DOMAIN'}" name="addNewEvent.chargeTo"
							id="chargeTo" headerKey="-1"
							headerValue="--Please Select--" applyscript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Amount: </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="amount" name="addNewEvent.amount"
							theme="myTheme" style="width:51%;" applyscript="true"
							maxlength="8" pattern="^[0-9]*.{1}[0-9]*$" errorMassage="Enter only numeric character"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Status: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1"
							list="{'ACTIVE','INACTIVE'}" name="addNewEvent.detailStatus"
							id="detailStatus" headerKey="-1" headerValue="--Please Select--"
							applyscript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Player Option: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1" list="{'Y','N'}"
							name="addNewEvent.playerOption" id="playerOption"
							headerKey="-1" headerValue="--Please Select--" applyscript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>
			</div>
		</div>

		<!-----------------------------Part 3----------------------------------------------->

		<div class="FormSection">
			<div class="greyStrip">
				<h4>Event Template Mapping</h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Template Type: </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="TemplateType"
							name="addNewEvent.templateType" theme="myTheme"
							style="width:51%;" applyscript="true"
							pattern="^[A-Z_]*$" errorMassage="Enter only capital alphabet and underscore(_)"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Language: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div>
							<ss:select theme="myTheme" cssClass="select1"
								list="%{languageBeanList}" listKey="languageId"
								listValue="languageName" name="addNewEvent.languageId"
								id="language" headerKey="-1" headerValue="--Please Select--"
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
						<label> Template Path: </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="templatePath"
							name="addNewEvent.templatePath" theme="myTheme"
							style="width:51%;" applyscript="true"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Template Subject: </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="templateSubject"
							name="addNewEvent.templateSubject" theme="myTheme"
							style="width:51%;" applyscript="true"
							pattern="^[A-Z_]*$" errorMassage="Enter only capital alphabet and underscore(_)"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Template From Name: </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="templateFromName"
							name="addNewEvent.templateFromName" theme="myTheme"
							style="width:51%;" applyscript="true"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Template From Email: </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="templateFromEmail"
							name="addNewEvent.templateFromEmail" theme="myTheme"
							style="width:51%;" applyscript="true"></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Sent On: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1"
							list="{'EXTERNAL','INTERNAL'}" name="addNewEvent.sentOn"
							id="sentOn" headerKey="-1" headerValue="--Please Select--"
							applyscript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>


				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Status: </label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1"
							list="{'ACTIVE','INACTIVE'}"
							name="addNewEvent.templateStatus" id="templateStatus"
							headerKey="-1" headerValue="--Please Select--" applyscript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>

				<!-- ---------------------------------------------------------------- -->

				<div class="box_footer" align="right">
					<s:submit value="Submit" align="right" cssClass="button"
						theme="simple" />
				</div>
			</div>
		</div>
	</s:form>

</body>
</html>
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

		<title>Security Question Management</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<SCRIPT type="text/javascript"
			src="<%=path%>/com/stpl/pms/action/bo/dm/js/dm.js"></SCRIPT>
		<script>
			$(document).ready(function(){
				var domainId = <%=request.getAttribute("bydefaultSelectedDomain") %>;
				if(domainId != 0 && domainId != -1){
					$("#domainId").val(domainId);
					_ajaxCallDiv('st_pms_dm_bo_loadSecQuesPage.action?domainId='+domainId,'','formDiv');
		//			$("#domainId").attr("disabled",true);
				}
			});
		</script>
	</head>

	<body>
	<s:form name="form" id="form" theme="simple"
				action="st_pms_dm_bo_secQuesPageSubmit">
				<s:token name="strutsToken" id="strutsToken" />
		<div id="container">
			<h2>
				Security Question Management
			</h2>
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Security Question Form
						</h4>
					</div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								<s:label value="Domain Name:" />
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden value="%{domainId}" id="domainId" name="domainId" ></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select list="%{domainMap}" headerKey="-1" applyscript="true"
								headerValue="Please Select" name="domainId" id="domainId"
								cssClass="select1" theme="myTheme"
								ajaxAction="st_pms_dm_bo_loadSecQuesPage.action"
								target="formDiv" value="%{bydefaultSelectedDomain}"></ss:select>
							</s:else>
						</div>
					</div>
				</div>
				<div id="formDiv"></div>
		</div>
		</s:form>
		
		<div id="fieldDiv" style="display: none;">

			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						New Security Question
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Security Question:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield id="secQues" name="secQues" maxlength="100" pattern="^[A-Za-z,? ]*$"
								errorMassage="Only [A-Za-z,? ] characters allowed" theme="myTheme" applyscript="true" placeholder="Please enter Question here." ></ss:textfield>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
				<ss:button id="addButton" cssClass="button" value="Add To List"></ss:button>
				</div>
			</div>
		</div>
	</body>
</html>

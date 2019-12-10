<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/extended-struts2-tags" prefix="ss"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
	$(document).ready(function() {
		createBubble();
		$("#widgetFrm").submit(function(){
			insertWidget(this);
			close_facebox();
			return false;
		});
	});
</script>
	</head>
	<body>
	<form id="widgetFrm" action="#">
		<div id="container" style="min-height: 0px; width: auto;">
			<div style="width: 100%; height: 0.1px;"></div>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Insert Widgets
					</h4>
				</div>
				<s:hidden id="widgetListJson"
					value="%{cmsBeansStr}"></s:hidden>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv" style="width: 35%">
							<label>
								Widgets Type:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv" style="width: 62%"><!-- code added for adding content of forgot _password on 1/12/2014 -->
							<ss:select cssClass="select1" cssStyle="width: 100%;"
								list="#{'LOGIN_WIDGET':'LOGIN','REGISTRATION_WIDGET':'REGISTRATION','FORGOT_PWD_WIDGET':'FORGOT PASSWORD'}"
								id="widgetType" headerKey="-1"
								headerValue="---Please Select---"  onchange="getWidget()"
								applyscript="true" name="widgetType"></ss:select>
						</div>
					</div>
					<div class="FormMainBox">
								<div class="labelDiv" style="width: 35%">
									<label>
										Widget Name:
									</label>
									<em class="Req">*</em>
								</div>
								<div class="InputDiv" style="width: 62%">
									<div>
										<ss:select cssClass="select1" cssStyle="width: 100%;"
										list="{}"
										name="widgetName" id="widgetName" headerKey="-1" applyscript="true"
										headerValue="--Please Select--">
										</ss:select></div>
										
									</div>
					</div>
					<s:hidden id="w_url" value=""></s:hidden>
					<s:hidden id="w_name" value=""></s:hidden>
					<div class="box_footer" align="right">
						<s:submit theme="simple" id="submitBtn" value="Insert"></s:submit>
					</div>
				</div>
			</div>
		</div>
		</form>
	</body>
</html>

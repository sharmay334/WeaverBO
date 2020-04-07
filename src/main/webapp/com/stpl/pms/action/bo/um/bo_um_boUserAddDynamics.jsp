<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>Add Dynamics</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>
<body>
	<div class="clear2"></div>
	<h2>
		Dynamic
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Dynamic Values To Tab</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_create_field_values.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Select Dynamic Field </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<s:select name="fieldName" id="fieldName" headerKey="-1"
									headerValue="Select choice" list="fieldList"
									cssClass="select1" theme="myTheme"  applyscript="true"></s:select>

								<div id="fieldName_error" class="fieldError">
									<s:fielderror>
										<s:param>fieldName</s:param>
									</s:fielderror>
								</div>
							</div>
					</div>
					
					
					
				</s:if>
			</div>
			<div class="box_footer" align="right">
				<input type="submit" value='Search' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

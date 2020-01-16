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

<title>Create Unit</title>
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
		Create Unit
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Create Unit</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_create_unitMeasure.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Type </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="unitType" id="unitType" headerKey="-1"
								headerValue="Select Stock Name" list="{'Compound','Simple'}"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>
							<div id="unitType_error" class="fieldError">
								<s:fielderror>
									<s:param>unitType</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Symbol </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="unitSymbol" id="unitSymbol"
								theme="myTheme" applyscript="true"></ss:textfield>

							<div id="unitSymbol_error" class="fieldError">
								<s:fielderror>
									<s:param>unitSymbol</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Formal Name </label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="formalName" id="formalName"
								theme="myTheme"></ss:textfield>

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Unit Quantity Code(UQC) </label>
						</div>
						<div class="InputDiv">
							<s:select name="UQC" id="UQC" headerKey="-1"
								headerValue="Select Stock Name" list="UQCList"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>

							<div id="UQC_error" class="fieldError">
								<s:fielderror>
									<s:param>UQC</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> No of decimal places </label>
						</div>
						<div class="InputDiv">
							<ss:textfield value="0" maxlength="100" name="decimalPlace" id="decimalPlace"
								theme="myTheme"></ss:textfield>
							<div id="decimalPlace_error" class="fieldError">
								<s:fielderror>
									<s:param>decimalPlace</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
				</s:if>
			</div>
			<div class="box_footer" align="right">
				<input type="submit" value='Create' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

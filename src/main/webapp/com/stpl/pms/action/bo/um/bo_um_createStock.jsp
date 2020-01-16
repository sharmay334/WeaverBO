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

<title>Create Group</title>
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
		Create Stock Group
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Create Stock Group</h4>
		</div>
		<s:form action="/com/stpl/pms/action/bo/um/bo_um_create_stock.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Name </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="stockName" id="stockName"
								theme="myTheme" applyscript="true"></ss:textfield>
							<div id="stockName_error" class="fieldError">
								<s:fielderror>
									<s:param>stockName</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Under </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="stockUnder" headerKey="-1"
								headerValue="Select Stock Name" list="{'Primary'}"
								cssClass="select1" theme="myTheme" applyscript="true"></s:select>

							<div id="stockUnder_error" class="fieldError">
								<s:fielderror>
									<s:param>stockUnder</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Should quantities of items be added </label><em
								class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="quantityCheck" headerKey="-1"
								headerValue="Select Any One" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme"></s:select>

							<div id="quantityCheck_error" class="fieldError">
								<s:fielderror>
									<s:param>quantityCheck</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Set/alter GST Details </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="gstDetailCheck" headerKey="-1"
								headerValue="Select Any One" list="{'Yes','No'}"
								cssClass="select1" theme="myTheme"></s:select>

							<div id="gstDetailCheck_error" class="fieldError">
								<s:fielderror>
									<s:param>gstDetailCheck</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					

				</s:if>

			</div>
			<div class="box_footer" align="right">
				<%-- <s:submit value="Search" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
					 --%>
				<input type="submit" value='Create Stock Group' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

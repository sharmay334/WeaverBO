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

<title>Create Stock Item</title>
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
		Create Stock Item
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Create Stock Item</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_create_stockCatagory.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Name </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="stockItemName"
								id="stockItemName" theme="myTheme" applyscript="true"></ss:textfield>
							<div id="stockItemName_error" class="fieldError">
								<s:fielderror>
									<s:param>stockItemName</s:param>
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
							<s:select name="stockUnderItem" id="stockUnderItem"
								headerKey="-1" headerValue="Select Stock Name"
								list="{'Primary'}" cssClass="select1" theme="myTheme"
								applyscript="true"></s:select>

							<div id="stockUnderItem_error" class="fieldError">
								<s:fielderror>
									<s:param>stockUnderItem</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Category </label>
						</div>
						<div class="InputDiv">
							<s:select name="stockItemCat" id="stockItemCat" headerKey="-1"
								headerValue="Select Stock Name" list="stockItemCatList"
								cssClass="select1" theme="myTheme"></s:select>

							<div id="stockItemCat_error" class="fieldError">
								<s:fielderror>
									<s:param>stockItemCat</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Units </label>
						</div>
						<div class="InputDiv">
							<s:select name="stockItemUnit" id="stockItemUnit" headerKey="-1"
								headerValue="Select Stock Name" list="stockItemUnitList"
								cssClass="select1" theme="myTheme"></s:select>

							<div id="stockItemCat_error" class="fieldError">
								<s:fielderror>
									<s:param>stockItemCat</s:param>
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

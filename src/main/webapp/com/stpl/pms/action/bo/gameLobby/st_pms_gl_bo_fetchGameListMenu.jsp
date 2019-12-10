<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Player Search</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

	</head>

	<body>
		<h2>
			Add or Update Vendor Game List
		</h2>
		<s:form id="vendorGameListFrm"
			action="st_pms_bo_getGameListForVendor" cssClass="ajaxFrm"
			target="searchResult" theme="simple">

			<div class="FormSection">

				<div class="greyStrip">
					<h4>
						Add or Update Vendor Game List
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Vendor List
							</label>
						</div>
						<div class="InputDiv">
							<div>
								<s:select theme="myTheme" cssClass="select2" list="vendorMap"
									name="vendorId" id="vendorId" headerKey="-1"
									headerValue="--Please Select--" key="key" value="value"
									cssStyle="width: 182px"></s:select>
							</div>
						</div>
					</div>
				</div>

				<div class="box_footer" align="right">
					<s:submit name="Search" value="Add or Update" cssClass="button"
						id="formSubmit"></s:submit>

				</div>
			</div>

			<div id="searchResult">

			</div>

		</s:form>

	</body>
</html>
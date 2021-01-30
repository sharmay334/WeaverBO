<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>

<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Search Employee</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

</head>
<body>
	<h2>
		Search Employee
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				Search Employee
			</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_searchBoUser_Search_attendance.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

		
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Select Company </label>
						</div>
						<div class="InputDiv">
							<s:select name="companyName" list="companyNameList"
								cssClass="select1" theme="myTheme"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Select Employee </label>
						</div>
						<div class="InputDiv">
							<s:select name="employeeName" list="employeeNameList"
								cssClass="select1" theme="myTheme"></s:select>
						</div>
					</div>
				

			</div>
			<div class="box_footer" align="right">
				<s:submit value="Search" align="left" cssStyle="margin-left:0px"
					cssClass="button" theme="simple"></s:submit>


			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>

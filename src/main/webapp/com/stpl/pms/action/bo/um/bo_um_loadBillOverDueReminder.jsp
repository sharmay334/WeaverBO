<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Bill Reminder
</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%-- <script type="text/javascript"
	src="com/stpl/pms/action/bo/reports/js/common_report.js"></script> --%>
	<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">
	
</head>

<body>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				Bill OverDue Report
			</h4>
		</div>
		<s:form id="searchUserFrm" action="/com/stpl/pms/action/bo/um/st_pms_bo_rep_BillReminderReportshow.action"
			 target="searchResult" theme="simple">
			<s:hidden name="reportData" id="reportData"></s:hidden>

			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select Ledger </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:select theme="myTheme" cssClass="select1"
								list="%{ledgerNames}" name="ledgerName" id="ledgerName" headerKey="0"
								headerValue="--Please Select--" onchange="showBills(this.value)"></s:select>

						</div>
					</div>
				</div>

				
			</div>
			<div class="box_footer" align="right">
			 <div id="waitDiv" class="animated-button-div"
					style="margin-left: 0px; display: none;">
					<div class="animated-striped" style="padding: 3px 20px 2px 20px;">Wait...</div>
				</div> 
				<s:submit name="Search" value="Search" id="searchButton"
					cssClass="button"></s:submit>
			</div>
		</s:form>
	</div>
	<div id="searchResult"></div>
</body>
</html>

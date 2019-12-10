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

<title>Mis Report</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="css/facebox_bigsize.css" media="screen" rel="stylesheet"
	type="text/css" />
<link href="css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.dataTables.mis.css" rel="stylesheet"
	type="text/css" />
<script src="js/facebox.js" type="text/javascript"></script>
<script type="text/javascript" src="js/datatable/jquery.dataTables.js"></script>
<script type="text/javascript"
	src="com/stpl/pms/action/bo/reports/js/common_report.js"></script>
<script type="text/javascript"
	src="com/stpl/pms/action/bo/reports/js/MisReport.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
<script type="text/javascript"
	src="com/stpl/pms/action/bo/reports/js/mis_report_pagination.js"></script>
</head>
<body>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				<s:property value="%{headerName}" />
			</h4>
		</div>

		<s:form id="playerSearchFrm"
			action="st_pms_bo_rep_dailyRakeWithRoyalty"
			cssClass="jsonFrmMisReport" theme="simple" name="misSearchForm"
			callBack="convertDataTable()" enctype="multipart/form-data">
			<s:hidden name="reportData" id="reportData"></s:hidden>
			<s:hidden name="reportTypeName" id="reportTypeName"></s:hidden>
			<s:hidden name="redirect" id="redirect" value="Search"></s:hidden>
			<s:hidden name="startIndex" id="startIndex" value="0"></s:hidden>
			<s:hidden name="recordTofetch" id="recordTofetch" value="101"></s:hidden>
			
			<s:hidden name="proceName" id="proceName" cssClass="commonFilter" value="dailyRakeAndRoyaltyForAlias"></s:hidden>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="small-text-box-section">
						<div class="div-5 din-5-new">
							<div class="lbl-name-div-misReport line-ht">Domain</div>

							<div class="small-text-box-div">
								<s:if test="%{domainId>1}">
									<s:hidden name="domainId" value="%{domainId}" id="domainId"
										cssClass="select2 commonFilter"></s:hidden>
									<s:property value="%{domainName}" />
								</s:if>
								<s:else>
									<s:select theme="myTheme" cssClass="select2 commonFilter"
										list="%{domainMap}" name="domainId" id="domainId"
										headerKey="0" headerValue="--Please Select--" listKey="%{key}"
										value="%{bydefaultSelectedDomain}" listValue="%{value}"
										cssStyle="width: 210px">
									</s:select>
								</s:else>
							</div>
						</div>

						<div class="div-5 din-5-new">
							<div class="lbl-name-div-misReport txt-rt line-ht">
								Alias<em class="Req">*</em>
							</div>

							<div class="small-text-box-div">
								<s:select name="aliasId" id="aliasId" list="{}" headerKey="-1"
									headerValue="--Please Select--" cssClass="commonFilter"
									onChange="getMisReportTypeAliasWise();" cssStyle="width: 180px" />
							</div>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox" id="defaultDateFilter">
					<div class="small-text-box-section">

						<div class="div-5">
							<div class="lbl-name-div-misReport line-ht" id="fromDateField">
								From Date</div>
<%-- fromDateRoyalty --%> 
							<div class="small-text-box-div">
								<ss:textfield id="fromDate" name="fromDate"
									cssClass="dateField commonFilter" theme="myTheme"
									readonly="true"></ss:textfield>
							</div>
						</div>
						<div class="div-5">
							<div class="lbl-name-div-misReport line-ht" id="toDateField">To
								Date</div>
<%-- toDateRoyalty --%>
							<div class="small-text-box-div">
								<ss:textfield id="toDate" name="toDate"
									cssClass="dateField commonFilter" theme="myTheme"
									readonly="true"></ss:textfield>
							</div>
						</div>

					</div>
				</div>
			</div>
			<div class="box_footer" align="right">
				<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
					<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div>
				<s:submit name="Search" id="searchButtonMis" value="Search"
					cssClass="button" ></s:submit>
				<%-- <ss:button name="Download" id="download" value="Download Excel"
					onclick="setParam()" cssClass="button"></ss:button> --%>
			</div>
		</s:form>
	</div>
	<div id="waitDivNext" class="animated-button-div"
		style="margin-left: 0px; display: none">
		<div class="animated-striped">Wait</div>
	</div>
	<div id="waitDivPrev" class="animated-button-div"
		style="margin-left: 0px; display: none">
		<div class="animated-striped" style="padding: 3px 20px 2px 20px;">Wait...</div>
	</div>
	<div id="searchResult"></div>
</body>
</html>


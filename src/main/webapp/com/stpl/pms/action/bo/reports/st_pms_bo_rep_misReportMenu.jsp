<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
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

		<s:form id="playerSearchFrm" action="st_pms_bo_rep_searchMISReport"
			cssClass="jsonFrmMisReport" theme="simple" name="misSearchForm"
			callBack="convertDataTable()" enctype="multipart/form-data">
			<s:hidden name="reportData" id="reportData"></s:hidden>
			<s:hidden name="reportTypeName" id="reportTypeName"></s:hidden>
			<s:hidden name="redirect" id="redirect" value="Search"></s:hidden>
			<s:hidden name="startIndex" id="startIndex" value="0"></s:hidden>
			<s:hidden name="recordTofetch" id="recordTofetch" value="101"></s:hidden>
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
							<div class="lbl-name-div-misReport txt-rt line-ht">Alias<em class="Req">*</em>
							</div>
							
							<div class="small-text-box-div">
								<s:select name="aliasId" id="aliasId"
									list="{}" headerKey="-1"
									headerValue="--Please Select--" cssClass="commonFilter" onChange="getMisReportTypeAliasWise();"
									cssStyle="width: 180px" />
							</div>

						</div>
						<div class="div-5 din-5-new	">
							<div class="lbl-name-div-misReport txt-rt line-ht">Report Type</div>
							<div class="small-text-box-div">
								<s:select name="proceName" id="proceName"
									list="{}" headerKey="-1"
									headerValue="--Please Select--" cssClass="commonFilter"
									cssStyle="width: 180px" />
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

							<div class="small-text-box-div">
								<ss:textfield id="fromDate" name="fromDate"
									cssClass="dateField commonFilter" theme="myTheme" readonly="true"></ss:textfield>
							</div>
						</div>
						<div class="div-5">
							<div class="lbl-name-div-misReport line-ht" id="toDateField">To
								Date</div>

							<div class="small-text-box-div">
								<ss:textfield id="toDate" name="toDate"
									cssClass="dateField commonFilter" theme="myTheme" readonly="true"></ss:textfield>
							</div>
						</div>

					</div>
				</div>
				<div id="MisRegsitrationReport" style="display: none"
					class="reportFilter">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div-misReport">State</div>

								<div class="small-text-box-div">
									<s:select list="#{}" headerKey="-1"
										headerValue="----Please Select----" theme="myTheme"
										cssClass="select2 MisRegsitrationReport" name="state"
										id="stateList" cssStyle="width: 182px; margin-left:0px"></s:select>
								</div>
							</div>
							<div class="div-2">
								<div class="lbl-name-div-misReport">City</div>

								<div class="small-text-box-div">
									<s:textfield name="city" theme="myTheme" id="city"
										cssClass="text-field-small MisRegsitrationReport"></s:textfield>
								</div>
							</div>
							<div class="div-3">
								<div class="lbl-name-div-misReport">Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist name="statusType"
										cssClass="MisRegsitrationReport"
										list="#{'deposit':'Deposit','free':'Free'}"></s:checkboxlist>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div-misReport">Email Verify</div>

								<div class="small-text-box-div">
									<s:radio id="emailVerify" name="emailIdVerify"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" theme="myTheme"
										value="%{'Both'}" cssClass="MisRegsitrationReport" />
								</div>
							</div>
							<div class="div-2">
								<div class="lbl-name-div-misReport">Mobile Verify</div>
								<div class="small-text-box-div">
									<s:radio id="mobileVerify" name="mobileNoVerify"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" theme="myTheme"
										value="%{'Both'}" cssClass="MisRegsitrationReport" />
								</div>

							</div>
							<div class="div-3">
								<div class="lbl-name-div-misReport">DOB Verify</div>
								<div class="small-text-box-div">
									<s:radio id="dobVerify" name="birthDateVerify" theme="myTheme"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" value="%{'Both'}"
										cssClass="MisRegsitrationReport" />
								</div>

							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">Birth Date</div>

								<div class="small-text-box-div-new">
									<s:textfield name="fromDob" id="fromDateDob" readonly="true"
										placeholder="From Date" cssClass="text-field-small"
										cssStyle="width:178px"></s:textfield>
									<s:textfield name="toDob" id="toDateDob" readonly="true"
										placeholder="To Date" cssClass="text-field-small"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
										

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5" style=" width: 670px;">

								<div class="lbl-name-div-misReport">Sign Up</div>

								<div class="small-text-box-div-new" style="width: auto;">
									<s:checkboxlist name="signType"
										cssClass="MisRegsitrationReport"
										list="#{'direct':'Direct Sign up','campaign':'Campaign Sign up','refer':'Refer Sign up','zapak':'Zapak Sign up','ola':'Online Affiliated'}"></s:checkboxlist>
								</div>
							</div>
						<div class="div-5" style="width: auto;">
								<div class="lbl-name-div-misReport">Reg. Device</div>
								<div class="small-text-box-div-new" style="width: auto;">
									<s:checkboxlist id="regDevice" name="playerStatusReg"
										list="#{'pc':'PC','mobile':'MOBILE'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>
							</div>
						</div>
					</div>
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
						<div class="div-5">
								<div class="lbl-name-div-misReport">Profile Status</div>

								<div class="small-text-box-div-new">
									<s:checkboxlist id="profileStatusReg" name="profileStatusReg"
										list="#{'plrMini':'MINI','plrFull':'FULL'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>
							</div>		
							<div class="div-5">
								<div class="lbl-name-div-misReport">Player Status</div>

								<div class="small-text-box-div-new">
									<s:checkboxlist id="playerStatusReg" name="playerStatusReg"
										list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>
							</div>
						</div>
					</div>
							
				</div>

				<div id="MisPlayerReport" style="display: none" class="reportFilter">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									First Deposit Date</div>
								<div class="small-text-box-div-new">
									<s:textfield name="fromDateFirstDepPR" id="fromDateFirstDepPR"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:158px"></s:textfield>

									<s:textfield name="toDateFirstDepPR" id="toDateFirstDepPR"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small playerReport"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Last Deposit Date</div>

								<div class="small-text-box-div-new">
									<s:textfield name="fromDateLastDepPR" id="fromDateLastDepPR"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small playerReport"
										cssStyle="width:158px"></s:textfield>

									<s:textfield name="toDateLastDepPR" id="toDateLastDepPR"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small playerReport"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Total Deposit Amount</div>

								<div class="small-text-box-div-new">
									<ss:textfield name="minTotalDepAmtPR" id="minTotalDepAmtPR"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="blur"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxTotalDepAmtPR" id="maxTotalDepAmtPR"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="blur"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>

								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Last Withdrawal Date</div>
								<div class="small-text-box-div-new">
									<s:textfield name="fromDateLastWithPR" id="fromDateLastWithPR"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small playerReport"
										cssStyle="width:158px"></s:textfield>

									<s:textfield name="toDateLastWithPR" id="toDateLastWithPR"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small playerReport"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Total Withdrawal Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minTotalWithAmtPR" id="minTotalWithAmtPR"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="blur"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxTotalWithAmtPR" id="maxTotalWithAmtPR"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="blur"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>

								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Last Cash Game Played Date</div>
								<div class="small-text-box-div-new">
									<s:textfield name="fromDateLastCashGamePR"
										id="fromDateLastCashGamePR" readonly="true"
										placeholder="From Date"
										cssClass="text-field-small playerReport"
										cssStyle="width:158px"></s:textfield>

									<s:textfield name="toDateLastCashGamePR"
										id="toDateLastCashGamePR" readonly="true"
										placeholder="To Date" cssClass="text-field-small playerReport"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Cash Balance</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minCashBalPR" id="minCashBalPR"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="blur"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxCashBalPR" id="maxCashBalPR"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="blur"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Bonus Balance</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minBonusBalPR" id="minBonusBalPR"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="blur"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxBonusBalPR" id="maxBonusBalPR"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="blur"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Promo Chips Balance</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minPromoBalPR" id="minPromoBalPR"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="blur"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxPromoBalPR" id="maxPromoBalPR"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="blur"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Sign Up</div>
								<div class="small-text-box-div-new">
									<s:checkboxlist name="signType"
										cssClass="MisRegsitrationReport"
										list="#{'direct':'Direct Sign up','campaign':'Campaign Sign up','refer':'Refer Sign up','zapak':'Zapak Sign up','ola':'Online Affiliated'}"></s:checkboxlist>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									No of Cash Game</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minNoCashGamePR" id="minNoCashGamePR"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="blur"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxNoCashGamePR" id="maxNoCashGamePR"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="blur"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									No of Free Games</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minNoFreeGamePR" id="minNoFreeGamePR"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="blur"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxNoFreeGamePR" id="maxNoFreeGamePR"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="blur"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									No of Tournament Played</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minNoTourPlayedPR" id="minNoTourPlayedPR"
										theme="myTheme" cssStyle="width:150px" placeholder="Minimum"
										readonly="true" cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxNoTourPlayedPR" id="maxNoTourPlayedPR"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										readonly="true" placeholder="Maximum"
										cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Status</div>
								<div class="small-text-box-div-new">
									<s:checkboxlist name="statusType"
										cssClass="MisRegsitrationReport"
										list="#{'deposit':'Deposit','free':'Free'}"></s:checkboxlist>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">

							<div class="div-1">
								<div class="lbl-name-div-misReport">Profile Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="profileStatusPR" name="playerStatusPR"
										list="#{'plrMini':'MINI','plrFull':'FULL'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>

							</div>
							<div class="div-2">
								<div class="lbl-name-div-misReport">Player Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="playerStatusPR" name="playerStatusPR"
										list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>

							</div>							
							<div class="div-3">
								<div class="lbl-name-div-misReport">Email Verified</div>
								<div class="small-text-box-div">
									<s:radio id="emailVerif" name="emailVerif"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" theme="myTheme"
										value="%{'Both'}" cssClass="MisRegsitrationReport" />
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="MisDepositAndWithdrawal" style="display: none"
					class="reportFilter">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5" style="width: 340px;margin-left: 0PX;">
								<div class="lbl-name-div-misReport">Transaction</div>
								<div class="small-text-box-div" style="width: 240px;">
									<s:radio id="tranType" name="tranType"
										list="#{'DEPOSIT':'DEPOSIT','WITHDRAWAL':'WITHDRAWAL','Both':'Both'}"
										theme="myTheme" value="%{'Both'}"
										cssClass="MisDepositAndWithdrawal" />
								</div>
							</div>
							
						</div>
					</div>
					
				<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">	
					<div class="div-5">
								<div class="lbl-name-div-misReport">Profile Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="profileStatus" name="profileStatus"
										list="#{'plrMini':'MINI','plrFull':'FULL'}"
										cssClass="MisDepositAndWithdrawal" theme="myTheme"></s:checkboxlist>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport">Player Status</div>
									<div class="small-text-box-div">
										<s:checkboxlist id="playerStatus" name="playerStatus"
											list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
											cssClass="MisDepositAndWithdrawal" theme="myTheme"></s:checkboxlist>
									</div>
								</div>	
							</div>
						</div>		
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Deposit Amount</div>
								<div class="small-text-box-div-new">

									<ss:textfield name="minimumDepAmt" id="minimumDepAmt"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="blur"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maximumDepAmt" id="maximumDepAmt"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Withdrawal Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minimumWithAmt" id="minimumWithAmt"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="blur"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maximumWithAmt" id="maximumWithAmt"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									First Deposit date</div>
								<div class="small-text-box-div-new">
									<s:textfield name="fromDateFirstDep" id="fromDateFirstDep"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:150px"></s:textfield>
									<s:textfield name="toDateFirstDep" id="toDateFirstDep"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Last Deposit Date</div>
								<div class="small-text-box-div-new">
									<s:textfield name="fromDateLastDep" id="fromDateLastDep"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:150px"></s:textfield>
									<s:textfield name="toDateLastDep" id="toDateLastDep"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									First Withdrawal Date</div>
								<div class="small-text-box-div-new">
									<s:textfield name="fromDateFirstWith" id="fromDateFirstWith"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:150px"></s:textfield>
									<s:textfield name="toDateFirstWith" id="toDateFirstWith"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Last Withdrawal Date</div>
								<div class="small-text-box-div-new">
									<s:textfield name="fromDateLastWith" id="fromDateLastWith"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:150px"></s:textfield>
									<s:textfield name="toDateLastWith" id="toDateLastWith"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Last Deposit Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minimumLastDepAmt" id="minimumLastDepAmt"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maximumLastDepAmt" id="maximumLastDepAmt"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Last Withdrawal Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minimumLastWithAmt" id="minimumLastWithAmt"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maximumLastWithAmt" id="maximumLastWithAmt"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
						</div>
					</div>

				</div>


				<div id="MisPlayerBalance" style="display: none"
					class="reportFilter">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">							
							<div class="div-1">
								<div class="lbl-name-div-misReport">Profile Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="profileStatusPB" name="profileStatusPB"
										list="#{'plrMini':'MINI','plrFull':'FULL'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>

							</div>
							<div class="div-2">
								<div class="lbl-name-div-misReport">Player Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="playerStatusPB" name="playerStatusPB"
										list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>

							</div>
							<div class="div-3">
								<div class="lbl-name-div-misReport">Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist name="statusType"
										cssClass="MisRegsitrationReport"
										list="#{'deposit':'Deposit','free':'Free'}"></s:checkboxlist>
								</div>

							</div>

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Total Deposit Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minTotDepAmt" id="minTotDepAmt"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxTotDepAmt" id="maxTotDepAmt"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Total Bonus</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minTotBonus" id="minTotBonus"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxTotBonus" id="maxTotBonus"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Total Winning Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minTotWin" id="minTotWin" theme="myTheme"
										cssStyle="width:150px" pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxTotWin" id="maxTotWin" theme="myTheme"
										cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Total Wager Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minTotWgr" id="minTotWgr" theme="myTheme"
										cssStyle="width:150px" pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxTotWgr" id="maxTotWgr" theme="myTheme"
										cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Player Cash Balance</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minAccBal" id="minAccBal" theme="myTheme"
										cssStyle="width:150px" pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxAccBal" id="maxAccBal" theme="myTheme"
										cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Tournament Winning</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minTourWin" id="minTourWin" theme="myTheme"
										cssStyle="width:150px" pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both" readonly="true"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxTourWin" id="maxTourWin" theme="myTheme"
										cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" readonly="true" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
						</div>
					</div>

				</div>




				<div id="MisWagerAndWinning" style="display: none"
					class="reportFilter">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">Game Type</div>
								<div class="small-text-box-div-new" id="gType1">
									<s:checkboxlist name="gameType" id="gameType" 
										list="#{'freeGame':'Free','cashGame':'Cash'}"></s:checkboxlist>
									
								</div>
								<div class="small-text-box-div-new" id="gType2">
									<s:checkboxlist name="gameType" id="gameType" 
										list="#{'cashGame':'Cash'}"></s:checkboxlist>
								</div>
							</div>

							<div class="div-5">
								<div class="lbl-name-div-misReport">Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist name="statusType" id="statusType"
										cssClass="MisRegsitrationReport"
										list="#{'deposit':'Deposit','free':'Free'}"></s:checkboxlist>
								</div>

							</div>

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div-misReport">Profile Status</div>
								<div class="small-text-box-div">
									<s:checkboxlist id="profileStatusWW" name="profileStatusWW"
										list="#{'plrMini':'MINI','plrFull':'FULL'}"
										cssClass="MisRegsitrationReport" theme="simple"></s:checkboxlist>
								</div>
							</div>
							<div class="div-2">
								<div class="lbl-name-div-misReport">Player Status</div>
								<div class="small-text-box-div">
									<s:checkboxlist id="playerStatusWW" name="playerStatusWW"
										list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
										cssClass="MisRegsitrationReport" theme="simple"></s:checkboxlist>
								</div>
							</div>
							<div class="div-3">
								<div class="lbl-name-div-misReport">Device</div>
								<div class="small-text-box-div">
									<s:checkboxlist name="statusType" id="statusType"
										cssClass="MisRegsitrationReport"
										list="#{'pc':'PC','mobile':'Mobile','tab':'Tablet'}"></s:checkboxlist>
								</div>
							</div>


						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
						<div class="div-5">
								<div class="lbl-name-div-misReport">
									Wager Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minWagAmount" id="minWagAmount"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxWagAmount" id="maxWagAmount"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" >
									Winning Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minWinAmt" id="minWinAmt" theme="myTheme"
										cssStyle="width:150px" pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxWinAmt" id="maxWinAmt" theme="myTheme"
										cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">Last Wager</div>

								<div class="small-text-box-div-new">
									<s:textfield name="lastWgrFromDate" id="lastWgrFromDate"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:160px"></s:textfield>
									<s:textfield name="lastWgrToDate" id="lastWgrToDate"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small"
										cssStyle="width:160px; margin-left:8px"></s:textfield>
								</div>
							</div>

							
							<div class="div-5">
								<div class="lbl-name-div-misReport">
									Vip Level</div>

								<div class="small-text-box-div-new">
									<s:select list="#{}" headerKey="0"
										headerValue="----Please Select----" theme="myTheme"
										cssClass="select2" name="vipLevel" id="vipLevel"
										cssStyle="width: 182px; margin-left:0px"></s:select>
								</div>
							</div>


						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
							<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">First Deposit Date</div>

								<div class="small-text-box-div-new">
									<s:textfield name="firstDepFromDate" id="firstDepFromDate"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:160px"></s:textfield>
									<s:textfield name="firstDepToDate" id="firstDepToDate"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small"
										cssStyle="width:160px; margin-left:8px"></s:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="margin-top:6px;">OLA Players</div>

								<div class="small-text-box-div-new">
									<div class="InputDiv inpRadio" style="float: left;">
									
									<s:checkbox name="isOla" id="isOla"></s:checkbox> <s:label for="isOla" value="Exclude"></s:label>
										
								</div>
								</div>

							</div>							
						</div>
						</div>
				</div>

				<div id="MisPlayerBonus" style="display: none" class="reportFilter">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">Profile Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="profileStatusBO" name="profileStatusBO"
										list="#{'plrMini':'MINI','plrFull':'FULL'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport">Player Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="playerStatusBO" name="playerStatusBO"
										list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
								<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Total Bonus</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minPlrBonus" id="minPlrBonus"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxPlrBonus" id="maxPlrBonus"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
						</div>
					</div>	
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Release Bonus</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minReleaseBonus" id="minReleaseBonus"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxReleaseBonus" id="maxReleaseBonus"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Pending Bonus</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minPendingBonus" id="minPendingBonus"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxPendingBonus" id="maxPendingBonus"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Bonus Count</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minNoBonus" id="minNoBonus" theme="myTheme"
										cssStyle="width:150px" pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxNoBonus" id="maxNoBonus" theme="myTheme"
										cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>

							<div class="div-5">
								<div class="lbl-name-div-misReport">Bonus Expiry Date</div>

								<div class="small-text-box-div-new">
									<s:textfield name="bonusExDateFrom" id="bonusExDateFrom"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:160px"></s:textfield>
									<s:textfield name="bonusExDateTo" id="bonusExDateTo"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small"
										cssStyle="width:160px; margin-left:8px"></s:textfield>
								</div>
							</div>


						</div>
					</div>

				</div>


				<div id="MisMixReport" style="display: none" class="reportFilter">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">Player Status</div>
								<div class="small-text-box-div-new">
									<s:radio id="playerStatusMX" name="playerStatusMX"
										list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE','Both':'Both'}"
										theme="myTheme" value="%{'Both'}"
										cssClass="MisRegsitrationReport" />
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport">Email Verified</div>
								<div class="small-text-box-div-new">
									<s:radio id="emailVerified" name="emailVerified"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" theme="myTheme"
										value="%{'Both'}" cssClass="MisRegsitrationReport" />
								</div>
							</div>


						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">DOB Verified</div>
								<div class="small-text-box-div-new">
									<s:radio id="dobVerified" name="dobVerified"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" theme="myTheme"
										value="%{'Both'}" cssClass="MisRegsitrationReport" />
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport">Mobile Verified</div>
								<div class="small-text-box-div-new">
									<s:radio id="moblVerified" name="moblVerified"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" theme="myTheme"
										value="%{'Both'}" cssClass="MisRegsitrationReport" />
								</div>
							</div>

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist name="statusType" id="statusType"
										cssClass="MisRegsitrationReport"
										list="#{'deposit':'Deposit','free':'Free'}"></s:checkboxlist>
								</div>

							</div>

							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Total Deposit Amount</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minTotDepAmount" id="minTotDepAmount"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxTotDepAmount" id="maxTotDepAmount"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">First Deposit Date</div>

								<div class="small-text-box-div-new">
									<s:textfield name="firstDepFromDate" id="firstDepFromDate"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:160px"></s:textfield>
									<s:textfield name="firstDepToDate" id="firstDepToDate"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small"
										cssStyle="width:160px; margin-left:8px"></s:textfield>
								</div>
							</div>

							<div class="div-5">
								<div class="lbl-name-div-misReport">Last Deposit Date</div>

								<div class="small-text-box-div-new">
									<s:textfield name="lastDepFromDate" id="lastDepFromDate"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small" cssStyle="width:160px"></s:textfield>
									<s:textfield name="lastDepToDate" id="lastDepToDate"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small"
										cssStyle="width:160px; margin-left:8px"></s:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Free Game Count</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minFreeGame" id="minFreeGame"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxFreeGame" id="maxFreeGame"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>

							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Cash Game Count</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minCashGame" id="minCashGame"
										theme="myTheme" cssStyle="width:150px"
										pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxCashGame" id="maxCashGame"
										theme="myTheme" cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>

						</div>
					</div>

				</div>
				<div id="MisPlayerBalanceDayWise" style="display: none"
					class="reportFilter">

					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">Transaction Date</div>

								<div class="small-text-box-div-new">
									<s:textfield name="txnDate" id="txnDate" readonly="true"
										placeholder="Transaction Date"
										cssClass="text-field-small txnDate" cssStyle="width:160px"></s:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport">Profile Status</div>
								<div class="small-text-box-div-new">
									<s:checkboxlist id="profileStatusPBD" name="profileStatusPBD"
										list="#{'plrMini':'MINI','plrFull':'FULL'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
						<div class="div-5">
								<div class="lbl-name-div-misReport">Player Status</div>
								<div class="small-text-box-div-new">
									<s:checkboxlist id="playerStatusPBD" name="playerStatusPBD"
										list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport">Status</div>
								<div class="small-text-box-div">
									<s:checkboxlist name="statusType"
										cssClass="MisRegsitrationReport"
										list="#{'deposit':'Deposit','free':'Free'}"></s:checkboxlist>
								</div>
							</div>

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">
								<div class="lbl-name-div-misReport">Player Cash Balance</div>
								<div class="small-text-box-div-new">
									<ss:textfield name="minAccBal" id="minAccBal" theme="myTheme"
										cssStyle="width:150px" pattern="^[0-9]*\.?[0-9]*$"
										errorMassage="Enter Value in correct format."
										placeholder="Minimum" patternOn="both"
										cssClass="text-field-small">
									</ss:textfield>
									<ss:textfield name="maxAccBal" id="maxAccBal" theme="myTheme"
										cssStyle="width:150px; margin-left:8px"
										pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
										errorMassage="Enter Value in correct format."
										placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-5">
								<div class="lbl-name-div-misReport" style="width: 100px;">
									Last Login Date</div>

								<div class="small-text-box-div-new">
									<s:textfield name="fromDateLastLogin" id="fromDateLastLogin"
										readonly="true" placeholder="From Date"
										cssClass="text-field-small playerBalanceReportDayWise"
										cssStyle="width:158px"></s:textfield>

									<s:textfield name="toDateLastLogin" id="toDateLastLogin"
										readonly="true" placeholder="To Date"
										cssClass="text-field-small playerBalanceReportDayWise"
										cssStyle="width:150px; margin-left:8px"></s:textfield>
								</div>
							</div>
						</div>
					</div>

				</div>

				<div id="MisDailyPlayReport" style="display: none"
					class="reportFilter">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div-misReport">Status</div>
								<div class="small-text-box-div">
									<s:checkboxlist name="statusType"
										cssClass="MisRegsitrationReport"
										list="#{'deposit':'Deposit','free':'Free'}"></s:checkboxlist>
								</div>
							</div>

							<div class="div-2">
								<div class="lbl-name-div-misReport">Profile Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="profileStatusDPR" name="profileStatusDPR"
										list="#{'plrMini':'MINI','plrFull':'FULL'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>

							</div>
							<div class="div-3">
								<div class="lbl-name-div-misReport">Player Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="playerStatusDPR" name="playerStatusDPR"
										list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>

							</div>
						</div>
					</div>
					<div class="clearFRM"></div>

				</div>

				
				<div id="MisPlrLoginReport" style="display: none"
					class="reportFilter">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div-misReport">Status</div>
								<div class="small-text-box-div">
									<s:checkboxlist name="statusType"
										cssClass="MisRegsitrationReport"
										list="#{'deposit':'Deposit','free':'Free'}"></s:checkboxlist>
								</div>
							</div>

							<div class="div-2">
								<div class="lbl-name-div-misReport">Profile Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="profileStatusPL" name="profileStatusPL"
										list="#{'plrMini':'MINI','plrFull':'FULL'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>

							</div>
							
							<div class="div-3">
								<div class="lbl-name-div-misReport">Player Status</div>

								<div class="small-text-box-div">
									<s:checkboxlist id="playerStatusPL" name="playerStatusPL"
										list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>

							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div-misReport">Email Verify</div>

								<div class="small-text-box-div">
									<s:radio id="emailVerify" name="emailVerify"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" theme="myTheme"
										value="%{'Both'}" cssClass="MisRegsitrationReport" />
								</div>
							</div>
							<div class="div-2">
								<div class="lbl-name-div-misReport">Mobile Verify</div>
								<div class="small-text-box-div">
									<s:radio id="mobileVerify" name="mobileVerify"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" theme="myTheme"
										value="%{'Both'}" cssClass="MisRegsitrationReport" />
								</div>

							</div>
							<div class="div-3">
								<div class="lbl-name-div-misReport">DOB Verify</div>
								<div class="small-text-box-div">
									<s:radio id="dobVerify" name="dobVerify"
										list="#{'Y':'Yes','N':'No','Both':'Both'}" theme="myTheme"
										value="%{'Both'}" cssClass="MisRegsitrationReport" />
								</div>

							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-5">

								<div class="lbl-name-div-misReport">Sign Up</div>

								<div class="small-text-box-div-new">
									<s:checkboxlist name="signType"
										cssClass="MisRegsitrationReport"
										list="#{'direct':'Direct Sign up','campaign':'Campaign Sign up','refer':'Refer Sign up','zapak':'Zapak Sign up','ola':'Online Affiliated'}"></s:checkboxlist>
								</div>
							</div>

							<div class="div-5">
								<div class="lbl-name-div-misReport">Login Device</div>

								<div class="small-text-box-div-new">
									<s:checkboxlist id="loginDevice" name="loginDevice"
										list="#{'devicePC':'PC','deviceMobile':'MOBILE'}"
										cssClass="MisRegsitrationReport" theme="myTheme"></s:checkboxlist>
								</div>
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
				<ss:button name="Download" id="download" value="Download Excel"
					onclick="setParam()" cssClass="button"></ss:button>
			</div>

		</s:form>
	</div>
<div id="waitDivNext" class="animated-button-div" style="margin-left: 0px; display:none">
<div class="animated-striped">Wait</div>
</div>
<div id="waitDivPrev" class="animated-button-div" style="margin-left: 0px;display:none">
<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
</div>
	<div id="searchResult"></div>
</body>
</html>


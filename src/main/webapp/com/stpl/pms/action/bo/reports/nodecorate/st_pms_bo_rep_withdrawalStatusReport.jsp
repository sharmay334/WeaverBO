<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Search Data</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script>
	$(document).ready(function() {
		$('th[class="header"]').attr('colspan', 1);
		$('[id*="amt"][type!=radio]').hide();
		rowSumAndAvgAmt();
		fromAndToDate();
	});
</script>
	</head>

	<body>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{resultList!=null && resultList.size()>0}">
				<div class="greyStrip">
					<h4 style="float: left">
						<s:if test="reportType!= 'getWithDrawalTxnReport'">
                         Deposit Transaction  Report For Domain : <s:property
								value="%{domainName}" />
						</s:if>
						<s:else>
                          Withdrawal Transaction  Report For Domain : <s:property
								value="%{domainName}" />
						</s:else>
					</h4>
					<h4 class="dateData" style="text-align: right; background: none">
					</h4>
				</div>
				<div id="ajaxResponse">
					<div class="dataTbl_top">
						<p align="center">
							Display Type:
							<s:radio id="typeToDisplay" name="typeToDisplay"
								list="#{'amt':'No.of Request','plr':'Requested Amount','both': 'Both'}"
								value="%{'amt'}" />

						</p>
					</div>
					<div class="dataTbl_top">
						<p>
							<s:if test="reportType!= 'getWithDrawalTxnReport'">
								<a
									href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=depTnxReports">Download
									Excel</a>
							</s:if>
							<s:else>
								<a
									href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerTxnReportsExportExcel.action?reportData=<s:property value="%{reportData}"/>&reportTypeName=withDrawTnxReports">Download
									Excel</a>
							</s:else>
						</p>
					</div>
					<div class="innerBox">
						<table width="830" cellspacing="0" cellpadding="0" border="0"
							align="center" class="payTransaction">
							<s:iterator value="%{reportResult}" status="reportResult"
								var="reportResult">
								<s:if test="%{#reportResult.index==0}">
									<tr>
										<th width="5%" valign="middle" rowspan="2"
											style="text-align: center;">
											Payment GateWay
										</th>
										<s:iterator value="value" var="reportResultKey"
											status="reportresultKey">
											<th colspan="2"
												id='th_<s:property value="#reportresultKey.index"/>'
												style="text-align: center;" class="header" >
												<a
													href='com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=getDepositDetailPG&reportData=.td_0,#fromDate,#toDate'
													target="expandIt" callBack="attachEvent('expandIt')"></a>
												<s:property value="key" />
											</th>
										</s:iterator>
										<th width="5%" valign="middle" colspan="2"
											style="text-align: center;" class="header">
											Total
										</th>

									</tr>
									<tr>
										<s:iterator value="value" var="reportResultKey"
											status="reportresultKey">
											<s:set name="keyName" value="%{key.replaceAll('_','')}"></s:set>
											<th style="text-align: center;"
												id='amt_<s:property value="#keyName"/>amt' data_column="sum" >
												 Amount
					
											</th>
											<th style="text-align: center;"
												id='plr_<s:property value="#keyName"/>plr' data_column="sum">
												Req
											</th>

										</s:iterator>
										<th style="text-align: center;" id='amt_totalamt'
											data_column="sum">
											Amount
										</th>
										<th style="text-align: center;" id='plr_totalplr'
											data_column="sum">
											Req
										</th>
									</tr>
								</s:if>
								<tr class="row_total">
									<td width="5%" valign="middle" style="text-align: center;"
										class='tdclass'>
										<s:property value="key" />
									</td>
									<s:set name="idValConst" value="%{'amt'}"></s:set>
									<s:iterator value="value" status="indexvalue" var="mapValue">
										<s:set name="keyName" value="%{key.replaceAll('_','')}"></s:set>
										<s:iterator value="%{#mapValue.value}" status="indexvalue"
											var="finalvalue">
												<td width="5%" style="text-align: right;"
													class="td_<s:property value="%{#keyName+#idValConst+' '+#idValConst}"/> "
													id='<s:property value="%{#idValConst}"/>_<s:property value="%{#indexvalue.index}"/>_<s:property value="#keyName"/>'>
													<s:property value="%{#finalvalue}" />
												</td>
											<s:if test="%{#idValConst=='amt'}">
												<s:set name="idValConst" value="%{'plr'}"></s:set>
											</s:if>
											<s:else>
												<s:set name="idValConst" value="%{'amt'}"></s:set>
											</s:else>
										</s:iterator>
									</s:iterator>
									<th width="5%" valign="middle"
										style="text-align: right; padding-right: 5px;"
										id="amt_totalSum" class='td_totalamt totalamt'>
										0.00
									</th>
									<th width="5%" valign="middle"
										style="text-align: right; padding-right: 5px;"
										id="plr_totalNo." class='td_totalplr totalplr'>
										0.00

									</th>
									<s:if test="reportType!= 'getWithDrawalTxnReport'">
										<th width="5%" valign="middle"
											style="text-align: right; padding-right: 5px;"
											class="totalsRate avg_totalsucc">
											0.00
										</th>
										<th width="5%" valign="middle"
											style="text-align: right; padding-right: 5px;"
											class="totalaTime avg_totaltime">
											0.00
										</th>
									</s:if>
								</tr>
							</s:iterator>

							<s:iterator value="%{reportResult}" status="reportResult"
								var="reportResult">

								<tr class="totalResult">
									<s:if test="%{#reportResult.index==0}">
										<th width="5%" valign="middle" rowspan="1"
											style="text-align: center;">
											Total
										</th>
										<s:iterator value="value" var="reportResultKey">
											<s:set name="keyName" value="%{key.replaceAll('_','')}"></s:set>
											<th width="5%" valign="middle"
												style="text-align: right; padding-right: 5px;"
												id='sum_<s:property value="#keyName"/>amt' class="totalAmt">
											</th>
											<th width="5%" valign="middle"
												style="text-align: right; padding-right: 5px;"
												id='sum_<s:property value="#keyName"/>plr' class="totalPlr">
											</th>
										</s:iterator>
										<th width="5%" valign="middle"
											style="text-align: right; padding-right: 5px;"
											id="sum_totalamt">
										</th>
										<th width="5%" valign="middle"
											style="text-align: right; padding-right: 5px;"
											id="sum_totalplr">
										</th>
										<s:if test="reportType!= 'getWithDrawalTxnReport'">
											<th width="5%" valign="middle"
												style="text-align: right; padding-right: 5px;"
												id="avgTotal_totalsucc">
											</th>
											<th width="5%" valign="middle"
												style="text-align: right; padding-right: 5px;"
												id="avgTotal_totaltime">
											</th>
										</s:if>
									</s:if>
								</tr>
							</s:iterator>
						</table>
					</div>
					<div class="box_footer">
					</div>
				</div>
			</s:if>
			<s:else>
				<div class="greyStrip">
					<h4>
						Error Message
					</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
		</div>

	</body>
</html>
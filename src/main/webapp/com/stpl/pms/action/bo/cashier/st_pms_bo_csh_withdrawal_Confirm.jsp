<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
			$(document).ready(function() {
				$('#withdrawalData').val($('#withdrawalDataDiv').html());
				$('#submitBtn').click(function(){
					$('#downloadParam').val("excel");
				});
				$('#submitBtn1').click(function(){
					$('#downloadParam').val("csvHdfc");
				});
				$('#submitBtn2').click(function(){
					$('#downloadParam').val("csvNonHdfc");
				});
				$('#submitBtn3').click(function(){
					$('#downloadParam').val("excelHdfc");
				});
				$('#submitBtn4').click(function(){
					$('#downloadParam').val("excelNonHdfc");
				});
			});
		</script>
	</head>

	<body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Success Message
				</h4>
			</div>
			<div class="innerBox">
				<div class="alert saved_msg">
					<span class="alert_close"></span>
					<strong>Success: </strong> <s:property value="%{actionMessage}"/>
				</div>
			</div>
		</div>
		<s:if test="%{generateExcel==true && wdrTxnMap.size()>0}">
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Processed Withdrawal For Domain: <s:property value="%{domainName}" />
					</h4>
				</div>
				<s:form id="exportExlFrm"
					action="st_pms_bo_csh_processdWithdrawal_exportExcel"
					theme="simple" method="post" enctype="multipart/form-data">
					<s:hidden name="processedWithdrawalJsonData" id="processedWithdrawalJsonData" value="%{wdrTxnStr}"></s:hidden>
					<s:hidden name="domainId" id="domainId"/>
					<s:hidden name="downloadParam" id="downloadParam" />
					<div class="innerBox" id="withdrawalDataDiv">
						<div style="display: none;">
							Date :
							<s:date name="%{@java.util.Calendar@getInstance().time}"
								format="dd/MM/yyyy" />
							<br />
							<br />domain
							To,
							<br />
							Hdfc BankLtd.
							<br />
							<br />
							Dear Sir,
							<br />
							<br />
							<p>
								You are requested to remit the proceeds as per details given
								below through RTGS / NEFT . Attaching Cheque No.______ for
								Rs.____________________ for RTGS. (for RTGS Cheque Draw in
								favour of "HDFC BANK LTD - RTGS and for NEFT draw cheque in
								favour of "HDFC BANK LTD. - NEFT".
							</p>
						</div>
						<table width="830" cellspacing="0" cellpadding="4" border="1"
							id="processWdrTbl" align="center" class="payTransaction">
							<thead>
								<tr>
									<th width="5%" valign="middle" align="left">
										Sr No
									</th>
									<th width="15%" valign="middle" align="left">
										Beneficiary Name
									</th>
									
									<th width="15%" valign="middle" align="left">
										Beneficiary A/C No
									</th>
									<th width="15%" valign="middle" align="left">
										Beneficiary Bank Name
									</th>
									<th width="20%" valign="middle" align="left">
										Beneficiary Bank address
									</th>
									<th width="15%" valign="middle" align="left">
										RTGS / NEFT IFSC CODE
									</th>
									<th width="15%" valign="middle" align="left">
										Withdrawal Amount
									</th>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="%{wdrTxnMap}" status="wdrTxn">
									<s:set var="redeemAcc" value="%{value.bankRedAcc}"></s:set>
									<tr>
										<td>
											<s:property value="%{#wdrTxn.index+1}" />
										</td>
										<td>
											<s:property value="%{#redeemAcc.accHolderName}" />
										</td>
										
										<td>
											<s:property value="%{#redeemAcc.accNum}" />
										</td>
										<td>
											<s:property value="%{#redeemAcc.bankName}" />
										</td>
										<td>
											<s:property value="%{#redeemAcc.branchAddress}" />
										</td>
										<td>
											<s:property value="%{#redeemAcc.ifscCode}" />
										</td>
										<td>
											<s:property value="%{value.toAmount}" />
											&nbsp;&nbsp;(
											<s:property
												value="%{currencyMap.get(value.toCurrencyId).getCurrCode()}" />
												
											)
										</td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
					</div>
					<div class="box_footer" align="right">
						<s:submit theme="simple" id="submitBtn" value="Download Excel"></s:submit>
						<s:submit theme="simple" id="submitBtn1" value="Download Csv For HDFC"></s:submit>
						<s:submit theme="simple" id="submitBtn2" value="Download Csv For Non HDFC"></s:submit>
						<s:submit theme="simple" id="submitBtn3" value="Download Excel For HDFC" style="padding: 6px 11px 4px !important;"></s:submit>
						<s:submit theme="simple" id="submitBtn4" value="Download Excel For Non HDFC" style="padding: 6px 12px 4px !important;"></s:submit>
					</div>
				</s:form>
			</div>
		</s:if>
	</body>
</html>

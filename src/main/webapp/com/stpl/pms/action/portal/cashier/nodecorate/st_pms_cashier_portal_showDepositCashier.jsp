<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
	request.setAttribute("serverPath",(request.getHeader("x-forwarded-proto") != null ? request.getHeader("x-forwarded-proto")
			: request.getScheme()) + "://"+ request.getServerName() + ":" + request.getServerPort());
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Cashier</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
			$(document).ready(function(){
				$('input[type="text"]').click(
						function() {
							if ($(this).val() == 'Amount'
									|| $(this).val() == 'Serial No'
									|| $(this).val() == 'PIN No'
									|| $(this).val() == 'Bonus Code'
									|| $(this).val() == 'Cheque No'
									|| $(this).val() == 'Bank Name'
									|| $(this).val() == 'Reference No')
								$(this).val('');
							$(this).css('color', '#312E25');

					});
					$('input[type="text"]').blur(
						function() {
							var id = $(this).attr('id');

							if ($(this).val() == '') {
								$(this).css('color', '#A6A6A6');
								if (id.indexOf('amount_') == 0)
									$(this).val('Amount');
								else if (id.indexOf('serialNo_') == 0)
									$(this).val('Serial No');
								else if (id.indexOf('pinNo_') == 0)
									$(this).val('PIN No');
								else if (id.indexOf('bonusCode') == 0)
									$(this).val('Bonus Code');
							} else if ($(this).val() == 'Amount'
									|| $(this).val() == 'Serial No'
									|| $(this).val() == 'PIN No'
									|| $(this).val() == 'Bonus Code'
									|| $(this).val() == 'Cheque No'
									|| $(this).val() == 'Bank Name'
									|| $(this).val() == 'Reference No') {
								$(this).css('color', '#A6A6A6');
							} else {
								if (id.indexOf('amount_') == 0) {
									if ($(this).val() == 'Amount') {
										$('#amount_err_status_dep').html("");
										$('#amount_err_status_dep').css('color',
												'green');
									} else
										validateAmount($(this),
												'amount_err_status_dep');
								}
							}
						});
						
				$('input[id*="amount_"]').change(function() {
					validateAmount($(this), 'amount_err_status_dep');
				});
				$('input[id*="amount_"]').keypress(function(event) {
					return chkAmountOnkeyPressed(event,'amount_err_status_dep');
				});
				$('input[type="text"]').keypress(function() {
					$(this).css('color', '#312E25');
				});
				$('select').change(function() {
					if ($(this).val() == -1) {
						$(this).css('color', '#A6A6A6');
					} else {
						$(this).css('color', '#312E25');
					}
				});
				$('form[id*="depFrm"]').submit(
					function() {
						var isDepoValid = depositValidate($(this),'amount_err_status_dep');
					return isDepoValid;
				});
				
				
			});
			
			$(function() {
				$(".datepicker").datepicker( {
					changeMonth : false,
					changeYear : false,
					dateFormat : "dd/mm/yy",
					minDate : "<%=new java.text.SimpleDateFormat("dd/MM/yyyy")
							.format(Calendar.getInstance().getTime().getTime())%>",
								maxDate: "<%=new java.text.SimpleDateFormat("dd/MM/yyyy")
							.format(Calendar.getInstance().getTime().getTime() + 20
									* 24 * 60 * 60 * 1000)%>",
								showOn: "both",
								buttonImage: "<%=path%>/images/calendar.gif",
								buttonImageOnly: true
							}).change(function() {
							$(this).css('color', '#312E25');
				});
			});
			$(function() {
				$(".accordion").accordion( {
					collapsible : true,
					clearStyle : true,
					header : 'div[class*="accordionHead"]',
					icons : false,
					active : false,
					create : function(event,ui){
						$(this).find('div[class*="accordionHead"]').each(function(){
							$(this).next("div").load($(this).find(':input[id*=contentPath_]').val());
						});
					}
					
				});
				$(".accordionHead > table :input").click(function(e){
					e.stopPropagation();
				});
				/*$(".accordionHead").click(function(e){
					if($(this).next("div").html()!='');
					$(this).next("div").load($(this).find(':input[id*=contentPath_]').val());
				});*/
				
			});
		</script>

	</head>
<body>
	<div id="respDiv" class="amountBoxCash">
		<div id="CashDepoBox" class="CashDepoBox">
		<s:set name="isPayOption" value="true"></s:set>
			<s:if test="%{payTypeMap!=null && payTypeMap.size()>0}">
				<s:set name="isNoPayOption" value="false"></s:set>
				<div id="amount_err_status_dep"></div>
				<div  class="accordion" id="accordion_payment">
				
				<s:iterator value="%{payTypeMap}" status="type" var="payType">
					<s:set name="tabIndex" value="%{#type.index+1}"></s:set>
					<s:if test="%{value.payTypeCode!='CASH_PAYMENT'}">
					<s:form action="%{(value.payTypeCode!='CASH_COLLECTION')?'st_pms_cashier_portal_depositRequest':'st_pms_cashier_portal_fillCashCollectionAddress'}"
						name="depFrm%{value.payTypeCode}" id="depFrm%{value.payTypeCode}" theme="simple"
						method="post" target="%{(value.payTypeCode=='CREDIT_CARD' || value.payTypeCode=='DEBIT_CARD' 
									|| value.payTypeCode=='NET_BANKING')?'_blank':''}">
						
						<s:token name="token_%{value.payTypeCode}" id="token_%{value.payTypeCode}" />
							<div class="yelowBG<s:if test="%{value.contentPath!=null}"> accordionHead</s:if>" id="accordionHead_<s:property value="%{value.payTypeCode}" />">
								<s:hidden id="contentPath_%{value.payTypeCode}" value="%{value.contentPath}"></s:hidden>
								<table width="99%" height="55" border="0" cellspacing="0"
									cellpadding="0" align="center">
									<tr>
										<td align="center" valign="middle"
											style="padding-left: 5px;padding-bottom: 3px;width: 5%;">
											<img  width="60px" height="40px" alt="<s:property value="%{value.payTypeDispCode}" />" src="<s:property value="%{value.imagePath}" />">
										</td>
										<td class="crdName" valign="middle" style="width: 20%;">
											<s:property value="%{value.payTypeDispCode}" />
											<s:hidden name="requestBean.paymentTypeId"
												value="%{value.payTypeId}"></s:hidden>
										</td>
										<td align="left" valign="middle" style="width:15%;">
											<s:select name="requestBean.currencyId"
												id="currency_%{value.payTypeCode}"
												list="%{value.currencyMap}" headerKey="-1" cssClass="selectCash"
												headerValue="--Please Select--" theme="simple"></s:select>
										</td>
										<td align="left" valign="middle" style="width:15%;">
											<s:textfield name="requestBean.amount" cssClass="InpTextBoxBg"
												id="amount_%{value.payTypeCode}" value="Amount" theme="simple"></s:textfield>
										</td>
										<td align="left" valign="middle" style="width:14%;">
											<s:if test="%{value.subTypeMap!=null && value.subTypeMap.size()>0}">
												<s:select name="requestBean.subTypeId"
													id="subTypeCode_%{value.payTypeCode}"
													list="%{value.subTypeMap}" headerKey="-1" cssClass="selectCash"
													headerValue="--Please Select--" theme="simple"></s:select>
											
										</s:if>
										<s:if test="%{value.payTypeCode=='CHEQUE_TRANS'}">
												<s:textfield name="requestBean.chequeNo"  cssClass="InpTextBoxBg"
													id="chequeNo_%{value.payTypeCode}" value="Cheque No" theme="simple"></s:textfield>
										</s:if>
										<s:if test="%{value.payTypeCode=='WIRE_TRANS'}">
												<s:textfield name="requestBean.refBankTxnNo"  cssClass="InpTextBoxBg" 
													id="refBankTxnNo_no_%{value.payTypeCode}" value="Reference No" theme="simple"></s:textfield>
										</s:if>
										</td>
										<td align="left" valign="middle" style="padding-left: 15px;width:15%;">
											<s:if test="%{value.payTypeCode=='CHEQUE_TRANS'}">
												<s:textfield name="requestBean.plrBankName"  cssClass="InpTextBoxBg"
													id="bankName_%{value.payTypeCode}" value="Bank Name" theme="simple" title="Bank Name"></s:textfield>
											</s:if>
											<s:elseif test="%{value.payTypeCode=='WIRE_TRANS'}">
												<s:select name="requestBean.providerId"
													id="providerCode_%{value.payTypeCode}"
													list="%{value.providerMap}" headerKey="-1" cssClass="selectCash"
													headerValue="--Please Select--" theme="simple"></s:select>
											</s:elseif>
										</td>
										<td align="left" valign="middle" style="padding-left: 15px;width:15%;">
											<s:if test="%{value.payTypeCode=='CHEQUE_TRANS' || value.payTypeCode=='WIRE_TRANS'}">
												<s:textfield name="requestBean.referenceDate" id="referenceDate_%{value.payTypeCode}"
															readonly="true" cssClass="InpTextBoxBg datepicker" theme="simple"></s:textfield>
											</s:if>
										</td>
										<td  align="left" valign="middle"
											style="padding-right: 10px;width:10%;">
											<s:submit name="submitBtn" id="depoContinue_%{value.payTypeCode}"
												value="Continue" theme="simple" cssClass="Inp_cont2"></s:submit>
										</td>
									</tr>
								</table>
							</div>
							<s:if test="%{value.contentPath!=null}">
								<div id="accordionContent_<s:property value="%{value.payTypeCode}" />">
									
								</div>
							</s:if>
					</s:form>
					</s:if>
				</s:iterator>
				</div>
			</s:if>
	    	<s:if test="pendingWdrMap!=null && pendingWdrMap.size()>0">
	    		<s:set name="isNoPayOption" value="false"></s:set>
					<div class="accordion">
						<div class="yelowBG" id="pendingWithdrawal"
							style="cursor: pointer;">
							<table width="99%" height="55" border="0" cellspacing="0"
								cellpadding="0" align="center">
								<tr>
									<td width="8%" align="center" valign="middle"
										style="padding-left: 5px">
									</td>
									<td width="32%" class="crdName" colspan="2">
										Pending Withdrawal
									</td>
									<td width="50%" align="left" valign="middle"> </td>
									<td width="5%" align="left" valign="middle"
										style="padding-right: 10px">
										<input type="button" name="submitBtn" id="btn_%{paymentType}"
											value="Continue" class="Inp_cont2" style="cursor: pointer;"/>
									</td>
								</tr>
							</table>
						</div>
						<div><!-- IF PENDING DEPOSITS FOUND -->
							<div class="RedStripSmall">
								<table width="100%" height="25" border="0" cellspacing="0"
									cellpadding="0">
									<tr>
										<td width="25%" align="center" valign="middle"
											class="hd8">
											Amount
										</td>
										<td width="25%" align="center" valign="middle"
											class="hd8">
											Withdrawal Date
										</td>
										<td width="25%" align="center" valign="middle"
											class="hd8">
											Payment Type
										</td>
										<td width="25%" align="center" valign="middle"
											class="hd8"></td>
									</tr>
								</table>
							</div>
							<s:iterator value="pendingWdrMap">
								<s:form action="st_pms_cashier_portal_plrDepositAgstCancelWdr"
									name="pendWdrFrm_%{value.transactionId}" id="pendWdrFrm_%{value.transactionId}"
									method="post" theme="simple">
									<table border="0" cellspacing="0" cellpadding="0" align="center"
										id="DepositTbl" style="margin-top: -5px">	<tr>
											<td width="25%" align="center" valign="middle">
												<s:token name="pendingWdrToken"></s:token>
												<s:hidden name="pendingWdrTxnId" value="%{value.transactionId}"></s:hidden>
												<s:property value="%{value.amount}" />
											</td>
											<td width="25%" align="center" valign="middle">
												<s:date name="%{value.transactionDate}"
													format="MM/dd/yyyy HH:mm:ss" />
											</td>
											<td width="25%" align="center" valign="middle">
												<s:property value="%{value.payTypeDispCode}" />
											</td>
											<td width="25%" align="center" valign="middle">
												<s:submit name="submitBtn" id="pendWdrl_cancel"
													theme="simple" value="Cancel" cssClass="Inp_cont2"></s:submit>
											</td>
										</tr>
									</table>
								</s:form>
							</s:iterator>
						</div>
					</div>
		    	</s:if>
		    	<s:if test="%{#isNoPayOption}">
		    		No payment option available.
		    	</s:if>
		</div>
	</div>
</body>
</html>

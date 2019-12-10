<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Process Withdrawal</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('input[id*=refTxnDate_]').datetimepicker({
						dateFormat : 'dd/mm/yy',
						timeFormat : 'HH:mm:ss',
						showSecond: true,
						changeMonth : true,
						numberOfMonths : 1,
						maxDate: serverDateStr,
						maxDateTime: $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
				});
				 $('input[id*=refTxnDate_]').datetimepicker('setDate', serverDateStr);  
				$('[id*="wdrSubmitBtn_"]').click(function(event){
					$("#settlementType").val($(this).attr('id').replace('wdrSubmitBtn_',''));
				});
				$(function() {
					$('#wdrSettlementFrm').submit(function(event){
						var wdrDataArray = new Object();
						var isValid = true;
						$('#wdrSettlementTbl tbody tr').each(function(index){
							var $row = $(this);
							if($row.find('> td:first-child > input[type="checkbox"]').prop('checked')){
								isValid = true;
								var txnId = $row.find('> td:first-child > input[type="checkbox"]').val();
								var refTxnNo = null;
								var refTxnDate = null;
								if($("#settlementType").val()=='DONE'){
								 refTxnNo = $row.find('> td > input[id*=refTxnNo_]').val()!=undefined ? $row.find('> td > input[id*=refTxnNo_]').val():null;
								 refTxnDate = $row.find('> td > input[id*=refTxnDate_]').val() !=undefined ? $row.find('> td > input[id*=refTxnDate_]').val() :null;
								}
								if($("#settlementType").val()=='DONE' && ($('#paymentTypeCode').val()=='MOBILE_MONEY' || $('#paymentTypeCode').val()=='BANK_TRANS') &&(refTxnNo==''||refTxnDate=='')){
									isValid = false;
								}else
									wdrDataArray[txnId] = new wdrDataObj(txnId,refTxnNo,refTxnDate);
							}
							return isValid;
						});
						if($('#wdrSettlementTbl tbody tr').find('> td:first-child > input[type="checkbox"]:checked').length==0){
							alert("Please select atleast one request to process.");
							isValid = false;
						}else if(!isValid){
							alert("Please fill all data for selected request.");
							isValid = false;
						}
						$("#domain").val($("#domainId").val());
						$('#withdrawalJsonData').val(JSON.stringify(wdrDataArray));
						return isValid;
					});
					
				});
				
			});
			
			
			function wdrDataObj(txnId,refTxnNo,refTxnDate) {
				this.transactionId = txnId;
				this.refTxnNo = refTxnNo;
				this.refTxnDate =  refTxnDate;
			}
			
			
	
</script>
	</head>

	<body>
		<s:if test="%{wdrTxnMap.size()>0}">
			<div class="greyStrip">
				<h4>
					Withdrawal Request
				</h4>
			</div>
			<s:form id="wdrSettlementFrm" method="post" theme="simple" action="st_pms_bo_csh_withdrawalSettlement_Save">
			<s:hidden name="settlementType" id="settlementType"></s:hidden>
			<div class="innerBox" style="overflow: auto;">
				<table width="830" cellspacing="0" cellpadding="4" border="0" id="wdrSettlementTbl" 
					align="center" class="payTransaction">
					<thead>
					<tr>
						<th width="5%" valign="middle" align="left">
							
						</th>
						<th width="15%" valign="middle" align="left">
							Txn ID
						</th>
						<th width="15%" valign="middle" align="left" >
							Date
						</th>
						<th width="20%" valign="middle" align="left" >
							User Name
						</th>
						<th width="15%" valign="middle" align="left" >
							Beneficiary Name
						</th>
						<s:if test="%{txnSearchBean.paymentTypeCode=='BANK_TRANS'}">
							<th width="15%" valign="middle" align="left" >
								A/C No
							</th>
							<th width="15%" valign="middle" align="left" >
								Bank Name
							</th>
						</s:if>
						
						<th width="15%" valign="middle" align="left" >
							Processed Amount
						</th>
                        <s:if test="%{txnSearchBean.paymentTypeCode=='MOBILE_MONEY'}">
                            <th width="15%" valign="middle" align="left" >
                                Provider
                            </th>
                        </s:if>
                        <s:if test="%{txnSearchBean.paymentTypeCode=='CHEQUE_TRANS'}">
							<th width="11%" valign="middle" align="left" >
								Cheque No
							</th>
							<th width="11%" valign="middle" align="left" >
								Cheque Date
							</th>
						</s:if>
						<s:elseif test="%{txnSearchBean.paymentTypeCode=='BANK_TRANS' || txnSearchBean.paymentTypeCode=='MOBILE_MONEY'}">
							<th width="11%" valign="middle" align="left" >
								Ref Txn No
							</th>
							<th width="14%" valign="middle" align="left" >
								Txn Date
							</th>
						</s:elseif>
						<th width="15%" valign="middle" align="left" >
							 Balance 
						</th>
						<th width="15%" valign="middle" align="left" >
							Withdrawable Bal
						</th>
					</tr>
					</thead>
					<tbody>
					<s:iterator value="%{wdrTxnMap}" status="wdrTxn">
						<tr>
							<td>
								<input name="txnIds" id="txnId_<s:property value="%{value.transactionId}" />"
									   type="checkbox" value="<s:property value="%{value.transactionId}" />" />
							</td>
							<td>
								<s:property value="%{value.transactionId}" />
							</td>
							<td>
								<s:property value="%{value.transactionDate}" />
							</td>
							<td>
								<s:property value="%{value.userName}" />
							</td>
							<s:if test="%{txnSearchBean.paymentTypeCode=='BANK_TRANS'}">
								<td>
									<s:property value="%{value.bankRedAcc.accHolderName}" />
								</td>
								<td>
									<s:property value="%{value.bankRedAcc.accNum}" />
								</td>
								<td>
									<s:property value="%{value.bankRedAcc.bankName}" />
								</td>
							</s:if>
							<s:else>
								<td>
									<s:property value="%{value.firstName}" /> <s:property value="%{value.lastName}" />
								</td>
							</s:else>
							<td>
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.toAmount)}" />&nbsp;&nbsp;<s:property value="%{currencyMap.get(value.toCurrencyId).getCurrCode()}" />
							</td>
                            <s:if test="%{txnSearchBean.paymentTypeCode=='MOBILE_MONEY'}">
                                <td>
                                    <s:property value="%{value.providerNameCode}"/>
                                </td>
                            </s:if>
                            <s:if test="%{txnSearchBean.paymentTypeCode=='CHEQUE_TRANS' || txnSearchBean.paymentTypeCode=='CASH_PAYMENT'}">

								<s:if test="%{txnSearchBean.paymentTypeCode=='CHEQUE_TRANS'}">
									<td>
										<s:property  value="%{value.refTxnNo}" ></s:property>
									</td>
									<td>
										<s:property value="%{value.refTxnDate}"></s:property>
									</td>
								</s:if>
							</s:if>
							<s:elseif test="%{txnSearchBean.paymentTypeCode=='BANK_TRANS'||txnSearchBean.paymentTypeCode=='MOBILE_MONEY'}">
									<td>
										<ss:textfield id="refTxnNo_%{value.transactionId}" maxlength="20" size="11%" name="refTxnNo" theme="myTheme" pattern="^[0-9a-zA-Z]*$" errorMassage="Special Character not allowed" ></ss:textfield>
									</td>
									<td>
										<ss:textfield id="refTxnDate_%{value.refTxnDate}" name="refTxnDate" size="14%" readonly="true" theme="myTheme" ></ss:textfield>
									</td>
							</s:elseif>
							<td>
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.walletInfo.cashBal)}" /> &nbsp;&nbsp;<s:property value="%{currencyMap.get(value.currencyId).getCurrCode()}" />
							</td>
							<td>
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.walletInfo.withdrawableBal)}" /> &nbsp;&nbsp;<s:property value="%{currencyMap.get(value.currencyId).getCurrCode()}" />
							</td>
						</tr>
					</s:iterator>
					</tbody>
				</table>
			</div>
			<div class="box_footer" align="right">
				<s:token name="processWdrToken" id="processWdrToken" />
				<s:hidden name="withdrawalJsonData" id="withdrawalJsonData"/>
				<s:hidden name="domainId" id="domain"/>
				<s:hidden name="paymentTypeCode" value="%{txnSearchBean.paymentTypeCode}"/>
				<s:submit cssClass="button" id="wdrSubmitBtn_DONE" theme="simple" value="DONE" action="st_pms_bo_csh_withdrawalSettlement_Save" ></s:submit>
				<s:submit cssClass="button" id="wdrSubmitBtn_FAILED" theme="simple" value="FAILED" action="st_pms_bo_csh_withdrawalSettlement_Save" ></s:submit>
			</div>
			</s:form>
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

	</body>
</html>

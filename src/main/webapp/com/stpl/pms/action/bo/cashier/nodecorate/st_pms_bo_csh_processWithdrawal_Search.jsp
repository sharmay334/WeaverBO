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
				debugger;
				$('select[id*=podmList_]').each(function(){
					var subTypeId = $(this).attr('id').split('_')[2];
					var selectedPodmid = $(this).attr('id').split('_')[3];
					var podmList = $(this);
					$.each(wdrTypeMap[$('#payTypeList').val()].subTypeMap[subTypeId].providerMap, function(index, value) {
						podmList.append(
							$('<option></option>').val(value.podmId).html(value.providerDiscCode));
					});
					podmList.val(selectedPodmid);
				});
				
				$('input[id*=refTxnDate_]').datetimepicker({
						defaultDate: "+0",
						dateFormat : 'dd/mm/yy',
						timeFormat : 'HH:mm:ss',
						showSecond : true,
						minDate : $("#allowedDate").val(),
						maxDate : '+0',
						changeMonth: true,
						numberOfMonths: 1
				});
				
				$(function() {
					$('#processWdrFrm').submit(function(){
						var wdrDataArray = new Object();
						var isValid = true;
						$('#processWdrTbl tbody tr').each(function(index){
							var $row = $(this);
							if($row.find('> td:first-child > input[type="checkbox"]').prop('checked')){
								isValid = true;
								var txnId = $row.find('> td:first-child > input[type="checkbox"]').val();
								var podmId = $row.find('> td > [id*=podmList_]').val();
								
								var refTxnNo = $row.find('> td > input[id*=refTxnNo_]').val()!=undefined ? $row.find('> td > input[id*=refTxnNo_]').val():null;
								var refTxnDate = $row.find('> td > input[id*=refTxnDate_]').val() !=undefined ? $row.find('> td > input[id*=refTxnDate_]').val() :null;
								if(podmId == -1 || $('#paymentTypeCode').val()=='CHEQUE_TRANS'&&(refTxnNo==''||refTxnDate=='')){
									isValid = false;
								}else
									wdrDataArray[txnId] = new wdrDataObj(txnId,podmId,refTxnNo,refTxnDate);
							}
							return isValid;
						});
						if($('#processWdrTbl tbody tr').find('> td:first-child > input[type="checkbox"]:checked').length==0){
							alert("Please select atleast one request to process.");
							isValid = false;
						}else if(!isValid){
							alert("Please select provider option for selected request.");
							isValid = false;
						}
						$("#domain").val($("#domainId").val());
						$("#domainName").val($("#domainId option:selected").text());
						$('#withdrawalJsonData').val(JSON.stringify(wdrDataArray));
						return isValid;
					});
					
				});
				var myclone = $("#processWdrTbl").clone();
					myclone.find( "tr >th:first-child,th:last-child,td:first-child,td:last-child" ).remove();
					//myclone.css('border','1px solid');
					
				var html = myclone.html();
				$('#withdrawalData').val('<table border="1">'+html+'</table>');
			});
			
			
			function wdrDataObj(txnId,podmId,refTxnNo,refTxnDate) {
				this.transactionId = txnId;
				this.podmId = podmId;
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
			<div style="width: 970px;">
			<s:form id="exportExlFrm" action="st_pms_bo_csh_processdWithdrawal_exportExcel" theme="simple"  method="post" enctype="multipart/form-data">
				<s:hidden name="withdrawalJsonData" id="withdrawalData"></s:hidden>
			</s:form>
			<br/>
			<br/>
			</div>
			<s:form id="processWdrFrm" method="post" theme="simple">
			<div class="innerBox" style="overflow-x: scroll;">
				<table width="830" cellspacing="0" cellpadding="4" border="0" id="processWdrTbl" overflow="scroll"
					align="center" class="payTransaction">
					<thead>
					<tr>
						<th width="3%" valign="middle" align="left" nowrap="nowrap">
							
						</th>
						<th width="12%" valign="middle" align="left" nowrap="nowrap">
							Txn ID
						</th>
						<th width="12%" valign="middle" align="left" nowrap="nowrap">
							Date
						</th>
						<th width="20%" valign="middle" align="left" nowrap="nowrap" >
							User Name
						</th>
                        <s:if test="%{txnSearchBean.paymentTypeCode!='MOBILE_MONEY' && txnSearchBean.paymentTypeCode!='ATM'}">
                        1213
                            <th width="15%" valign="middle" align="left" >
                                Beneficiary Name
                            </th>
                        </s:if>
						<s:if test="%{txnSearchBean.paymentTypeCode=='CHEQUE_TRANS'}">
							<th width="15%" valign="middle" align="left" nowrap="nowrap">
								Cheque No
							</th>
							<th width="15%" valign="middle" align="left" nowrap="nowrap">
								Cheque Date
							</th>
						</s:if>
						<s:elseif test="%{txnSearchBean.paymentTypeCode=='BANK_TRANS'}">
							<th width="15%" valign="middle" align="left" nowrap="nowrap">
								A/C No
							</th>
							<th width="15%" valign="middle" align="left" nowrap="nowrap">
								Bank Name
							</th>
							<th width="15%" valign="middle" align="left" style="display: none" nowrap="nowrap">
								Branch
							</th>
							<th width="15%" valign="middle" align="left" nowrap="nowrap">
								IFSC Code
							</th>
						</s:elseif>
						
						<th width="10%" valign="middle" align="left" >
							Processed Amount 
						</th>
						<th width="10%" valign="middle" align="left" nowrap="nowrap">
							Balance 
						</th>
						<th width="10%" valign="middle" align="left" >
							Withdrawable Balance 
						</th>
						<th width="12%" valign="middle" align="left" nowrap="nowrap">
							Provider
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
							<s:if test="%{txnSearchBean.paymentTypeCode=='CHEQUE_TRANS' || txnSearchBean.paymentTypeCode=='CASH_PAYMENT'
											|| txnSearchBean.paymentTypeCode=='PREPAID_WALLET'}">
								<td>
									<s:property value="%{value.firstName}" /> <s:property value="%{value.lastName}" />
								</td>
								<s:if test="%{txnSearchBean.paymentTypeCode=='CHEQUE_TRANS'}">
									<td>
										<ss:textfield id="refTxnNo_%{value.transactionId}" name="refTxnNo" theme="myTheme" pattern="^[0-9a-zA-Z]*$" errorMassage="Special Character not allowed" ></ss:textfield>
									</td>
									<td>
										<ss:textfield id="refTxnDate_%{value.transactionId}" name="refTxnDate" readonly="true" theme="myTheme" ></ss:textfield>
									</td>
								</s:if>
							</s:if>
							<s:elseif test="%{txnSearchBean.paymentTypeCode=='BANK_TRANS'}">
								<td>
									<s:property value="%{value.bankRedAcc.accHolderName}" />
								</td>
								<td>
									<s:property value="%{value.bankRedAcc.accNum}" />
								</td>
								<td>
									<s:property value="%{value.bankRedAcc.bankName}" />
								</td>
								<td style="display: none">
									<s:property value="%{value.bankRedAcc.branchAddress}" />
								</td>
								<td>
									<s:property value="%{value.bankRedAcc.ifscCode}" />
								</td>
							</s:elseif>
							
							<td>
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.toAmount)}" />&nbsp;&nbsp;<s:property value="%{currencyMap.get(value.toCurrencyId).getCurrCode()}" />
							</td>
							<td>
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.walletInfo.cashBal)}" /> &nbsp;&nbsp;<s:property value="%{currencyMap.get(value.currencyId).getCurrCode()}" />
							</td>
							<td>
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.walletInfo.withdrawableBal)}" /> &nbsp;&nbsp;<s:property value="%{currencyMap.get(value.currencyId).getCurrCode()}" />
							</td>
							<td>
								<s:if test="%{txnSearchBean.paymentTypeCode=='CASH_PAYMENT' || txnSearchBean.paymentTypeCode=='PREPAID_WALLET' || txnSearchBean.paymentTypeCode=='MOBILE_MONEY'}">
									<s:hidden name="providerName" value ="%{value.providerNameCode}" />
									<s:property value="%{value.providerNameCode}" />
									<s:hidden name="podmIds" id="podmList_%{value.transactionId}_%{value.subtypeId}_%{value.podmId}" value="%{value.podmId}"></s:hidden>
								</s:if>
								<s:else>
									<s:select cssClass="select" style="width:95px;" name="podmIds" id="podmList_%{value.transactionId}_%{value.subtypeId}_%{value.podmId}"  list="#{'-1':'--Please Select--'}" theme="myTheme"   ></s:select>
								</s:else>
							</td>
						</tr>
					</s:iterator>
					</tbody>
				</table>
			</div>
			<div class="box_footer" align="right">
				<s:token name="processWdrToken" id="processWdrToken" />
				<s:hidden name="withdrawalJsonData" id="withdrawalJsonData"/>
				<s:hidden name="paymentTypeCode" value="%{txnSearchBean.paymentTypeCode}"/>
				<s:hidden name="domainId" id="domain"/>
				<s:hidden name="domainName" id="domainName" />
				
				<%-- <s:if test="%{txnSearchBean.paymentTypeCode!='CASH_PAYMENT'}"> --%>
					<s:submit cssClass="button" id="wdrSubmitBtn" theme="simple" value="Process Withdrawal" action="st_pms_bo_csh_processWithdrawal_Save" ></s:submit>
				<%-- </s:if> --%>
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

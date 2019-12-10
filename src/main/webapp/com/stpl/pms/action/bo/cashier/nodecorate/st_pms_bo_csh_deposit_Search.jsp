<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Process Deposit</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('select[id*=providerList_]').each(function(){
					var selectedProviderId = $(this).attr('id').split('_')[2];
					var providerList = $(this);
					$.each(payTypeMap[$('#payTypeList').val()].providerMap, function(index, value) {
						providerList.append(
							$('<option></option>').val(index).html(value));
					});
					providerList.val(selectedProviderId);
					
				});
				
			$(function() {
					$('#processDepositFrm').submit(function(){
						var depositDataArray = new Object();
						var isValid = true;
						$('#processDepositTbl tbody tr').each(function(index){
							var $row = $(this);
							if($row.find('> td:first-child > input[type="checkbox"]').prop('checked')){
								isValid = true;
								var requestId = $row.find('> td:first-child > input[type="checkbox"]').val();
								var providerId = $row.find('> td > select[id*=providerList_]').val();
								var podmId = $row.find('> td > input[id*=podmId_]').val();
								var paymentTypeId = $('#payTypeList').val();
								if(providerId == -1){
									isValid = false;
								}else
									depositDataArray[requestId] = new depositDataObj(requestId,providerId,podmId,paymentTypeId);
							}
							return isValid;
						});
						if($('#processDepositTbl tbody tr').find('> td:first-child > input[type="checkbox"]:checked').length==0){
							alert("Please select atleast one request to process.");
							isValid = false;
						}
						else if(!isValid){
							alert("Please fill all data for selected request.")
							isValid = false;
						}
						$('#depositJsonData').val(JSON.stringify(depositDataArray));
						
						return isValid;
					});
					
				});
				
				$('select[id*=providerList_]').change(function(){
					$(this).next('input[type=hidden]').val('-1');
				});
			});
			
			
			function depositDataObj(requestId,providerId,podmId,paymentTypeId) {
				this.requestId = requestId;
				this.providerId = providerId;
				this.podmId = podmId;
				this.paymentTypeId = paymentTypeId;
			}
			
			
	
</script>
	</head>

	<body>
		<s:if test="%{depositReqMap.size()>0}">
			<div class="greyStrip">
				<h4>
					Deposit Request
				</h4>
			</div>
			<form id="processDepositFrm" method="post">
			<div class="innerBox">
				<table width="830" cellspacing="0" cellpadding="4" border="0" id="processDepositTbl" 
					align="center" class="payTransaction">
					<thead>
					<tr>
						<th width="5%" valign="middle" align="left">
							
						</th>
						<th width="15%" valign="middle" align="left">
							Request Id
						</th>
						<th width="20%" valign="middle" align="left" >
							User Name
						</th>
						<th width="15%" valign="middle" align="left" >
							VIP Level
						</th>
						<th width="15%" valign="middle" align="left" >
							Request Date
						</th>
						<th width="15%" valign="middle" align="left" >
							Amount
						</th>
						<s:if test="%{txnSearchBean.paymentTypeCode=='CHEQUE_TRANS'}">
							<th width="15%" valign="middle" align="left" >
								Cheque No
							</th>
							<th width="15%" valign="middle" align="left" >
								Cheque Date
							</th>
							<th width="15%" valign="middle" align="left" >
								Player Bank Name
							</th>
						</s:if>
						<s:elseif test="%{txnSearchBean.paymentTypeCode=='WIRE_TRANS'}">
							<th width="15%" valign="middle" align="left" >
								Bank Txn No
							</th>
							<th width="15%" valign="middle" align="left" >
								Bank Txn Date
							</th>
						</s:elseif>
						<th width="15%" valign="middle" align="left" >
							Provider
						</th>
					</tr>
					</thead>
					<tbody>
					<s:iterator value="%{depositReqMap}" status="depoReq">
						<tr>
							<td>
								<input name="requestIds" id="requestId_<s:property value="%{value.requestId}" />"
									   type="checkbox" value="<s:property value="%{value.requestId}" />" />
							</td>
							<td>
								<s:property value="%{value.requestId}" />
							</td>
							<td>
								<s:property value="%{value.playerInfo.userName}" />
							</td>
							<td>
								<s:property value="%{value.playerInfo.vipLevel}" />
							</td>
							<td>
								<%-- <s:date name="%{new java.util.Date(value.requestTime)}" format="dd/MM/yyyy HH:mm:ss" /> --%>
								<s:property value="%{value.requestTimeStr}" />
							</td>
							<td>
								<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(value.amount)}" />&nbsp;&nbsp;<s:property value="%{currencyMap.get(value.currencyId).currCode}" />
							</td>
							
							<s:if test="%{txnSearchBean.paymentTypeCode=='CHEQUE_TRANS'}">
							<td>
								<s:property value="%{value.chequeNo}"/>
							</td>
							<td>
								<s:property value="%{value.referenceDate}"/>
							</td>
							<td>
								<s:property value="%{value.plrBankName}"/>
							</td>
							<td>
								<select class="select" name="providerIds"  id="providerList_<s:property value="%{value.requestId}" />_<s:property value="%{value.providerId}" />" >
									<option value="-1">
										----Please Select----
									</option>
								</select>
								<s:hidden name="podmIds" id="podmId_%{value.requestId}" value="%{value.podmId}"></s:hidden>
							</td>
							</s:if>
							<s:elseif test="%{txnSearchBean.paymentTypeCode=='WIRE_TRANS'}">
							<td>
								<s:property value="%{value.refBankTxnNo}"/>
							</td>
							<td>
								<s:property value="%{value.referenceDate}"/>
							</td>
							<td>
								<s:property value="%{value.providerName}"/>
							</td>
							</s:elseif>
							
						</tr>
					</s:iterator>
					</tbody>
				</table>
			</div>
			<div class="box_footer" align="right">
				<s:hidden name="depositJsonData" id="depositJsonData"/>
				<s:hidden name="paymentTypeCode" value="%{txnSearchBean.paymentTypeCode}"/>
				<s:token name="strutsToken" id="strutsToken"></s:token>
				<s:submit cssClass="button" id="depositSubmitBtn" theme="simple" value="Process Deposit" action="st_pms_bo_csh_processDeposit_Save" ></s:submit>
				<s:submit cssClass="button" id="depositCancelBtn" theme="simple" value="Cancel Deposit" action="st_pms_bo_csh_cancelDeposit_Submit" ></s:submit>
			</div>
			</form>
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

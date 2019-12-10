<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
	request.setAttribute("serverPath",(request.getHeader("x-forwarded-proto") != null ? request.getHeader("x-forwarded-proto")
			: request.getScheme()) + "://"+ request.getServerName() + ":" + request.getServerPort());
%>

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
	
	$(document).ready(function() {
		$("#CashWdrBox").accordion( {
			collapsible : true,
			clearStyle : true,
			header : 'div[class="yelowBG"]',
			icons : false ,
			active : false
		});
		$('input[id*=amount_]').click(function(){
			if ($(this).val() == 'Amount')
				$(this).val('');
				$(this).css('color', '#312E25');
			return false;
		});
		$('select[id*=currency_]').click(function(){
			
			return false;
		});
		
		$('input[type="text"]').blur(
					function() {
						var id = $(this).attr('id');

						if ($(this).val() == '') {
							$(this).css('color', '#A6A6A6');
							if (id.indexOf('amount_') == 0)
								$(this).val('Amount');
						} else if ($(this).val() == 'Amount') {
							$(this).css('color', '#A6A6A6');
						} else {
							if (id.indexOf('amount_') == 0) {
								if ($(this).val() == 'Amount') {
									$('#amount_err_status_wdr').html("");
									$('#amount_err_status_wdr').css('color',
											'green');
								} else
									validateAmount($(this),
											'amount_err_status_wdr');
							}
						}
					});
						
				$('input[id*="amount_"]').change(function() {
					validateAmount($(this), 'amount_err_status_wdr');
				});
				$('input[id*="amount_"]').keypress(function(event) {
					return chkAmountOnkeyPressed(event,'amount_err_status_wdr');
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
			$('form[id*="wdrFrm"]').submit(
					function() {
						var isDepoValid = validateAmount($(this).find('input[id*="amount_"]'), 'amount_err_status_wdr');
						if($(this).find('select[id*="currency_"]').val()==-1){
						 	isDepoValid = false;
						 	 $('#amount_err_status_wdr').css('font-size', '12px');
							 $('#amount_err_status_wdr').css('color', 'red');
							 $('#amount_err_status_wdr').css('font-weight', 'bold');
						 	 $('#amount_err_status_wdr').html('Please select currency');
						 }
					return isDepoValid;
				});
		
	});
</script>

	</head>
	<body>
		<div id="respDiv" class="amountBoxCash">
			<div id="CashWdrBox" class="CashDepoBox">
				<s:if test="%{payTypeMap!=null && payTypeMap.size()>0}">
					<div id="amount_err_status_wdr"></div>
					<s:iterator value="%{payTypeMap}" status="type">
						<s:set name="tabIndex" value="%{#type.index+1}"></s:set>
						<s:form 
							name="wdrFrm%{value.payTypeCode}"
							id="wdrFrm%{value.payTypeCode}" theme="simple" method="post" >
							<s:token name="token_%{value.payTypeCode}"
								id="token_%{value.payTypeCode}" />
							<div>
								<div class="yelowBG" id="wdrPayType">
									<table width="99%" height="55" border="0" cellspacing="0"
										cellpadding="0" align="center">
										<tr>
											<td align="center" valign="middle"
												style="padding-left: 10px; padding-bottom: 3px; min-width: 8%;">
												<img width="60px" height="40px"
													alt="<s:property value="%{value.payTypeDispCode}" />"
													src="<s:property value="%{value.imagePath}" />">
											</td>
											<td width="20%" class="crdName" valign="middle">
												<s:property value="%{value.payTypeDispCode}" />
												<s:hidden name="wdrRequestBean.paymentTypeId"
													value="%{value.payTypeId}"></s:hidden>
											</td>
											<td width="15%" align="left" valign="middle">
												<s:select name="wdrRequestBean.currencyId"
													id="currency_%{value.payTypeCode}"
													list="%{value.currencyMap}" headerKey="-1"
													cssClass="selectCash" headerValue="--Please Select--"
													theme="simple"></s:select>
											</td>
											<td width="15%" align="left" valign="middle"
												style="padding-left: 15px">
												<s:textfield name="wdrRequestBean.amount"
													cssClass="InpTextBoxBg" id="amount_%{value.payTypeCode}"
													value="Amount" theme="simple"></s:textfield>
											</td>
											<td width="50%" align="left" valign="middle">
												<s:if test="%{value.payTypeCode!='BANK_TRANS'&& value.subTypeMap!=null && value.subTypeMap.size()>0}">
													<s:select name="wdrRequestBean.subTypeId"
														id="subTypeCode_%{value.payTypeCode}"
														list="%{value.subTypeMap}" headerKey="-1"
														cssClass="selectCash" headerValue="--Please Select--"
														theme="simple"></s:select>
	
												</s:if>
											</td>
											<td width="5%" align="left" valign="middle"
												style="padding-right: 10px">
												<SPAN id="yelowBGBtn">
												<input type="button" name="submitBtn" id="btn_%{paymentType}"
														value="Continue" class="Inp_cont2" style="cursor: pointer;"/>
												</SPAN>
											</td>
										</tr>
									</table>
								</div>
								<div style="width: 92%;display: none;" >
									<s:if test="%{value.payTypeCode=='BANK_TRANS'}">
										<s:set name="bankList" value="%{value.subTypeMap}"></s:set>
										<s:include value="st_pms_cashier_portal_bankRedeemAccInfo.jsp"></s:include>
									</s:if>
									<s:elseif test="%{value.payTypeCode=='CHEQUE_TRANS'}">
										<s:include value="st_pms_cashier_portal_chequeRedeemAccInfo.jsp"></s:include>
									</s:elseif>
									
								</div>
							</div>
						</s:form>
					</s:iterator>
				</s:if>
				<s:else>
		    		No withdrawal option available 
		    	</s:else>
			</div>
		</div>


	</body>

</html>

<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
pageContext.setAttribute("basePath", basePath);
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Deposit Request</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<SCRIPT type="text/javascript">
	$(document).ready(function() {
		if($("#paga").length>0){
			console.log($("#paga").length>0);
		}else {
			$('#paymentForm').submit();
		}
	});
</SCRIPT>

  </head>
  
  <body>
  <s:form name="paymentForm" id="paymentForm"
			action="%{requestBean.redirectUrl}" namespace="" method="POST">
			<h1>
				Please Wait...
			</h1>
			<s:if test="%{requestBean.providerName=='CITRUS'}">
				<table>
					<s:hidden name="merchantTxnId" value="%{requestBean.requestId}"></s:hidden>
					<s:hidden name="orderAmount"
						value="%{requestBean.amount}"></s:hidden>
					<s:hidden name="currency"
						value="%{requestBean.currency}"></s:hidden>
					<s:hidden name="firstName"
						value="%{playerInfoBean.firstName}"></s:hidden>
					<s:hidden name="lastName"
						value="%{playerInfoBean.lastName}"></s:hidden>
					<s:hidden name="email"
						value="%{playerInfoBean.emailId}"></s:hidden>
					<s:hidden name="addressStreet1"
						value="%{playerInfoBean.addressLine1}"></s:hidden>
					<s:hidden name="addressCity"
						value="%{playerInfoBean.city}"></s:hidden>
					<s:hidden name="addressZip"
						value="%{playerInfoBean.postalCode}"></s:hidden>
					<s:hidden name="addressState"
						value="%{playerInfoBean.stateCode}"></s:hidden>
					<s:hidden name="phoneNumber" value="%{playerInfoBean.mobileNo}"></s:hidden>
					<s:hidden name="paymentMode" value="%{requestBean.paymentMode}" />
					<s:hidden name="%{requestBean.cardType}" value="%{requestBean.subTypeCode}" />
					
					<s:hidden name="returnUrl"
						value="%{#attr.basePath+'portal/cashier/depositResponseCitrus'}"></s:hidden>
					<s:hidden name="secSignature" value="%{requestBean.citrusSignature}"></s:hidden>
					<s:hidden name="reqtime" value="%{requestBean.requestTime}"></s:hidden>
				</table>
			</s:if>
			<s:elseif test="%{requestBean.providerName=='TECHPROCESS'}">
				<table>
					<s:hidden name="msg" id='msg' value="%{requestBean.tsplMsg}"></s:hidden>
				</table>
			</s:elseif>
			<s:elseif test="%{requestBean.providerName=='ATOM'}">
				<table>
					<s:hidden name="ttype" id='ttype' value="%{requestBean.ttype}"></s:hidden>
					<s:hidden name="tempTxnId" id='tempTxnId' value="%{requestBean.tempTxnId}"></s:hidden>
					<s:hidden name="token" id='token' value="%{requestBean.token}"></s:hidden>
					<s:hidden name="txnStage" id='txnStage' value="%{requestBean.txnstage}"></s:hidden>
				</table>
			</s:elseif>
			<s:elseif test="%{requestBean.providerName=='SAFECHARGE'}">
				<table>
					<s:hidden name="merchant_id" value="%{requestBean.merchantId}"></s:hidden>
					<s:hidden name="merchant_site_id" value="%{requestBean.merchantSiteId}"></s:hidden>
					<s:hidden name="customSiteName" value="%{requestBean.customSiteName}"></s:hidden>
					<s:hidden name="item_name_1" value="%{requestBean.itemName1}"></s:hidden>
					<s:hidden name="item_number_1" value="%{requestBean.itemNumber1}"></s:hidden>
					<s:hidden name="item_amount_1" value="%{requestBean.itemAmount1}"></s:hidden>
					<s:hidden name="item_quantity_1" value="%{requestBean.itemQuantity1}"></s:hidden>
					<s:hidden name="total_amount" value="%{requestBean.amount}"></s:hidden>
					<s:hidden name="version" value="%{requestBean.requestVersion}"></s:hidden>
					<s:hidden name="time_stamp" value="%{requestBean.requestTimeStamp}"></s:hidden>
					<s:hidden name="currency" value="%{requestBean.currency}"></s:hidden>
					<s:hidden name="payment_method" value="%{requestBean.paymentMode}"></s:hidden>
					<s:hidden name="merchant_unique_id" value="%{requestBean.requestId}"></s:hidden>
					<s:hidden name="checksum" value="%{requestBean.checksum}"></s:hidden>
				</table>
			</s:elseif>
			
			<s:elseif test="%{requestBean.providerName=='PAYCASH'}">
				<table>
					<s:hidden name="BANKID" value="%{requestBean.subTypeCode}"></s:hidden>
					<s:hidden name="PRN" value="%{requestBean.requestId}"></s:hidden>
					<s:hidden name="PID" value="%{requestBean.pid}"></s:hidden>
					<s:hidden name="AMT" value="%{requestBean.amount}"></s:hidden>
					<s:hidden name="ITC" value="%{requestBean.merchantId}"></s:hidden>
					<s:hidden name="MD" value="%{requestBean.paymentMode}"></s:hidden>
					<s:hidden name="CRN" value="%{requestBean.currency}"></s:hidden>
					<s:hidden name="RU" value="%{#attr.basePath+'portal/cashier/depositResponsePaycash'}"></s:hidden>
				</table>
			</s:elseif>
			<s:elseif test="%{requestBean.providerName=='EBS'}">
				<table>
					 <s:hidden name="channel" value="0" /> 
					<s:hidden name="account_id" value="%{requestBean.accountId}" />
					<s:hidden name="algo" value="%{requestBean.secureKeyType}" />
					<s:hidden name="reference_no" value="%{requestBean.requestId}" />
					<s:hidden name="amount" value="%{requestBean.amount}" />
					<s:hidden name="mode" value="LIVE" />
					 <s:hidden name="currency" value="%{requestBean.currency}" />
					<s:hidden name="description" value="KPR Deposit" />
					<s:hidden name="return_url" value="%{#attr.basePath+'portal/cashier/depositResponseEBS'}" />
					<s:hidden name="name" value="%{playerInfoBean.firstName+' '+playerInfoBean.lastName}" />
					<s:hidden name="address" value="%{playerInfoBean.addressLine1}" />
					<s:hidden name="city" value="%{playerInfoBean.city}" />
					<s:hidden name="state" value="%{playerInfoBean.stateCode}" />
					<s:hidden name="country" value="IND" />
					<s:hidden name="postal_code" value="%{playerInfoBean.postalCode}" />
					<s:hidden name="phone" value="%{playerInfoBean.mobileNo}" />
					<s:hidden name="email" value="%{playerInfoBean.emailId}" />
					<s:hidden name="payment_option" value="%{requestBean.subTypeCode}" /> 
				
					<s:hidden name="secure_hash" value="%{requestBean.secureHash}" />
				</table>
			</s:elseif>	
			 <s:elseif test="%{requestBean.providerName=='PAYU'}">
				<table>
					<s:hidden name="key" value="%{requestBean.key}" />
					<s:hidden name="txnid" value="%{requestBean.requestId}" />
					<s:hidden name="amount" value="%{requestBean.amount}" />
					<s:hidden name="productinfo" value="KPR Deposit" />
					<s:hidden name="surl" value="%{#attr.basePath+'portal/cashier/depositResponsePAYU'}" />
					<s:hidden name="furl" value="%{#attr.basePath+'portal/cashier/depositResponsePAYU'}" />
					<s:hidden name="curl" value="%{#attr.basePath+'portal/cashier/depositResponsePAYU'}" />
					<s:hidden name="firstname" value="%{playerInfoBean.firstName}" />
					<s:hidden name="lastname" value="%{playerInfoBean.lastName}" />
					<s:hidden name="address1" value="%{playerInfoBean.addressLine1}" />
					<s:hidden name="address2" value="" />
					<s:hidden name="city" value="%{playerInfoBean.city}" />
					<s:hidden name="state" value="%{playerInfoBean.stateCode}" />
					<s:hidden name="country" value="IND" />
					<s:hidden name="zipcode" value="%{playerInfoBean.postalCode}" />
					<s:hidden name="phone" value="%{playerInfoBean.mobileNo}" />
					<s:hidden name="email" value="%{playerInfoBean.emailId}" />
					<s:hidden name="udf1" value="" />
					<s:hidden name="udf2" value="" />
					<s:hidden name="udf3" value="" />
					<s:hidden name="udf4" value="" />
					<s:hidden name="udf5" value="" />
					<s:hidden name="hash" value="%{requestBean.hash}" />
					<s:hidden name="pg" value="%{requestBean.paymentMode}" />
				</table>
			</s:elseif> 
			<s:elseif test="%{requestBean.providerName=='PAYU MONEY'}">
				<table>
					<s:hidden name="key" value="%{requestBean.key}" />
					<s:hidden name="txnid" value="%{requestBean.requestId}" />
					<s:hidden name="amount" value="%{requestBean.amount}" />
					<s:hidden name="productinfo" value="KPR Deposit" />
					<s:hidden name="surl" value="%{#attr.basePath+'portal/cashier/depositResponsePAYUMoney'}" />
					<s:hidden name="furl" value="%{#attr.basePath+'portal/cashier/depositResponsePAYUMoney'}" />
					<s:hidden name="curl" value="" />
					<s:hidden name="firstname" value="%{playerInfoBean.firstName}" />
					<s:hidden name="lastname" value="%{playerInfoBean.lastName}" />
					<s:hidden name="address1" value="%{playerInfoBean.addressLine1}" />
					<s:hidden name="address2" value="" />
					<s:hidden name="city" value="%{playerInfoBean.city}" />
					<s:hidden name="state" value="%{playerInfoBean.stateCode}" />
					<s:hidden name="country" value="IND" />
					<s:hidden name="zipcode" value="%{playerInfoBean.postalCode}" />
					<s:hidden name="phone" value="%{playerInfoBean.mobileNo}" />
					<s:hidden name="email" value="%{playerInfoBean.emailId}" />
					<s:hidden name="udf1" value="" />
					<s:hidden name="udf2" value="" />
					<s:hidden name="udf3" value="" />
					<s:hidden name="udf4" value="" />
					<s:hidden name="udf5" value="" />
					<s:hidden name="hash" value="%{requestBean.hash}" />
					<s:hidden name="pg" value="%{requestBean.paymentMode}" />
					<s:hidden name="service_provider" value="payu_paisa" />
				</table>
			</s:elseif>
			<s:elseif test="%{requestBean.providerName=='MPOWER'}">
			
			</s:elseif>		
			<s:elseif test="%{requestBean.providerName=='PAYTM'}">
				<table>
					<s:hidden name="MID" value="%{requestBean.mid}" />
					<s:hidden name="ORDER_ID" value="%{requestBean.requestId}" />
					<s:hidden name="CUST_ID" value="%{playerInfoBean.playerId}" />
					<s:hidden name="TXN_AMOUNT" value="%{requestBean.amount}" />
					<s:hidden name="CHANNEL_ID" value="WEB" />
					<s:hidden name="INDUSTRY_TYPE_ID" value="%{requestBean.pid}" />
					<s:hidden name="WEBSITE" value="SACHARWEB" />
					<s:hidden name="CHECKSUMHASH" value="%{requestBean.checksumHash}" />
					<s:hidden name="MSISDN" value="%{playerInfoBean.mobileNo}" />
					<s:hidden name="EMAIL" value="%{playerInfoBean.emailId}" />
					<s:hidden name="CALLBACK_URL" value="%{#attr.basePath+'portal/cashier/depositResponsePayTm'}" />
				</table>
			</s:elseif>	
			
			<s:elseif test="%{requestBean.providerName=='CASHFREE'}">
				<table>
					<s:hidden name="appId" value="%{requestBean.appId}" />
					<s:hidden name="orderId" value="%{requestBean.requestId}" />
					<s:hidden name="signature" value="%{requestBean.CashFreeSignature}" />
					<s:hidden name="orderAmount" value="%{requestBean.amount}" />
					<s:hidden name="customerPhone" value="%{playerInfoBean.mobileNo}" />
					<s:hidden name="customerEmail" value="%{playerInfoBean.emailId}" />
					<s:hidden name="returnUrl" value="%{#attr.basePath+'portal/cashier/depositResponseCashFree'}" />
				</table>
			</s:elseif>	
			
			<s:elseif test="%{requestBean.providerName=='Paga'}">
				<div id = "paga">
					<s:hidden name="description[0]" value="%{requestBean.description}" />
					<s:hidden name="subtotal[0]" value="%{requestBean.amount}" />
					<s:hidden name="invoice" value="%{requestBean.requestId}" />
					<s:hidden name="return_url" value="%{#attr.basePath+'portal/cashier/depositResponsePaga'}" />
					<s:hidden name="test" value="%{requestBean.test}" />
				</div>		
				<script type="text/javascript" src="<s:property value="%{requestBean.pagaScriptUrl}"/>"> </script>
			</s:elseif>
			<s:elseif test="%{requestBean.providerName=='INTERSWITCH'}">
				<table>
					<s:hidden name="product_id" value="%{requestBean.productId}" />
					<s:hidden name="amount" value="%{requestBean.amount}" />
					<s:hidden name="currency" value="%{requestBean.currencyCode}" />
					<s:hidden name="site_redirect_url" value="%{#attr.basePath+'portal/cashier/depositResponseInterswitch'}" />
					<s:hidden name="txn_ref" value="%{requestBean.requestId}" />
					<s:hidden name="hash" value="%{requestBean.hash}" />
					<s:hidden name="pay_item_id" value="%{requestBean.payItemId}" />
					<s:hidden name="cust_id" value="%{playerInfoBean.mobileNo}" />
					<s:hidden name="cust_id_desc" value="Player Mobile No" />
					<s:hidden name="cust_name" value="%{playerInfoBean.firstName+' '+playerInfoBean.lastName}" />
					<s:hidden name="cust_name_desc" value="Player Full Name" />
				</table>
			</s:elseif>		
		</s:form>
		
	<%-- 	<script type="text/javascript" src="https://qa1.mypaga.com/paga-web/epay/ePay-button.paga?k=973872ae-f037-4d57-a54d-044ab3dac1f1&e=false"></script> --%>	
		
  </body>
</html>

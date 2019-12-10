<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Deposit Response</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/old/address.css">
	<script src="<%=path%>/js/jQuery/jquery-1.8.3.js" type="text/javascript" ></script>
	<SCRIPT type="text/javascript">
		$(document).ready(function() {		
			$('form').submit();
		});
	</SCRIPT>
	</head>

	<body>
	
	<s:if test="%{responseBean.responseUrl== null ||responseBean.responseUrl=='MOBILE_APP'}">
		<s:hidden id="responseJson" value="%{responseJson}"></s:hidden>
	</s:if>
	<s:else>
		<center><h3>Please Wait...</h3></center>
		<s:form action="%{responseBean.responseUrl}" method="post">
			
			<s:hidden name="responseBean.playerId" value="%{responseBean.playerId}"/>
			<s:hidden name="responseBean.requestId" value="%{responseBean.requestId}"/>
			<s:hidden name="responseBean.requestAmount" value="%{responseBean.requestAmount}"/>
			<s:hidden name="responseBean.netAmount" value="%{responseBean.netAmount}"/>
			<s:hidden name="responseBean.status" value="%{responseBean.status}"/>
			<s:hidden name="responseBean.txnType" value="%{responseBean.txnType}"/>
			<s:hidden name="responseBean.requestTime" value="%{responseBean.requestTime}"/> 
			<s:hidden name="responseBean.responseMsg" value="%{responseBean.responseMsg}"/>
			<s:hidden name="responseBean.requestTime" value="%{responseBean.requestTime}"/>
			<s:hidden name="responseBean.firstDeposit" value="%{responseBean.firstDeposit}"/>
			<s:hidden name="responseBean.bonusAmount" value="%{responseBean.bonusAmount}"/>
			<s:hidden name="responseBean.playerSessionId" value="%{responseBean.playerSessionId}"></s:hidden>
			<s:hidden name="responseBean.paymentType" value="%{responseBean.paymentType}"></s:hidden>
			<s:hidden name="responseBean.paySubType" value="%{responseBean.paySubType}"></s:hidden>
			<s:hidden name="responseBean.promoCodeApplied" value="%{responseBean.promoCodeApplied}"></s:hidden>
			<s:hidden name="responseBean.bonusType" value="%{responseBean.bonusType}"></s:hidden>
			<s:hidden name="responseBean.txnId" value="%{responseBean.txnId}"></s:hidden>
			
			<!-- walletinfo bean -->
			<s:if test="%{responseBean.walletInfo != null}">
				<s:hidden name="responseBean.walletInfo.currencyId" value="%{responseBean.walletInfo.currencyId}"></s:hidden>
				<s:hidden name="responseBean.walletInfo.totalBal" value="%{responseBean.walletInfo.totalBal}"></s:hidden>
				<s:hidden name="responseBean.walletInfo.cashBal" value="%{responseBean.walletInfo.cashBal}"></s:hidden>
				<s:hidden name="responseBean.walletInfo.bonusBal" value="%{responseBean.walletInfo.bonusBal}"></s:hidden>
				<s:hidden name="responseBean.walletInfo.pendingWinning" value="%{responseBean.walletInfo.pendingWinning}"></s:hidden>
				<s:hidden name="responseBean.walletInfo.withdrawableBal" value="%{responseBean.walletInfo.withdrawableBal}"></s:hidden>
				<s:hidden name="responseBean.walletInfo.pgCharges" value="%{responseBean.walletInfo.pgCharges}"></s:hidden>
				<s:hidden name="responseBean.walletInfo.totalWgr" value="%{responseBean.walletInfo.totalWgr}"></s:hidden>
			</s:if>
		</s:form>
	</s:else>
	</body>
</html>
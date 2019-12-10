<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
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
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<SCRIPT type="text/javascript">
	$(document).ready(function (){
	$("#close_image").show();
	bonusTable = $('#bonusDetails').dataTable({
		"scrollX" : true,
		"sPaginationType" : "full_numbers",
		"aoColumnDefs" : [ {
			'bSortable' : false,
			"aTargets" : [ 0 ]
		} ]
	});
	var activeAccordian = false;
	var $accordions = $(".accordion").on('click', function() {
        	activeAccordian = this;
    		}).accordion({
			collapsible : true,
			heightStyle: "content",
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true 
			}).on('click', function(event, ui) {
        $accordions.not(activeAccordian).accordion('activate', false);
    });
    var activeAccordianN = false;
	var $accordionsN = $(".accordionN").on('click', function() {
        	activeAccordianN = this;
    		}).accordion({
			collapsible : true,
			heightStyle: "content",
			clearStyle : true,
			icons : {
			header : "plus",
			headerSelected : "minus"
			},
			active : true 
			}).on('click', function(event, ui) {
        $accordionsN.not(activeAccordianN).accordion('activate', false);
    });
	});
	</SCRIPT>
  </head>
  
  <body>
    <div class="FormSection" style="margin: 10px;width: 900px;margin-top: 30px;">
				<div class="greyStrip">
					<h4>
						Fraud Analysis Report 
					</h4>
				</div>
				<div class="accordion">
				<h4>Profile Information</h4>
				<div>
				<table>
				<tbody>
				<tr>
				<td width="35%" align="center" style="padding-left: 4px ; line-height:25px"> User Name :</td>
				<td width="35%" align="center"><s:property value="plrFraudReqBean.userName"/></td>
				<td width="35%" align="center"> Date Of Joining :</td>
				<td width="35%" align="center"><s:property value="plrFraudReqBean.registrationDate"/></td>
				
				<td></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="35%" align="center" style="padding-left: 4px; line-height:25px">Requested Withdrawal Amount :</td>
				<td width="35%" align="center"><s:property value="plrFraudReqBean.withdrawalAmt"/></td>
				<td width="35%" align="center">Requested Mode of Payment : </td>
				<td width="35%" align="center"><s:property value="plrFraudReqBean.withdrawalMode"/></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="35%" align="center" style="padding-left: 4px; line-height:25px">Total Deposit Till Date :</td>
				<td width="35%" align="center"><s:property value="plrFraudReqBean.totalDeposit"/></td>
				<td width="35%" align="center">Total Withdrawal Till Date :</td>
				<td width="35%" align="center"><s:property value="plrFraudReqBean.totalWithdrawal"/></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="35%" align="center" style="padding-left: 4px; line-height:25px">Age Verified :</td>
				<td width="35%" align="center"><s:if test='plrFraudReqBean.ageVerified == "VERIFIED"'>Yes</s:if><s:else>No</s:else></td>
				<td width="35%" align="center">Address Verified :</td>
				<td width="35%" align="center"><s:if test='plrFraudReqBean.addressVerified == "VERIFIED"'>Yes</s:if><s:else>No</s:else></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="35%" align="center" style="padding-left: 4px; line-height:25px">Balance in A/C :</td>
				<td width="35%" align="center"><s:property value="plrFraudReqBean.cashBal"/></td>
				<td width="35%" align="center">No of Payments in Last Month :</td>
				<td width="35%" align="center"><s:property value="plrFraudReqBean.payOutsInMnth"/></td>
				</tr>
				</tbody>
				</table>
				</div>
				</div>
				<div class="accordion">
				<h4>
				Last Pay-Out Request Time Information
				</h4>
				<div>
				<table><tbody>
				<tr>
				<td width="30%" align="left" style="line-height:25px">Deposit From Last Pay-Out Req.:</td>
				<s:if test="plrFraudReqBean.wagerFrmLstPayOut<(plrFraudReqBean.depstFrmLstPayOut / 100)*50">
				<td width="25%" style="text-align:center;color:red">	
				<s:property   value="plrFraudReqBean.depstFrmLstPayOut"/>
				</td>
				</s:if>
				<s:else>
				<td width="25%" style="text-align:center">	
				<s:property   value="plrFraudReqBean.depstFrmLstPayOut"/>
				</td>
				</s:else>
				<td width="30%" align="left" style="line-height:25px">Wagering From Last Pay-Out Req.:</td>
				<td width="25%"  style="text-align:center"><s:property value="plrFraudReqBean.wagerFrmLstPayOut"/></td>
				</tr>
				<tr>
				<td width="30%" align="left" style="line-height:25px">Winning From Last Pay-Out Req.:</td>
				<td width="25%" style="text-align:center"><s:property value="plrFraudReqBean.winningFrmLstPayOut"/></td>
				<td width="30%" align="left" style="line-height:25px">Bonus Redeemed to Cash :</td>
				<td width="25%" style="text-align:center"><s:property value="plrFraudReqBean.bonusRedeemFrmLstPayOut"/></td>
				</tr>
				<tr>
				<td width="30%" align="left" style="line-height:25px">Rejection of Payment (Player) :</td>
				<td width="25%" style="text-align:center"><s:property  value="plrFraudReqBean.payoutRejectedPlr" /></td>
				<td width="30%" align="left" style="line-height:25px"  >Pending Requests :</td>
				<td width="25%" style="text-align:center"><s:property value="plrFraudReqBean.pendingReqFrmLstPayOut"/></td>
				</tr>
				<tr>
				<td width="30%" align="left"  style="line-height:25px">Last Pay-Out Request On :</td>
				<td width="25%" style="text-align:center"><s:if test="plrFraudReqBean.lastPayoutRequestOn == null">NILL</s:if><s:else><s:property value="plrFraudReqBean.lastPayoutRequestOn"/></s:else></td>
				<td width="30%" align="left" style="line-height:25px">Last Pay-Out On :</td>
				<td width="25%" style="text-align:center"><s:if test="plrFraudReqBean.lastPayOutOn == null">NILL</s:if><s:else><s:property value="plrFraudReqBean.lastPayOutOn"/></s:else></td>
				</tr>
				</tbody>
				</table>
				<div class="accordionN">
				<h4 style="padding-left: 5px">
				Rejection of Payment (Back Office) :&nbsp;&nbsp;&nbsp;<s:property  value="plrFraudReqBean.payoutRejectedBo" />
				</h4>
				<div>
				<s:if test="plrFraudReqBean.payoutRejectedBo>0">
				<table border="0" 
					align="center" class="payTransaction" style="margin-top:0px;">
					<thead>
					<tr style="height:20px">
						<th width="20%" valign="middle" align="left" nowrap="nowrap">
							Request Date 
						</th>
						<th width="20%" valign="middle" align="left" nowrap="nowrap" >
							Amount
						</th>
						<th width="20%" valign="middle" align="left" nowrap="nowrap">
							Cancellation Date
						</th>
						<th width="40%" valign="middle" align="left" nowrap="nowrap">
							Reason
						</th>
					</tr>
					</thead>
					<tbody>
					 <s:iterator value="%{plrFraudReqBean.reasonDetail}" >
						<tr style="line-height:18px">
							<td>
								<s:property value="%{transactionDate}" />
							</td>
							<td>
								<s:property value="%{amount}" />
							</td>
							<td>
								<s:property value="%{processTime}" />
							</td>
							<td>
								<s:property value="%{reasonForCancel}" />
							</td>
						</tr>
					</s:iterator> 
				</tbody>
				</table>
				</s:if>
				<s:else>
				<h3 align="center"><font color="red">No Withdrawal is cancelled by Back office.</font></h3>
				</s:else>
				</div>
				</div>
				</div>
				</div>
				
				<div class="accordion">
				<h4>
				Bonus Details
				</h4>
				<div>
				<s:if test="plrFraudReqBean.bonusDetails.size()>0">
				<table  border="0" id="bonusDetails"
					align="center" class="payTransaction" >
					<thead>
					<tr>
						<th width="20%" valign="middle" align="left">
							Bonus Name
						</th>
						<th width="20%" valign="middle" align="left">
							Is Redeemable
						</th>
						<th width="20%" valign="middle" align="left" >
							Amount Redeemed To Cash
						</th>
						<th width="10%" valign="middle" align="left" >
							Transaction Date
						</th>
						<th width="20%" valign="middle" align="left" >
							Wager Contribution At Transfer
						</th>
						
					</tr>
					</thead>
					<tbody>
					 <s:iterator value="%{plrFraudReqBean.bonusDetails}" >
						<tr>
							<td>
								<s:property value="%{bonusCode}" />
							</td>
							<td>
								<s:property value="%{status}" />
							</td>
							<td>
								<s:property value="%{redeemedAmtToCash}" />
							</td>
							<td>
								<s:property value="%{transactionDate}" />
							</td>
							<td>
								<s:property value="%{wrContributionAtTransfer}" />
							</td>
						</tr>
					</s:iterator> 
					</tbody>
				</table>
				</s:if>
				<s:else>
				<h3 align="center"><font color="red">No Bonus Details Found.</font></h3>
				</s:else>
				</div>
				</div>
				
				<div class="accordion">
				<h4>
				Game Played Information
				</h4>
				<div>
								<h6>IP Information</h6><br>
				
				<table>
				<tbody>
				<tr>
				<s:iterator value="plrFraudReqBean.ipGameMap" status="ipGameMap">
				<s:if test="key.contains('R-')">
				<td width="12%" style="padding-left: 4px; line-height:25px;color: #CD0A0A"> <s:property value='%{key.replace("R-","")}'/>:</td>
				</s:if>
				<s:elseif test="key.contains('B-')">
				<td width="12%" style="padding-left: 4px; line-height:25px;color: #0000FF"> <s:property value='%{key.replace("B-","")}'/>:</td>
				</s:elseif>
				<s:elseif test="key.contains('G-')">
				<td width="12%" style="padding-left: 4px; line-height:25px;color: #15B856"> <s:property value='%{key.replace("G-","")}'/>:</td>
				</s:elseif>
				<s:else>
				<td width="12%" style="padding-left: 4px; line-height:25px;"> <s:property value='%{key}'/>:</td>
				</s:else>
				<td width="12%" align="center"><s:property value="%{value}"/></td>
				<s:if test="#ipGameMap.even">
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				</s:if>
				</s:iterator>
				<s:if test="plrFraudReqBean.ipGameMap == null || plrFraudReqBean.ipGameMap.size==0">
				<td>No records found</td>
				</s:if>
				</tr>
				</tbody></table><br>
				<h6>Opponents Information</h6>
				<table>
				<tbody>
				
				<tr>
				<s:iterator value="plrFraudReqBean.playerGameMap" status="playerGameMap">
				<td width="12%" style="padding-left: 4px; line-height:25px">
				 <s:if test="key.contains('R-')">
					<div class="accordionN"><h6 style="color: #CD0a0a"><s:property value='%{key.replace("R-","")}'/>:</h6>
					<div><b>IP Address</b><br>
					<s:iterator value="%{value.get(1)}" >
					<br>
					<s:if test="top.contains('R-')">					
					<div style="color: #CD0a0a"><s:property value='top.replace("R-","")'/></div>
					</s:if>
					<s:elseif test="top.contains('G-')">	
					<div style="color: #15B856"><s:property value='top.replace("G-","")'/></div>
					</s:elseif>
					<s:elseif test="top.contains('B-')">	
					<div style="color: #0000FF"><s:property value='top.replace("B-","")'/></div>
					</s:elseif>
					<s:else>
					<div><s:property value='top'/></div>
					</s:else>
					</s:iterator>
					</div></div>
				</s:if>
				<s:elseif test="key.contains('B-')">
				<div class="accordionN"><h6 style="color: #0000FF"><s:property value='%{key.replace("B-","")}'/>:</h6>
					<div><b>IP Address</b><br>
					
					<s:iterator value="%{value.get(1)}" >
					<br>
					<s:if test="top.contains('B-')">	
					<div style="color: #0000FF"><s:property value='top.replace("B-","")'/></div>
					</s:if>
					<s:else>
					<div><s:property value='top'/></div>
					</s:else>
					</s:iterator>
					</div></div>
				</s:elseif>
				<s:elseif test="key.contains('G-')">
				<div class="accordionN"><h6 style="color: #15B856"><s:property value='%{key.replace("G-","")}'/>:</h6>
					<div><b>IP Address</b><br>
					<s:iterator value="%{value.get(1)}" >
					<br>
					<s:if test="top.contains('G-')">	
					<div style="color: #15B856"><s:property value='top.replace("G-","")'/></div>
					</s:if>
					<s:elseif test="top.contains('B-')">	
					<div style="color: #0000FF"><s:property value='top.replace("B-","")'/></div>
					</s:elseif>
					<s:else>
					<div><s:property value='top'/></div>
					</s:else>
					</s:iterator>
					</div></div>
				</s:elseif>
				<s:else>
				<div class="accordionN"><h6><s:property value='%{key.replace("G-","")}'/>:</h6>
					<div><b>IP Address</b><br>
					<s:iterator value="%{value.get(1)}" >
					<br><div><s:property value='top.replace("G-","")'/></div>
					</s:iterator>
					</div></div>
				</s:else>
				</td>
				<td width="12%" align="center"><div class="accordionN"><h6><s:property value="%{value.get(0)[0]}"/></h6>
				<div><b>Game Results</b><br><br>Won:<s:property value="%{value.get(2)[0]}"/> lost:<s:property value="%{value.get(2)[1]}"/></div></div></td> &nbsp;&nbsp;
				<s:if test="#playerGameMap.even">
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				</s:if>
				</s:iterator>
				<s:if test="plrFraudReqBean.playerGameMap == null || plrFraudReqBean.playerGameMap.size==0">
				<td>No records found</td>
				</s:if>
				</tr>
				</tbody></table>
				</div>
				</div>
				<div class="accordion">
				<h4>
				Game Played With Referral/Referee Information
				</h4>
				<div>
				<table>
				<tbody>
				<tr>
				<s:iterator value="plrFraudReqBean.refPlrGameMap" status="refPlrGameMap">
				<td width="12%" style="padding-left: 4px; line-height:25px">
				<div class="accordionN"><h6><s:property value="%{key}"/>:</h6>
				<div><b>IP Address</b><br>
				<s:iterator value="%{value.get(1)}">
				<br><s:property/>
				</s:iterator>
				</div></div>
				</td>
				<td width="12%" align="center"><div class="accordionN"><h6><s:property value="%{value.get(0)[0]}"/></h6>
				<div><b>Game Results</b><br><br>Won:<s:property value="%{value.get(2)[0]}"/> lost:<s:property value="%{value.get(2)[1]}"/></div></div></td> &nbsp;&nbsp;
				<s:if test="#refPlrGameMap.even">
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				</s:if>
				</s:iterator>
				<s:if test="plrFraudReqBean.refPlrGameMap == null || plrFraudReqBean.refPlrGameMap.size==0">
				<td>No records found</td>
				</s:if>
				</tr>
				</tbody></table>
				</div>
				</div>
	</div>
  </body>
</html>

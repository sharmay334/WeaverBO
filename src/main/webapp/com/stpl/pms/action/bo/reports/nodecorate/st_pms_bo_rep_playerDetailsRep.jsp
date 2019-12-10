<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Player Detail Report</title>

	<SCRIPT type="text/javascript">
	$(document).ready(function(){
		 $("#fromLastTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				maxDate : new Date(),
				onClose : function(dateText, inst) {
				
					$("#toLastTrans").datetimepicker("option", "minDate", dateText);
					
				}
			});
			$("#toLastTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				hour: 23,
				minute: 59,
				second: 59,
				maxDate : new Date(),
				onClose : function(dateText, inst) {
					$("#fromLastTrans").datetimepicker("option", "maxDate", dateText);
					
				}
			});
			 $("#fromBonusTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				maxDate : new Date(),
				onClose : function(dateText, inst) {
				
					$("#toBonusTrans").datetimepicker("option", "minDate", dateText);
					
				}
			});
			$("#toBonusTrans").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				hour: 23,
			minute: 59,
			second: 59,
			maxDate : new Date(),
				onClose : function(dateText, inst) {
					$("#fromBonusTrans").datetimepicker("option", "maxDate", dateText);
					
				}
			});
			$('#txnDateWise').click(function(){
				if($('#toLastTrans').val().length==11){
					$('#toLastTrans').val($('#toLastTrans').val()+" 23:59:59");
				}
				if($('#fromLastTrans').val().length==11){
					$('#fromLastTrans').val($('#fromLastTrans').val()+" 00:00:00");
				}
			});
			$('#bonusDateWise').click(function(){
				if($('#toBonusTrans').val().length==11){
					$('#toBonusTrans').val($('#toBonusTrans').val()+" 23:59:59");
				}
				if($('#fromBonusTrans').val().length==11){
					$('#fromBonusTrans').val($('#fromBonusTrans').val()+" 00:00:00");
				}
			});
			$('#txnDateWise').click(function(){AjaxCall($(this));});
			$('#bonusDateWise').click(function(){AjaxCall($(this));});
			$('#plrInfoEdit').click(function(){
				AjaxCall($(this));
			});
			function AjaxCall(txt){
					
		var divId = txt.attr('target');
		var param = "";
		var ajaxParam = new Array();
		var ajaxParamVal = "";
		var isChk = true;
		if (typeof txt.attr('ajaxParamPlr') !== 'undefined') {
			var ajaxParamLen =txt.attr('ajaxParamPlr').split(',').length;
			if (ajaxParamLen > 0) {
				ajaxParam = txt.attr('ajaxParamPlr').split(',');
				$.each(ajaxParam, function(index, value) {
					ajaxParamVal = $('#' + value).val();
					param = param + value + "=" + ajaxParamVal + '&';
				});
				// param.replaceLast('&','');
			} else {
				param = txt.attr('name') + "=" + txt.val();
			}
		} else {
			param = txt.attr('name') + "=" + txt.val();
		}
		$.ajax( {
			type : "POST",
			url : txt.attr('ajaxActionPlr'),
			data : param,
			async : false,
			success : function(result) {
				$("#" + divId).html(result);
			}
		});
		return false;
			}
			$('.openFaceBox').facebox({
				closeImage : '<%=request.getContextPath()%>/images/closelabel.png'
  	 		});
			
			
	});
	
	</SCRIPT>

	</head>

	<body>
	<form>
	<div id="replaceEditField">
	<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Signup Information
					</h4>
				</div>
				<table width="95%" cellpadding="0" cellspacing="0" align="center" style="margin-left: 40px;font-size: 12px;color: #2b2b2b; line-height:45px" >
				<tr></tr>
				<tr>
				<td width="25%" align="center" > User Name :</td>
				<td width="25%" align="center" ><s:property value="%{plrDetailBean.userName}"/></td>
				
				<td width="25%" align="center" > Affiliate Source :</td>
				<td width="25%" align="center" ><s:property value="%{plrDetailBean.affiliateSource}"/></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Reg IP :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.regIp}"/></td>
				<td width="25%" align="center">Practice Balance</td>
				<td width="25%" align="center"><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.preBalance)}"/></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Reg Country :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.regCountry}"/></td>
				<td width="25%" align="center">Bonus Balance</td>
				<td width="25%" align="center"><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.bonBal)}"/></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Reg State :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.regState}"/></td>
				<td width="25%" align="center">Cash Balance</td>
				<td width="25%" align="center"><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.cashBal)}"/></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Reg Date :</td>
				<td width="25%" align="center"><s:date name="%{plrDetailBean.registrationDate}" format="dd/MM/yyyy HH:mm:ss"/></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Last Login IP :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.lastLoginIp}" /></td>
				<!--<td width="25%" align="center">Total Balance</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.totBal}"/></td>
				--></tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Last Login Country :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.lastLoginCountry}"/></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Last Login City :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.lastLoginState}"/></td>
				
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Last Login Date :</td>
				<td width="25%" align="center"><s:date name="%{plrDetailBean.plrLoginBean.get(0).loginDate}" format="dd/MM/yyyy HH:mm:ss"/></td>
				</tr>
				</table>
	</div>
	<div id="plrPersonalInfo" >
	<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Personal Information
					</h4>
				</div>
				<table width="95%" cellpadding="0" cellspacing="0" align="center" style="margin-left: 40px;font-size: 12px;color: #2b2b2b; line-height:45px" >
				<tr></tr>
				<tr>
				<td width="25%" align="center">Title :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.title}" /><s:hidden value="%{plrDetailBean.title}" id="title" name="title"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">First Name :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.firstName}" /><s:hidden value="%{plrDetailBean.firstName}" id="fName" name="fName"></s:hidden></td>
				<td width="25%" align="center">Last Name :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.lastName}"/>
				<s:hidden value="%{plrDetailBean.lastName}" id="lName" name="lName"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Date of Birth :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.dob}"/>
				<s:hidden value="%{plrDetailBean.dob}" id="dob" name="dob"></s:hidden></td>
				<!--<td width="25%" align="center">Age Verified :</td>
				--><!--<td width="25%" align="center"><s:if test='%{plrDetailBean.ageVerifed=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{plrDetailBean.ageVerifed=="N"}'>
					<label>No</label>
					</s:elseif>
				<s:hidden value="%{plrDetailBean.ageVerifed}" id="ageVerifed" name="ageVerifed"></s:hidden></td>
				--></tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Email :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.emailId}"/>
					<s:hidden value="%{plrDetailBean.emailId}" id="emailId" name="emailId"></s:hidden></td>
				<td width="25%" align="center">
					&nbsp;&nbsp;&nbsp;&nbsp; 
					<a rel="facebox" id="changePlrMobile" class="button openFaceBox" 
						href="com/stpl/pms/action/bo/pm/st_bo_pm_changePlrEmailOrMobile.action?requestPlayerId=<s:property value="%{plrDetailBean.playerId}"/>&domainId=<s:property value="%{plrDetailBean.domainId}"/>&changeReq=Email&currentData=<s:property value="%{plrDetailBean.emailId}"/>" 
					 style="float:none;vertical-align: baseline;">Change</a>
				 </td>
				<td width="25%" align="center"></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
					<td width="25%" align="center">Email Verified :</td>
					<td width="25%" align="center"><s:if test='%{plrDetailBean.emailVerified=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{plrDetailBean.emailVerified=="N"}'>
					<label>No</label>
					</s:elseif>
					<s:hidden value="%{plrDetailBean.emailVerified}" id="emailVerified" name="emailVerified"></s:hidden></td>
					<td width="25%" align="center"></td>
					<td width="25%" align="center"></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">House No. </td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.houseNum}"/> 
				<s:hidden value="%{plrDetailBean.houseNum}" id="houseNum" name="houseNum"></s:hidden></td>
				<!--<td width="25%" align="center">Address Verified :</td>
				<td width="25%" align="center"><s:if test='%{plrDetailBean.addressVerified=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{plrDetailBean.addressVerified=="N"}'>
					<label>No</label>
					</s:elseif>
				<s:hidden value="%{plrDetailBean.addressVerified}" id="addressVerified" name="addressVerified"></s:hidden></td>
				--></tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Address Line1</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.addressLine1}"/>
				<s:hidden value="%{plrDetailBean.addressLine1}" id="add1" name="add1"></s:hidden></td>
				<td width="25%" align="center">Address Line2</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.addressLine2}"/>
				<s:hidden value="%{plrDetailBean.addressLine2}" id="add2" name="add2"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Country</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.country}"/>
				<s:hidden value="%{plrDetailBean.countryId}" id="plrCountry" name="plrCountry"></s:hidden></td>
				<td width="25%" align="center">State</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.state}"/>
				<s:hidden value="%{plrDetailBean.stateId}" id="plrState" name="plrState"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">City</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.city}"/>
				<s:hidden value="%{plrDetailBean.city}" id="plrCity" name="plrCity"></s:hidden></td>
				<td width="25%" align="center">Pin Code</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.postalCode}"/>
				<s:hidden value="%{plrDetailBean.postalCode}" id="plrPostalCode" name="plrPostalCode"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Gender :</td>
				<td width="25%" align="center"><s:if test='%{plrDetailBean.gender=="M"}'>
					<label>Male</label>
				</s:if>
				<s:elseif test='%{plrDetailBean.gender=="F"}'>
					<label>Female</label>
				</s:elseif>
				<s:hidden value="%{plrDetailBean.gender}" id="gender1" name="gender1"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Mobile No :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.mobileNo}"/>
					<s:hidden value="%{plrDetailBean.mobileNo}" id="mobileNo" name="mobileNo"></s:hidden>
					&nbsp;&nbsp;&nbsp;&nbsp; 
					
					<a rel="facebox" id="changePlrMobile" class="button openFaceBox" 
						href="com/stpl/pms/action/bo/pm/st_bo_pm_changePlrEmailOrMobile.action?requestPlayerId=<s:property value="%{plrDetailBean.playerId}"/>&domainId=<s:property value="%{plrDetailBean.domainId}"/>&changeReq=Mobile No&currentData=<s:property value="%{plrDetailBean.mobileNo}"/>" 
					 style="float:none;vertical-align: baseline;">Change</a>
				
				</td>
				<td width="25%" align="center">Mobile Verified :</td>
				<td width="25%" align="center"><s:if test='%{plrDetailBean.phoneVerified=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{plrDetailBean.phoneVerified=="N"}'>
					<label>No</label>
					</s:elseif>
				<s:hidden value="%{plrDetailBean.phoneVerified}" id="phoneVerified" name="phoneVerified"></s:hidden></td>
				
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Player Status :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.regStatus}"/>
				<s:hidden value="%{plrDetailBean.regStatus}" id="regStatus1" name="regStatus1"></s:hidden></td>
				<td width="25%" align="center">Reason :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.reason}"/>
				<s:hidden value="%{plrDetailBean.reason}" id="reason" name="reason"></s:hidden></td>
				
				</tr>
				</table>
			
			<s:hidden value="%{plrDetailBean.playerId}" name="playerId1" id="playerId1"></s:hidden>
			<s:hidden value="%{plrDetailBean.domainId}" name="domainId1" id="domainId1"></s:hidden>
			<div class="box_footer" align="right">
				<ss:button name="eDit" value="Edit" cssClass="button" ajaxActionPlr="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerPersonalDetailsEdit.action"  target="plrPersonalInfo" ajaxParamPlr="plrCity,plrCountry,plrState,plrPostalCode,title,houseNum,gender1,emailVerified,phoneVerified,addressVerified,add1,fName,lName,emailId,ageVerifed,dob,mobileNo,title,playerId1,reason,regStatus1,add2,domainId1" id="plrInfoEdit"></ss:button>
			</div>
</div>	
			
			
</div>
		<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Login Details
					</h4>
				</div>
				<s:if test="%{plrDetailBean.plrLoginBean.size()>0}">
				<table  width="95%" border="0" cellspacing="0" cellpadding="0" id="payTransaction" align="center" class="payTransaction">
				<tr>
				<th width="10%" valign="middle" align="left">S.No</th>
				<th width="22.5%" valign="middle" align="left">Login Date</th>
				<th width="22.5%" valign="middle" align="left">IP Address</th>
				<th width="22.5%" valign="middle" align="left">City</th>
				<th width="22.5%" valign="middle" align="left">Device</th>
				</tr>
				<s:iterator value="%{plrDetailBean.plrLoginBean}" status="plrLoginBean">
				<tr>
					<td>
						
						<s:property value="%{#plrLoginBean.index+1}" />
					</td>
					<td>
						
						<s:date name="loginDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:property value="%{ipAddress}" />
					</td>
					<td>
						<s:property value="%{city}" />
					</td>
					<td>
						<s:property value="%{device}" />
					</td>

				</tr>
				</s:iterator>
				</table>
				</s:if><s:else>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
					</div>
					
					<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Player Wallet Details
					</h4>
				</div>
				
				<table  width="95%" border="0" cellspacing="0" cellpadding="0" id="payTransaction" align="center" class="payTransaction">
				<tr>
				<th width="10%" valign="middle" align="left">Total Balance</th>
				<th width="10%" valign="middle" align="left">Cash Balance</th>
				<th width="10%" valign="middle" align="left">Bonus Balance</th>
				<th width="10%" valign="middle" align="left">Total Deposit</th>
				<th width="10%" valign="middle" align="left">Total Winning</th>
				<th width="10%" valign="middle" align="left">Total Wager</th>
				<th width="10%" valign="middle" align="left">Total WithDrawal</th>
				<th width="10%" valign="middle" align="left">Total Bonus</th>
				<th width="10%" valign="middle" align="left">Withdrawable Balance</th>
				</tr>
			
				<tr>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrWalletBean.totalBal)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrWalletBean.cashBal)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrWalletBean.bonusBal)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrWalletBean.totalDeposit)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrWalletBean.totalWinning)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrWalletBean.totalWager)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrWalletBean.totalWithdrawal)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrWalletBean.totalBonus)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrWalletBean.withdrawableBal)}"  />
					</td>
				</tr>
				
				</table>
				
					</div>
		<div class="FormSection" id="lastTransactionData">
		
			<div class="greyStrip">
					<h4>
					Last Transaction
					<input type="text" id="fromLastTrans" name="fromLastTrans" placeholder="From Date" value="<s:property value="%{plrDetailBean.plrTxnBean.get(0)}"/>" readonly="readonly" applyscript="true" />
						<input type="text" id="toLastTrans" name="toLastTrans" placeholder="To Date" value="<s:property value="%{plrDetailBean.plrTxnBean.get(1)}"/>" applyscript="true" readonly="readonly"/>
					 <input type="button" ajaxActionPlr="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerFullTxn.action" ajaxParamPlr="txnPlayerId,toLastTrans,fromLastTrans" target="lastTransactionData" class="button" value="View Txn Details" id="txnDateWise" checked="true" style="margin: 5px 6px 5px 0 !important;"/>
					</h4>
					
					</div>
					
					<s:if test="%{plrDetailBean.plrTxnBean.get(2).size()>0}">	
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="payTransaction" align="center" class="payTransaction">
			<tr>
				<th>
					S.No
				</th>
				<th>
					 Date
				</th>
				<th>
					  Transaction Id 
				</th>
				<th>
					Particulars
				</th>
				<th>
					Credit 
				</th>

				<th>
					Debit 
				</th>

				<th>
					Balance
				</th>
			</tr>

			<s:iterator value="%{plrDetailBean.plrTxnBean.get(2)}" status="plrTxnList">
				<tr>
					<td>
						<s:property value="%{#plrTxnList.index+1}" />
					</td>
					<td>
						<s:date name="transactionDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:property value="%{transactionId}" />
					</td>
					<td>
						<s:property value="%{particular}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(creditAmount)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(debitAmount)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(balance)}" />
					</td>

				</tr>
			</s:iterator>
			
		</table>
		<div style="margin-left: 80%">
		<h3><label style="font-size: 12px">Opening Balance <s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrTxnBean.get(2).get(getPlrDetailBean().getPlrTxnBean().get(2).size()-1).openingBalance)}"/></label></h3>
		</div>
		
		</s:if><s:else>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
			<div class="box_footer" align="right">
			<s:hidden id="txnPlayerId" name="txnPlayerId" value="%{playerId}"></s:hidden>
		
		 </div> 
		</div>
		<!-- Last Deposit Start -->
		
			<div class="FormSection">
			<div class="greyStrip">
					<h4>
					Deposit Transaction
					
					</h4>
					</div>
					<s:if test="%{plrDetailBean.plrDepositBean.size()>0}">	
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="payTransaction" align="center" class="payTransaction" >
			<tr>
				<th>
					S.No
				</th>
				<th>
					 Date
				</th>
				<th>
					  Transaction Id 
				</th>
				<th>
					Requested Id
				</th>
				<th>
					Amount
				</th>
			</tr>
			<s:iterator value="%{plrDetailBean.plrDepositBean}" status="plrDepositList">
				<tr>
					<td>
						<s:property value="%{#plrDepositList.index+1}" />
					</td>
					<td>
						<s:date name="transactionDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:property value="%{transactionId}" />
					</td>
					<td>
						<s:property value="%{requestId}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(amount)}" />
					</td>

				</tr>
			</s:iterator>

		</table>
		</s:if><s:else>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
		</div>
		
		<!-- Last Deposit end -->
		<!-- Last WithDrawal start -->
		
		<div class="FormSection">
			<div class="greyStrip">
					<h4>
					WithDrawal Transaction
					</h4>
					</div>
					<s:if test="%{plrDetailBean.plrWithdrawalBean.size()>0}">	
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="payTransaction" align="center" class="payTransaction">
			<tr>
				<th>
					S.No
				</th>
				<th>
					 Date
				</th>
				<th>
					  Transaction Id 
				</th>
				<th>
					Process Charges
				</th>
				<th>
					Withrawal Mode 
				</th>
				<th>
					Balance
				</th>
			</tr>

			<s:iterator value="%{plrDetailBean.plrWithdrawalBean}" status="plrWithDrawal">
				<tr>
					<td>
						<s:property value="%{#plrWithDrawal.index+1}" />
					</td>
					<td>
						<s:date name="transactionDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:property value="%{transactionId}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(processCharges)}" />
					</td>
					<td>
						<s:property value="%{withdrawalMode}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(amount)}" />
					</td>

				</tr>
			</s:iterator>

		</table>
		</s:if><s:else>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
		</div>
		
		<!-- Last WithDrawal End -->
		<!-- Last Bonus start -->
		
		<div class="FormSection" id="bonusDetailData">
			<div class="greyStrip">
					<h4>
					Bonus Details
					<input type="text" id="fromBonusTrans" name="fromBonusTrans" placeholder="From Date" value="<s:property value="%{plrDetailBean.plrBonusDetails.get(0)}"/>" readonly="readonly" applyscript="true" />
						<input type="text" id="toBonusTrans" name="toBonusTrans" placeholder="To Date" value="<s:property value="%{plrDetailBean.plrBonusDetails.get(1)}"/>" applyscript="true" readonly="readonly"/>
						<input type="button" ajaxActionPlr="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerBonusDetail.action" ajaxParamPlr="txnPlayerId,toBonusTrans,fromBonusTrans" target="bonusDetailData" class="button" value="View Bonus Details" id="bonusDateWise" checked="true" style="margin: 5px 6px 5px 0 !important;" />
					</h4>
					</div>
					<s:if test="%{plrDetailBean.plrBonusDetails.get(2).size()>0}">	
				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="payTransaction" align="center" class="payTransaction">
			<tr>
				<th>
					S.No
				</th>
				<th>
					 Rec. Date
				</th>
				<th>
					  Exp. Date 
				</th>
				<th>
					Bonus Name
				</th>
				<th>
					Bonus Amount
				</th>
				<th>
					To Cash
				</th>
				<th>
					Status
				</th>
			</tr>

			<s:iterator value="%{plrDetailBean.plrBonusDetails.get(2)}" status="plrBonus">
				<tr>
					<td>
						<s:property value="%{#plrBonus.index+1}" />
					</td>
					<td>
						<s:date name="receivedDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:date name="expiredDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:property value="%{bonusCode}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(bonusAmt)}" />
					</td>
					<td>
						<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(redeemedBonusAmt)}" />
					</td>
					<td>
						<s:property value="%{wrStatus}" />
					</td>
					

				</tr>
			</s:iterator>

		</table>
		</s:if><s:else>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
			<div class="box_footer" align="right">
			<s:hidden id="bonusPlayerId" name="bonusPlayerId" value="%{playerId}"></s:hidden>
		 
		 </div> 
		</div>
		
		<div class="FormSection" id="tempDetailData">
			<div class="greyStrip">
					<h4>
					Inbox Details
					</h4>
					</div>
					
					<s:if test="%{plrDetailBean.plrInboxTemp.size()>0}">	
				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="payTransaction" align="center" class="payTransaction">
			<tr>
				<th>
					S.No
				</th>
				<th>
					 Subject
				</th>
				<!--<th>
					Template Name
				</th>
				--><th>
					 Sent Date
				</th>
				<th>
					 Exp. Date 
				</th>
				<th>
					Status
				</th>
			</tr>

			<s:iterator value="%{plrDetailBean.plrInboxTemp}" status="plrInbox">
				<tr>
					<td>
						<s:property value="%{#plrInbox.index+1}" />
					</td>
					<td>
						<s:property value="%{subject}" />
					</td>
					<!--<td>
						<s:property value="%{templateName}"/>
					</td>
					--><td>
						<s:date name="sentDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					<td>
						<s:date name="expiryDate" format="dd/MM/yyyy HH:mm:ss"/>
					</td>
					
					<td>
						<s:property value="%{emailStatus}" />
					</td>
					

				</tr>
			</s:iterator>

		</table>
		</s:if><s:else>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Msg: </strong>No Record
						Found.
					</div>
				</div>
			</s:else>
			<div class="box_footer" align="right">
			<s:hidden id="bonusPlayerId" name="bonusPlayerId" value="%{playerId}"></s:hidden>
		 
		 </div> 
		</div>
		
		<!-- Last Bonus End -->
		<!-- Vip Criteria Start -->
		
		<div class="plrVipCriteria">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							VIP Criteria
						</h4>
					</div>

					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction" id="vipCriteriaTbl" style="font-size: 12px">
							VIP Level <s:property value="%{plrDetailBean.vipLevel}"/>
							
						<thead>
							<tr>

								<th width="5%" valign="middle" align="left" class="sNo" style="width: 98px; height: 20px;">
									Criteria
								</th>
								<th width="5%" valign="middle" align="left" class="sNo" style="width: 98px; height: 20px;">
									Last Month
								</th>
								<th width="5%" valign="middle" align="left" class="sNo" style="width: 98px; height: 20px;">
									Last Quater
								</th>
								<th width="5%" valign="middle" align="left" class="sNo" style="width: 98px; height: 20px;">
									Last Year
								</th>
								<th width="5%" valign="middle" align="left" class="sNo" style="width: 98px; height: 20px;">
									Since Reg
								</th>
							</tr>
							</thead>
							<tbody>
							<tr>

								<td>
									<label>Login Freq</label>
								</td>
								<td>
									<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipLogin.lastMonthFreq)}"/>
								</td>
								<td>
									<s:property  value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipLogin.lastQuarterFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipLogin.lastYearFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipLogin.sinceRegiFreq)}"/>
								</td>
							</tr>
							<tr>

								<td>
								<label>	Login Count</label>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipLogin.lastMonthCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipLogin.lastQuarterCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipLogin.lastYearCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipLogin.sinceRegiCount)}"/>
								</td>
							</tr>
						<tr>

								<td>
									<label>Deposit Freq</label>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.lastMonthFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.lastQuarterFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.lastYearFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.sinceRegiFreq)}"/>
								</td>
							</tr>
							<tr>

								<td>
									<label>Deposit Count</label>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.lastMonthCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.lastQuarterCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.lastYearCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.sinceRegiCount)}"/>
								</td>
							</tr>
							<tr>

								<td>
									<label>Deposit Value</label>
								</td>
								<td><s:property  value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.lastMonthValue)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.lastQuarterValue)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.lastYearValue)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipDeposit.sinceRegiValue)}"/>
								</td>
							</tr>
							<tr>

								<td>
									<label>Withdrawal Freq</label>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.lastMonthFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.lastQuarterFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.lastYearFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.sinceRegiFreq)}"/>
								</td>
							</tr>
							<tr>

								<td>
								<label>Withdrawal Count</label>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.lastMonthCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.lastQuarterCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.lastYearCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.sinceRegiCount)}"/>
								</td>
							</tr>
							<tr>

								<td>
									<label>Withdrawal Value</label>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.lastMonthValue)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.lastQuarterValue)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.lastYearValue)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWithdrawal.sinceRegiValue)}"/>
								</td>
							</tr>
							<tr>

								<td>
									<label>WagerRummy Freq</label>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.lastMonthFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.lastQuarterFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.lastYearFreq)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.sinceRegiFreq)}"/>
								</td>
							</tr>
							<tr>

								<td>
									<label>WagerRummy Count</label>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.lastMonthCount)}" />
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.lastQuarterCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.lastYearCount)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.sinceRegiCount)}"/>
								</td>
							</tr>
							<tr>

								<td>
									<label>WagerRummy Value</label>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.lastMonthValue)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.lastQuarterValue)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.lastYearValue)}"/>
								</td>
								<td><s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(plrDetailBean.plrVipWagerRummy.sinceRegiValue)}"/>
								</td>
							</tr>
						</tbody>
					</table>

				</div>
			</div>
			</div>
		</form>
		<!-- Vip Criteria end -->
		<!--<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Quick Tabs
					</h4>
				</div>
				<s:a href="#" cssClass="button" id="plrPersonalInfo">Personal Information</s:a>
				
				</div>
	--></body>
</html>

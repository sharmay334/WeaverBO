<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Player Detail Report</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link href="css/facebox_bigsize.css" media="screen" rel="stylesheet"
			type="text/css" />
			<SCRIPT type="text/javascript" src="<%=path%>/js/jquery.paginate.js"></SCRIPT>
		<script src="js/facebox.js" type="text/javascript"></script>
		<script type="text/javascript"
			src="com/stpl/pms/action/bo/reports/js/playerSearchLoadDetail.js"></script>
		
	<SCRIPT type="text/javascript">
	
	</SCRIPT>

	</head>

	<body>
	<form>
	<div id="replaceEditField">
	<s:hidden value="%{plrDetailBean.domainId}" name="domainId1" id="domainId1"></s:hidden>
	<s:hidden id="detailPlayerId" name="playerId" value="%{playerId}"></s:hidden>
							
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
				<td width="25%" align="center">Last Login State :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.registrationState}"/></td>
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
				<td><s:hidden value="%{plrDetailBean.ageVerifed}" id="ageVerifed" name="ageVerifed"></s:hidden></td>
				</tr>
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
				<td align="center" class="word-wrap"><p><s:property value="%{plrDetailBean.addressLine1}"/></p>
				<s:hidden value="%{plrDetailBean.addressLine1}" id="add1" name="add1"></s:hidden></td>
				<td width="25%" align="center">Address Line2</td>
				<td align="center" class="word-wrap"><p><s:property value="%{plrDetailBean.addressLine2}"/></p>
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
				<td width="25%" align="center">Profile Status :</td>
				<td width="25%" align="center"><s:property value="%{plrDetailBean.profileStatus}"/>
				<s:hidden value="%{plrDetailBean.profileStatus}" id="profileStatus" name="profileStatus"></s:hidden></td>				
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
				<tr class="clearFRM"></tr>
				<tr>
					<td width="25%" align="center">Subscribe Promo Mail :</td>
						<td width="25%" align="center"><s:if test='%{plrDetailBean.commPromo=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{plrDetailBean.commPromo=="N"}'>
						<label>No</label>
					</s:elseif>
						<s:hidden value="%{plrDetailBean.commPromo}" id="commPromo1" name="commPromo1"></s:hidden></td>
				</tr>		
				
				</table>
			
			<s:hidden value="%{plrDetailBean.playerId}" name="playerId1" id="playerId1"></s:hidden>
			<div class="box_footer" align="right">
				<ss:button name="eDit" value="Edit" cssClass="button" ajaxActionPlr="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerPersonalDetailsEdit.action"  target="plrPersonalInfo" ajaxParamPlr="plrCity,plrCountry,plrState,plrPostalCode,title,houseNum,gender1,emailVerified,phoneVerified,addressVerified,add1,fName,lName,emailId,ageVerifed,dob,mobileNo,title,playerId1,reason,regStatus1,add2,domainId1,profileStatus,commPromo1" id="plrInfoEdit"></ss:button>
			</div>
</div>	
			
			
</div>
			<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="login">
				
				<h4 style="font-weight: bold;">Login Details</h4>
					<div id="login_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
						<div  id="waitLogin" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
					</div>
					
				</div>
			</div>

			<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="wallet">
				
				<h4 style="font-weight: bold;">Player Wallet Details</h4>
					<div id="wallet_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
					<div  id="waitWallet" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
					</div>
					
				</div>
			</div>

				<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="lastTxn">
				
				<h4 style="font-weight: bold;">Last Transaction
				</h4>
				<div id="lastTxn_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
				<div  id="waitTxn" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
				</div>
				</div>
			</div>	
		<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="deposit">
				
				<h4 style="font-weight: bold;">Deposit Transaction</h4>
					<div id="deposit_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
					<div  id="waitDeposit" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
				</div>
			</div>	
		</div>
		<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="thirdPartyTxn">
				
				<h4 style="font-weight: bold;">Third Party Transaction</h4>
					<div id="thirdPartyTxn_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
					<div  id="waitThirdPartyTxn" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
				</div>
			</div>	
		</div>
		<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="withdraw">
				
				<h4 style="font-weight: bold;">WithDrawal Transaction</h4>
					<div id="withTxn_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
					<div  id="waitWith" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
				</div>
			</div>	
		</div>
		<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="bonus">
				
				<h4 style="font-weight: bold;">Bonus Details</h4>
					<div id="bonus_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
					<div  id="waitBonus" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
				</div>
			</div>	
		</div>
		<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="inbox">
				
				<h4 style="font-weight: bold;">Inbox Details</h4>
					<div id="inbox_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
					<div  id="waitInbox" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
				</div>
			</div>	
			<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="vip">
				
				<h4 style="font-weight: bold;">VIP Criteria</h4>
					<div id="vip_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
					<div  id="waitVip" style="text-align:center">
					<s:hidden id="vipLevelValue" value="%{plrDetailBean.vipLevel}"></s:hidden>
					<img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
					<!-- <div id="waitVip">wait...</div></div> -->
					</div>
					
				</div>
			</div>
			
			<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="campaign">				
				<h4 style="font-weight: bold;">Campaign Details</h4>
					<div id="campaign_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
					<div  id="waitcampaign" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
				</div>
			 </div>		
		 </div>
		
		<div style="margin-top: 15px;" style="display:none">
				<div class="accordion login-acc" id="notInUse">
				</div>
		</div>	
			</div>
			</div>
		</form>
		</body>
</html>
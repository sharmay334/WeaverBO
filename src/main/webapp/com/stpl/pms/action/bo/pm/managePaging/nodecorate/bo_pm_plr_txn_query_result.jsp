<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
		<link href="<%=path%>/css/BoNew.css" media="screen" rel="stylesheet" type="text/css"/>
		<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
			type="text/css" />
		<%-- <link href="<%=path%>/css/paginaton_style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path%>/js/jquery.paginate.js"></script> --%>
		<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
		
		<script src="js/facebox.js" type="text/javascript"></script>
		<link href="<%=path%>/css/facebox_bigsize.css" media="screen" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript"
			src="<%=path%>/com/stpl/pms/action/bo/reports/js/playerSearchLoadDetail.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	$("#passError").hide();
	$("#c_passError").hide();
	function matchPass() {
		$("#c_passError").hide();
		var pass = $("#pass").val();
		var c_pass = $("#cnfrm_pass").val();
		if (pass != c_pass) {
			$("#c_passError").val("password and confirm password does not match")
			$("#c_passError").show();
		}
	}
	function check()
	{
		var pass = $("#pass").val();
		var c_pass = $("#cnfrm_pass").val();
		if(pass.length === 0){
			$("#passError").val("field cannot be empty")
			$("#passError").show();
			return false;
		}
		if(c_pass.length === 0){
			$("#c_passError").val("field cannot be empty")
			$("#c_passError").show();
			return false;
		}
		if(pass.length > 6){
			$("#passError").val("Max length should not be more than 6")
			$("#passError").show();
			return false;
		}
			$("#changePlrInfoFrm").submit();
			
	}
</script>
<style>
table, th, td {
	border: 1px solid black;
}
</style>
</head>
<body>

	<div class="clear2"></div>
	<!-- <h2>Player Personal Information</h2> -->


	<s:form action="bo_pm_plr_change_pass" method="POST"
		name="plrTxnQueryResult" theme="simple"
		target="passwordChangedSuccess">
		<s:token name="strutsToken" id="strutsToken"></s:token>
		
		<div id="plrPersonalInfo" >
	<div class="FormSection tblBorder">
				<div class="greyStrip">
					<h4>
						Personal Information
					</h4>
				</div>
				<s:if test="plrmaster != null">
				<table class="tableNoStyle01" width="95%"  cellpadding="0" cellspacing="0" align="center" style="margin-left: 40px;font-size: 12px;color: #2b2b2b; line-height:45px" >
				<tr></tr>
				<tr>
				<td width="25%" align="center">Player Id :</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.playerId}" /><s:hidden value="%{plrmaster.playerId}" id="requestPlayerId" name="requestPlayerId"></s:hidden></td>
				</tr>
				<tr class="clearFRM"></tr> 
				<tr>
				<td width="25%" align="center">First Name :</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.firstName}" /><s:hidden value="%{plrDetailBean.firstName}" id="fName" name="fName"></s:hidden></td>
				<td width="25%" align="center">Last Name :</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.lastName}"/>
				
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Date of Birth :</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.dateOfBirth}"/>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Email :</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.emailId}"/>
					
				
				<td width="25%" align="center"></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
					<td width="25%" align="center">Email Verified :</td>
					<td width="25%" align="center"><s:if test='%{plrmaster.emailVerified=="Y"}'>
					<label>Yes</Failedlabel>
					</s:if>
					<s:elseif test='%{plrmaster.emailVerified=="N"}'>
					<label>No</label>
					</s:elseif>
					<td width="25%" align="center"></td>
					<td width="25%" align="center"></td>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">House No. </td>
				<td width="25%" align="center"><s:property value="%{plrmaster.stPmPlayerInfo.houseNum}"/> 
				
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Address Line1</td>
				<td align="center" class="word-wrap"><p><s:property value="%{plrmaster.stPmPlayerInfo.addressLine1}"/></p>
				<td width="25%" align="center">Address Line2</td>
				<td align="center" class="word-wrap"><p><s:property value="%{plrmaster.stPmPlayerInfo.addressLine2}"/></p>
				</tr>
				<tr class="clearFRM"></tr>
				
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">City</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.stPmPlayerInfo.city}"/>
				<td width="25%" align="center">Pin Code</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.stPmPlayerInfo.postalCode}"/>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Gender :</td>
				<td width="25%" align="center"><s:if test='%{plrmaster.gender=="M"}'>
					<label>Male</label>
				</s:if>
				<s:elseif test='%{plrmaster.gender=="F"}'>
					<label>Female</label>
				</s:elseif>
				<td width="25%" align="center">Profile Status :</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.plrStatus}"/>
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Mobile No :</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.mobileNo}"/>
					&nbsp;&nbsp;&nbsp;&nbsp; 
					
					
				</td>
				<td width="25%" align="center">Mobile Verified :</td>
				<td width="25%" align="center"><s:if test='%{plrmaster.phoneVerified=="Y"}'>
					<label>Yes</label>
					</s:if>
					<s:elseif test='%{plrmaster.phoneVerified=="N"}'>
					<label>No</label>
					</s:elseif>
				
				</tr>
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Player Status :</td>
				<td width="25%" align="center"><s:property value="%{plrmaster.status}"/>
				
				</tr>
				<tr class="clearFRM"></tr>
				
				<tr class="clearFRM"></tr>
				<tr>
				<td width="25%" align="center">Password :</td>
				<td width="25%" align="center">********
					&nbsp;&nbsp;&nbsp;&nbsp; 
					<a rel="facebox" id="changePlrMobile" class="button openFaceBox" 
					href="com/stpl/pms/action/bo/pm/st_bo_pm_changePlrPassword.action?requestPlayerId=<s:property value="%{plrmaster.playerId}"/>"
					style="float:none;vertical-align: baseline;">Change</a>
				 </td>
				<td width="25%" align="center"></td>
				</tr>
				</table>
				</s:if>
				
</div>	
			
			
</div>

		<%-- <div class="plrTransactionInfo">
			<div class="FormSection">
				<div class="greyStrip">
					<h4>Last Transactions </h4>
				</div>
				<div class="FormMainBox styleBox01">
				 
				
				<s:if test="ticketDetailBeans != null">
			<s:if test="ticketDetailBeans.size()!= 0">
				<table class="tableStyle01" width="100%" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction"style="font-size: 12px">
						<thead>
					<tr>
						<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">Transaction Id</th>
						<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">Game Id</th>
						<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">Game Name</th>
						<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">Game Type</th>
						<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">Transaction Date</th>
						<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">Amount</th>
						<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">Status</th>
						<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">Service Code</th>
						<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;"	>Ref Txn No</th>
									<!-- <th width="5%" valign="middle" align="left" class="sNo"
											style="width: 98px; height: 20px;">Track Ticket</th> -->	
					</tr>
					</thead>
					<tbody>
					<s:iterator value="ticketDetailBeans">
						<tr>
							<td><s:property value="%{transactionId}" /></td>
							<td><s:property value="%{gameId}" /></td>
							<td><s:property value="%{gameName}" /></td>
							<td><s:property value="%{gameType}" /></td>
							<td><s:property value="%{transactionDate}" /></td>
							<td><s:property value="%{amount}" /></td>
							<td><s:property value="%{status}" /></td>
							<td><s:property value="%{serviceCode}" /></td>
							<td><s:property value="%{refTxnNo}" /></td>
							<s:hidden value="%{plrmaster.playerId}" name="playerId" id="playerId"></s:hidden>
							
							<td><a rel="facebox" id="changePlrMobile" class="button openFaceBox" 
							href="com/stpl/pms/action/bo/pm/st_bo_pm_trackTicket.action?transactionId=<s:property value="%{transactionId}"/>"
							style="float:none;vertical-align: baseline;">Ticket</a>
													
								</td>
											<td><ss:button id="resendTicketSms" 
													Class="button resendTicketSmsClass" value="Resend Sms"
													ajaxActionPlr= "/WeaverBO/com/stpl/pms/action/bo/pm/st_bo_pm_reSendTicketSms.action"
													 ajaxParamPlr="playerId"></ss:button>
													
													</td>
						</tr>
					</s:iterator>
					</tbody>
				</table>
			</s:if>

		</s:if>
			
				
				</div>
			</div>
		</div> --%>
		</s:form>
		<form>
		<s:hidden value="%{plrmaster.domainId}" name="domainId1" id="domainId1"></s:hidden>
		<s:hidden value="%{plrmaster.aliasId}" id="aliasId" name="aliasId"></s:hidden>
		<s:hidden id="detailPlayerId" name="playerId1" value="%{plrmaster.playerId}"></s:hidden>
		<div style="margin-top: 15px;">
				<div class="accordion login-acc" id="ticketDetails">
				
				<h4 style="font-weight: bold;">Ticket Details</h4>
					<div id="ticket_details" style="padding:0px;background-color: #F2F2F2; height:auto !important;">
						<div  id="waitTicket" style="text-align:center"><img src="<%=path%>/images/712.GIF"  width="70" height="70" alt="loading..." ></div>
					</div>
					
				</div>
			</div>
	
	
	<div class="clearFRM"></div>
		<div class="clearFRM"></div>
		<div class="clearFRM"></div>
		<div class="clearFRM"></div>
		<div class="clearFRM"></div>
		<div class="clearFRM"></div>
		</form>
	
	<!-- <div id="smsResponse"></div> -->
	
	<div id="passwordChangedSuccess">
	
	</div>

</body>
</html>
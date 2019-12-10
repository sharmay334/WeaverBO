
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

<title>Search Result</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/player_detail.js"></script>
<link rel="stylesheet"
	href="<%=path%>/com/stpl/pms/action/bo/loyalty/css/player_detail.css" />
<script type="text/javascript">
	var _error = '<s:property value="%{errorMessage}"/>';
	var render = '<s:property value="%{render}"/>';
</script>
<script type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/loyalty/js/loyaltybo.js"></script>
</head>

<body>
	<div id="plrSearchRes">
		<s:if
			test="%{playerOverview != null && playerOverview.player != null}">
			<s:if test="playerOverview.player.tier.id>1">	
	
				  <div class="FormSection">
				 	 <div class="greyStrip">
						<h4>
							Player Details
						</h4>
					</div>
					
					
					<table style="width: 90%; margin: 28px;">
						<tr>
							<td   class="key" style="width:18%;">Player Id :</td>
							<td  style="text-align: left;"><s:property
										value="%{playerOverview.player.playerId}" /></td>
										
							<td class="key" style="width:18%;">Points :</td>
							<td class="value"><s:property
										value="%{@com.stpl.loyalty.common.Util@roundHalfUp(playerOverview.player.loyaltyWallet.pointAsTotal,2)}" />
									</td>				
						</tr>
						<tr>
							<td class="key" style="width:18%;">Tier :</td>
							<td class="value" style="text-transform: uppercase;"><s:property
										value="%{playerOverview.player.tier.displayName}" /></td>
										
							<td class="key" style="width:18%;">Cash value :</td>
							<td class="value">&#8377;&nbsp;<s:property
										value="%{@com.stpl.loyalty.common.Util@roundHalfUp(cashReport.totalAvailableCash,2)}" />
									</td>			
						</tr>
						
						<tr>
							<td colspan="2"></td>
							<td class="key" style="width:18%;">Cash Withdrawal limit:</td>
							<td class="value">&#8377;&nbsp;<s:property
										value="%{@com.stpl.loyalty.common.Util@roundHalfUp(playerOverview.player.tier.monthlyLimit - playerOverview.player.loyaltyWallet.currentMonthWithdrwal,2)}" />
									</td>
						</tr>
					
					</table>
				</div>	
					
					<div class="FormSection">
				 	 <div class="greyStrip">
						<h4>
							Exposure
						</h4>
					</div>
					<table style="width: 90%; margin: 28px;">
						 <tr>
							<s:if test="%{!topTier}">
									
										<td class="key" style="width:18%;">Next tier :
										</td>
										<td class="value" style="text-transform: uppercase;"><s:property
												value="%{nextTier.displayName}" />
										</td>
									
								</s:if>	
								<s:else>
									<td class="key" colspan="2" style="font-size: 16px;">Player has acheived highest tier.</td>
								</s:else>							
								<td class="key" style="width:18%;">Current tier earning :</td>
								<td class="value"><s:property value="%{@com.stpl.loyalty.common.Util@roundHalfUp(playerOverview.player.loyaltyWallet.currentTierEarning,2)}" />
											<%-- <s:property value="%{playerOverview.player.loyaltyWallet.currentTierEarning}" /> --%>
									</td>
								<td class="value_button"><button
										onclick="initPointAdd(<s:property value="%{playerOverview.player.id}"/>)">Add</button>
								</td>								
						 </tr>	
						<tr>
								<td class="key" style="width:18%;">Maintenance points :</td>
								<td class="value"><s:property
										value="%{currentTier.maintanancePoints}" />
								</td>
								
								<td class="key" style="width:18%;">Accumulation ending on :</td>
								<td class="value"><s:property
										value="%{@com.stpl.loyalty.common.Util@formatDate(playerOverview.player.accumulationPeriodEnd,'MMM dd,yyyy')}" />
								</td>
								<td class="value_button"><button
									onclick="initGraceAddDialog(<s:property value="%{playerOverview.player.id}"/>,'accumulation',<s:property value="%{!playerOverview.player.defaultAccGraceProvided}"/>,'<s:property value="%{playerOverview.player.tier.displayName}"/>',<s:property value="%{playerOverview.player.tier.maintananceGrace}"/>,'<s:property value="%{@com.stpl.loyalty.common.Util@formatDate(playerOverview.player.accumulationPeriodEnd,'MMM dd,yyyy')}"/>')">Extend</button>
							</td>
					</tr>
						<s:if test="%{!topTier}">
							<tr>
								<td class="key" style="width:18%;">Next tier entry points :</td>
								<td class="value"><s:property
										value="%{nextTier.entryPoints}" />
								</td>
							</tr>
						</s:if>
					</table>
				</div>			
				
				<div class="FormSection">
				 	 <div class="greyStrip">
						<h4>
							 Packet List Wallet
						</h4>
					</div>
							
				<div class="innerBox">
					
					<table style="width: 99%;" cellspacing="0" cellpadding="4"
						border="0" align="center" class="datatable" id="packet_table">
						<thead>
							<tr>
								<th>Packet No.</th>
								<th>Tier</th>
								<th>State</th>
								<th>Total points</th>
								<th>Cash value</th>
								<th>Expiry</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{playerOverview.packets}" status="rowStatus">
								<tr height="48px">
									<td><s:property value="%{#rowStatus.index+1}" />
									</td>
									<td style="text-transform: uppercase;"><s:property value="%{tier.displayName}" />
									</td>
									<td><s:property value="%{state}" />
									</td>
									<td><s:property
											value="%{ @com.stpl.loyalty.common.Util@roundHalfUp(pointAsTotal,2)}" />
									</td>
									<td>&#8377;&nbsp;<s:if test="%{tier.cashConversionRate>0.0}"><s:property
											value="%{@com.stpl.loyalty.common.Util@roundHalfUp(pointAsCash/tier.cashConversionRate,2)}" /></s:if><s:else>0</s:else>
									</td>
									<td><s:property
											value="%{@com.stpl.loyalty.common.Util@formatDate(expiryDate,'MMM dd,yyyy')}" />
									</td>
									<td style="width: 20px;"><s:if test="%{state == 'saved'}">
											<button onclick="initGraceAddDialog(<s:property value="%{id}"/>,'expiry',<s:property value="%{!defaultExpGraceProvided}"/>,'<s:property value="%{tier.displayName}"/>',<s:property value="%{tier.expiryGrace}"/>,'<s:property value="%{@com.stpl.loyalty.common.Util@formatDate(expiryDate,'MMM dd,yyyy')}"/>')">extend</button>
										</s:if></td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>

			</div>
			<div class="clear2"></div>
								
		</s:if>
		<s:else>
				<div class="FormSection">
				<div class="greyStrip">
					<h4>Error Message</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Info: </strong> No record found as player is in Bronze club.
					</div>
				</div>
			</div>
		</s:else>
	</s:if>
	<s:else>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>Error Message</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg ">
						<span class="alert_close"></span><strong>Info: </strong> No such
						player found.
					</div>
				</div>
			</div>
	</s:else>
		<br />
</div>
	<!-- create div for manual point addition -->
	
	<div id="point_addition_dialog" title="Add points" style="display:none">
		<p>
			<span class="ui-icon ui-icon-circle-check"
				style="float:left; margin:0 7px 50px 0;"></span> <input
				id="player_master_id" type="hidden" /> Please enter point(s): <input
				id="point_added" /></br>
			<button id="point_add_button">Add</button>
		</p>
	</div>

	<!-- popup div for grace provider -->
	<div id="grace_dialog" title="Provide grace" style="display:none">
		<p>
			<span class="ui-icon ui-icon-circle-check"
				style="float:left; margin:0 7px 50px 0;"></span> <input id="type"
				type="hidden"> <input id="unique_identifier" type="hidden" />
		<%-- <div id="defaultDiv">
			Since, this is the first extension for this <span id="typeSpan"></span>
			so default will be provided. </br> <span id="typeSpan"></span> tier is <span
				id="tier_name"></span>.Therefore, default grace provided will be <span
				id="default_grace"></span> months.
		</div> --%>
		<div id="NoteDiv">
		Note: Default grace for <span id="tier_name"></span> should be <span id="default_grace"></span> days.
			<%-- Since, this is the first extension for this <span id="typeSpan"></span>
			. So it is advisable to provide default grace. Player current tier is <span
				id="tier_name"></span>.Therefore, default grace provided should be <span
				id="default_grace"></span> days. --%>
		</div>
		</br>
		<div id="varDiv">
			Please mention number of days : <!-- <input id="grace_input" /> --> <input theme="myTheme" requiredLabel="true"
									id="grace_input" pattern="^[0-9,]*$"
									errorMassage="Enter numeric character and comma only"
									cssClass="text-field-small" value=""></input>
		</div>
		</br>
		<button id="grace_button">extend</button>
		</p>
	</div>

	<s:hidden id="currentTierMaintanancePoints"
		name="currentTier.maintanancePoints" />
	<s:hidden id="nextTierEntryPoints" name="nextTier.entryPoints" />
	<s:hidden id="currentEarning"
		name="playerOverview.player.loyaltyWallet.currentTierEarning" />
	<s:hidden id="toptier" name="topTier" />
	<s:hidden id="floortier" name="floorTier" />		
	
</body>
</html>

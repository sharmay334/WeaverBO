<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
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
			src="<%=path%>/com/stpl/pms/action/bo/bonus/js/inner_bonus_search.js"></script>
	</head>

	<body>
	<div id="bonusSearchRes">
		<s:if test="%{bonusSearchList.size()>0}">
			<div class="clear2"></div>
			<div class="FormSection" id="formBonus">
				<div class="greyStrip">
					<h4>Bonus List</h4>
				</div>
				<div class="innerBox">
					<table cellspacing="0" cellpadding="4" border="0" align="center"
						class="payTransaction" id="bonusList">
						<thead>
							<tr>
								<th valign="middle" style="text-align: center;" nowrap="nowrap">
									<s:checkbox id="allCheckBox" fieldValue="false"
										name="allCheckBox" theme="simple"></s:checkbox></th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap" >
								Bonus Priority Order
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap" >
								Bonus Name
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap" >
								Domain Name
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap" >
								Alias Name
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap" >
								Eligibility Criteria
							</th>
							<th valign="middle" style="text-align: center;"nowrap="nowrap">
								Related To
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Activity
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Activity Value
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Activity Value Min
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Activity Value Max
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Availability Type
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								From Date
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								To Date
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Before Days
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								After Days
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Player Event
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Eligibility Group
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Device Type
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Status
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Visibility
							</th>
							<th valign="middle" style="text-align: center;" nowrap="nowrap">
								Edit
							</th>
						</tr>
						</thead>
						<tbody>
							<s:iterator value="%{bonusSearchList}">
								<tr>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:checkbox id="bonusIds_%{bonusId}" name="selectedBonusIdList"
											fieldValue="%{bonusId}" theme="simple"></s:checkbox>
											</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
									<s:if test="%{promoCode=='' || promoCode==NULL }">
										<s:property value="%{bonusOrderBo}" />
										</s:if>
										<s:else>
											NA
										</s:else>
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										
											<s:property value="%{bonusDispCode}" />
										
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										
											<s:property value="%{domainName}" />
										
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										
											<s:property value="%{aliasName}" />
										
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										
											<s:property value="%{gameBonusEligibilityCriteria}" />
										
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{relatedTo}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{activityName}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{activityValue}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{activityValueMin}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{activityValueMax}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{availabilityType}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{availableFromDate}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{availableToDate}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{availableBeforeDays}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{availableAfterDays}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{playerEvent}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{eligibilityGroup}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:if test = "%{bonusDevicEligibilityBean.deviceTypeId ==null || ''.equals(bonusDevicEligibilityBean.deviceTypeId)}">
												
										</s:if>
										<s:else>
											<a title="<s:property value="%{bonusDevicEligibilityBean.deviceTypeId}" />" >Show Details</a>
											<%-- <div class="q-icon">
												<img src="images/que-mark.png" alt="what"
												style="margin-left: -4px; margin-top:-5px;" /> 
	               								<div class="promo-bubble-tip"><p><s:property value="%{bonusDevicEligibilityBean.deviceTypeId}" /></p></div>
	               							</div> --%>
										</s:else>
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:property value="%{status}" />
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:if test ="%{visibility == 'SHOW'}">
											DISPLAYED
										</s:if>
										<s:else>
											HIDDEN
										</s:else>
									</td>
									<td valign="middle" style="text-align: center;" nowrap="nowrap">
										<s:form action="bo_promo_create_bonus_menu" theme="simple">
											<s:hidden name="bonusMaster.bonusId" value="%{bonusId}"theme="simple"></s:hidden>
											<s:hidden name="relatedTo" value="%{relatedTo}"></s:hidden>
											<s:submit value="View/Edit" theme="simple"></s:submit>
										</s:form>
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>

				</div>
				<div class="box_footer">
					<input type="button" id="btnSubmit" value="INACTIVE BONUS" />
					<s:if test="%{activityId==7 || activityId ==8}">
					<input type="button" id="hideButton" value="HIDE BONUS" />
					</s:if>
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
						<span class="alert_close"></span><strong>Info: </strong> No Such
						type of Bonus Available.
					</div>
				</div>
			</div>
		</s:else>
		<br />
	
</div>
</body>
</html>

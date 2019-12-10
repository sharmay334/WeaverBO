<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =(String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Search Bonus</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
		<script type="text/javascript"
			src="<%=path%>/com/stpl/pms/action/bo/bonus/js/bonus_search.js"></script>
	</head>

	<body>
		<div class="clear2"></div>
		<h2>
			Search Bonus
		</h2>
		<s:hidden id="activityData"
			value="%{activityStr}" />
		<s:hidden id="criteriaData"
			value="%{criteriaStr}" />
		<s:form action="bo_promo_bonus_search_result" theme="simple" target="resultDiv">
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Search Criteria <s:checkbox name="specificSearch" id="specificSearch" value="true"></s:checkbox> <s:label for="specificSearch" value="Specific Include Generic"></s:label>
					</h4>
				</div>
				<div class="innerBox">
					<div>
						<s:fielderror theme="simple">
							<s:param name="%{domainId}" value="%{domainId}"></s:param>
						</s:fielderror>
					</div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain Name:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden name="bonusMaster.domainId"
									value="%{domainId}" id="domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<s:select theme="myTheme" cssClass="select1"
									list="%{domainMap}" applyscript="true"
									name="bonusMaster.domainId" id="domainId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}"></s:select>
							</s:else>
						</div>
					</div>
					<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Alias Name:
								</label>
							</div>
							<div class="InputDiv">
							<s:if test="%{(bonusMaster.aliasId!=null && bonusMaster.aliasId>-1)}">
									<s:hidden name="bonusMaster.aliasId" value="%{bonusMaster.aliasId}"
										id="aliasId"></s:hidden>
									<s:property value="%{aliasName}" />
								</s:if>
								<s:else>
								<s:select theme="myTheme" cssClass="select1" list="#{}"
									name="bonusMaster.aliasId"
									id="aliasList" headerKey="-1"
									headerValue="--Please Select--" ></s:select>
								</s:else>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Bonus Name
								</label>
								<!-- <em class="Req">*</em> -->
							</div>
							<div class="InputDiv">
								<ss:textfield theme="myTheme"
									name="bonusMaster.bonusDispCode"
									id="bonusName"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Related to
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div>
								<ss:select theme="myTheme" cssClass="select1" id="relatedTo"
									applyscript="true" list="#{}"></ss:select>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div>
						<s:fielderror theme="simple">
							<s:param name="%{activityId}" value="%{activityId}"></s:param>
						</s:fielderror>
					</div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Activity
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div>
								<s:select theme="myTheme" cssClass="select1" applyscript="true"
									name="bonusMaster.activityId" id="activityId" list="#{}"></s:select>
							</div>
						</div>
					</div>
					<div id="activityValueYesNo">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Activity Value
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio list="#{'YES':'Yes'}" name="bonusMaster.activityValue"
									id="activityValue" value="%{'YES'}"></s:radio>
							</div>
						</div>
					</div>
					<div id="activityValueMinMax">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Activity Value Min
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield theme="myTheme"
									name="bonusMaster.activityValueMin"
									pattern="^\d{0,9}(\.\d{1,2})?$" patternOn="blur"
									errorMassage="Only decimal numbers allowed."
									id="activityValueMin"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Activity Value Max
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield theme="myTheme"
									name="bonusMaster.activityValueMax"
									pattern="^\d{0,9}(\.\d{1,2})?$" patternOn="blur"
									errorMassage="Only decimal numbers allowed."
									id="activityValueMax"></ss:textfield>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> 
								Availability Type
							</label>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio 
								list="#{'NO_EVENT':'No Event','GEN_EVENT':'General Event','PLR_SPECIFIC_EVENT':'Player Specific Event'}"
								name="bonusMaster.availabilityType" id="availabilityType"
								value="%{'NO_EVENT'}"></s:radio>
						</div>
					</div>
					<div id="genEventDateDiv">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Available From Date
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield theme="myTheme"
									name="bonusMaster.availableFromDate" id="availableFromDate"
									cssClass="dateField" readonly="true"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Available To Date
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield theme="myTheme" name="bonusMaster.availableToDate"
									id="availableToDate" cssClass="dateField" readonly="true"></s:textfield>
							</div>
						</div>
					</div>
					<div id="plrSpecificEventDiv">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Player Event
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio
									list="#{'BIRTHDAY':'Birth Day','JOINING_DATE':'Joining Date'}"
									name="bonusMaster.playerEvent" id="playerEvent"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Available Before Days
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield theme="myTheme" pattern="^[0-9]*$"
									patternOn="both" errorMassage="Only numbers allowed."
									name="bonusMaster.availableBeforeDays" id="availableBeforeDays"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Available After Days
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield theme="myTheme" pattern="^[0-9]*$"
									patternOn="both" errorMassage="Only numbers allowed."
									name="bonusMaster.availableAfterDays" id="availableAfterDays"></ss:textfield>
							</div>
						</div>
					</div>
					
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Eligibility Group
							</label>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio name="bonusMaster.eligibilityGroup"
								id="eligibilityGroup"
								list="#{'GENERIC_CRITERIA':'Generic Criteria','SPECIFIC_CRITERIA':'Specific Criteria','EMAIL_LIST':'Emails','PLR_USERNAME_LIST':'Player user name'}"
								value="%{'GENERIC_CRITERIA'}"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div id="genCriteriaDiv">
						<div class="FormMainBox height60">
							<div class="labelDiv">
								<label>
									VIP Level:
								</label>
							</div>
							<div class="InputDiv">
								<ss:select theme="myTheme" cssClass="select1"
									list="%{vipLevelBeanList}" listKey="id" listValue="vipCode"
									data-placeholder="All vip levels" name="vipLevelId"
									id="vipLevelList" multiple="true"></ss:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox height60">
							<div class="labelDiv">
								<label>
									Country:
								</label>
							</div>
							<div class="InputDiv">
								<ss:select theme="myTheme" cssClass="select1"
									list="%{countryBeanList}" listKey="countryId" listValue="name"
									data-placeholder="All countries" name="countryId"
									id="countryList" multiple="true"></ss:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Player Type:
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio id="playerType" name="playerType"
									value="%{'DIRECT_PLAYER'}"
									list="#{'DIRECT_PLAYER':'Direct Player','AFFILATE_PLAYER':'Affilate Player','BOTH':'Both'}"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Status:
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio id="status" name="bonusMaster.status"
									value="%{'BOTH'}"
									list="#{'ACTIVE':'Active','INACTIVE':'Inactive','BOTH':'Both'}"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Visibility:
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio id="visibility" name="bonusMaster.visibility"
									value="%{'BOTH'}"
									list="#{'SHOW':'Displayed','HIDE':'Hidden','BOTH':'Both'}"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
					</div>
					<div id="criteriaDiv" style="display: none;">
						<div style="min-height: 60px; height: auto;">
							<table width="100%" id="criteriaTlb">
								<thead>
									<tr>
										<th>
											Related To
										</th>
										<th>
											Activity
										</th>
										<th colspan="2">
											Value
										</th>
										<th>
											Remove
										</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
						<div class="clearFRM"></div>
					</div>
					<div id="userNameDiv" style="display: none;">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									User Name's
								</label>
							</div>
							<div class="InputDiv">
								<ss:textfield name="userNames" id="userName"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
					</div>
					<div id="emailIdDiv" style="display: none;">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Email Id's
								</label>
							</div>
							<div class="InputDiv">
								<ss:textfield name="emailIds" id="emailIds"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
					</div> 
				</div>
				<div class="box_footer" align="right">
					<ss:button id="addCriteria" value="Add Criteria" ></ss:button>
					<ss:button id="removeCriteria" value="Remove Criteria" ></ss:button>
					<s:submit value="Search"></s:submit>
				</div>
			</div>
		</s:form>
		
		<div id="resultDiv">
		
		</div>
	</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Create Bonus</title>

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
			src="<%=path%>/com/stpl/pms/action/bo/bonus/js/bonus.js"></script>
	</head>

	<body>

		<div class="clear2"></div>
		<h2>
			<s:if test="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)}">Edit</s:if><s:else>Create</s:else> Bonus
		</h2>
		<s:hidden id="activityData"	value="%{activityStr}" />
		<s:hidden id="criteriaData" value="%{criteriaStr}" />
	
		<s:form action="bo_promo_create_bonus_checkDuplicate" theme="simple">
		<s:token name="strutsToken" id="strutsToken"></s:token>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						When to Give
					</h4>
				</div>
				<div class="innerBox">
					<div style="color:red;" >
						<s:fielderror theme="simple" fieldName="bonusDispCode"/>
					</div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Bonus Name
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:set name="isReadOnly"
								value="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)}"></s:set>
							<s:hidden name="bonusMaster.bonusId" value="%{bonusMaster.bonusId}"></s:hidden>
							<s:hidden id="userListByFileFlag" value="%{bonusMaster.eligibilityBean.isUserNameListByFile}"></s:hidden>
							<ss:textfield theme="myTheme" name="bonusMaster.bonusDispCode"
								pattern="^[a-zA-Z0-9 ]*$" patternOn="both" applyscript="true" maxlength="50"
								errorMassage="Only alphanumeric characters allowed."
								id="bonusDispCode" value="%{bonusMaster.bonusDispCode}"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div style="color:red;" >
						<s:fielderror theme="simple" fieldName="availabilityType"/>
					</div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Related to
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div>
								<s:hidden id="tempRelatedTo" value="%{relatedTo}"></s:hidden>
								<ss:select theme="myTheme" cssClass="select1" id="relatedTo" name="relatedTo"
									applyscript="true" list="#{}"></ss:select>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div style="color:red;" >
						<s:fielderror theme="simple" fieldName="activityId"/>
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
								<s:hidden id="tempActivityId" value="%{bonusMaster.activityId}"></s:hidden>
								<s:hidden id="activityName" name="activityName" value=""></s:hidden>
								<s:select theme="myTheme" cssClass="select1" applyscript="true"
									name="bonusMaster.activityId" id="activityId" list="#{}"></s:select>
							</div>
						</div>
					</div>
					
					<div id="gameGroup">
					
						<%-- <div style="color:red;" >
						<s:fielderror theme="simple" fieldName="gameTypeList"/>
					</div> --%>
						<%-- <div class="FormMainBox" style="height:60px;">
							<div class="labelDiv">
								<label>
									Game Group Type
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv inpRadio">
							<s:hidden name="gameGroupType" id="gameGroupType" 
							value="%{bonusMaster.bonusGameEligibilityBean.gameType}"></s:hidden>
							<s:select theme="myTheme" cssClass="select1" 
							list="#{'RUMMY':'Rummy','POKER':'Poker'}"
									data-placeholder="All Game List" name="gameType"
																	
									id="gameTypeList" multiple="true" ></s:select>
							</div>
						</div>
					
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Game Bonus Criteria
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'WAGER':'On Wager','RAKE':'On Rake'}"
								name="bonusMaster.gameBonusCriteria" id="gameBonusCriteria"
								value="%{(bonusMaster.gameBonusCriteria!=null && bonusMaster.gameBonusCriteria!='')?bonusMaster.gameBonusCriteria:'WAGER'}"></s:radio>
						</div>
					</div> --%>
					</div>
					<div id="deviceValueYesNo">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Client Device
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio list="#{'YES':'Yes'}" name="clientDeviceType"
									id="clientDeviceType" value="%{'YES'}" ></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						
						<div class="FormMainBox" style="height:60px;">
							<div class="labelDiv">
								<label>
									Device Type
								</label>
							</div>
							<div class="InputDiv inpRadio">
							<s:hidden name="deviceType" id="deviceType" 
							value="%{bonusMaster.bonusDevicEligibilityBean.deviceTypeId}"></s:hidden>
							<s:select theme="myTheme" cssClass="select1" 
							list="#{'PC_BROWSER':'PC Browser','PC_DOWNLOADABLE_CLIENT':'PC Dowloadable Client','ANDROID_BROWSER':'Android Browser','ANDROID_APP_FREE':'Android App Free','ANDROID_APP_CASH':'Android App Cash','IOS_BROWSER':'IOS Browser','IOS_APP_CASH':'IOS App Cash','WINDOWS_BROWSER':'Windows Browser','WINDOWS_APP':'Windows App'}"
									data-placeholder="All Device List" name="deviceTypeId"
																	
									id="deviceTypeList" multiple="true"></s:select>
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
									id="activityValue" value="%{bonusMaster.activityValue}" ></s:radio>
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
									id="activityValueMin" maxlength="9" value="%{bonusMaster.activityValueMin}"></ss:textfield>
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
									id="activityValueMax" maxlength="9" value="%{bonusMaster.activityValueMax}"></ss:textfield>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> 
								Availability Type
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio 
								list="#{'NO_EVENT':'No Event','GEN_EVENT':'General Event','PLR_SPECIFIC_EVENT':'Player Specific Event'}"
								name="bonusMaster.availabilityType" id="availabilityType"
								value="%{(bonusMaster.availabilityType!=null && bonusMaster.availabilityType!='')?bonusMaster.availabilityType:'NO_EVENT'}"></s:radio>
						</div>
					</div>
					<div id="genEventDateDiv">
						<div class="clearFRM"></div>
						<div style="color:red;" >
							<s:fielderror theme="simple" fieldName="availableFromDate"/>
						</div>

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
									cssClass="dateField" readonly="true"
									value="%{bonusMaster.availableFromDate}"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div style="color:red;" >
							<s:fielderror theme="simple" fieldName="availableToDate"/>
						</div>

						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Available To Date
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield theme="myTheme" name="bonusMaster.availableToDate"
									id="availableToDate" cssClass="dateField" readonly="true"
									value="%{bonusMaster.availableToDate}"></s:textfield>
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
								<em class="Req">*</em>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio
									list="#{'BIRTHDAY':'Birth Day','JOINING_DATE':'Joining Date'}"
									name="bonusMaster.playerEvent" id="playerEvent"
									value="%{bonusMaster.playerEvent}"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div style="color:red;" >
							<s:fielderror theme="simple" fieldName="availableBeforeDays"/>
						</div>

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
									name="bonusMaster.availableBeforeDays" id="availableBeforeDays"
									value="%{bonusMaster.availableBeforeDays}"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div style="color:red;" >
							<s:fielderror theme="simple" fieldName="availableAfterDays"/>
						</div>

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
									name="bonusMaster.availableAfterDays" id="availableAfterDays"
									value="%{bonusMaster.availableAfterDays}"></ss:textfield>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
				</div>
			</div>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Whom to Give
					</h4>
				</div>
				<div class="innerBox">
					<div style="color:red;" >
						<s:fielderror theme="simple" fieldName="domainId"/>
					</div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain Name:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
						
								<s:if test="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)}">
									<s:hidden name="bonusMaster.domainId" value="%{bonusMaster.domainId}"
										id="domainId"></s:hidden>
									<s:hidden name="bonusMaster.gameBonusCriteria" id="bonusMaster.gameBonusCriteria" 
										value="%{bonusMaster.gameBonusCriteria}"></s:hidden>
									<s:property value="%{domainName}" />
								</s:if>
								<s:else>
									<s:select theme="myTheme" cssClass="select1"
										list="%{domainMap}"
										applyscript="true" name="bonusMaster.domainId" id="domainId"
										headerKey="-1" headerValue="--Please Select--" listKey="%{key}"
										listValue="%{value}" value="%{bonusMaster.domainId}"></s:select>
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
							<s:if test="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)}">
									<s:hidden name="bonusMaster.aliasId" value="%{bonusMaster.aliasId}"
										id="aliasId"></s:hidden>
										<s:if test="%{(bonusMaster.aliasId>0)}">
											<s:property value="%{aliasName}" />
										</s:if>
										<s:else>
											All Alias
										</s:else>
								</s:if>
								<s:else>
								<s:select theme="myTheme" cssClass="select1" list="#{}"
									name="bonusMaster.aliasId"
									id="aliasList" headerKey="-1"
									headerValue="--Please Select--"></s:select>
								</s:else>
							</div>
						</div>
						<div id="campaignDiv">
							<div class="clearFRM"></div>
							
							<div class="FormMainBox" style="height:60px;">
								<div class="labelDiv">
									<label>
										Campaign
									</label>
								</div>
								<div class="InputDiv inpRadio">
								<s:hidden name="campaign" id="prevCampVal" 
							value="%{bonusMaster.eligibilityBean.campIdList}"></s:hidden>
								<s:select theme="myTheme" cssClass="select1" 
								list="#{}"
										data-placeholder="-----------Select Campaign---------------" name="bonusMaster.eligibilityBean.campIdList"
																		
										id="campIdList" multiple="true"></s:select>
								</div>
							</div>
						</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Eligibility Group
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio name="bonusMaster.eligibilityGroup"
								id="eligibilityGroup"
								list="#{'GENERIC_CRITERIA':'Generic Criteria','SPECIFIC_CRITERIA':'Specific Criteria','EMAIL_LIST':'Emails','PLR_USERNAME_LIST':'Player user name'}"
								value="%{(bonusMaster.eligibilityGroup!=null && bonusMaster.eligibilityGroup!='')?bonusMaster.eligibilityGroup:'GENERIC_CRITERIA'}"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div id="genCriteriaDiv">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Profile Status:
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio id="playerStatus" name="playerStatus"
									value="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)?(bonusMaster.eligibilityBean.playerStatus!=null && bonusMaster.eligibilityBean.playerStatus!='')?bonusMaster.eligibilityBean.playerStatus:'BOTH':'BOTH'}"
									list="#{'FULL':'Full','MINI':'Mini','BOTH':'Both'}"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Email Verified:
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio id="emailVerification" name="emailVerification"
									value="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)?(bonusMaster.eligibilityBean.emailVerification!=null && bonusMaster.eligibilityBean.emailVerification!='')?bonusMaster.eligibilityBean.emailVerification:'NOT_APPLICABLE':'NOT_APPLICABLE'}"
									list="#{'YES':'Yes','NO':'No','NOT_APPLICABLE':'Not Applicable'}"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Mobile Verified:
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio id="mobileVerification" name="mobileVerification"
									value="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)?(bonusMaster.eligibilityBean.mobileVerification!=null && bonusMaster.eligibilityBean.mobileVerification!='')?bonusMaster.eligibilityBean.mobileVerification:'NOT_APPLICABLE':'NOT_APPLICABLE'}"
									list="#{'YES':'Yes','NO':'No','NOT_APPLICABLE':'Not Applicable'}"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Is Depositor:
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio id="isDepositor" name="isDepositor"
									value="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)?(bonusMaster.eligibilityBean.isDepositor!=null && bonusMaster.eligibilityBean.isDepositor!='')?bonusMaster.eligibilityBean.isDepositor:'NOT_APPLICABLE':'NOT_APPLICABLE'}"
									list="#{'YES':'Yes','NO':'No','NOT_APPLICABLE':'Not Applicable'}"></s:radio>
							</div>
						</div>
						<div class="clearFRM"></div><s:hidden name="vipLevel" id="vipLevel" 
							value="%{bonusMaster.eligibilityBean.vipLevelId}"></s:hidden>
						<div class="FormMainBox" style="height:60px;">
							<div class="labelDiv">
								<label>
									VIP Level:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1" list="#{}"
									data-placeholder="All vip levels" name="vipLevelId"
									id="vipLevelList" multiple="true"></s:select>
							</div>
						</div>
						<div class="clearFRM"></div><s:hidden name="countryLevel" id="countryLevel" 
							value="%{bonusMaster.eligibilityBean.countryId}"></s:hidden>
						<div class="FormMainBox" style="height:60px;">
							<div class="labelDiv">
								<label>
									Country:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1" list="#{}"
									data-placeholder="All countries" name="countryId"
									id="countryList" multiple="true"></s:select>
							</div>
						</div>
						<!-- code added for multiple states according to selected country -->
						<div class="clearFRM"></div><s:hidden name="stateLevel" id="stateLevel" 
							value="%{bonusMaster.eligibilityBean.stateId}"></s:hidden>
						<div id="stateDiv">
						
						</div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Player Type:
								</label>
							</div>
							<div class="InputDiv inpRadio">
								<s:radio id="playerType" name="playerType"
									value="%{'BOTH'}"
									list="#{'DIRECT_PLAYER':'Direct Player','AFFILATE_PLAYER':'Affilate Player','BOTH':'Both'}"></s:radio>
							</div>
						</div>
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
								<s:if test="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0 && bonusMaster.eligibilityBean.isUserNameListByFile=='true')}">
									<a id="userFileLink" href="#" download="UserList.csv">Download File </a>
									<span><button id="editUserName" style="margin: 0 !important;" class="editAction">Edit</button></span>
									<%-- <span><a id="editUserName" href="#">Edit User Name List</a></span> --%>																		
								</s:if>
								
								<div id="divUserlist">
									<ss:textfield name="userNames" cssStyle="width:58%; float: left;" id="userName" value="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)?bonusMaster.eligibilityBean.userNameList:''}" maxLength="500" placeholder="Accept upto 500 characters"></ss:textfield>
									<div id="userFile">&nbsp;&nbsp;	<b> or</b>    <input type="file" id="fileInput" /> </div>	
									<span id="filenote" style="padding: 0 0 0 28px;">  .csv file only</span>
								</div>														
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
								<ss:textfield name="emailIds" id="emailIds" value="%{(bonusMaster.bonusId!=null && bonusMaster.bonusId>0)?bonusMaster.eligibilityBean.emailList:''}"></ss:textfield>
							</div>
						</div>
						<div class="clearFRM"></div>
					</div>
				</div>
				<div class="box_footer" align="right">
				<ss:button id="addCriteria" value="Add Criteria"></ss:button>
			</div>
			</div>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						How Much
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Bonus As
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="{'BONUS','CASH'}" name="bonusMaster.bonusValueAs"
								id="bonusValueAs"
								value="%{(bonusMaster.bonusValueAs!=null && bonusMaster.bonusValueAs!='')?bonusMaster.bonusValueAs:'BONUS'}"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div style="color:red;" >
						<s:fielderror theme="simple" fieldName="bonusValueType"/>
					</div>

					<div class="FormMainBox"><s:hidden name="bonusValueType" id="bonusValue" 
							value="%{(bonusMaster.bonusValueType!=null && bonusMaster.bonusValueType!='')?bonusMaster.bonusValueType:'PERCENT'}"></s:hidden>
						<div class="labelDiv">
							<label>
								Bonus Value Type
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'PERCENT':'Percent','FIXED':'Fixed'}"
								name="bonusMaster.bonusValueType" id="bonusValueType"
								value="%{(bonusMaster.bonusValueType!=null && bonusMaster.bonusValueType!='')?bonusMaster.bonusValueType:'PERCENT'}"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div  style="color:red;" >
						<s:fielderror theme="simple" fieldName="bonusValue"/>
					</div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Bonus Value
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield theme="myTheme" name="bonusMaster.bonusValue"
								applyscript="true" pattern="^[1-9][\.\d]*(,\d+)?$" patternOn="both" min="1"
								maxlength="9" errorMassage="Only decimal numbers allowed." id="bonusValue"
								value="%{(bonusMaster.bonusValue<=0)?'':bonusMaster.bonusValue}"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox" id="maxBonusValueDiv">
						<div class="labelDiv">
							<label>
								Max Bonus Value
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield theme="myTheme" name="bonusMaster.maxBonusValue"
								applyscript="true" pattern="^[1-9][\.\d]*(,\d+)?$" patternOn="both" min="1"
								maxlength="9" errorMassage="Only decimal numbers allowed." id="maxBonusValue"
								value="%{(bonusMaster.maxBonusValue<=0.0)?'':bonusMaster.maxBonusValue}"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
				</div>
			</div>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Player Restrictions
					</h4>
				</div>
				<div class="innerBox">
				<s:hidden name="bonusCrit" id="bonusCrit" 
							value="%{bonusMaster.gameBonusCriteria}"></s:hidden>
							<s:hidden name="gameGroupType" id="gameGroupType" 
							value="%{bonusMaster.bonusGameEligibilityBean.gameType}"></s:hidden>
				<div id="gameingCriteria"></div>
				
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Max Usage Count
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv"><s:hidden name="maxCountValue" id="maxCountValue" 
							value="%{bonusMaster.maxUsageCount}"></s:hidden>
							<ss:textfield theme="myTheme" name="bonusMaster.maxUsageCount"
								pattern="^([0-9]*|-1?)$" patternOn="both" applyscript="true"
								errorMassage="Only numbers or -1 allowed" id="maxUsageCount"
								maxlength="9" value="%{bonusMaster.maxUsageCount}" cssStyle="width:75%;float:left;"></ss:textfield>
								<div style="float: left; margin: 5px 0px 0px 10px;"><span style="float: right;">Exclude</span><input type="checkbox" name="maxCount" id="maxCount"></div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div style="color:red;" >
						<s:fielderror theme="simple" fieldName="playerUsageCount"/>
					</div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Player Usage Count
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv"><s:hidden name="playerCountValue" id="playerCountValue" 
							value="%{bonusMaster.playerUsageCount}"></s:hidden>
							<ss:textfield theme="myTheme" name="bonusMaster.playerUsageCount"
								pattern="^([0-9]*|-1?)$" patternOn="both"  applyscript="true"
								errorMassage="Only numbers or -1 allowed" id="playerUsageCount"
								maxlength="9" value="%{bonusMaster.playerUsageCount}" cssStyle="width:75%;float:left;"></ss:textfield>
								<div style="float: left; margin: 5px 0px 0px 10px;"><span style="float: right;">Exclude</span><input type="checkbox" name="playerCount" id="playerCount"></div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Optout Option
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'YES':'Yes','NO':'No'}"
								name="bonusMaster.optoutOption" id="optoutOption"
								value="%{(bonusMaster.optoutOption!=null && bonusMaster.optoutOption!='')?bonusMaster.optoutOption:'NO'}"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div style="color:red;" >
						<s:fielderror theme="simple" fieldName="expiryAfterAcceptType"/>
					</div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Expiry After Accept Type
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'DATE':'Date','DAYS':'Days','NONE':'None'}"
								name="bonusMaster.expiryAfterAcceptType"
								id="expiryAfterAcceptType"
								value="%{(bonusMaster.expiryAfterAcceptType!=null && bonusMaster.expiryAfterAcceptType!='')?bonusMaster.expiryAfterAcceptType:'NONE'}"></s:radio>
						</div>
					</div>
					<div id="expiryAfterDateDiv">
						<div class="clearFRM"></div>
						<div style="color:red;" >
							<s:fielderror theme="simple" fieldName="expiryAfterAcceptDate"/>
						</div>

						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Expiry After Accept Date
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield theme="myTheme"
									name="bonusMaster.expiryAfterAcceptDate"
									id="expiryAfterAcceptDate" cssClass="dateField" readonly="true"
									value="%{bonusMaster.expiryAfterAcceptDate}"></s:textfield>
							</div>
						</div>
					</div>
					<div id="expiryAfterDaysDiv">
						<div class="clearFRM"></div>
						<div style="color:red;" >
							<s:fielderror theme="simple" fieldName="expiryAfterAcceptDays"/>
						</div>

						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Expiry After Accept Days
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield theme="myTheme" pattern="^[0-9]*$"
									patternOn="both" errorMassage="Only numbers allowed."
									name="bonusMaster.expiryAfterAcceptDays"
									id="expiryAfterAcceptDays"
									value="%{bonusMaster.expiryAfterAcceptDays}"></ss:textfield>
							</div>
						</div>
					</div>
					
					
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<div id="requirementType">
							<label>
								Wager Requirment Type
							</label>
							<em class="Req">*</em></div>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'SELF':'Self','THIRD_PARTY':'Third Party'}"
								name="bonusMaster.wrType" id="wrType"
								value="%{(bonusMaster.wrType!=null&& bonusMaster.wrType!='')?bonusMaster.wrType:'SELF'}"></s:radio>
						</div>
					</div>
					<div id ="wageringDiv">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
						<div id="requirementTargetType">
							<label>
								Wager Requirment Target Type
							</label>
							<em class="Req">*</em></div>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'PERCENT':'Percent','FIXED':'Fixed'}"
								name="bonusMaster.wrTargetType" id="wrTargetType"
								value="%{(bonusMaster.wrTargetType!=null && bonusMaster.wrTargetType!='')?bonusMaster.wrTargetType:'PERCENT'}"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
						<div id="requirementTargetValue">
							<label>
								Wager Requirment Target Value
							</label>
							<em class="Req">*</em></div>
						</div>
						<div class="InputDiv">
							<ss:textfield theme="myTheme" name="bonusMaster.wrTargetValue"
								pattern="^\d{0,9}(\.\d{1,2})?$" patternOn="both" applyscript="true"
								errorMassage="Only decimal numbers allowed." id="wrTargetValue"
								maxlength="9" value="%{bonusMaster.wrTargetValue}"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Redemption Cycle
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield theme="myTheme" name="bonusMaster.redemptionCycle"
								pattern="^[0-9]*$" patternOn="both" applyscript="true"
								errorMassage="Only numbers allowed." id="redemptionCycle"
								maxlength="9" value="%{bonusMaster.redemptionCycle}"></ss:textfield>
						</div>
					</div>
					</div>
					<div class="FormMainBox">
										<div class="clearFRM"></div>
						<div class="labelDiv">
							<label>
								Offer only if he has no bonus
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'YES':'Yes','NO':'No'}"
								name="bonusMaster.singleBonus" id="singleBonus"
								value="%{(bonusMaster.singleBonus!=null && bonusMaster.singleBonus!='')?bonusMaster.singleBonus:'NO'}"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Delivery Mode
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
						<s:radio
								list="#{'AUTO':'Auto','COUPON_UNIQUE':'Unique Coupon','COUPON_SAME':'Same Coupon'}"
								name="bonusMaster.deliveryMode" id="deliveryMode"
								value="%{(bonusMaster.deliveryMode!=null && bonusMaster.deliveryMode!='')?bonusMaster.deliveryMode:'AUTO'}" ></s:radio>
								
						</div>
					</div>
					<div id="promoCodeDiv">
						<div class="clearFRM"></div>
						<div style="color:red;" >
							<s:fielderror theme="simple" fieldName="promoCode"/>
						</div>

						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Promo Code
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:textfield theme="myTheme" name="bonusMaster.promoCode"
									id="promoCode" value="%{bonusMaster.promoCode}" maxlength="50"></ss:textfield>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Is Redeemable
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'YES':'Yes','NO':'No'}"
								name="bonusMaster.isRedeemable" id="isRedeemable"
								value="%{(bonusMaster.isRedeemable!=null && bonusMaster.isRedeemable!='')?bonusMaster.isRedeemable:'NO'}"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Bonus Status
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'ACTIVE':'Active','INACTIVE':'In Active'}"
								name="bonusMaster.status" id="status"
								value="%{(bonusMaster.status!=null && bonusMaster.status!='')?bonusMaster.status:'ACTIVE'}"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Bonus Visibility
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv inpRadio">
							<s:radio list="#{'SHOW':'Show','HIDE':'Hide'}"
								name="bonusMaster.visibility" id="visibility"
								value="%{(bonusMaster.visibility!=null && bonusMaster.visibility!='')?bonusMaster.visibility:'SHOW'}"></s:radio>
						</div>
					</div>
				</div><input type="hidden" name="bonusMaster.eligibilityBean"/>
				<div class="box_footer" align="right">
					<s:submit value="Submit"></s:submit>
				</div>
			</div>
		</s:form>
	</body>
</html>

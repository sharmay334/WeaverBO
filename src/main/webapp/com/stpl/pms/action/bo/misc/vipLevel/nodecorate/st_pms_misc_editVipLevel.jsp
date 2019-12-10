<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>VIP Level Setup</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
		
	</head>
	<body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Edit VIP Level </h4>
			</div>
					
			<s:form action="st_pms_misc_editVipLevel_save" id="vipSaveForm" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Level:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield name="vipMaster.vipLevel" value="%{vipMaster.vipLevel}" id="vipLevel" readonly="true" theme="simple" applyscript="true"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Code:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield name="vipMaster.vipCode" value="%{vipMaster.vipCode}" id="vipCode"  theme="simple" applyscript="true"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Display Code:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield name="vipMaster.vipDispCode" value="%{vipMaster.vipDispCode}" id="vipDispCode"  theme="simple" applyscript="true"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Group:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="simple" cssClass="select1" value="%{vipMaster.vipGroup}"
								list="#{'BRONZE':'Bronze','SILVER':'Silver','GOLD':'Gold','PLATINUM':'Platinum','DIAMOND':'Diamond'}"
								name="vipMaster.vipGroup" id="vipGroup" headerKey="-1"
								headerValue="--Please Select--"  applyscript="true"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Color:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield  name="vipMaster.vipColor" cssStyle="width:620px;" readonly="true" value="%{vipMaster.vipColor}" id="vipColor" theme="simple" applyscript="true"></ss:textfield>
						</div>
					</div>
					<s:if test="%{vipMaster.levelType=='AUTO'}">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Current VIP Rule:
								</label>
							</div>
							<div class="InputDiv" id="currentVipRuleDiv" style="height: auto">
								<s:property value="%{vipMaster.vipRule}"/>
							</div>
								
							<s:hidden  id="currentVipRuleHidden" value="%{vipMaster.vipRule}"></s:hidden>					
							<s:hidden name="vipMaster.vipRule" id="vipRuleHidden" value="%{vipMaster.vipRule}"></s:hidden>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									New VIP Rule:
								</label>
							</div>
							<div class="InputDiv" id="vipRuleDiv" style="height: auto">
								
							</div>
							<div class="InputDiv" id="vipRuleEditDiv" style="text-align: right;height: auto">
								<input type="button" id="editVipRuleBtn" value="Edit Rule"> 
								<input type="button" id="resetVipRuleBtn" value="Reset Rule" style="display: none"> 
							</div>
							
						</div>
						<table id="vipCriteriaTbl" class="payTransaction" width="830" cellspacing="0" cellpadding="4" border="0" align="center">
							<thead>
								<tr>
									<th width="10%" valign="middle" align="left"> Code </th>
									<th width="50%" valign="middle" align="left"> Criteria </th>
									<th width="15%" valign="middle" align="left"> Min. Value </th>
									<th width="15%" valign="middle" align="left"> Max Value </th>
									<th width="10%" valign="middle" align="left"></th>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="%{ruleCriList}" status="vipCrit">
									<tr>
										<td id="criCode_<s:property value="%{#vipCrit.index+1}" />"> <s:property value="%{criteriaCode}" /> </td>
										<td>
											<ss:select theme="simple" cssClass="select1" value="%{criteriaCode}" applyscript="true"
												list="%{activeVipCriteria}" listKey="value.criteriaCode" listValue="value.criteriaName"
												name="criteriaCode" id="criteriaCode_%{#vipCrit.index+1}" headerKey="-1"
												headerValue="--Please Select--"  ></ss:select>
										</td>
										<td>
											<ss:textfield name="minValue" value="%{minValue}" id="minValue_%{#vipCrit.index+1}"  theme="simple" 
													cssStyle="height: 20px;" maxlength="5" applyscript="true" 
													pattern="^[0-9]*$" errorMassage="Only numeric value allowed" ></ss:textfield>
										</td>
										<td>
											<ss:textfield name="maxValue" value="%{maxValue}" id="maxValue_%{#vipCrit.index+1}"  
												theme="simple" cssStyle="height: 20px;" maxlength="10" applyscript="true"
												pattern="^[0-9]*$" errorMassage="Only numeric value allowed"></ss:textfield>
										</td>
										<td>
											<input id="removeCriteriaBtn_<s:property value="%{#vipCrit.index+1}" />" type="button" value="Remove">
										</td>
									</tr>
								</s:iterator>
							</tbody>
							<tfoot>
								<tr>
									<th style="border-right:none;" colspan="3"></th>
									<th valign="middle" style="text-align:right;border-right:none;border-left:none;">
										<input id="createRuleBtn" type="button" value="Create Rule" style="display: none;">
									</th>
									<th valign="middle" style="border-left:none;text-align:left;">
										<input id="addCriteriaBtn" type="button" value="Add Criteria">
									</th>
								</tr>
							</tfoot>
							</table>
						
					</s:if>
				</div>
				<div class="box_footer" align="right">
					<s:hidden name="vipMaster.domainId" id="updateDomainId" value="%{vipMaster.domainId}"></s:hidden>
					<s:hidden name="vipMaster.levelType" value="%{vipMaster.levelType}" id="editLevelType"/>
					<ss:submit theme="simple" id="vipSubmitBtn" value="Submit" ></ss:submit>
				</div>
			</s:form>
		</div>
	</body>
</html>

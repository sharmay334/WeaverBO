<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
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
				<h4>Add VIP Level </h4>
			</div>
					
			<s:form action="st_pms_misc_vipLevelSetUp_Save" id="vipSaveForm" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Level:
							</label>
						</div>
						<div class="InputDiv">
							<s:set name="minVipLevel" value="%{vipMaster.levelType=='AUTO'? 1001 : 5001}"/>
							<s:set name="maxVipLevel" value="%{vipMaster.levelType=='AUTO'? 2000 : 6000}"/>
							<ss:textfield name="vipMaster.vipLevel"  id="vipLevel" value="" maxlength="4" max="%{#maxVipLevel}" min="%{#minVipLevel}" pattern="^[0-9]*$" 
									errorMassage="Only numeric value allowed" theme="simple"  applyscript="true" ></ss:textfield>
						</div>
						<div class="InputDiv" id="vipLevelAvailMsg"></div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Code:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield name="vipMaster.vipCode"  id="vipCode" value=""  theme="simple" applyscript="true"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Display Code:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield name="vipMaster.vipDispCode"  id="vipDispCode" value=""  theme="simple" applyscript="true"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Group:
							</label>
						</div>
						<div class="InputDiv">
							<ss:select theme="simple" cssClass="select1" 
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
							<ss:textfield  name="vipMaster.vipColor" cssStyle="width:620px;" readonly="true"  id="vipColor" theme="simple" applyscript="true"></ss:textfield>
						</div>
					</div>
					<s:if test="%{vipMaster.levelType=='MANUAL'}">
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Remarks:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield name="vipMaster.remarks"  id="remarks" value=""  theme="simple" applyscript="true"></ss:textfield>
						</div>
					</div>
					</s:if>
					<s:if test="%{vipMaster.levelType=='AUTO'}">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									VIP Rule:
								</label>
							</div>
							<div class="InputDiv" id="vipRuleDiv" style="height: auto">
								<s:property value="%{vipMaster.vipRule}"/>
							</div>
							<s:hidden name="vipMaster.vipRule" id="vipRuleHidden" value="%{vipMaster.vipRule}"></s:hidden>
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
								<tr>
									<td id="criCode_1"> <s:property value="%{criteriaCode}" /> </td>
									<td>
										<ss:select theme="simple" cssClass="select1" 
											list="%{activeVipCriteria}" listKey="value.criteriaCode" listValue="value.criteriaName"
											name="criteriaCode" id="criteriaCode_1" headerKey="-1"
											headerValue="--Please Select--"  applyscript="true"></ss:select>
									</td>
									<td>
										<ss:textfield name="minValue"  id="minValue_1"  theme="simple" 
												cssStyle="height: 20px;" maxlength="5" applyscript="true" 
												pattern="^[0-9]*$" errorMassage="Only numeric value allowed" ></ss:textfield>
									</td>
									<td>
										<ss:textfield name="maxValue" id="maxValue_1"  
											theme="simple" cssStyle="height: 20px;" maxlength="10" applyscript="true"
											pattern="^[0-9]*$" errorMassage="Only numeric value allowed"></ss:textfield>
									</td>
									<td>
										<input id="removeCriteriaBtn_1" type="button" value="Remove">
									</td>
								</tr>
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
					<s:hidden name="vipMaster.domainId" id="addDomainId" value="%{vipMaster.domainId}"></s:hidden>
					<s:hidden name="vipMaster.levelType" value="%{vipMaster.levelType}" id="addLevelType"/>
					<ss:submit theme="simple" id="vipSubmitBtn" value="Submit" ></ss:submit>
				</div>
			</s:form>
		</div>
	</body>
</html>

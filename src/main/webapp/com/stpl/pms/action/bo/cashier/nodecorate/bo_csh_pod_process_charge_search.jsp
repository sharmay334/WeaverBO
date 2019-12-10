<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>
		<link
			href="<%=path%>/com/stpl/pms/action/bo/cashier/css/provider_charge.css"
			rel="stylesheet" type="text/css" />
		<SCRIPT type="text/javascript"
			src="<%=path%>/com/stpl/pms/action/bo/cashier/js/provider_charge.js"></SCRIPT>
	</head>
	<body>
		<h4>
			Processing Charge
		</h4>
		<div id="processingChargeDiv">
			<h1 class="ui-widget-header">
				Payment Processing Charge
			</h1>
			<button id="add_tab">
				Add More Options
			</button>
			<div id="tabs">
				<ul>
					<s:iterator value="%{podmProcessingChargeMap}">
						<li>
							<a href="javascript:void(0);" onclick="javascript: openTab('tabs-<s:property value="%{key}"/>',this); "><s:property
									value="%{'Process Charge-'+value.processingChargeId}" /> </a>
							<span class="ui-icon ui-icon-close" role="presentation">Remove
								Tab</span>
						</li>
					</s:iterator>
				</ul>
				<s:iterator value="%{podmProcessingChargeMap}" >
					<div id="tabs-<s:property value="%{key}"/>">
						<table id="table-<s:property value="%{key}"/>">
							<s:hidden id="processingChargeId"
								value="%{value.processingChargeId}"></s:hidden>
							<tr>
								<td>
									<s:label value="Charge Type 1" theme="simple"></s:label>
								</td>
								<td>
								<s:select id="charge1Type" list="{'FIXED','PERCENT','-'}" headerKey="-1"
								headerValue="--Please Select--" value="%{value.charge1Type}" theme="simple"></s:select>
								</td>
							</tr>
							<tr>
								<td>
								<s:label value="Charge Value 1" theme="simple"></s:label>
								</td>
								<td>
								<s:textfield id="charge1Value" value="%{value.charge1Value}" theme="simple"></s:textfield>
								</td>
							</tr>
							<tr>
								<td>
								<s:label value="Charge Type 2" theme="simple"></s:label>
								</td>
								<td>
								<s:select id="charge2Type" list="{'FIXED','PERCENT','-'}" headerKey="-1"
								headerValue="--Please Select--" value="%{value.charge2Type}" theme="simple"></s:select>
								</td>
							</tr>
							<tr>
								<td>
								<s:label value="Charge Value 2" theme="simple"></s:label>
								</td>
								<td>
								<s:textfield id="charge2Value" value="%{value.charge2Value}" theme="simple"></s:textfield>
								</td>
							</tr>
							<tr>
								<td>
								<s:label value="Relation" theme="simple"></s:label>
								</td>
								<td>
								<s:select id="relation" list="{'MAX','SUM','-'}" headerKey="-1" headerValue="--Please Select--"
								value="%{value.relation}" theme="simple"></s:select>
								</td>
							</tr>
							<tr>
								<td>
									<s:label value="Max Value" theme="simple"></s:label>
								</td>
								<td>
								<s:textfield id="maxValue" value="%{value.maxValue}" theme="simple"></s:textfield>
								</td>
							</tr>
						</table>
						<div id="podmCharge-<s:property value="%{key}" />"
							class="css-treeview">
							<h1 class="ui-widget-header">
								Payment Options
							</h1>
							<ul id="payTypeUL">
								<s:iterator value="%{value.payTypeMap}">
									<s:set name="payTypeKey" value="%{key}"></s:set>
									<li id="<s:property value="%{'payTypeLi-'+#payTypeKey}"/>">
										<s:checkbox id="%{'payType-'+#payTypeKey}"
											name="%{'payType-'+#payTypeKey}" value="false"
											fieldValue="%{''}"></s:checkbox>
										<s:label value="%{value.payTypeDispCode}"
											for="%{'payType-'+#payTypeKey}"></s:label>
										<ul id="<s:property value="%{'paySubTypeUL-'+#payTypeKey}"/>">
											<s:iterator value="%{value.subTypeMap}">
												<s:set name="paySubTypeKey" value="%{#payTypeKey+'-'+key}"></s:set>
												<li
													id="<s:property value="%{'paySubTypeLi-'+#paySubTypeKey}"/>">
													<s:checkbox id="%{'paySubType-'+#paySubTypeKey}"
														name="%{'paySubType-'+#paySubTypeKey}" value="false"
														fieldValue="%{''}"></s:checkbox>
													<s:label value="%{value.subTypeCode}"
														for="%{'paySubType-'+#paySubTypeKey}"></s:label>
													<ul
														id="<s:property value="%{'providerUL-'+#paySubTypeKey}"/>">
														<s:iterator value="%{value.providerMap}">
															<li
																id="<s:property value="%{'providerLi-'+#paySubTypeKey+'-'+key}"/>">
																<s:hidden name="podmId"
																	id="%{'podmId-'+#paySubTypeKey+'-'+key}"
																	value="%{value.podmId}"></s:hidden>
																<s:property value="%{value.providerDiscCode}" />
															</li>
														</s:iterator>
													</ul>
												</li>
											</s:iterator>
										</ul>
									</li>
								</s:iterator>
							</ul>
						</div>
					</div>
				</s:iterator>
			</div>
			<div>
				<s:form action="bo_csh_pod_process_charge_save"
					onsubmit="return prepareData()">
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<s:hidden name="podmProcessingChargeStr"
						id="podmProcessingChargeStr"></s:hidden>
					<s:submit value="Submit"></s:submit>
				</s:form>
			</div>
		</div>
		<div id="paymentProviderDiv" class="css-treeview">
			<h1 class="ui-widget-header">
				Payment Options
			</h1>
			<ul id="payTypeUL">
				<s:iterator value="%{pomMap}">
					<s:set name="payTypeKey" value="%{key}"></s:set>
					<li id="<s:property value="%{'payTypeLi-'+#payTypeKey}"/>">
						<s:checkbox id="%{'payType-'+#payTypeKey}"
							name="%{'payType-'+#payTypeKey}" value="false" fieldValue="%{''}"></s:checkbox>
						<s:label value="%{value.payTypeDispCode}"
							for="%{'payType-'+#payTypeKey}"></s:label>
						<ul id="<s:property value="%{'paySubTypeUL-'+#payTypeKey}"/>">
							<s:iterator value="%{value.subTypeMap}">
								<s:set name="paySubTypeKey" value="%{#payTypeKey+'-'+key}"></s:set>
								<li id="<s:property value="%{'paySubTypeLi-'+#paySubTypeKey}"/>">
									<s:checkbox id="%{'paySubType-'+#paySubTypeKey}"
										name="%{'paySubType-'+#paySubTypeKey}" value="false"
										fieldValue="%{''}"></s:checkbox>
									<s:label value="%{value.subTypeCode}"
										for="%{'paySubType-'+#paySubTypeKey}"></s:label>
									<ul id="<s:property value="%{'providerUL-'+#paySubTypeKey}"/>">
										<s:iterator value="%{value.providerMap}">
											<li
												id="<s:property value="%{'providerLi-'+#paySubTypeKey+'-'+key}"/>">
												<s:hidden name="podmId"
													id="%{'podmId-'+#paySubTypeKey+'-'+key}"
													value="%{value.podmId}"></s:hidden>
												<s:property value="%{value.providerDiscCode}" />
											</li>
										</s:iterator>
									</ul>
								</li>
							</s:iterator>
						</ul>
					</li>
				</s:iterator>
			</ul>
		</div>
	</body>
</html>

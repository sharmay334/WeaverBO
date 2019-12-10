<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<SCRIPT type="text/javascript">
 
	$(document).ready(function() {
		$("#accordion").accordion( {
			collapsible : true,
			clearStyle : true,
			header : 'div[class*="accordianHeader"]',
			icons : {
				header : "plus1",
				headerSelected : "minus1"
			},
			active : false
		});
		var flag = true;
		$(".accordian_content input:checkbox").each(function() {
			if (!this.checked) {
				flag = false;
			}
		});
		if (flag == true) {
			$("#selectAll").attr('checked', true);
		}

	});
</SCRIPT>

<s:form name="blockCountryFrm" id="blockCountryFrm" theme="simple"
	action="st_pms_dm_blockCountryStateSave">
	<s:token name="strutsToken" id="strutsToken"></s:token>
	<div class="FormSection">
		<div class="greyStrip">
			<input
				style="margin-right: 20px; margin-left: 30px; margin-top: 8px;"
				type="checkbox" id="selectAll" name="selectAll"
				onclick="selectAllCon(this)">
			<s:label cssClass="label" cssStyle="font-weight:bold" value="Select All" />
		</div>
		<div class="innerBox">
				<div id="accordion" class="UIaccordian">
				<s:iterator value="%{#request.countryStateBean}" status="countryStateBean">
					<div class="accordianHeader" style="width: 95%">
						<div id="contry<s:property value="countryCode"/>" style="color: rgb(85, 85, 85);float: left; font-family: Arial,Helvetica,sans-serif;font-size: 13px;padding: 0px 0 0 8px;">

							<s:if test="status.equals('ACTIVE')">
								<input
									style="margin-right: 20px; margin-left: 20px; margin-top: 10px;"
									type="checkbox" id="country" name="country" checked="checked"
									value="<s:property value="countryCode"/>"
									onclick="checkUncheckAll(event,'contry<s:property value="countryCode"/>','accordian<s:property value="countryCode"/>');" />
							</s:if>
							<s:else>
								<input
									style="margin-right: 20px; margin-left: 20px; margin-top: 10px;"
									type="checkbox" id="country" name="country"
									value="<s:property value="countryCode"/>"
									onclick="checkUncheckAll(event,'contry<s:property value="countryCode"/>','accordian<s:property value="countryCode"/>');" />
							</s:else>
							<s:property value="name" />
							
						</div>
					</div>
				<div class="accordian_content" id="accordian<s:property value="countryCode"/>" style="width: 92%">
					<div id="top" align="left" style="margin-left: 18px">
						<table>
							<s:iterator value="stateList" status="status">

								<s:if test="%{#status.index == 0}">
									<tr>
										<td style="width: 500px; font-size: 12px; padding-top:8px">
											<s:if test="%{status.equals('ACTIVE')}">
												<input type="checkbox" id="state" name="state"
													value="<s:property value="%{stateCode}"/>"
													checked="checked"
													onclick="check(this,'contry<s:property value="countryCode"/>','accordian<s:property value="countryCode"/>')" />
											</s:if>
											<s:else>
												<input type="checkbox" id="state" name="state"
													value="<s:property value="%{stateCode}"/>"
													onclick="check(this,'contry<s:property value="countryCode"/>','accordian<s:property value="countryCode"/>')" />
											</s:else>
											<s:property value="%{name}" />
										</td>
								</s:if>
								<s:elseif test="%{#status.index%3 == 0}">
									</tr>
									<tr>
										<td style="width: 500px;font-size: 12px;padding-top:8px">
											<s:if test="%{status.equals('ACTIVE')}">
												<input type="checkbox" id="state" name="state"
													checked="checked"
													value="<s:property value="%{stateCode}"/>"
													onclick="check(this,'contry<s:property value="countryCode"/>','accordian<s:property value="countryCode"/>')" />
											</s:if>
											<s:else>
												<input type="checkbox" id="state" name="state"
													value="<s:property value="%{stateCode}"/>"
													onclick="check(this,'contry<s:property value="countryCode"/>','accordian<s:property value="countryCode"/>')" />
											</s:else>
											<s:property value="%{name}" />
										</td>
								</s:elseif>
								<s:else>
									<td style="width: 500px;font-size: 12px;padding-top:8px">
										<s:if test="%{status.equals('ACTIVE')}">
											<input type="checkbox" id="state" name="state"
												checked="checked" value="<s:property value="%{stateCode}"/>"
												onclick="check(this,'contry<s:property value="countryCode"/>','accordian<s:property value="countryCode"/>')" />
										</s:if>
										<s:else>
											<input type="checkbox" id="state" name="state"
												value="<s:property value="%{stateCode}"/>"
												onclick="check(this,'contry<s:property value="countryCode"/>','accordian<s:property value="countryCode"/>')" />
										</s:else>
										<s:property value="%{name}" />
									</td>
								</s:else>

							</s:iterator>


						</table>

					</div>

				</div>
			</s:iterator>
        </div>
		</div>
		<input type="hidden" name="domainId" id="domainId"
			value="<s:property value="domainId"/>">

		<div class="box_footer" align="right">
			<input id="frmSubmit" class="button" type="submit" value="submit"
				name="submit" onclick="return submitfrm()">
		</div>
	</div>
</s:form>
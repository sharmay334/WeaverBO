<%@ taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@ page language="java" contentType="text/html"%>
<%@ page import="java.util.*"%>
<%
	String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>
		<script type="text/javascript">
			$(document).ready(function() {
				var countryMap = $.parseJSON($('#countryMapJson').val());
								
				$('#countryCode').change(function() {
					if($(this).val()!=-1){
						$('#stateCode').empty().append($('<option></option>').val("-1").html("----Please select----"));
						var countryCode = $(this).val();
						var stateList = countryMap[countryCode].stateList;
						if (stateList!=undefined && stateList.length>0 ) {
							$.each(stateList, function(key,state){
								$('#stateCode').append($('<option></option>').val(state.stateCode).html(state.name));
							});
						}else{
							$('#stateCode').empty().append($('<option></option>').val("-1").html("----Please select----"));
						}
						
					}else{
						$('#stateCode').empty().append($('<option></option>').val("-1").html("----Please select----"));
					}
				});
				$('#firstVerification').change(function() {
					if($(this).val()=='EMAIL'){
						$('#verificationThrough').empty();
						$('#verificationThrough').append($('<option></option>').val("CODE").html("Code"));
						$('#verificationThrough').append($('<option></option>').val("LINK").html("Link"));
					}else{
						$('#verificationThrough').empty().append($('<option></option>').val("CODE").html("Code"));
					}
				});
				$('[id*="domain_currency_"]:checkbox').change(function() {
					if($(this).prop("checked")){
						$('select[id="currencyId"]').append($('<option></option>').val($(this).val()).html($.trim($('#domain_currency_span_'+$(this).val()).html())));
					}else{
						$('select[id="currencyId"] option[value="'+$(this).val()+'"]').remove();
					}
				});
				$('[id*="domain_language_"]:checkbox').change(function() {
					if($(this).prop("checked")){
						$('select[id="languageId"]').append($('<option></option>').val($(this).val()).html($.trim($('#domain_language_span_'+$(this).val()).html())));
					}else{
						$('select[id="languageId"] option[value="'+$(this).val()+'"]').remove();
					}
				});
				
			});
				
</script>
	</head>
	<body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4> Domain Information </h4>
		</div>
		<s:hidden id="countryMapJson" value="%{countryStr}"/>
		<s:hidden id="domainName" name="domainBean.domainName" value="%{domainBean.domainName}"/>
		<div class="innerBox">
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Company Name </label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield  name="domainBean.domainOwner" id="domainOwner" maxlength="50"  pattern="^[a-zA-Z0-9. ]*$" onpaste="return false;" 
					 			   errorMassage="Special character is not allowed" theme="myTheme" applyscript="true"></ss:textfield>
				</div>
			</div>
		
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Address </label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield name="domainBean.address" id="address" theme="myTheme" applyscript="true"></ss:textfield>
				</div>
			</div>
		
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Country </label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<s:select name="domainBean.countryCode" cssClass="select1" id="countryCode" headerKey="-1" headerValue="----Please Select----"
							  list="%{countryMap}" listKey="%{key}" listValue="%{value.name}" theme="myTheme" applyscript="true"/>
				</div>
			</div>

			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> State </label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<s:select name="domainBean.stateCode"  cssClass="select1" headerKey="-1" headerValue="----Please Select----" 
						list="%{countryMap.get(domainBean.countryCode).stateList}" listKey="%{stateCode}" listValue="%{name}" id="stateCode" theme="myTheme"  applyscript="true"/>
				</div>
			</div>

			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Contact Person </label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield pattern="^[a-zA-Z ]*$" errorMassage="Numeric and Special Character not allowed" maxlength="25"
								theme="myTheme" name="domainBean.contactPersonName" id="contactPersonName" applyscript="true"></ss:textfield>
				</div>
			</div>
		
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Phone Number </label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield name="domainBean.ownerContactNo" id="ownerContactNo" theme="myTheme" pattern="^[0-9]*$" 
								  errorMassage="Only Numeric character allowed" maxLength="15" minLength="10" applyscript="true"></ss:textfield>
				</div>
			</div>
		</div>
	</div>

	<div class="FormSection">
	<div class="greyStrip">
		<h4> Registration Information </h4>
	</div>
	<div class="innerBox">
		<%-- <div class="FormMainBox">
			<div class="labelDiv">
				<label> Registration Type </label>
			</div>
			<div class="InputDiv">
				<s:select list="{'SINGLEPAGE','MULTIPAGE'}" name="domainBean.registrationType" id="registrationType"
					cssClass="select1" theme="myTheme" applyscript="true"></s:select>
			</div>
		</div>
		
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Registration Mode </label>
			</div>
			<div class="InputDiv">
					<s:select list="{'PROGRESSIVE','COMPREHENSIVE'}" name="domainBean.registrationMode" id="registrationMode"
						cssClass="select1" theme="myTheme" applyscript="true"></s:select>
			</div>
		</div>
		
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Registration Page </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.registrationPage" id="registrationPage" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
						<a href="/<%=path %>/com/stpl/pms/action/bo/pm/bo_pm_load_managepage.action?domainId=<s:property value='%{domainBean.domainId}'/>" style="text-decoration: none;color: #000000">
							EDIT
						</a>
					</label>
			</div>
		</div>
		<div class="clearFRM"></div> --%>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label>
					Term and Condition
				</label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.termCondition" id="termCondition" theme="myTheme" readonly="true"></ss:textfield>
			</div>
		</div>
		
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label>
					Privacy Policy
				</label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.privacyPolicy" id="privacyPolicy" theme="myTheme" readonly="true"></ss:textfield>
			</div>
		</div>
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Security Question List </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.securityQuesList" id="securityQuesList" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
					<a style="text-decoration: none;color:#000000" href="st_pms_dm_bo_secQuesMgmt.action?domainId=<s:property value='%{domainBean.domainId}'/>&&ip=check">
						EDIT
					</a>
				</label>
			</div>

		</div>
		<div class="clearFRM"></div>

		<div class="FormMainBox">
			<div class="labelDiv">
				<label>
					Referral List
				</label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.referralList" id="referralList" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
						<a style="text-decoration: none;color:#000000" href="st_pms_dm_bo_referralMgmt.action?domainId=<s:property value='%{domainBean.domainId}'/>&&ip=check">
							EDIT
						</a>
					</label>
			</div>

		</div>
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Password Policy </label>
				<em class="Req">*</em>
			</div>
			<div class="InputDiv">
				<s:select name="domainBean.passwordPolicyId"  cssClass="select1" headerKey="-1" headerValue="----Please Select----"
					id="passwordPolicyId" list="%{passwordPolicyMap}" theme="myTheme"  applyscript="true"/>
			</div>
		</div>
		
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label>
					Role Preference
				</label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.rolePreference" id="rolePreference" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
						<a href="/<%=path %>/com/stpl/pms/action/bo/misc/st_pms_misc_vipLevelSetUp_Menu.action?domainId=<s:property value='%{domainBean.domainId}'/>" style="text-decoration: none;color: #000000">
							EDIT
						</a>
					</label>
			</div>
		</div>
		
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label>
					Duplicate Logic
				</label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.duplicateLogic" id="duplicateLogic" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
						<a href="/<%=path %>/com/stpl/pms/action/bo/riskMgmt/st_pms_bo_riskMgmt_showDLDomainList.action?domainId=<s:property value='%{domainBean.domainId}'/>" style="text-decoration: none;color: #000000">
							EDIT
						</a>
					</label>
			</div>

		</div>
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Login Allow Through </label>
			</div>
			<div class="InputDiv">
				<div id="listColumns">
					<s:checkbox name="domainBean.loginThroughEmail" id="loginThroughEmail" fieldValue="YES"
						value="%{domainBean.loginThroughEmail == 'YES'}"  ></s:checkbox>
					<span class="inpSpan"> E-mail </span>
					<s:checkbox name="domainBean.loginThroughUsername" id="loginThroughUsername" fieldValue="YES"
						value="%{domainBean.loginThroughUsername == 'YES'}"  ></s:checkbox>
					<span class="inpSpan"> User Name </span>
					<s:checkbox name="domainBean.loginThroughMobileNo" id="loginThroughMobileNo" fieldValue="YES"
						value="%{domainBean.loginThroughMobileNo == 'YES'}"  ></s:checkbox>
					<span class="inpSpan"> Phone No </span>
					<s:checkbox name="domainBean.loginThroughFconnect" id="loginThroughFconnect" fieldValue="YES"
						value="%{domainBean.loginThroughFconnect == 'YES'}" ></s:checkbox>
					<span class="inpSpan"> F-connect </span>
					
				</div>
			</div>
		</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Allowed Features Blocked Country </label>
				</div>
				<div class="InputDiv">
					<s:select name="domainBean.allowedfeatureBlockedCountry"  cssClass="select1"
							id="allowedfeatureBlockedCountry" list="{'LOGIN','REGISTER','TRANSACTION'}" theme="myTheme" applyscript="true" />
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Player Password </label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<s:select name="domainBean.plrPassword" headerKey="-1" headerValue="-- Please Select --" cssClass="select1"
							id="plrPassword" list="{'PLAYER_GIVEN','RANDOM'}"  applyscript="true" theme="myTheme" />
				</div>
			</div>
			
		<div id="UserGiven" style="height: auto">
		
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Send Password </label>
				</div>
				<div class="InputDiv">
					<s:select name="domainBean.sendPassword"  cssClass="select1"
							id="sendPassword" list="#{'EMAIL':'Email','PHONE':'Phone'}"  theme="myTheme" />
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> First Auto Verification </label>
				</div>
				<div class="InputDiv">
					<s:select name="domainBean.firstVerification"  cssClass="select1" 
						id="firstVerification" list="#{'EMAIL':'Email','PHONE':'Phone'}" theme="myTheme" />
				</div>
			</div>
			
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Verification Through </label>
				</div>
				<div class="InputDiv">
					<s:select name="domainBean.verificationThrough"  cssClass="select1"
							id="verificationThrough" list="#{'LINK':'Link','CODE':'Code'}" theme="myTheme" />
				</div>
			</div>
		</div>
	</div>
</div>
<div class="FormSection">

	<div class="greyStrip">

		<h4>
			Payment Information
		</h4>
	</div>
	<div class="innerBox">
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Currency </label>
			</div>
			<div id="currencyId" class="InputDiv1">
				<s:set name="count" value="0"></s:set>
				<s:iterator value="%{currencyMap}">
					
					<s:checkbox id="domain_currency_%{key}" name="domainBean.currency" fieldValue="%{key}" value="%{dmActiveCurrMap.containsKey(key)}"
									theme="myTheme"> </s:checkbox>	
						
						
					<span class="inpSpan" id="domain_currency_span_<s:property value="%{key}" />">
						<s:property value="%{value.currName}" />
					</span>
					<s:if test="%{#count==4}"> <br />
						<s:set name="count" value="0"></s:set>
					</s:if>
					<s:else>
						<s:set name="count" value="%{#count+1}"></s:set>
							&nbsp;&nbsp;
					</s:else>
				</s:iterator>
			</div>
		</div>
		<br />
		<div class="clearFRM"></div>
		<div  id="Currency">
			<div  class="FormMainBox">
				<div class="labelDiv">
					<label> Default Currency </label>
				</div>
				<div class="InputDiv">
					<s:select name="domainBean.currencyId" cssClass="select1" id="currencyId" theme="myTheme"
							list="%{dmActiveCurrMap}" listKey="%{key}" listValue="%{value.currName}"/>
				</div>
			</div>
			<div class="clearFRM"></div>
		</div>	
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Payment Option </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.paymentOption" id="paymentOption" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
						<a href="/<%=path %>/com/stpl/pms/action/bo/cashier/bo_csh_podmSetup_Menu.action?domainId=<s:property value='%{domainBean.domainId}'/>" style="text-decoration: none;color: #000000">
							EDIT
						</a>
					</label>
			</div>
		</div>
		<div class="clearFRM"></div>

		<div class="FormMainBox">
			<div class="labelDiv">
				<label>
					Merchant Provider Account
				</label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.merchantProviderAccount" id="merchantProviderAccount" theme="myTheme" readonly="true"></ss:textfield>
			</div>
		</div>
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Wallet Type </label>
			</div>
			<div class="InputDiv">
				<s:select list="{'PR_NB','PR_RB','PR_RBRW','PR_NBRW','PO_RBRW','KhelPlay'}" name="domainBean.walletType" id="walletType"
					cssClass="select1" theme="myTheme" applyscript="true"></s:select>
			</div>
		</div>
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Payment Option Currency </label>
			</div>
			<div class="InputDiv">
				<s:select list="{'DOMAIN','PLAYER'}" name="domainBean.paymentOptionCurrency" id="paymentOptionCurrency"
					cssClass="select1" theme="myTheme" applyscript="true"></s:select>
			</div>
		</div>
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> TDS ON </label>
			</div>
			<div class="InputDiv">
				<s:select list="{'WINNING','WITHDRAWAL','BOTH','NONE'}" name="domainBean.tdsOn" id="tdsOn" cssClass="select1" 
					theme="myTheme" applyscript="true"></s:select>
			</div>
		</div>
		<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Bonus Usage Order </label>
				</div>
				<div class="InputDiv">
					<s:select list="{'RECIEVED','EXPIRED'}" name="domainBean.bonusUsageOrder" id="bonusUseOrder"
						cssClass="select1" theme="myTheme" applyscript="true"></s:select>
				</div>
			</div>
		
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Player Visible Wallet </label>
				</div>
				<div class="InputDiv">
					<s:select list="{'TOTAL','CASH','CASH BONUS','ALL'}" name="domainBean.plrVisibleWallet" id="plrVisibleWallet"
						cssClass="select1" theme="myTheme" applyscript="true"></s:select>
				</div>
			</div>
			
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Action on Pending Withdrawal  </label>
				</div>
				<div class="InputDiv">
					<s:select list="{'ALLOW','OPTIONAL','BLOCKED'}" name="domainBean.depActionPendingWdr" id="depActionPendingWdr"
						cssClass="select1" theme="myTheme" applyscript="true"></s:select>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Withdrawal Approve Limit </label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield name="domainBean.wdrApprovalLimit" id="wdrApprovalLimit" theme="myTheme" pattern="^(([0-9]+\.?[0-9]?[0-9]?)|-1?)$" 
						errorMassage="Only Number or -1 allowed"  applyscript="true" value="%{(domainBean.wdrApprovalLimit<0)?-1:domainBean.wdrApprovalLimit}"></ss:textfield>
				</div>
			</div>
		
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Bonus Wagering Carry Forword </label>
				</div>
				<div class="InputDiv">
					<div style="color: #2b2b2b; font-size: 12px; line-height: 35px; padding: 0px 2px 0px 4px">
						<s:radio list="{'YES','NO'}" name="domainBean.bonusWrCarryFwd"
							id="bonusWrCarryFwd" cssClass="inpSpan" theme="myTheme"></s:radio>
					</div>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv" style="width: 24%">
					<label> Bonus Expired After Cash Balance </label>
					<em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<ss:textfield name="domainBean.bonusExipryLimit" id="bonusExipryLimit" theme="myTheme" pattern="^([0-9]+\.?[0-9]?[0-9]?)$"
						errorMassage="Only Numeric character allowed"  applyscript="true" min="1"></ss:textfield>
				</div>
			</div>
		</div>
	</div>
	<div class="FormSection">
	<div class="greyStrip">
		<h4> Portal Information </h4>
	</div>
	<div class="innerBox">
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Language </label>
			</div>
			<div id="languageDiv" class="InputDiv1">
				<s:set name="count" value="0"></s:set>
				<s:iterator value="languageMap">
					<s:checkbox id="domain_language_%{key}" name="domainBean.language"  value="%{dmActiveLangMap.containsKey(key)}"
									fieldValue="%{key}" theme="myTheme"></s:checkbox>
					<span class="inpSpan" id="domain_language_span_<s:property value="%{key}"/>"> <s:property value="%{value.languageName}"/>  </span>
					<s:if test="%{#count==4}">
						<br /> <s:set name="count" value="0"></s:set>
					</s:if>
					<s:else>
						<s:set name="count" value="%{#count+1}"></s:set> &nbsp;&nbsp;
					</s:else>
				</s:iterator>
			</div>
		</div>
		<div class="clearFRM"></div>
		<div  class="FormMainBox">
			<div class="labelDiv">
				<label> Default Language </label>
			</div>
			<div class="InputDiv">
				<s:select name="domainBean.languageId"  cssClass="select1" 
					id="languageId" list="%{dmActiveLangMap}"
						listKey="%{key}" listValue="%{value.languageName}" theme="myTheme" />
			</div>
		</div>
			
		<%-- <div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> PC-Layout </label>
			</div>
			<div class="InputDiv">
				<s:select name="domainBean.layoutPc"  headerValue="-- Please Select --" cssClass="select1"
					id="layoutPc" list="{'default','gold','platinum','sliver'}" theme="myTheme"  applyscript="true"/>
			</div>
		</div>
			
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> PC-Domain Alias </label>
				<em class="Req">*</em>
			</div>
			<div class="InputDiv">
				<ss:textfield name="domainBean.pcDomainAlias" id="pcDomainAlias" value="%{domainBean.pcDomainAlias.get(0)}"  theme="myTheme" pattern="^[a-zA-Z.0-9]*$" 
							errorMassage=" Special character not allowed" applyscript="true"></ss:textfield >
			</div>
		</div>
			
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Mobile-Layout </label>
			</div>
			<div class="InputDiv">
				<s:select name="domainBean.layoutMobile" headerValue="-- Please Select --" cssClass="select1" applyscript="true"
					id="layoutMobile" list="{'default','gold','platinum','sliver'}" theme="myTheme" />
			</div>
		</div>
			
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Mobile-Domain Alias </label>
				<em class="Req">*</em>
			</div>
			<div class="InputDiv">
				<ss:textfield name="domainBean.mobileDomainAlias" id="mobileDomainAlias" value="%{domainBean.mobileDomainAlias.get(0)}" theme="myTheme" pattern="^[a-zA-Z.0-9]*$" errorMassage=" Special character not allowed"  applyscript="true"></ss:textfield>
			</div>
		</div>
			
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Tab-Layout </label>
			</div>
			<div class="InputDiv">
				<s:select name="domainBean.layoutTab"  headerValue="-- Please Select --" cssClass="select1" applyscript="true"
					id="layoutTab" list="{'default','gold','platinum','sliver'}" theme="myTheme" />
			</div>
		</div>
			
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Tab-Domain Alias </label>
				<em class="Req">*</em>
			</div>
			<div class="InputDiv">
				<ss:textfield name="domainBean.tabDomainAlias" id="tabDomainAlias" value="%{domainBean.tabDomainAlias.get(0)}"  pattern="^[a-zA-Z.0-9]*$" errorMassage=" Special character not allowed"  theme="myTheme" applyscript="true"></ss:textfield>
			</div>
		</div> --%>

		
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label>
					Allowed Countries
				</label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.allowedCountries" id="allowedCountries" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
						<a href="st_pms_dm_blockCountryState.action?domainId=<s:property value='%{domainBean.domainId}'/>&&ip=check" style="text-decoration: none;color: #000000">
							EDIT </a>
					</label>
			</div>
		</div>
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Blocked IP </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.blockedIp" id="blockedIp" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
						<a href="/<%=path %>/com/stpl/pms/action/bo/riskMgmt/bo_dm_blockIp_Search.action?domainId=<s:property value='%{domainBean.domainId}'/>&&ip=check" style="text-decoration: none;color: #000000">
							EDIT
						</a>
					</label>
			</div>
		</div>
	
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Blocked Email </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.blockedEmail" id="blockedEmail" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
						<a href="/<%=path %>/com/stpl/pms/action/bo/riskMgmt/bo_dm_blockEmail_Search.action?domainId=<s:property value='%{domainBean.domainId}'/>&&email=check" style="text-decoration: none;color: #000000">
							EDIT
						</a>
					</label>
			</div>
		</div>
		
		<div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Blocked Phone </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield name="domainBean.blockedPhone" id="blockedPhone" theme="myTheme" readonly="true"></ss:textfield>
					<label Class="buttonEdit">
						<a href="/<%=path %>/com/stpl/pms/action/bo/riskMgmt/bo_dm_blockPhone_Search.action?domainId=<s:property value='%{domainBean.domainId}'/>&&email=check" 
							style="text-decoration: none;color: #000000">
							EDIT
						</a>
					</label>
			
			</div>
		</div>
	</div>
</div>

<div class="FormSection">
	<div class="greyStrip">
		<h4>
			Miscellaneous Information
		</h4>
	</div>

	<div class="innerBox">
		<%-- <div class="clearFRM"></div>
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Logo Upload </label>
			</div>
			<div class="InputDiv" style="position: relative;">
				<s:file name="domainLogo"  cssStyle="select1" theme="myTheme" id="domainLogo" ></s:file>
				<div id="domainLogoDiv" style="color:#777777; font-size:12px;">
					( .jpeg,.png are allowed.) </div>
          		</div>
		</div> --%>
		<div class="clearFRM"></div>
		<div class="FormMainBox">
					<div class="labelDiv">
						<label> Default Service Name </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.serviceId" headerKey="-1"
							headerValue="-- Please Select --" cssClass="select1" 
							id="serviceId" list="%{serviceMap}" theme="myTheme"  applyscript="true"/>
					</div>
				</div>
			
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Game Try Before Login </label>
					</div>
					<div class="InputDiv">
						<div style="color: #2b2b2b; font-size: 12px; line-height: 35px; padding: 0px 2px 0px 4px">
							<s:radio list="{'YES','NO'}" name="domainBean.gameTryBeforeLogin"
								id="gameTryBeforeLogin" cssClass="inpSpan" theme="myTheme"></s:radio>
						</div>
					</div>
				</div>
				
				 <div class="clearFRM"></div>
				 <div class="FormMainBox">
	       			<div class="labelDiv"><label>Player Ledger Format</label> <em class="Req">*</em> </div>
	           		<div class="InputDiv">
			           <s:select name="domainBean.playerLedgerFormat" headerKey="-1"
							headerValue="-- Please Select --" cssClass="select1" id="playerLedgerFormat" theme="myTheme" 
							list="{'WAGER_AND_FUND','ONLY_WAGER','ONLY_FUND'}" applyscript="true"
							value="%{domainBean.playerLedgerFormat}" />
	      			</div>
	   			</div>
	   			
	   			<div class="clearFRM"></div>
				<div class="FormMainBox">
	       			<div class="labelDiv"><label>Check Responsible Gaming</label></div>
	           		<div class="InputDiv">
						<div style="color: #2b2b2b; font-size: 12px; line-height: 35px; padding: 0px 2px 0px 4px">
							<s:radio list="{'YES','NO'}" name="domainBean.checkRg"
								id="checkRg" cssClass="inpSpan" theme="myTheme"></s:radio>
						</div>
					</div>
	   			</div>
	   			
	   			<div class="clearFRM"></div>
				 <div class="FormMainBox">
	       			<div class="labelDiv"><label>Allowed Invaild Login Try</label><em class="Req">*</em></div>
	           		<div class="InputDiv">
						<ss:textfield name="domainBean.allowedInvaildLoginTry" id="allowedInvaildLoginTry" 
						 pattern="^([0-9]*|-1?)$" errorMassage="Only numbers or -1 allowed"  theme="myTheme" applyscript="true"></ss:textfield>
					</div>
	   			</div>
	   			
	   			<div class="clearFRM"></div>
				 <div class="FormMainBox">
	       			<div class="labelDiv"><label>PlayerPasswordHistoryCount</label><em class="Req">*</em></div>
	           		<div class="InputDiv">
						<ss:textfield name="domainBean.playerPasswordHistoryCount" id="playerPasswordHistoryCount"  pattern="^([0-9]*|-1?)$" errorMassage="Only numbers or -1 allowed"  theme="myTheme" applyscript="true"></ss:textfield>
					</div>
	   			</div>
<%--			
			<div class="clearFRM"></div>
				<div class="FormMainBox">
	       			<div class="labelDiv"><label>Auto age verification</label></div>
	           		<div class="InputDiv">
						<div style="color: #2b2b2b; font-size: 12px; line-height: 35px; padding: 0px 2px 0px 4px">
							<s:radio list="{'YES','NO'}" name="domainBean.tpAutoVerification"
								id="tPAutoVerification" cssClass="inpSpan" theme="myTheme"></s:radio>
						</div>
					</div>
	   			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
					<div class="labelDiv">
						<label> Age verification provider </label>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.verificationSourceId" headerKey="-1"
							headerValue="-- Please Select --" cssClass="select1" 
							id="verificationSourceId" listKey="value.sourceId" listValue="value.sourceName"
							list="%{autoVerificationSourceMap}" theme="myTheme"  applyscript="true"/>
					</div>
				</div>
			--%>
      <%--   <div class="clearFRM"></div>
         <div class="FormMainBox">
        	<div class="labelDiv"><label>
        	Url List
        	</label></div>
            <div class="InputDiv">
           <s:select list="{'BYDEFAULT','SPECIFIC'}"
					name="domainBean.urlList"  id="urlList" onpaste="return false;" 
					cssClass="select1"></s:select>
            </div>
        </div>
        </div> --%>
        
		</div>
<div class="box_footer" align="right">
		<s:submit name="createDomain" value="Edit Domain Detail"
			cssClass="button" id="submit" theme="simple"></s:submit>
			<s:submit name="cancel" value="Cancel" cssClass="button"
				id="cancel" theme="simple" action="bo_home_page"></s:submit>
	</div>
	<br><br>

</body>
</html>
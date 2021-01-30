<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" contentType="text/html"%>
<%@ page import="java.util.*"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib uri="/extended-struts2-tags" prefix="ss"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<title>Domain Registration</title>
<script type="text/javascript">
$(document).ready(function() {
	 var countryMap = $.parseJSON($('#countryMapJson').val());
	$.each(countryMap, function(key,value) {
		$('#countryCode').append( $('<option></option>').val(key).html(value.name));
	});
	
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
		
		$('.chkAll').change(
						function() {
							$(this).closest('tr').siblings('tr')
									.find('.chkGrp').attr('checked',
											this.checked);
							$(this).closest('tr').siblings('tr')
									.find('.chkGrp').change();
							
						});
	
	$('.chkGrp').change(
						function() {
							chkPriv($(this));
							$(this).closest('tr').siblings('tr')
									.find('.chkOne').attr('checked',
											this.checked);
							chkDefault($(this).closest('tr').siblings('tr')
									.find('.chkOne'));
							//setCkhDefault(resp);
						});

				$('.chkOne').change(
					function() {
							if ($(this).attr('readonly') != 'readonly') {
								var chk = true;
								$(this).closest('table').parents('td').find(
										'.chkOne').each(function() {
									if (!this.checked) {
										chk = false;
									}
								});
								$(this).closest('table').closest('tr')
										.siblings('tr').find('.chkGrp').attr(
												'checked', chk);
								chkPriv($(this).closest('table').closest('tr')
										.siblings('tr').find('.chkGrp'));
								chkDefault($(this).closest('table').parents(
										'td').find('.chkOne'));
									chk = true;
								$(this).closest('table').parents('td').find(
										'.chkOne').each(function() {
									if (!this.checked) {
										chk = false;
									}
								});
								$(this).closest('table').closest('tr')
										.siblings('tr').find('.chkGrp').attr(
												'checked', chk);
								chkPriv($(this).closest('table').closest('tr')
										.siblings('tr').find('.chkGrp'));
										
							} else {
								$(this).attr('checked', true);
							}
						}); 
	
});
				
				
</script>
<!--<script type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/dm/js/dm.js"></script>-->
<script type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/um/js/um.js"></script>
</head>
	<body>
		<div class="clear2"></div>
		<br />
		<h2>
			Domain Registration
		</h2>
		<s:form id="RegistrationDomain" name="RegDomain" action="bo_dm_boDomainReg_Save" theme="simple" enctype="multipart/form-data" onsubmit="return chksub();">
			<s:token name="strutsToken" id="strutsToken" />
			<div id="centerdiv">
		<div class="FormSection">
			<div class="greyStrip">
				<h4> Domain Information </h4>
			</div>
			<s:hidden id="countryMapJson" value="%{countryStr}"/>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain Name </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield pattern="^[a-zA-Z0-9.]*$"  name="domainBean.domainName" 
							id="domainName"  title="ex. www.abc.com, mobile.abc.com" errorMassage="Special character is not allowed" 
							theme="myTheme" action="bo_dm_validateDomain.action" maxlength="100" applyscript="true"  ></ss:textfield>
						<div id="domainName_error" class="fieldError" >
							<s:fielderror><s:param>domainName </s:param></s:fielderror>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Company Name </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield  name="domainBean.domainOwner" id="domainOwner" maxlength="50"  pattern="^[a-zA-Z0-9. ]*$"
						 			   errorMassage="Special character is not allowed" theme="myTheme" applyscript="true"></ss:textfield>
						<div id="domainOwner_error" class="fieldError" >
							<s:fielderror><s:param>domainOwner </s:param></s:fielderror>
						</div>
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
						<div id="address_error" class="fieldError" >
							<s:fielderror><s:param>address </s:param></s:fielderror>
						</div>
					</div>
				</div>
			
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Country </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.countryCode" cssClass="select1" id="countryCode" 
								  list="#{'-1':'----Please Select----'}" theme="myTheme" applyscript="true"/>
						<div id="countryCode_error" class="fieldError" >
							<s:fielderror><s:param>country</s:param></s:fielderror>
						</div>
					</div>
				</div>

				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> State </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.stateCode"  cssClass="select1" list="#{'-1':'----Please Select----'}"
							id="stateCode" theme="myTheme"  applyscript="true"/>
						<div id="stateCode_error" class="fieldError" >
							<s:fielderror><s:param>state</s:param></s:fielderror>
						</div>
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
						<div id="contactPersonName_error" class="fieldError" >
							<s:fielderror><s:param>contactPersonName</s:param></s:fielderror>
						</div>
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
						<div id="ownerContactNo_error" class="fieldError" >
							<s:fielderror><s:param>ownerContactNo</s:param></s:fielderror>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="FormSection">
			<div class="greyStrip"><h4> User Information</h4></div>
	        <div class="innerBox">	
	        	<div class="FormMainBox">
		        	<div class="labelDiv"><label>First Name</label><em class="Req">*</em></div>
		            <div class="InputDiv">
		            	<ss:textfield maxlength="30" id="firstName" theme="myTheme" name="userDetailBean.firstName" 
		            				pattern="^[a-zA-Z]*$" errorMassage="Numeric and Special Character not allowed" applyscript="true"/>
			            <div id="firstName_error" class="fieldError" >
							<s:fielderror><s:param>firstName</s:param></s:fielderror>
						</div>
		            </div>
		        </div>
		        
		        <div class="clearFRM"></div>
		        <div class="FormMainBox">
		        	<div class="labelDiv"><label>Last Name</label><em class="Req">*</em></div>
		            <div class="InputDiv">
		           		<ss:textfield maxlength="30" id="lastName" theme="myTheme" name="userDetailBean.lastName" pattern="^[a-zA-Z]*$" 
		           					errorMassage="Numeric and Special Character not allowed" applyscript="true"></ss:textfield>
			             <div id="lastName_error" class="fieldError" >
			             	<s:fielderror><s:param>lastName</s:param></s:fielderror>
						 </div>
		            </div>
		        </div>
		        
		        <div class="clearFRM"></div>
	            <div class="FormMainBox">
	        		<div class="labelDiv"><label>Gender</label><em class="Req">*</em></div>
		            <div class="InputDiv">
			            <s:select name="userDetailBean.gender" headerKey="-1"
								headerValue="-- Please Select --" cssClass="select1" id="gender"
								list="#{'M':'Male','F':'Female'}" theme="myTheme" applyscript="true"/>
						<div id="gender_error" class="fieldError" >
							<s:fielderror><s:param>gender</s:param></s:fielderror>
						</div>
		            </div>
		        </div>
	         	
	         	<div class="clearFRM"></div>
		        <div class="FormMainBox">
		        	<div class="labelDiv"><label>User Name</label><em class="Req">*</em></div>
		            <div class="InputDiv">
		           		<ss:textfield theme="myTheme" maxlength="30" name="userDetailBean.userName" id="userName" 
	           						 pattern="^[a-zA-Z0-9._]*$" errorMassage="Special Character not allowed" 
	           						 action="bo_dm_validateDomainUserName.action" minLength="6" applyscript="true"></ss:textfield>
						<div id="userName_error" class="fieldError" >
							<s:fielderror><s:param>userName</s:param></s:fielderror>
						 </div>
		            </div>
		        </div>
		        
		        <div class="clearFRM"></div>
		        	<div class="FormMainBox">
		        		<div class="labelDiv"><label>Email</label><em class="Req">*</em></div>
		           		<div class="InputDiv">
				            <ss:textfield maxlength="50" theme="myTheme"  name="userDetailBean.emailId" id="emailId" 
				            			pattern="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" errorMassage="Please Enter Valid Email Id" 
				            			applyscript="true" patternOn="blur"  action="bo_dm_validateDomainUserEmail.action"/>
		            	<div id="emailId_error" class="fieldError">
							<s:fielderror><s:param>emailId</s:param></s:fielderror>
						</div>
		            </div>
		        </div>
		        
		        <div class="clearFRM"></div>
		        	<div class="FormMainBox">
		        		<div class="labelDiv"><label>Phone Number</label><em class="Req">*</em></div>
		           		<div class="InputDiv">
				            <ss:textfield maxlength="15" name="userDetailBean.phoneNbr" theme="myTheme" id="phoneNbr" pattern="^[0-9]*$" 
				            			errorMassage="Only Numeric character allowed" maxLength="15" applyscript="true"></ss:textfield>
							<div id="phoneNbr_error" class="fieldError">
								<s:fielderror><s:param>phoneNbr</s:param></s:fielderror>
							</div>
		            	</div>
		        	</div>
		        
		        <div class="clearFRM"></div>
		        <div class="FormMainBox">
		        	<div class="labelDiv"><label>Secret Question</label><em class="Req">*</em></div>
		            <div class="InputDiv">
				        <s:select name="userDetailBean.secQues" headerKey="-1"
								headerValue="-- Please Select --" cssClass="select1" id="secQues" theme="myTheme" applyscript="true"
								list="{'What is Your Pets Name?','Which is your favourite game?','What is your college name?'}"
								value="gameType" />
						<div id="secQues_error" class="fieldError">
							<s:fielderror><s:param>secQues</s:param></s:fielderror>
						</div>
		            </div>
		        </div>
		        
		        <div class="clearFRM"></div>
	            <div class="FormMainBox">
		        	<div class="labelDiv"><label>Secret Answer</label><em class="Req">*</em></div>
		            <div class="InputDiv">
		            	<ss:textfield  name="userDetailBean.secAns" id="secAns" theme="myTheme" maxlength="30" pattern="^[a-zA-Z]*$" 
		            				errorMassage="Numeric and Special Character is not allowed" applyscript="true"></ss:textfield>
			            <div id="secAns_error" class="fieldError">
							<s:fielderror><s:param>secAns</s:param></s:fielderror>
						</div>
		            </div>
		        </div>
			</div>
		</div>
		
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					Privilege
				</h4>
		</div>
		<div class="innerBox" style="width: 100%;margin: 0px;padding: 0px;margin-bottom: 10px;">
				<div class="FormMainBox1">
		<s:if test="rolePriviledgeMap != null">
			<s:if test="rolePriviledgeMap.size()!= 0">
			<div id="accordion" class="UIaccordian">
				<s:iterator value="%{rolePriviledgeMap}" status="divService"
					var="divSerVar">
					<div id="tabs-<s:property value="#divService.index+1" />"
						style="width: 100%">
						<s:set name="serviceDispName" value="%{key}"></s:set>
	
						<s:iterator value="%{value}" status="divInterface">
							<div class="accordianHeader" style="width: 95%;">
							<h3>
								<a href="#section<s:property value="#divInterface.index+1"  />"
									style="color: #333333; font-size: 13px"> <s:set
										name="interface" value="%{key}"></s:set> <s:property
										value="#interface.substring(0,#interface.indexOf('-'))" /> </a>
										
							</h3>
								<!--<span class="minus1" id="min"></span>
								--></div>
							<div class="accordian_content" id="accordian_content<s:property value="%{key}" />" style="display: block;padding-top: 8px;padding-bottom: 8px;margin-top:0px; border:1px #AAAAAA solid;width: 92%;">
									
							<s:hidden name="mappingId"
								value="%{#interface.substring(#interface.indexOf('-')+1)}" />
							<s:hidden name="privCount" value="0" />
							<s:iterator value="%{value}" status="divRelatedTo">
								<s:set name="count" value="0"></s:set>
							<div style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">
								<table id="tlb_<s:property value="%{key}" />"  width="100%">
									<tr align="center" style="background: #e7e7e7" height="24px">
									
										<th  style="text-align: left;" >
											<input type="checkbox" class="chkAll" />
											<b> <s:if test="%{key=='ACT_MGT'}">Account Management</s:if>
												<s:elseif test="%{key=='GAME_MGT'}">Game Management</s:elseif>
												<s:elseif test="%{key=='REPORTS'}">Reports</s:elseif> <s:elseif
													test="%{key=='USER_MGT'}">User Management</s:elseif> <s:elseif
													test="%{key=='ROLE_MGT'}">Role Management</s:elseif> <s:elseif
													test="%{key=='PLAYER_MGT'}">Player Management</s:elseif> <s:elseif
													test="%{key=='MISC'}">Misc</s:elseif> <s:elseif
													test="%{key=='HURDLE_MGT'}">Hurdle Management</s:elseif> <s:elseif
													test="%{key=='LOYALTY'}">Loyalty Management</s:elseif><s:elseif
													test="%{key=='CMS'}">Content Management System</s:elseif> <s:elseif
													test="%{key=='LOGIN_MGT'}">Login Management</s:elseif> <s:elseif
													test="%{key=='DOMAIN_MGT'}">Domain Management</s:elseif> <s:elseif
													test="%{key=='RISK_MGT'}">Risk Management</s:elseif><s:elseif 
													test="%{key=='RG'}">Responsible Gaming Management</s:elseif><s:elseif 
													test="%{key=='CASHIER' }">Cashier</s:elseif>
													<s:elseif test="%{key=='BONUS' }">Bonus</s:elseif> 
													<s:elseif test="%{key=='TOURNAMENT_REPORT' }">Tournament Report</s:elseif></b>
										</th>
										<th width="33%"></th>
										<th width="33%"></th>
										
									</tr>
									<tr id="test_<s:property value="%{key}" />" align="left" style="text-align: left;">
										<s:iterator value="%{value}" status="divPriv">
											<s:set name="count" value="%{#count+1}"></s:set>
											
											<td width="33%" style="border:2px #f2f2f2 solid; background: #e0e0e0;vertical-align: top;padding-bottom:4px">
												<table id="table_<s:property value="%{key}" />" >
													<tr id="parent1_<s:property value="%{key}" />">
														<td>
														<span>	<input name="rolePrivGrp" type="checkbox" class="chkGrp"
																value="<s:property value="%{key}" />" />
																
															<font style="font-weight: bold; color: #828282;line-height: 30px">
															<s:property value="%{key}" /></font></span>
														</td>
													</tr>
													<tr id="parent_<s:property value="%{key}" />">
														<td>
														<div id="d11" style="overflow: auto; height: auto; width: 258px;">
															<table >
																<s:iterator value="%{value}" status="itrPriv">
																<div id="skilrock" style="float: left;">
																	<tr align="left" style="text-align: left;">
																		<td width="20px">
																			&nbsp;&nbsp;&nbsp;
																		</td>
																		<td width="auto">
																		
																			<input name="rolePriv<s:property
										value="#interface.substring(0,#interface.indexOf('-'))" />" class="chkOne" type="checkbox"
																				value="<s:property value="privTitle"/>" /> 
																			<s:property value="privTitle"/>
																			
																		</td>
																	
																	</tr>
																	</div>
																</s:iterator>
															</table>
															</div>
														</td>
													</tr>
												</table>
											</td>
											<s:if test="%{#count==3}">
												<s:set name="count" value="0"></s:set>
									</tr>
									<tr align="left" style="text-align: left;">
										</s:if>
										</s:iterator>
									</tr>
								</table>
								</div>
							</s:iterator>
							</div>
							
							
						</s:iterator>
					</div>
				
					</s:iterator>
					</div>
				</s:if>
			</s:if>
			
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
						<div id="registrationType_error" class="fieldError">
						</div>
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
						<div id="registrationMode_error" class="fieldError"> </div>
					</div>
				</div> --%>
				
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Password Policy </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.passwordPolicyId"  cssClass="select1" headerKey="-1" headerValue="----Please Select----"
							id="passwordPolicyId" list="%{passwordPolicyMap}" theme="myTheme"  applyscript="true"/>
						<div id="passwordPolicyId_error" class="fieldError"> </div>
					</div>
				</div>
				
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Login Allow Through </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div id="listColumns">
							<s:checkbox name="domainBean.loginThroughEmail" id="loginThroughEmail" fieldValue="YES"
								value="YES"  ></s:checkbox>
							<span class="inpSpan"> E-mail </span>
							<s:checkbox name="domainBean.loginThroughUsername" id="loginThroughUsername" fieldValue="YES"
								value="YES"  ></s:checkbox>
							<span class="inpSpan"> User Name </span>
							<s:checkbox name="domainBean.loginThroughMobileNo" id="loginThroughMobileNo" fieldValue="YES"
								value="YES"  ></s:checkbox>
							<span class="inpSpan"> Phone No </span>
							<s:checkbox name="domainBean.loginThroughFconnect" id="loginThroughFconnect" fieldValue="YES"
								value="YES" ></s:checkbox>
							<span class="inpSpan"> F-connect </span>
						</div>
						<div id="loginThrough_error" class="fieldError">
							<s:fielderror><s:param>LoginAllowThrough</s:param></s:fielderror>
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
						<div id="allowedPlrBlockedCountry_error" class="fieldError"> </div>
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
						<div id="plrPassword_error" class="fieldError">
							<s:fielderror><s:param>plrPassword</s:param></s:fielderror>
						</div>
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
							<div id="sendPassword_error" class="fieldError"> </div>
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
							<div id="firstVerification_error" class="fieldError"> </div>
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
							<div id="verificationThrough_error" class="fieldError"> </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="FormSection">
			<div class="greyStrip">
				<h4> Payment Information </h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Currency </label>
						<em class="Req">*</em>
					</div>
					<div id="currencyId" class="InputDiv1">
						<s:set name="count" value="0"></s:set>
						<s:iterator value="%{currencyMap}">
							<s:checkbox id="domain_currency_%{key}" name="domainBean.currency" fieldValue="%{key}"
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
						<div id="currencyId_error" class="fieldError"">
							<s:fielderror><s:param>currency</s:param></s:fielderror>
						</div>
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
							<s:select name="domainBean.currencyId" cssClass="select1" 
									id="currencyId" list="{}" theme="myTheme" />
						</div>
					</div>
					<div class="clearFRM"></div>
				</div>	
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Wallet Type </label>
					</div>
					<div class="InputDiv">
						<s:select list="{'PR_NB','PR_RB','PR_RBRW','PR_NBRW','PO_RBRW','KhelPlay'}" name="domainBean.walletType" id="walletType"
							cssClass="select1" theme="myTheme" applyscript="true"></s:select>
						<div id="walletType_error" class="fieldError"> </div>
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
						<div id="paymentOptionCurrency_error" class="fieldError"> </div>
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
						<div id="tdsOn_error" class="fieldError"> </div>
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
						<div id="bonusUseOrder_error" class="fieldError"> </div>
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
						<div id="plrVisibleWallet_error" class="fieldError"> </div>
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
						<div id="depActionPendingWdr_error" class="fieldError"> </div>
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
							errorMassage="Only Number or -1 allowed"  applyscript="true"></ss:textfield>
						<div id="wdrApprovalLimit_error" class="fieldError"> </div>
					</div>
				</div>
			
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Bonus Wagering Carry Forword </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div style="color: #2b2b2b; font-size: 12px; line-height: 35px; padding: 0px 2px 0px 4px">
							<s:radio list="{'YES','NO'}" name="domainBean.bonusWrCarryFwd"
								id="bonusWrCarryFwd" cssClass="inpSpan" theme="myTheme"></s:radio>
						</div>
						<div id="bonusWrCarryFwd_error" class="fieldError"">
							<s:fielderror><s:param>bonusWrCarryFwd</s:param></s:fielderror>
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
						<div id="bonusExipryLimit_error" class="fieldError"> </div>
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
						<em class="Req">*</em>
					</div>
					<div id="languageDiv" class="InputDiv1">
						<s:set name="count" value="0"></s:set>
						<s:iterator value="%{languageMap}">
							<s:checkbox id="domain_language_%{key}" name="domainBean.language" 
									fieldValue="%{value.languageId}" theme="myTheme" ></s:checkbox>
							<span class="inpSpan" id="domain_language_span_<s:property value="%{key}"/>"> <s:property value="%{value.languageName}"/>  </span>
							<s:if test="%{#count==4}">
								<br /> <s:set name="count" value="0"></s:set>
							</s:if>
							<s:else>
								<s:set name="count" value="%{#count+1}"></s:set> &nbsp;&nbsp;
							</s:else>
						</s:iterator>
						<div id="language_error" class="fieldError"">
							<s:fielderror><s:param>language</s:param></s:fielderror>
						</div>
					</div>
				</div>
			</div>
			
			<div class="clearFRM"></div>
			<div id="defLanguageDiv">
				<div  class="FormMainBox">
					<div class="labelDiv">
						<label> Default Language </label>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.languageId"  cssClass="select1" 
							id="languageId" list="{}" theme="myTheme" />
					</div>
				</div>
				
				<div class="clearFRM"></div>
			</div>
			<%-- <div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> PC-Layout </label>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.layoutPc"  headerValue="-- Please Select --" cssClass="select1"
							id="layoutPc" list="{'default','gold','platinum','sliver'}" theme="myTheme"  applyscript="true"/>
						<div id="layoutPc_error" class="fieldError">
							<s:fielderror><s:param>pcLayout</s:param></s:fielderror>
						</div>
					</div>
				</div>
			</div>
			
			<div class="clearFRM"></div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> PC-Domain Alias </label>
						<em class="Req">*</em>
					</div>
					
					
					<div class="InputDiv">
						<ss:textfield name="domainBean.pcDomainAlias" id="pcDomainAlias"  theme="myTheme" pattern="^[a-zA-Z.0-9]*$" 
									errorMassage=" Special character not allowed" value="%{domainBean==null?'':domainBean.pcDomainAlias.get(0)}" applyscript="true"></ss:textfield >
						<div id="pcDomainAlias_error" class="fieldError">
							<s:fielderror><s:param>pcDomainAlias</s:param></s:fielderror>
						</div>
					</div>
				</div>
			</div>
			
			<div class="clearFRM"></div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Mobile-Layout </label>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.layoutMobile" headerValue="-- Please Select --" cssClass="select1" applyscript="true"
							id="layoutMobile" list="{'default','gold','platinum','sliver'}" theme="myTheme" />
						<div id="layoutMobile_error" class="fieldError"">
							<s:fielderror><s:param>layoutMobile</s:param></s:fielderror>
						</div>
					</div>
				</div>
			</div>
			
			<div class="clearFRM"></div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Mobile-Domain Alias </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield name="domainBean.mobileDomainAlias" id="mobileDomainAlias" value="%{domainBean==null?'':domainBean.mobileDomainAlias.get(0)}" theme="myTheme" pattern="^[a-zA-Z.0-9]*$" errorMassage=" Special character not allowed"  applyscript="true"></ss:textfield>
						<div id="mobileDomainAlias_error" class="fieldError">
							<s:fielderror><s:param>mobileDomainAlias</s:param></s:fielderror>
						</div>
					</div>
				</div>
			</div>
			
			<div class="clearFRM"></div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Tab-Layout </label>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.layoutTab"  headerValue="-- Please Select --" cssClass="select1" applyscript="true"
							id="layoutTab" list="{'default','gold','platinum','sliver'}" theme="myTheme" />
						<div id="layoutTab_error" class="fieldError">
							<s:fielderror><s:param>tabLayout</s:param></s:fielderror>
						</div>
					</div>
				</div>
			</div> 
			
			<div class="clearFRM"></div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Tab-Domain Alias </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield name="domainBean.tabDomainAlias" id="tabDomainAlias" value="%{domainBean==null?'':domainBean.tabDomainAlias.get(0)}" pattern="^[a-zA-Z.0-9]*$" errorMassage=" Special character not allowed"  theme="myTheme" applyscript="true"></ss:textfield>
						<div id="tabDomainAlias_error" class="fieldError">
							<s:fielderror><s:param>tabDomainAlias</s:param></s:fielderror>
						</div>
					</div>
				</div>
			</div>--%>
		</div>

		<div class="FormSection">
			<div class="greyStrip">
				<h4> Miscellaneous Information </h4>
			</div>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Default Service Name </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="domainBean.serviceId" headerKey="-1"
							headerValue="-- Please Select --" cssClass="select1" 
							id="serviceId" list="%{serviceMap}" theme="myTheme"  applyscript="true"/>
						<div id="serviceId_error" class="fieldError">
							<s:fielderror><s:param>service</s:param></s:fielderror>
						</div>
					</div>
				</div>
			
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Game Try Before Login </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<div style="color: #2b2b2b; font-size: 12px; line-height: 35px; padding: 0px 2px 0px 4px">
							<s:radio list="{'YES','NO'}" name="domainBean.gameTryBeforeLogin"
								id="gameTryBeforeLogin" cssClass="inpSpan" theme="myTheme"></s:radio>
						</div>
						<div id="gameTryBeforeLogin_error" class="fieldError"">
							<s:fielderror><s:param>gameTryBeforeLogin</s:param></s:fielderror>
						</div>
					</div>
				</div>
				
			<%--	<div class="clearFRM"></div>
				 <div class="FormMainBox">
					<div class="labelDiv">
						<label> Logo Upload </label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv" style="position: relative;">
						<s:file name="domainLogo"  cssStyle="select1" theme="myTheme" id="domainLogo" applyscript="true" ></s:file>
						<div id="domainLogoDiv" style="color:#777777; font-size:12px;">
							( .jpeg,.png are allowed.) </div>
						<div id="domainLogo_error" class="fieldError">
							<s:fielderror><s:param>domainLogo</s:param></s:fielderror>
						</div>
	           		</div>
				</div>
					 --%>
				 <div class="clearFRM"></div>
				 <div class="FormMainBox">
	       			<div class="labelDiv"><label>Player Ledger Format</label><em class="Req">*</em></div>
	           		<div class="InputDiv">
			           <s:select name="domainBean.playerLedgerFormat" headerKey="-1"
							headerValue="-- Please Select --" cssClass="select1" id="playerLedgerFormat" theme="myTheme" 
							list="{'WAGER_AND_FUND','ONLY_WAGER','ONLY_FUND'}" applyscript="true"
							value="gameType" />
						<div id="playerLedgerFormat_error" class="fieldError">
							<s:fielderror><s:param>playerLedgerFormat</s:param></s:fielderror>
						</div>
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
						<div id="checkRg_error" class="fieldError"">
							<s:fielderror><s:param>checkRg</s:param></s:fielderror>
						</div>
					</div>
	   			</div>
	   			
	   			<div class="clearFRM"></div>
				 <div class="FormMainBox">
	       			<div class="labelDiv"><label>Allowed Invaild Login Try</label><em class="Req">*</em></div>
	           		<div class="InputDiv">
						<ss:textfield name="domainBean.allowedInvaildLoginTry" id="allowedInvaildLoginTry"  pattern="^([0-9]*|-1?)$" errorMassage="Only numbers or -1 allowed"  theme="myTheme" applyscript="true"></ss:textfield>
						<div id="allowedInvaildLoginTry_error" class="fieldError">
							<s:fielderror><s:param>allowedInvaildLoginTry</s:param></s:fielderror>
						</div>
					</div>
	   			</div>
	   			
	   			<div class="clearFRM"></div>
				 <div class="FormMainBox">
	       			<div class="labelDiv"><label>PlayerPasswordHistoryCount</label><em class="Req">*</em></div>
	           		<div class="InputDiv">
						<ss:textfield name="domainBean.playerPasswordHistoryCount" id="playerPasswordHistoryCount"  pattern="^([0-9]*|-1?)$" errorMassage="Only numbers or -1 allowed"  theme="myTheme" applyscript="true"></ss:textfield>
						<div id="playerPasswordHistoryCount_error" class="fieldError">
							<s:fielderror><s:param>playerPasswordHistoryCount</s:param></s:fielderror>
						</div>
					</div>
	   			</div>
			</div>
<%--			<div class="clearFRM"></div>
				<div class="FormMainBox">
	       			<div class="labelDiv"><label>Auto age verification</label></div>
	           		<div class="InputDiv">
						<div style="color: #2b2b2b; font-size: 12px; line-height: 35px; padding: 0px 2px 0px 4px">
							<s:radio list="{'YES','NO'}" name="domainBean.tpAutoVerification"
								id="tPAutoVerification" cssClass="inpSpan" theme="myTheme"></s:radio>
						</div>
						<div id="tPAutoVerification_error" class="fieldError"">
							<s:fielderror><s:param>tPAutoVerification</s:param></s:fielderror>
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
						<div id="verificationSourceId_error" class="fieldError">
							<s:fielderror><s:param>verificationSourceId</s:param></s:fielderror>
						</div>
					</div>
				</div>--%>
			<div class="box_footer" align="right">
				<s:submit name="createDomain" value="Create Domain" cssClass="button"
					id="submit" theme="simple" ></s:submit>
				<s:submit name="cancel" value="Cancel" cssClass="button"
						id="cancel" theme="simple" action="bo_home_page"></s:submit>
			</div>
		</div>
	</div>
	
	
	
</s:form>
</body>
</html>


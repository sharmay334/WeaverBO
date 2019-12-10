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

		<title>Confirm Address</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/old/address.css">
		
		<SCRIPT type="text/javascript">
			$(document).ready(function(){
				var jsonMap = $.parseJSON($('#json').val());
				var cityNameIdMap = {};
				$.each(jsonMap, function(index,value) {
					cityNameIdMap[value.city] = index;
				});
				var curCity = cityNameIdMap[$('#curCity').val()];
				if(curCity!=null && curCity!='undefined'){
					$('#selCity').val(curCity);
					$("#pincodeTxt").autocomplete( {
						source : jsonMap[curCity]['pinCode']
					});	
				}
				$('#selCity').change(function() {
						var city = $(this).val();
						if(city==-1|| city==null || city=='undefined'){
							$("#cash_coll_addr_tbl #error_text").text("Please select city!!"); 
							$("#pincodeTxt").autocomplete( {
								source :''
							});
						}else{
							$("#cash_coll_addr_tbl #error_text").text(""); 
							$("#pincodeTxt").autocomplete( {
								source : jsonMap[city]['pinCode']
							});	
							$('#curCity').val($(this).find('option:selected').text());
						}	
						$("#pincodeTxt").val('');
				});
				$('#coll_addr_form :input, textarea, select')
						.not(':input[type=button], :input[type=submit], :input[type=reset],:input[type=radio]').each(function() {
						      $(this).css('color', '#312E25');	
				});	
				
				$('input:radio[name=addressType]').click(function() {
					var addrType = $(this).val();
					$("#pincodeTxt").val();
					var $inputs = $('#coll_addr_form :input, textarea, select').not(':input[type=button], :input[type=submit], :input[type=reset],:input[type=radio],:input[type=hidden]');
						if (addrType != 'new') {
							var tblId = "#" + addrType + "_addr_tbl #" + addrType;
						    $inputs.each(function() {
						    	if($(this).attr('id')=='selCity'){
						    		$(this).val(cityNameIdMap[$(tblId + "_"+$(this).attr('id')).text()]);
						    		$(this).change();
						    	}else{
									$(this).val($(tblId + "_"+$(this).attr('id')).text());
								}
						    });
						}else{
							$inputs.each(function() {
						      	$(this).val('');
							});
							$("#pincodeTxt").autocomplete( {
								source :''
							});	
						}
						$("#cash_coll_addr_tbl #error_text").text(""); 
					
				});
				
				$('#coll_addr_form :input[type=submit]').click(
					function(e) {
					//e.preventDefault();
					if($(this).attr('id')=='submit_confirm'){
						var address = $.trim($('textarea#addressLine1').val());
						var pincode = $.trim($('#coll_addr_form :input[id=pincodeTxt]').val());
						var city =$.trim($('select[id=selCity]').val());
						var contactNum = $.trim($('#coll_addr_form :input[id=contactNum]').val());

						if(address==''|| address==null || address=='undefined'){
							$("#cash_coll_addr_tbl #error_text").text("Please fill address!!"); 
							return false;
						}else if(city==-1|| city==null || city=='undefined'){
							$("#cash_coll_addr_tbl #error_text").text("Please select city!!"); 
							return false;
						}else if(pincode==''|| pincode==null || isNaN(pincode)){
							$("#cash_coll_addr_tbl #error_text").text("Please fill valid pincode!!"); 
							return false;
						}else if(contactNum==''|| contactNum==null || isNaN(contactNum)){
							$("#cash_coll_addr_tbl #error_text").text("Please fill valid phone no!!"); 
							return false;
						}
						$("#cash_coll_addr_tbl #error_text").text(""); 
						return true;
					}else if($(this).attr('id')=='submit_cancel'){
						$("#cash_coll_addr_tbl #error_text").text(""); 
						return true;
					}
				});	
			});

	
</SCRIPT>
		
		
	</head>

	<body><s:hidden  id="json" value="%{cityPinJsonMap}"></s:hidden>
		<s:set name="plrInfo" value="%{playerInfoBean}"></s:set>
			<div id="YelloBoxCash">
		    	<div id="Addressbox">
		    	 	<div class="YeloStrip"><p>Confirm Your Address</p></div>
			    	<div id="RegisterSection">
			        	<div class="RegisBox"><h2>Registered Address</h2>
				            <div class="RegisBorderBox">
				            <s:if test="%{plrCollAddMap.get('REGISTERED_ADDR')==null}">
				             <font style="color: red;">Sorry, we currently don't serve to this address.Please provide new address to collect the cash.</font>
				            </s:if>
				              <table width="99%" border="0" cellspacing="0" cellpadding="0" align="center" class="line_hight" id="reg_addr_tbl">
				                <tr>
				                  <td height="38" colspan="2" align="left" valign="middle" class="Nam"><s:property value="#plrInfo.firstName" /> <s:property value="#plrInfo.lastName" /></td>
				                </tr>
				                <tr>
				                  <td width="28%" align="left" valign="top" class="Nam2">House no.</td>
				                  <td width="72%" align="left" valign="top" class="Nam3" id="reg_houseNo"><s:property value="#plrInfo.houseNum" /></td>
				                </tr>
				                <tr>
				                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
				                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
				                </tr>
				                <tr>
				                  <td width="28%" align="left" valign="top" class="Nam2">Address </td>
				                  <td width="72%" align="left" valign="top" class="Nam3" id="reg_addressLine1"><s:property value="#plrInfo.addressLine1" /><br/><s:if test="%{#plrInfo.addressLine2!=null}">
				                  				<s:property value="#plrInfo.addressLine2" /></s:if></td>
				                </tr>
				                <tr>
				                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
				                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
				                </tr>
				                <tr>
				                  <td align="left" valign="top" class="Nam2">City</td>
				                  <td align="left" valign="top" class="Nam3" id="reg_selCity"><s:property value="#plrInfo.city" /></td>
				                </tr>
				                <tr>
				                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
				                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
				                </tr>
				                <tr>
				                  <td align="left" valign="top" class="Nam2">Pincode</td>
				                  <td align="left" valign="top" class="Nam3" id="reg_pincodeTxt"><s:property value="#plrInfo.postalCode" /></td>
				                </tr>
				                <tr>
				                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
				                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
				                </tr>
				                <tr>
				                  <td align="left" valign="top" class="Nam2">Phone No.</td>
				                  <td align="left" valign="top" class="Nam3" id="reg_contactNum"><s:property value="#plrInfo.mobileNum" /></td>
				                </tr>
				                <tr>
				                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
				                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
				                </tr>
				              </table>
				            </div>
			            </div>
			        </div>
		     	<s:if test="%{plrCollAddMap.get('LAST_ADDR')!=null}">
		     		<s:set name="lastCollAddr" value="%{plrCollAddMap.get('LAST_ADDR')}"></s:set>
		     			<div id="BilingSectionSmallRight">
        					<div class="RegisBox" style="margin-left:70px">
								<h2>Last Collection Address</h2>
					            <div class="RegisBorderBox">
					              <table width="99%" border="0" cellspacing="0" cellpadding="0" align="center" class="line_hight" id="last_addr_tbl">
					                <tr>
					                  <td height="38" colspan="2" align="left" valign="middle" class="Nam"><s:property value="#plrInfo.firstName" /> <s:property value="#plrInfo.lastName" /></td>
					                </tr>
					                <tr>
					                  <td width="28%" align="left" valign="top" class="Nam2">House no.</td>
					                  <td width="72%" align="left" valign="top" class="Nam3" id="last_houseNo"><s:property value="#lastCollAddr.houseNum" /></td>
					                </tr>
					                <tr>
					                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
					                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
					                </tr>
					                <tr>
					                  <td width="28%" align="left" valign="top" class="Nam2">Address.</td>
					                  <td width="72%" align="left" valign="top" class="Nam3" id="last_addressLine1"><s:property value="#lastCollAddr.addressLine1" /><br/><s:if test="%{#lastCollAddr.addressLine2!=null}">
									                  				<s:property value="#lastCollAddr.addressLine2" /></s:if></td>
					                </tr>
					                <tr>
					                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
					                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
					                </tr>
					                <tr>
					                  <td align="left" valign="top" class="Nam2">City</td>
					                  <td align="left" valign="top" class="Nam3" id="last_selCity"><s:property value="#lastCollAddr.city" /></td>
					                </tr>
					                <tr>
					                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
					                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
					                </tr>
					                <tr>
					                  <td align="left" valign="top" class="Nam2">Pincode</td>
					                  <td align="left" valign="top" class="Nam3" id="last_pincodeTxt"><s:property value="#lastCollAddr.pincode" /></td>
					                </tr>
					                <tr>
					                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
					                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
					                </tr>
					                <tr>
					                  <td align="left" valign="top" class="Nam2">Phone no.</td>
					                  <td align="left" valign="top" class="Nam3" id="last_contactNum"><s:property value="#lastCollAddr.contactNum" /></td>
					                </tr>
					                <tr>
					                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
					                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
					                </tr>
					              </table>
					            </div>
            				</div>
        				</div>
			       
		     	</s:if>
		     		
					<s:form theme="simple" id="coll_addr_form">
					<s:hidden name="requestBean.amount" value="%{requestBean.amount}"></s:hidden>
					<s:hidden name="requestBean.currencyId" value="%{requestBean.currencyId}"></s:hidden>
					<s:hidden  name="requestBean.collectionDate" value="%{requestBean.collectionDate}"/>
					<s:hidden  name="requestBean.paymentTypeId" value="%{requestBean.paymentTypeId}"/>
					<s:hidden  name="requestBean.collectionDate" value="%{requestBean.collectionDate}"/>
					
					<s:token name="cshCollnToken"></s:token>
					<div id="BilingSection">
			        	<h2>Collection Address</h2>
			            <div class="BillingBox">
			              <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="line_hight" id="cash_coll_addr_tbl">
			              	 <tr>
			                  <td align="left" valign="middle" style="color: red; font-weight: bold;" colspan="2" id="error_text"></td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="left" valign="middle">&nbsp;</td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>	
			                  <td align="left" valign="middle" class="Nam2" >
				                  <s:if test="%{plrCollAddMap.get('REGISTERED_ADDR')!=null}">
					            	 	<input type="radio" name="addressType" id="reg_address" value="reg" checked="checked">Registered Address
					            	 	<s:set name="collAddress"  value="%{plrCollAddMap.get('REGISTERED_ADDR')}"></s:set>
					               		<s:set name="curCity" value="%{#collAddress.city}"/>
					               </s:if>
					                <s:if test="%{plrCollAddMap.get('LAST_ADDR')!=null}">
					            	 	<input type="radio" name="addressType" id="last_address"  value="last" checked="checked">Last Address
					            	 	<s:set name="collAddress" value="%{plrCollAddMap.get('LAST_ADDR')}"></s:set>
					            	 	<s:set name="curCity" value="%{#collAddress.city}"/>
					               </s:if>
				                  	<input type="radio" name="addressType" id="new_address" value="new" checked="checked">New Address	&nbsp;
			                  		<s:set name="collAddress" ></s:set>
			                  		<s:set name="curCity" value="%{cityPinMap.get(requestBean.subTypeId).city}"/>
			                  </td>
			                </tr>
			                 <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="left" valign="middle">&nbsp;</td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">House No</td>
			                  <td align="left" valign="middle">
			                  	<s:textfield name="plrCshCollnbean.houseNum" maxlength="20" value="%{#collAddress.houseNum}"  id="houseNo" cssClass="InpTextBoxBg" /></td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="left" valign="middle">&nbsp;</td>
			                </tr>
								<tr>
									<td align="left" valign="middle" class="Nam2">
										Address
									</td>
									<td align="left" valign="top">
										<textarea name="plrCshCollnbean.addressLine1"
											id="addressLine1" cols="45" rows="5" style="height: 60px"
											class="InpTextBoxBg"><s:property value="%{#collAddress.addressLine1}" /> <s:if test="%{#collAddress.addressLine2!=null}"><s:property value="%{#collAddress.addressLine2}" /></s:if> </textarea>
									</td>
								</tr>
								<tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="left" valign="middle" class="Nam2">(Maximum Limit : 200 characters)</td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="left" valign="middle">&nbsp;</td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">City</td>
			                  <td align="left" valign="middle">
										<s:select list="%{cityPinMap}" headerKey="-1"
											headerValue="---Please select city---" listValue="%{value.city}"
											cssClass="InpTextBoxBg"
											id="selCity" name="requestBean.subTypeId" />
										<s:hidden name="plrCshCollnbean.city" id="curCity" value="%{#curCity}"></s:hidden>
									</td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="left" valign="middle">&nbsp;</td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">Pincode</td>
			                  <td align="left" valign="middle"><s:textfield name="plrCshCollnbean.pincode" maxlength="6" id="pincodeTxt" value="%{#collAddress.pincode}" cssClass="InpTextBoxBg" /> </td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="left" valign="middle">&nbsp;</td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">Phone No.</td>
			                  <td align="left" valign="middle"><s:textfield name="plrCshCollnbean.contactNum" maxlength="15" id="contactNum" value="%{#collAddress.contactNum}" cssClass="InpTextBoxBg"/> </td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="left" valign="middle">&nbsp;</td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="center" valign="middle">
			                  	<s:submit value="Confirm" id="submit_confirm" action="st_pms_cashier_portal_cashCollnRequest" cssClass="Inp_cont2"/>&nbsp; &nbsp; 
			                  </td>
			                </tr>
			                <tr>
			                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
			                  <td align="left" valign="middle">&nbsp;</td>
			                </tr>
			              </table>
			            </div>
		        	</div>
		        	</s:form>
		     	
		    </div>
		</div>
	</body>
</html>

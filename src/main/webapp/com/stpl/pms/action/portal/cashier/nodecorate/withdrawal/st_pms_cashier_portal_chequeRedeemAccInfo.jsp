<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	<div style="margin-top: -13px">
		<s:if test="%{plrRedeemAccMap.get(value.payTypeCode)!=null}">	
			<s:set name="chqRedAccBean" value="%{plrRedeemAccMap.get(value.payTypeCode).chqAccInfo}"></s:set>
   			<s:hidden name="wdrRequestBean.redeemAccountId" value="%{#chqRedAccBean.redeemAccId}"></s:hidden>
   			<s:hidden name="wdrRequestBean.isNewRedeemAcc" id="isNewRedeemAcc" value="N"></s:hidden>
	            <table border="0" cellspacing="0" cellpadding="0" id="wireTrans" align="center">
						<tr>
							<td width="29%" align="left" valign="middle" class="hdwire"
								style="border-top: 1px #F5EABD solid">Name</td>
		                  	<td width="71%" align="left" valign="middle"
								style="border-top: 1px #F5EABD solid"><s:property value="%{#chqRedAccBean.firstName+' '+#chqRedAccBean.lastName}" /></td>
		                </tr>
		               	<tr>
							<td align="left" valign="middle" class="hdwire">House No</td>
		                 	<td align="left" valign="middle"><s:property value="%{#chqRedAccBean.houseNum}" /></td>
		                </tr>
		                
		                <tr>
							<td align="left" valign="middle" class="hdwire">Address </td>
		                 	<td align="left" valign="middle">
		                  	<s:property value="%{#chqRedAccBean.addressLine1}" /><br/> <s:property value="%{#chqRedAccBean.addressLine2}" /></td>
		                </tr>
		                <tr>
							<td align="left" valign="middle" class="hdwire">City </td>
		                  <td align="left" valign="middle"><s:property value="%{#chqRedAccBean.city}" /></td>
		                </tr>
		                <tr>
							<td align="left" valign="middle" class="hdwire">State</td>
		                 	<td align="left" valign="middle"><s:property value="%{#chqRedAccBean.stateCode}" /></td>
		                </tr>
		                <tr>
							<td align="left" valign="middle" class="hdwire">Country</td>
		                  	<td align="left" valign="middle"><s:property value="%{#chqRedAccBean.countryCode}" /></td>
		                </tr>
		               <tr>
							<td align="left" valign="middle" class="hdwire">Pin Code</td>
		                 	<td align="left" valign="middle"><s:property value="%{#chqRedAccBean.postalCode}" /></td>
		               </tr>
		               <tr>
		                 <td align="left" valign="middle" class="hdwire" style="border-right: none">&nbsp;</td>
		                  <td align="left" valign="middle" style="border-left: none">
		                  	<s:submit value="Confirm" id="submit_confirm" action="st_pms_cashier_portal_chequeWdrRequest" cssClass="Inp_cont2"/>&nbsp; &nbsp; 
		                  </td>
	               	   </tr>
         	</table>
           </s:if>
           <s:else>
       			<s:hidden name="wdrRequestBean.isNewRedeemAcc" id="isNewRedeemAcc" value="Y"></s:hidden>
		              <table border="0" cellspacing="0" cellpadding="0" id="wireTrans" align="center">
						<tr>
							<td width="29%" align="left" valign="middle" class="hdwire"
								style="border-top: 1px #F5EABD solid">Name</td>
		                  <td width="71%" align="left" valign="middle"
								style="border-top: 1px #F5EABD solid">
		                  	<s:property value="%{playerInfoBean.firstName+' '+playerInfoBean.lastName}" />
		                  	<s:hidden name="wdrRequestBean.chqRedAcc.firstName" value="%{playerInfoBean.firstName}"/>
		                  	<s:hidden name="wdrRequestBean.chqRedAcc.lastName" value="%{playerInfoBean.lastName}"></s:hidden>
		                  </td>
		                </tr>
		                <tr>
		                  <td align="left" valign="middle" class="hdwire">House No</td>
		                  <td align="left" valign="middle">
		                  	<s:property value="%{playerInfoBean.houseNum}" />
		                  	<s:hidden name="wdrRequestBean.chqRedAcc.houseNum" value="%{playerInfoBean.houseNum}"/>
		                  </td>
		                </tr>
		                
		                <tr>
		                  <td align="left" valign="middle" class="hdwire">Address </td>
		                  <td align="left" valign="middle">
		                  	<s:property value="%{playerInfoBean.addressLine1}" /><br/> 
		                  	<s:property value="%{playerInfoBean.addressLine2}" />
		                  	<s:hidden name="wdrRequestBean.chqRedAcc.addressLine1" value="%{playerInfoBean.addressLine1}"/>
		                  	<s:hidden name="wdrRequestBean.chqRedAcc.addressLine2" value="%{playerInfoBean.addressLine2}"/>
		                  </td>
		                </tr>
		               <tr>
		                  <td align="left" valign="middle" class="hdwire">City </td>
		                  <td align="left" valign="middle">
		                  	<s:property value="%{playerInfoBean.city}" />
		                  	<s:hidden name="wdrRequestBean.chqRedAcc.city" value="%{playerInfoBean.city}"/>
		                  </td>
		                </tr>
		               <tr>
		                  <td align="left" valign="middle" class="hdwire">State</td>
		                  <td align="left" valign="middle">
		                  	<s:property value="%{playerInfoBean.state}" />
		                  	<s:hidden name="wdrRequestBean.chqRedAcc.stateCode" value="%{playerInfoBean.state}"/>
		                  </td>
		                </tr>
		                <tr>
		                  <td align="left" valign="middle" class="hdwire">Country</td>
		                  <td align="left" valign="middle">
		                  	<s:property value="%{playerInfoBean.countryCode}" />
		                  	<s:hidden name="wdrRequestBean.chqRedAcc.countryCode" value="%{playerInfoBean.countryCode}"/>
		                  </td>
		                </tr>
		                <tr>
		                  <td align="left" valign="middle" class="hdwire">Pin Code</td>
		                  <td align="left" valign="middle">
		                  	<s:property value="%{playerInfoBean.postalCode}" />
		                  	<s:hidden name="wdrRequestBean.chqRedAcc.postalCode" value="%{playerInfoBean.postalCode}"/>
		                  </td>
		                </tr>
		                <tr>
		                  <td align="left" valign="middle" class="hdwire" style="border-right: none">&nbsp;</td>
		                  <td align="left" valign="middle" style="border-left: none">
		                  	<s:submit value="Confirm" id="submit_confirm" action="st_pms_cashier_portal_chequeWdrRequest" cssClass="Inp_cont2"/>&nbsp; &nbsp; 
		                  </td>
	               		</tr>
              		</table>
           </s:else>
  </div>
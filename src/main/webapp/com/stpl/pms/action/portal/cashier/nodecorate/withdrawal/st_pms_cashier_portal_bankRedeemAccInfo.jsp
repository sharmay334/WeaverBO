<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/old/redeemInfo.css">
<script type="text/javascript">
	$(document).ready(function(){
		$("input:radio[name=wdrRequestBean.redeemAccountId]").click(function (){
		    if($(this).attr('id')=='newAcc'){
		    	$('#isNewRedeemAcc').val('Y');
		    }else{
		    	$('#isNewRedeemAcc').val('N');
		    }
		  });
		  
		  $("#RegisterSection").accordion( {
			collapsible : true,
			clearStyle : true,
			header : 'div[class="redeemAccHead"]',
			icons : {
				header : "defaultIconWhite",
				headerSelected : "selectedIconWhite"
			},
			active : false
		});
		$('input[id*=redeemAcc_]').click(function(e){
			e.stopPropagation();
		});
	});

</script>
	
	<div id="Addressbox">
    	<div id="RegisterSection">
    		<s:set name="bankRedAccBean" value="%{plrRedeemAccMap.get(value.payTypeCode)}"></s:set>
    		<s:iterator value="#bankRedAccBean.bankRedAccMap">
       		<div class="RegisBox">
       			<div class="redeemAccHead">
       			<input type="radio" name="wdrRequestBean.redeemAccountId" value='<s:property value="%{value.redeemAccId}"/>' id='redeemAcc_<s:property value="%{value.redeemAccId}"/>'> 
       				<s:property value="%{value.bankName+'-'+value.accNum}"/> </div>
	            <div class="RegisBorderBox" style="padding: 4px;">
		              <table width="99%" border="0" cellspacing="0" cellpadding="0" align="center" class="line_hight" id="reg_addr_tbl">
		                <tr>
		                  <td width="28%" align="left" valign="top" class="Nam2">A/C Holder Name</td>
		                  <td width="72%" align="left" valign="top" class="Nam3" id="acc_hold_name"><s:property value="%{value.accHolderName}" /></td>
		                </tr>
		                 <tr>
		                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
		                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
		                </tr>
		                <tr>
		                  <td align="left" valign="top" class="Nam2">A/C Type</td>
		                  <td align="left" valign="top" class="Nam3" id="racc_type"><s:property value="%{value.accType}" /></td>
		                </tr>
		                
		                <tr>
		                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
		                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
		                </tr>
		                <tr>
		                  <td width="28%" align="left" valign="top" class="Nam2">Branch Address </td>
		                  <td width="72%" align="left" valign="top" class="Nam3" id="branch_address">
		                  	<s:property value="%{value.branchCity+','+value.branchLocation}" /><br/> <s:property value="%{value.branchAddress}" /></td>
		                </tr>
		                <tr>
		                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
		                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
		                </tr>
		                <tr>
		                  <td align="left" valign="top" class="Nam2">IFSC Code</td>
		                  <td align="left" valign="top" class="Nam3" id="ifsc_code"><s:property value="%{value.ifscCode}" /></td>
		                </tr>
		                <tr>
		                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
		                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
		                </tr>
		                <tr>
		                  <td align="left" valign="top" class="Nam2">MICR Code</td>
		                  <td align="left" valign="top" class="Nam3" id="micr_code"><s:property value="%{value.micrCode}" /></td>
		                </tr>
		                <tr>
		                  <td align="left" valign="top" class="Nam2">&nbsp;</td>
		                  <td align="left" valign="top" class="Nam3">&nbsp;</td>
		                </tr>
		              </table>
		            </div>
	            </div>
	            </s:iterator>
	        </div>
   			
			<div id="BilingSection">
	        	<h2><input type="radio" id="newAcc" checked="checked" name="wdrRequestBean.redeemAccountId" value="-1">
	        		<s:hidden name="wdrRequestBean.isNewRedeemAcc" id="isNewRedeemAcc" value="Y"></s:hidden>
	        		New Account
	        	</h2>
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
	                  <td align="left" valign="middle" class="Nam2">A/C Holder Name</td>
	                  <td align="left" valign="middle">
	                  	<s:textfield name="wdrRequestBean.bankRedAcc.accHolderName" maxlength="50" id="accHolderName" cssClass="InpTextBoxLargeBg" theme="simple" />
	                  </td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">A/C No.</td>
	                  <td align="left" valign="middle">
	                  	<s:textfield name="wdrRequestBean.bankRedAcc.accNum" maxlength="20" id="accNum" cssClass="InpTextBoxLargeBg" theme="simple" />
	                  </td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">Confirm A/C No.</td>
	                  <td align="left" valign="middle">
	                  	<s:textfield name="confirmAccNum" maxlength="20" id="confirmAccNum" cssClass="InpTextBoxLargeBg" theme="simple" />
	                  </td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">A/C Type</td>
	                  <td align="left" valign="middle">
	                  	<s:radio list="#{'SAVING':'Saving','CURRENT':'Current'}" value="%{'SAVING'}" name="wdrRequestBean.bankRedAcc.accType" id="accType" theme="simple"></s:radio>
	                  </td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	                
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">Bank Name </td>
	                  <td align="left" valign="middle">
	                  	<s:select name="wdrRequestBean.bankRedAcc.subtypeId"
							id="subTypeCode_%{value.payTypeCode}" 
							list="%{#bankList}" headerKey="-1"
							cssClass="InpTextBoxLargeBg" headerValue="--Please Select--"
							theme="simple"></s:select>
	                  </td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">Branch Location</td>
	                  <td align="left" valign="middle">
	                  	<s:textfield name="wdrRequestBean.bankRedAcc.branchLocation" maxlength="20" id="branchLocation" cssClass="InpTextBoxLargeBg" theme="simple"/>
	                  </td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">Branch City</td>
	                  <td align="left" valign="middle">
							<s:textfield name="wdrRequestBean.bankRedAcc.branchCity" maxlength="30" id="branchCity" cssClass="InpTextBoxLargeBg" />
						</td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	                
					<tr>
						<td align="left" valign="middle" class="Nam2">
							Branch Address
						</td>
						<td align="left" valign="top">
							<textarea name="wdrRequestBean.bankRedAcc.branchAddress"
								id="addressLine1" cols="45" rows="5" style="height: 60px"
								class="InpTextBoxLargeBg"></textarea>
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
	                  <td align="left" valign="middle" class="Nam2">IFSC Code</td>
	                  <td align="left" valign="middle"><s:textfield name="wdrRequestBean.bankRedAcc.ifscCode" maxlength="20" id="ifscCode"cssClass="InpTextBoxLargeBg" /> </td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">MICR Code</td>
	                  <td align="left" valign="middle"><s:textfield name="wdrRequestBean.bankRedAcc.micrCode" maxlength="20" id="micrCode" cssClass="InpTextBoxLargeBg"/> </td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="center" valign="middle">
	                  	<s:submit value="Confirm" id="submit_confirm" action="st_pms_cashier_portal_bankWdrRequest" cssClass="Inp_cont2"/>&nbsp; &nbsp; 
	                  </td>
	                </tr>
	                <tr>
	                  <td align="left" valign="middle" class="Nam2">&nbsp;</td>
	                  <td align="left" valign="middle">&nbsp;</td>
	                </tr>
	              </table>
	            </div>
       		</div>
		    </div>
  

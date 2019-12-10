<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Reddem Account Approval</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
	<script type="text/javascript">
			$(document).ready(function(){
				$(function() {
					$('#redeemAccEditForm').submit(function(){
						$("#bankCode").val($("#bankName option:selected").text());					
					});
					
					$(document).on("blur","#ifscCode", function(){
						$(this).val($(this).val().toUpperCase());
					} );
					
					$(document).on("blur","#branchCity", function(){
						$(this).val($.trim($(this).val()));
					} );					
				});
				
			});
	</script>
<style type="text/css">
input#accHolderName {
	width: 35%;
}
</style>

</head>

	<body>
		<div class="FormSection">		
			<div class="greyStrip">
				<h4>
					Edit Redeem Account ID <s:property value="%{redeemAccIdEdit}"/>
				</h4>
			</div>
			 <s:form id="redeemAccEditForm" action="st_pms_bo_csh_RedeemAcc_Update" theme="simple">
			 <s:token name="strutsToken" id="strutsToken"></s:token>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Beneficiary Name
							</label>
						</div>
						<div class="InputDiv">
							<div>
								<%-- <s:property value="%{beneficiaryName}"/> --%>
								<s:hidden name="redAccBankBean.redeemAccId" id="redeemAccId" value="%{redeemAccIdEdit}" />	
								<%-- <s:hidden name="redAccBankBean.accHolderName" id="accHolderName" value="%{beneficiaryName}" /> --%>
								<ss:textfield name="redAccBankBean.accHolderName" id="accHolderName" value="%{beneficiaryName}"  style="width: 35%"></ss:textfield>	
								<s:hidden name="bankCode" id="bankCode"/>
								<s:hidden name="aliasId" id="aliasId" value="%{aliasId}"/>
								<s:hidden name="domainId" id="domainId" value="%{domainId}"/>								
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								A/C No 
							</label>
							<em class="Req">*</em>	
						</div>
						<div class="InputDivHalf">
							<ss:textfield name="redAccBankBean.accNum" id="accNum" applyscript="true" value="%{accNum}" theme="myTheme" maxlength="20" pattern="^[0-9]*$" patternOn="both" errorMassage="Enter valid account no"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Bank Name
							</label>
							<em class="Req">*</em>
							
						</div>
						<div class="InputDivHalf">
							<s:select theme="myTheme" cssClass="select1" name="redAccBankBean.subtypeId" applyscript="true"  value="%{subtypeId}"
										list="%{bankMap}" listKey="%{value}" listValue="%{key}" headerKey="-1" style="width: 35%;" headerValue="--Please Select--"
										id="bankName"  
										></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
							Branch Location
							</label>
						</div>						
							<div class="InputDivHalf">
							<ss:textfield name="redAccBankBean.branchLocation" id="branchLocation" value="%{branchLocation}" theme="myTheme" maxlength="20"></ss:textfield>
						</div>
						
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
							Branch City
							</label>
							<em class="Req">*</em>
						</div>						
							<div class="InputDivHalf">
							<ss:textfield name="redAccBankBean.branchCity" id="branchCity" value="%{branchCity}" applyscript="true" theme="myTheme" maxlength="30"></ss:textfield>
						</div>
						
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
							Branch Address
							</label>
						</div>						
							<div class="InputDiv" style="height: auto">
							<s:textarea name="redAccBankBean.branchAddress" id="branchAddress" cols="45" value="%{branchAddress}" maxlength="200"
															rows="5" cssStyle="width:34%;"></s:textarea><br/> 	(Maximum Limit : 200 characters)
															
															</div>
						
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								IFSC Code
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<ss:textfield name="redAccBankBean.ifscCode" id="ifscCode" applyscript="true" value="%{ifscCode}" pattern="^[0-9a-zA-Z]*$" patternOn="both" errorMassage="Enter valid Ifsc code" theme="myTheme" maxlength="20"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								MICR Code
							</label>
							
						</div>
						<div class="InputDivHalf">
							<ss:textfield name="redAccBankBean.micrCode" id="micrCode"  theme="myTheme" value="%{micrCode}" maxlength="20" pattern="^[0-9a-zA-Z]*$" patternOn="both" errorMassage="Enter valid Micr code" ></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
				

				</div>
				<div class="box_footer" align="right">
					<s:submit  value="Update" cssClass="button"></s:submit>
				</div>
			</s:form>
		
</div>
	</body>
</html>

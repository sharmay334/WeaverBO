<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Player Payment Correction</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
	</head>
<script type="text/javascript">
$(document).ready(function(){
	loadAliasName("<s:property value="%{payCorrection.domainId}" />");
}); 
function loadAliasName(domainId){
	var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
	$('#aliasId').empty().append( $('<option></option>').val("-1").html("----Please Select----") );
	$.each(aliasMap,function(index, value) {
		$('#aliasId').append($('<option></opplayerSearchMenution>').val(index).html(value));
  	});
}

</script>
	<body>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					Player Payment Correction
				</h4>
			</div>
			 <s:form id="payCorrectionFrm" action="st_pms_bo_csh_plrPaymentCorrection_save" theme="simple">
			 <s:token name="strutsToken" id="strutsToken"></s:token>
				<div class="innerBox">
				<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Alias </label><em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<div>
	<ss:select theme="myTheme" cssClass="select1" list="%{}" id="aliasId" headerKey="-1" name="payCorrection.aliasId"
									headerValue="--Please Select--" applyscript="true">
								</ss:select>


					</div>
				</div>
			</div>
				<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								User Name
							</label>
						</div>
						<div class="InputDiv">
							<div>
								<s:property value="%{userName}"/>
								<s:hidden name="payCorrection.userName" id="userName" value="%{userName}" />
								<s:hidden name="payCorrection.domainId" id="domainId" value="%{payCorrection.domainId}" />
							
								<s:hidden name="payCorrection.playerId" id="playerId" value="%{payCorrection.playerId}" />
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Correction Type
							</label>
						</div>
						<div class="InputDivHalf inpRadio">
							<ss:radio list="#{'DEBIT':'Debit','CREDIT':'Credit'}"
								name="payCorrection.correctionType" id="correctionType" value="%{'DEBIT'}"/>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Correction Amount
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="amount" max="10000" name="payCorrection.amount" theme="myTheme" value="" applyscript="true" pattern="^[0-9]*$" errorMassage="Only Numeric Character allowed" maxlength="5"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Impact On Withdrawable
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:radio list="#{'YES':'Yes','NO':'No'}"
								name="payCorrection.withdrawableImpact" id="correctionType" value="%{'NO'}"/>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Reason
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<ss:textfield name="payCorrection.reason" id="reason" applyscript="true" theme="myTheme" maxlength="95"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
				

				</div>
				<div class="box_footer" align="right">
					<s:submit  value="Submit" cssClass="button"></s:submit>
				</div>
			</s:form>
		</div>
	</body>
</html>

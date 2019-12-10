<%@ taglib uri="/struts-tags" prefix="s" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Manipulate Payment Sub Type</title>
  <script type="text/javascript">
	$(function(){
		$("#payTypeMast option[value='CHEQUE_TRANS']").remove();
		$("#payTypeMast option[value='HAND_CASH']").remove();
		$("#payTypeMast option[value='WIRE_TRANS']").remove();
		
		$("#payTypeMast").change(function(){
	  		if(this.value!=-1){
	  			_ajaxCallDiv("st_pms_csh_getPaySubTypes.action","paymentTypeCode="+this.value,"tabContainer");
	  		}else{
	  			$("#tabContainer").empty();
	  		}
  			$("#dynamicArea").empty();
  			$("#addNewForm").hide();
	  	});
	});	
	
	$(function(){
  		paramArr=window.location.search.replace("?","").split("=");
  		if(paramArr.length==2 && ""!=paramArr[1].trim() && paramArr[0]==="lastView"){
			$("#payTypeMast").val(paramArr[1]);
  			_ajaxCallDiv("st_pms_csh_getPaySubTypes.action","paymentTypeCode="+paramArr[1],"tabContainer");
  		}
  	});
	
	$(document).on('click', 'button.editAction', function(){
		createDynForm($(this).parent().parent()); 
		$("#addNewForm h4").text("Edit Payment Sub Type");
		return false;
	});
	
 	//global common data...
	window.textField=["cardName","cshpayTypeDispCode","bankNameDispCode","walletName","city","pinCode"];
	window.cntryReqLst=["NET_BANKING","CASH_COLLECTION","BANK_TRANS"];
  </script>
  </head>
  <body>
    <div id="container">
    	<h2>Add/Update Payment Sub-Type</h2>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Select Payment Type</h4>
			</div>
			<form id="payTypeForm">
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Payment type master:
							</label><em class="Req">*</em>
						</div>
						
						<div class="InputDiv">
							<s:select list="%{payTypeMasterList}" listKey="paymentTypeCode" listValue="paymentTypeDispCode"
							headerKey="-1" headerValue="--Please Select--" cssClass="select1"
							name="paymentTypeCode" id="payTypeMast" theme="myTheme" ></s:select>
						</div>					
					</div>
				</div>
			</form>
		</div>    	
 	<div id="tabContainer"></div>
    </div>
	<div style="margin-bottom: 50px;"></div>
  </body>
</html>

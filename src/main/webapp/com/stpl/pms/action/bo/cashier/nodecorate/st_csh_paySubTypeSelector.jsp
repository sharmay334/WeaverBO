<%@ taglib uri="/struts-tags" prefix="s" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<script type="text/javascript">
	$(function(){
		$("#payTypeMast option[value='CHEQUE_TRANS']").remove();
		$("#payTypeMast option[value='HAND_CASH']").remove();
		$("#payTypeMast option[value='WIRE_TRANS']").remove();
		$("#payTypeMast").change(function(){
	  		if(this.value!=-1)
	  			_ajaxCallDiv("<%=path%>"+"/com/stpl/pms/action/bo/cashier/st_pms_csh_getPaySubTypes.action","paymentTypeCode="+this.value,"tabContainer");
	  	});
	});	
	
	$(document).on('click', '', function(){
	});
	
 	//global common data...
/* 	window.textField=["cardName","cshpayTypeDispCode","bankNameDispCode","walletName","city","pinCode"];
	window.cntryReqLst=["NET_BANKING","CASH_COLLECTION","BANK_TRANS"]; */
  </script>
  </head>
  <body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>Select Payment Type</h4>
		</div>
		<div class="innerBox">
			<div class="clearFRM"></div>
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
	</div>    	
  </body>
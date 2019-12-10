<%@ taglib prefix="s" uri="/struts-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>add podm</title>
    <link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
    <script type="text/javascript">
    function reInitChzn(selektor){
    	$(selektor).removeClass("chzn-done");
		$(selektor+"_chzn").remove();
		$(selektor).chosen();
		$(selektor+"_chzn .chzn-choices").css("height","auto");
    }
    
    function setMapInSelect(idSelctor,map){
    	$(idSelctor).empty();
    	for (var key in map) {
		  	if (map.hasOwnProperty(key)) {
		  		$(idSelctor).append($('<option></option>').val(key).html(map[key]));
			}
		}
    }
    
    $(function(){
	    $("#payTypeMast option[value='6']").remove();//CHEQUE_TRANS
		//$("#payTypeMast option[value='11']").remove();//HAND_CASH
		$("#payTypeMast option[value='8']").remove();//WIRE_TRANS
		
	    reInitChzn("#subTypeSelektor");
	    reInitChzn("#roleIdSelektor");
	    
    	 $("#payTypeMast").change(function(){
    		if(this.value!="-1"){
				var subTypeMap = _ajaxCallJson("com/stpl/pms/action/bo/cashier/st_pms_csh_getPaySubTypeSelector.action","paymentTypeId="+this.value);
				setMapInSelect("#subTypeSelektor",subTypeMap);
			    reInitChzn("#subTypeSelektor");
			}
    	 });
    	  $("#domainId").change(function(){
    		if(this.value!="-1"){
    			var jsonList = '["vipList","currencyList","countryList",aliasList]';
				commonData = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+this.value+"&jsonList="+jsonList,"");
				
				$("#aliasId").empty().append($('<option>').html("--Please Select--").val(-1));
				$.each(commonData["aliasList"], function(index, value) {
					$("#aliasId").append($('<option>').val(value.aliasId).html(value.aliasName));
				}); 
				
				$("#roleIdSelektor").empty();
				$.each(commonData["vipList"], function(index, value) {
					$("#roleIdSelektor").append($('<option></option>').val(value.vipLevel).html(value.vipCode));
				});
    			reInitChzn("#roleIdSelektor");
				
				$("#payCountrySelecktor").empty().append($('<option>').html("--Please Select--").val(-1));
				$.each(commonData["countryList"], function(index, value) {
					$("#payCountrySelecktor").append($('<option></option>').val(value.countryId).html(value.name));
				});
				
				$("#payCurrencySelecktor").empty().append($('<option>').html("--Please Select--").val(-1));
				$.each(commonData["currencyList"], function(index, value) {
					$("#payCurrencySelecktor").append($('<option></option>').val(value.currencyId).html(value.currName).attr("data-currCode",value.currCode));
				});
				
			}
    	 });
    	 
    	 $("#payCurrencySelecktor").change(function(){
    	 	if (this.value!="-1") 
				$("#providerCurrencyCode").val($(this).find("option:selected").attr("data-currCode"));
			else
				$("#providerCurrencyCode").val("");
    	 });
    	 
    	$("#subTypeSelektor").change(function(){
    		var subTypeVal=$(this).val();
    		if(subTypeVal && subTypeVal.length>1){
    			$("#provSubTypeCodeDiv").hide();
    			$("#providerSubTypeCode").prop("disabled",true);
    			$("#providerSubTypeCode").val(null);
    		} else{
    			$("#provSubTypeCodeDiv").show();
    			$("#providerSubTypeCode").prop( "disabled",false);
    		}
    	});
    	
    	$("#PODMForm").submit(function(){
    		return validatePODMForm();
    	});
    	
    });
    function validatePODMForm(){
			if(!$("#subTypeSelektor").val()){
    			alert("Please Select payment sub type!");
    			return false;
    		}
			if(!$(".tranTypeSelctor:checked").val()){
    			alert("Please Select Transaction Type!");
    			return false;
    		}
			if(!$(".typProcTime:checked").val()){
    			alert("Please Select Typical Process Time!");
    			return false;
    		}
			
			if(!$("form :input[type='checkbox']:checked").val()){
    			alert("Please select check aleast one device!");
    			return false;
    		}
			
			if(new RegExp("^\(?:\\d+\\.)\?\\d+$").test($("#minValue").val())){
				if(parseFloat($("#minValue").val())<0){
					alert("Min value shoud be a positive number!");
    				return false;
				}    				
    		}else{
    			alert("Min Value invalid");
    			return false;
    		}
			
			if(new RegExp("^\(?:\\d+\\.)\?\\d+$").test($("#maxValue").val())){
    			if(parseFloat($("#maxValue").val())<parseFloat($("#minValue").val())){
    				alert("Max Value should not be less than Min Value!");
   					return false;
   				}
    		}else{
    			alert("Max Value invalid!");
    			return false;
    		}
							
			if(!$(".chgPayeeSelektor:checked").val()){
    			alert("Please select charge payee!");
    			return false;
    		}
		return true;
    	}
    </script>
  </head>
  <body>
    <div id="container">
    	<h2>Add PODM</h2>
		<form id="PODMForm" action="com/stpl/pms/action/bo/cashier/st_pms_csh_savePODMSetup.action" method="post" >
			<div class="FormSection">
				<div class="greyStrip">
					<h4>Current Payment Sub Types</h4>
				</div>
				<s:token></s:token>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Domain Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select theme="myTheme" cssClass="select1" list="%{domainMap}" applyscript="true" name="payOptBean.domainId" id="domainId" headerKey="-1"
								headerValue="--Please Select--"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Alias Name: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select theme="myTheme" cssClass="select1" list="#{}" applyscript="true" name="payOptBean.aliasId" id="aliasId" headerKey="-1"
								headerValue="--Please Select--"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Payment Provider:
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select list="%{paymentProviderMap}" applyscript="true" listValue="%{value.toUpperCase()}" headerKey="-1" headerValue="--Please Select--" cssClass="select1"
							name="payOptBean.providerId" id="providerSelektor" theme="myTheme" ></s:select>
						</div>					
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Payment type master:
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select list="%{payTypeMasterList}"  applyscript="true" listKey="paymentTypeId" listValue="paymentTypeDispCode"
							headerKey="-1" headerValue="--Please Select--" cssClass="select1"
							name="payOptBean.paymentTypeId" id="payTypeMast" theme="myTheme" ></s:select>
						</div>					
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Payment Sub Type:
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv" style="height: auto;">
						<!-- headerKey="-1" headerValue="--Please Select--" -->
							<s:select list="#{}" cssClass="select1" data-placeholder="select a payment sub type..."  multiple="true" id="subTypeSelektor" 
							name="payOptBean.subTypeIdArr" theme="myTheme" cssStyle="height:auto"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Level(s):
							</label>
						</div>
						<div class="InputDiv" style="height: auto;">
							<s:select  multiple="true" list="#{}" data-placeholder="select nothing for all VIP levels... " cssClass="select1" id="roleIdSelektor" 
							name="payOptBean.roleIdArr" theme="myTheme" cssStyle="height:auto"></s:select>
						</div>
					</div>
					<div id="provSubTypeCodeDiv">
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
										Provider SubType Code:
								</label>
							</div>
							<div class="InputDiv">
								<s:textfield theme="myTheme" name="payOptBean.providerSubTypeCode" id="providerSubTypeCode" 
								maxlength="50"></s:textfield>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
									Country:
							</label> 
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select applyscript="true" id="payCountrySelecktor" name="payOptBean.countryId" headerKey="-1" headerValue="--Please Select--" list="#{}" theme="myTheme" cssClass="select1"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
									Currency:
							</label> 
							<em class="Req">*</em>
						</div>
						<s:hidden name="payOptBean.providerCurrencyCode" id="providerCurrencyCode"></s:hidden>
						<div class="InputDiv">
							<s:select applyscript="true" id="payCurrencySelecktor" name="payOptBean.currencyId" headerKey="-1" headerValue="--Please Select--" list="#{}" listValue="%{value.currCode}" theme="myTheme" cssClass="select1"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
									Transaction Type:
							</label> 
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:radio  list="#{'DEPOSIT':'DEPOSIT','WITHDRAWAL':'WITHDRAWAL'}" cssClass="tranTypeSelctor" applyscript="true" id="tranTypeSelctor"  name="payOptBean.txnType"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
									Typical Process Time:
							</label> 
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:radio applyscript="true" cssClass="typProcTime" id="typProcTime" name="payOptBean.typicalProcessTime" list="#{'INSTANT':'INSTANT','1-2 DAYS':'1-2 DAYS','2-4 DAYS':'2-4 DAYS','4-5 DAYS':'4-5 DAYS'}" theme="myTheme" ></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
									Device:
							</label> 
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:checkboxlist applyscript="true" cssClass="deviceSelektor" name="payOptBean.deviceArr" list="#{'PC':'PC','MOBILE':'MOBILE'}" theme="myTheme"></s:checkboxlist>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
									Minimum Value:
							</label> 
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
						<s:textfield theme="myTheme" id="minValue" name="payOptBean.minValue" applyscript="true"></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
									Maximum Value:
							</label> 
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
						<s:textfield theme="myTheme" id="maxValue" name="payOptBean.maxValue" applyscript="true"></s:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
									Charge Payee:
							</label> 
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:radio  applyscript="true" id="chgPayeeSelektor" cssClass="chgPayeeSelektor" name="payOptBean.chargePayee" list="#{'DOMAIN':'DOMAIN','PLAYER':'PLAYER'}" theme="myTheme"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
									Prcessing Charge:
							</label> 
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select applyscript="true" id="procChargeSelektor" name="payOptBean.processingChargeId" headerKey="-1" headerValue="--Please Select--" list="%{procChargMap}" theme="myTheme" cssClass="select1"></s:select>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<s:submit id="Submit" name="Submit" theme="simple"
						cssClass="button"></s:submit>
				</div>
			</div>
			</form>
		</div>
		<div id="subTypeContainer"></div>   	
  	<div style="margin: 50px;"></div>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Player Withdrawal</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=path%>/css/jquery.ui.theme.min.css" rel="stylesheet" type="text/css" />
		<SCRIPT type="text/javascript">
			var count = 1;
			var wdrTypeMap;
			$(document).ready(function() {
				var domainId = $("#domainId").val();
				if(domainId!=-1 && domainId != "") {
					domainChangeActivity(domainId);
				}
			
				$('#domainId').change(function() {
					domainChangeActivity($(this).val());
				});
				
				function domainChangeActivity(domainId){
					$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  				var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
	  				$.each(aliasMap,function(index, value) {
	  					$('#aliasId').append($('<option></option>').val(index).html(value));
	  				});
				
					$('#countryList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$('#currencyList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$('#vipList').empty().append($('<option></option>').val("0").html("----All Role----"));
					var jsonList = '["countryList","vipList","currencyList"]';
					var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
					$.each(map["countryList"], function(index,
							value) {
						$('#countryList').append(
								$('<option></option>').val(
										value.countryId).html(
										value.name));
					});
					if(map["countryList"].length==1){
						$('#countryList').find('option[value=-1]').remove();
						$('#countryList').change();
					}
					
					
					$.each(map["currencyList"], function(index,
							value) {
						$('#currencyList').append(
								$('<option></option>').val(
										value.currencyId).html(
										value.currName));
					});
					if(map["currencyList"].length==1){
						$('#currencyList').find('option[value=-1]').remove();
						$('#currencyList').change();
					}
					
					$.each(map["vipList"], function(index,
							value) {
						$('#vipList').append(
								$('<option></option>').val(
										value.vipLevel).html(
										value.vipCode));
					});
				}
				
				$('#currencyList').change(function() {
					$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					if($('#domainId').val()!=-1 && $(this).val()!=-1 && $('#countryList').val()!=-1 && $('#device').val()!=-1){
					var param = 'domainId='+$('#domainId').val()+'&countryId='+$('#countryList').val()+'&currencyId='+$(this).val()+'&vipLevelId='+$('#vipList').val()+'&device='+$('#device').val();
						wdrTypeMap = _ajaxCallJson('com/stpl/pms/action/bo/cashier/st_pms_bo_csh_getWdrPaymentType.action',param);
						if(wdrTypeMap!='error'){
							$.each(wdrTypeMap, function(index, value) {
								$('#payTypeList').append(
									$('<option></option>').val(value.paymentTypeId).html(value.payTypeDispCode));
							});
						}else{
							$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
						}
					}else{
						$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					}
				});
				$('#countryList').change(function() {
						$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
						if($('#domainId').val()!=-1 && $(this).val()!=-1 && $('#currencyList').val()!=-1 && $('#device').val()!=-1){
						var param = 'domainId='+$('#domainId').val()+'&countryId='+$(this).val()+'&currencyId='+$('#currencyList').val()+'&vipLevelId='+$('#vipList').val()+'&device='+$('#device').val();
						wdrTypeMap = _ajaxCallJson('com/stpl/pms/action/bo/cashier/st_pms_bo_csh_getWdrPaymentType.action',param);
							if(wdrTypeMap!='error'){
								$.each(wdrTypeMap, function(index, value) {
									$('#payTypeList').append(
										$('<option></option>').val(value.paymentTypeId).html(value.payTypeDispCode));
								});
							}else{
								$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
							}
						}else{
							$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
						}
					});
					
				$('#device').change(function() {
						$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
						if($('#domainId').val()!=-1 && $(this).val()!=-1 && $('#currencyList').val()!=-1 && $('#countryList').val()!=-1){
						var param = 'domainId='+$('#domainId').val()+'&aliasId='+$('#aliasId').val()+'&countryId='+$('#countryList').val()+'&currencyId='+$('#currencyList').val()+'&vipLevelId='+$('#vipList').val()+'&device='+$(this).val();
						wdrTypeMap = _ajaxCallJson('com/stpl/pms/action/bo/cashier/st_pms_bo_csh_getWdrPaymentType.action',param);
							if(wdrTypeMap!='error'){
								$.each(wdrTypeMap, function(index, value) {
									$('#payTypeList').append(
										$('<option></option>').val(value.paymentTypeId).html(value.payTypeDispCode));
								});
							}else{
								$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
							}
						}else{
							$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
						}
					});	
					
				$('#payTypeList').change(function() {
					if($(this).val()!=-1){
						$('#paymentTypeCode').val(wdrTypeMap[$(this).val()].payTypeCode);
					}
				});
			$(".dateField").datetimepicker(
			{
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond : true,
				maxDate: serverDateStr,
				maxDateTime:$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
				onClose : function(dateText, inst) {
					if ($(this).attr('id').indexOf('fromDate') != -1) {
						$('#toDate').datetimepicker("option", "minDate",
								dateText);
						$('#toDate').datetimepicker("option", "minDateTime",
								$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
					} else if ($(this).attr('id').indexOf('toDate') != -1) {
						$('#fromDate').datetimepicker("option", "maxDate",
								dateText);
						$('#fromDate').datetimepicker("option", "maxDateTime",
								$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
					}
				}
			});
              $('#toDate').datetimepicker('setDate', new Date());  
              
               
                $('#plrWdrSearchFrm :input, textarea, select').change(function(){
                	$('#searchResult').html('');
                	$('table.bubbletip').css('display','none');
                });
                
                $("#downloadExcel").click(function(){
                var domainId=$("#domainId").val();
                var aliasId=$("#aliasId").val();
                var vipList =$("#vipList").val();
                var countryList =$("#countryList").val();
                var currencyList =$("#currencyList").val();
                var device= $("#device").val();
                var payTypeList=$("#payTypeList").val();
                var paymentTypeCode = $("#paymentTypeCode").val();
                var fromDate = $("#fromDate").val();
                var toDate =$("#toDate").val();
                var fromAmount =$("#fromAmount").val();
                var toAmount = $("#toAmount").val();
                var wdrStatus= $("#wdrStatus").val();
				var isValid = false;
				var downloadFrm = $("<form></form>");
				downloadFrm.attr("id","downloadForm");
				downloadFrm.attr("action","com/stpl/pms/action/bo/cashier/st_pms_bo_csh_initiatedWithdrawal_exportExcel.action?txnSearchBean.domainId="+domainId+"&txnSearchBean.aliasId="+aliasId+"&txnSearchBean.vipLevel="+vipList+"&txnSearchBean.countryId="+countryList+"&txnSearchBean.currencyId="+currencyList+"&txnSearchBean.device="+device+"&txnSearchBean.paymentTypeId="+payTypeList+"&txnSearchBean.paymentTypeCode="+paymentTypeCode+"&txnSearchBean.fromDate="+fromDate+"&txnSearchBean.toDate="+toDate+"&txnSearchBean.fromAmount="+fromAmount+"&txnSearchBean.toAmount="+toAmount+"&wdrStatus="+wdrStatus);
				downloadFrm.attr("method","POST");
					$("#downloadDiv").append(downloadFrm);
				if(domainId!=-1 && countryList!=-1 && currencyList!=-1 && device!=-1 && payTypeList!=-1)	
					$("#downloadForm").submit();
				else
					$("#domainId").createBubble();
				$("#downloadDiv").empty();
				return false;
                });
                
			});
		
		</SCRIPT>
	</head>

	<body>
	<s:hidden id="allowedDate" value="%{@com.stpl.pms.utility.Utility@getServerDate(1,-3,0,'dd/MM/yyyy')}" />
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Withdrawal Search </h4>
			</div>
					
			<s:form id="plrWdrSearchFrm" action="st_pms_bo_csh_withdrawal_Search" target="searchResult" theme="simple">
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain Name
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden name="txnSearchBean.domainId" value="%{domainId}" id="domainId"></s:hidden>
								<s:property value="%{domainName}"/>
							</s:if>
							<s:else>
								<s:select theme="myTheme" cssClass="select1"
									list="%{domainMap}"
									name="txnSearchBean.domainId" id="domainId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" applyscript="true" value="%{bydefaultSelectedDomain}"  ></s:select>
							</s:else>
							
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Alias Name
							</label>
						</div>
						<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="%{aliasMap}"
									name="txnSearchBean.aliasId" id="aliasId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}"  ></s:select>
							
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								VIP Level or Role
							</label>
						</div>
						<div class="InputDiv"> 
							<ss:select list="%{vipLevelBeanList}" headerKey="0" headerValue="--All Role--"
								cssClass="select1" name="txnSearchBean.vipLevel" id="vipList"
								theme="myTheme" applyscript="true" listKey="vipLevel"
								listValue="vipCode"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Country
							</label>
							<em class="Req">*</em>
						</div> 
						<div class="InputDiv">
							<ss:select cssClass="select1" name="txnSearchBean.countryId"
								id="countryList" headerKey="-1" headerValue="--Please Select--"
								list="%{countryBeanList}" theme="myTheme" applyscript="true"
								listKey="countryId" listValue="name"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Currency
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select list="%{currencyBeanList}" headerKey="-1"
								headerValue="--Please Select--" cssClass="select1"
								name="txnSearchBean.currencyId" id="currencyList"
								theme="myTheme" applyscript="true" listKey="currencyId"
								listValue="currName"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Device:
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select
								list="#{'-1':'----- Please Select ------','PC':'PC','MOBILE':'Mobile','MOBILE_WEB':'Mobile Web','TAB':'Tab','DOWNLOADABLE_CLIENT':'Downloadable Client'}"
								applyscript="true" cssClass="select1" name="txnSearchBean.device" id="device"
								theme="myTheme"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Withdrawal Type
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select list="#{'-1':'----Please Select----'}" cssClass="select1" name="txnSearchBean.paymentTypeId" id="payTypeList" theme="myTheme" applyscript="true"></s:select>
							
							<s:hidden name="txnSearchBean.paymentTypeCode" id="paymentTypeCode"/>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Date
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield name="txnSearchBean.fromDate" cssClass="dateField" id="fromDate" readonly="true" value="%{deploymentDate}"   theme="myTheme"></ss:textfield>
							<ss:textfield name="txnSearchBean.toDate"  cssClass="dateField" id="toDate" readonly="true"  theme="myTheme"></ss:textfield>
						</div>
						
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Amount
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield name="txnSearchBean.fromAmount" id="fromAmount"  theme="myTheme" pattern="^[0-9]*$" errorMassage="Only Numeric Character allowed" ></ss:textfield>
							<ss:textfield name="txnSearchBean.toAmount" id="toAmount" theme="myTheme" pattern="^[0-9]*$" errorMassage="Only Numeric Character allowed"></ss:textfield>
							<s:hidden name="wdrStatus" id="wdrStatus" value="%{wdrStatus}" ></s:hidden>
							
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<ss:submit theme="simple" id="submitBtn" value="Search" ></ss:submit>
					<s:if test="#context['struts.actionMapping'].name=='st_pms_bo_csh_processWithdrawal_Menu'">
   					<s:submit name="Download" id="downloadExcel" value="Download Excel"/>
					</s:if>
					
					
				</div>
			</s:form>
			<div id="downloadDiv">
			
			</div>
		</div>
		<div class="clear2"></div>
		<div id="searchResult" class="FormSection">

		</div>
	</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Player Deposits</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=path%>/css/jquery.ui.theme.min.css" rel="stylesheet" type="text/css" />
		<SCRIPT type="text/javascript">
			var count = 1;
			var payTypeMap;
			$(document).ready(function() {
				$('#domainId').change(function() {
					$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  				var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  				$.each(aliasMap,function(index, value) {
	  					$('#aliasId').append($('<option></option>').val(index).html(value));
	  				});
				
					$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$('#currencyList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					var domainId = $('#domainId').val();
					var device = $('#device').val();
					if(domainId!=-1 && device !=-1){
						preparePaymentTyp(domainId,device);
					}
				});
				
				$('#device').change(function() {
					$('#payTypeList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$('#currencyList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					var domainId = $('#domainId').val();
					var device = $('#device').val();
					if(domainId!=-1 && device !=-1){
						preparePaymentTyp(domainId,device);
					}
				});
				
				$('#payTypeList').change(function() {
					$('#paymentTypeCode').val(payTypeMap[$(this).val()].payTypeCode);
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
				
                $('#plrDepoSearchFrm :input, textarea, select').change(function(){
                	$('#searchResult').html('');
                });
			});
			
			function preparePaymentTyp(domainId,device){
				var map = _ajaxCallJson("com/stpl/pms/action/bo/cashier/st_pms_bo_csh_getDepositOptions.action?domainId="+domainId+"&device="+device,"");
					$.each(map["offlinePayTypeMap"], function(index,
							value) {
						$('#payTypeList').append(
								$('<option></option>').val(
										index).html(value.payTypeDispCode));
					});
					payTypeMap = map["offlinePayTypeMap"];
					$.each(map["currencyList"], function(index,
							value) {
						$('#currencyList').append(
								$('<option></option>').val(
										value.currencyId).html(
										value.currName));
					});
			}
		
		</SCRIPT>
	</head>

	<body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Deposit Search
				</h4>
			</div>
			<s:form id="plrDepoSearchFrm" action="st_pms_bo_csh_deposit_Search"
				target="searchResult" theme="simple">
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
								<s:hidden name="txnSearchBean.domainId" value="%{domainId}"
									id="domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<s:select theme="myTheme" cssClass="select1" list="%{domainMap}"
									name="txnSearchBean.domainId" id="domainId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" applyscript="true" value="%{bydefaultSelectedDomain}" ></s:select>
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
								<s:select theme="myTheme" cssClass="select1" list="%{aliasMap}"
									name="txnSearchBean.aliasId" id="aliasId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" ></s:select>

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
								Currency
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1" list="#{'-1':'--Please Select--'}"
								name="txnSearchBean.currencyId" id="currencyList"  applyscript="true"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Deposit Type
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1" list="#{'-1':'--Please Select--'}"
								name="txnSearchBean.paymentTypeId" id="payTypeList"  applyscript="true"></ss:select>
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
							<ss:textfield name="txnSearchBean.fromDate" id="fromDate"
								value="%{deploymentDate}" cssClass="dateField" readonly="true"
								theme="myTheme"></ss:textfield>
							<ss:textfield name="txnSearchBean.toDate" id="toDate"
								readonly="true" cssClass="dateField" theme="myTheme"></ss:textfield>
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
							<ss:textfield name="txnSearchBean.fromAmount" id="fromAmount"
								theme="myTheme" pattern="^[0-9]*$"
								errorMassage="Only Numeric Character allowed"></ss:textfield>
							<ss:textfield name="txnSearchBean.toAmount" id="toAmount"
								theme="myTheme" pattern="^[0-9]*$"
								errorMassage="Only Numeric Character allowed"></ss:textfield>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<s:submit theme="simple" id="submitBtn" value="Search"></s:submit>
				</div>
			</s:form>
		</div>
		<div class="clear2"></div>
		<div id="searchResult" class="FormSection">

		</div>
	</body>
</html>

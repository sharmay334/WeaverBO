<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="/extended-struts2-tags" prefix="ss"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Processing Charge </title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="Processing Charge ">
		<script type="text/javascript">
			$(document).ready(
			function() {
				$('#domainId').change(function() {
					$('#countryList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$('#currencyList').empty().append($('<option></option>').val("-1").html("----Please Select----"));;
					$('#vipLevelList').empty().append($('<option></option>').val("-1").html("----All Role----"));;
					var domainId = $(this).val();
					var jsonList = '["countryList","vipList","currencyList"]';
					var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
					$.each(map["countryList"], function(index,
							value) {
						$('#countryList').append(
								$('<option></option>').val(
										value.countryId).html(
										value.name));
					});
					
					$.each(map["currencyList"], function(index,
							value) {
						$('#currencyList').append(
								$('<option></option>').val(
										value.currencyId).html(
										value.currName));
					});
					$.each(map["vipList"], function(index,
							value) {
						$('#vipLevelList').append(
								$('<option></option>').val(
										value.vipLevel).html(
										value.vipCode));
					});
				});
                
			});
			
				
	function openTab(divId,obj){	
			$('div[id*="tabs-"]').hide();
			$("#"+divId).show();	
	}
</script>
		
	</head>

	<body>
		<div id="container">
			<h2>
				Cashier Payment Processing Charge
			</h2>
			<div class="FormSection">
			 <div class="greyStrip">
				<h4>
					Search For Processing Charge
				</h4>
				</div>
				<s:form theme="simple" id="pomFrm"
					action="bo_csh_pod_process_charge_search" target="searchResult"
					cssClass="ajaxFrm">
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:if test="%{domainId>1}">
									<s:hidden value="%{domainId}" id="domainId"
									name="domainId"></s:hidden>
									<s:property value="%{domainName}" />
								</s:if>
								<s:else>
									<ss:select theme="simple" cssClass="select1" list="%{domainMap}"
									name="domainId" id="domainId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" applyscript="true"></ss:select>
								</s:else>
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
								<ss:select cssClass="select1" name="countryId" id="countryList"
									list="%{countryBeanList}" listKey="countryId" listValue="name"
									headerKey="-1" headerValue="--Please Select--" applyscript="true">
								</ss:select>
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
							<div class="InputDiv">
								<ss:select list="%{currencyBeanList}" listKey="currencyId"
									listValue="currName" headerKey="-1"
									headerValue="--Please Select--" cssClass="select1"
									name="currencyId" id="currencyList" applyscript="true">
								</ss:select>
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
									list="#{'-1':'----- Please Select ------','MOBILE':'Mobile','PC':'PC'}"
									applyscript="true" cssClass="select1" name="device" id="device"
									theme="myTheme"></ss:select>
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
								<ss:select theme="simple" cssClass="select1" id="txnType"
									name="txnType" list="{'DEPOSIT','WITHDRAWAL'}" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></ss:select>
							</div>

						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									VIP Level or Role:
								</label>
							</div>
							<div class="InputDiv">
								<ss:select cssClass="select1" name="vipLevelId"
									id="vipLevelList" list="%{vipLevelBeanList}" headerKey="-1"
									listKey="vipLevel" listValue="vipCode"
									headerValue="----All Role----">
								</ss:select>
							</div>
						</div>
					</div>
					<div class="box_footer" align="right">
						<s:submit theme="simple" id="submitBtn" value="Search"></s:submit>
					</div>
				</s:form>
			</div>
			<div id="searchResult"></div>
			<div class="clearFRM"></div>
		</div>
	</body>
</html>

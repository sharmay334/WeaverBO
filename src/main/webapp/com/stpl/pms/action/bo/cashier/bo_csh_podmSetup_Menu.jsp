<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Cashier Provider Options</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
		 $(document).ready(
			function() {
				$('#domainId').change(function() {
						if($("#domainId").val()=="0"){
						$('#aliasId').attr('disabled','true');
					}
					else{
						$('#aliasId').removeAttr('disabled');
						$("#aliasId").html("");
						loadAliasName($(this).val());
					}
				
				
					$('#countryList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$('#currencyList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$('#roleList').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					var domainId = $(this).val();
					var jsonList = '["countryList","currencyList","vipList"]';
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
						$('#roleList').append(
								$('<option></option>').val(
										value.vipLevel).html(
										value.vipCode));
					});
				});
                function loadAliasName(domainId){
					var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
					$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$.each(aliasMap,function(index, value) {
						$('#aliasId').append($('<option></opplayerSearchMenution>').val(index).html(value));
				  	});
			}
			});
			</script>
	</head>

	<body>
		<div id="container">
			<h2>
				Cashier Payment Options

			</h2>
			<div class="FormSection">
			 <div class="greyStrip">
				<h4>
					Payment Option Search
				</h4>
				</div>
				<s:form theme="simple" id="pomFrm" action="bo_csh_podmSetup_Search" target="searchResult">
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name:
								</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:if test="%{domainId>1}">
									<s:hidden value="%{domainId}" id="domainId"
										name="domainId"></s:hidden>
									<s:property value="%{domainName}" />
								</s:if>
								<s:else>
									<s:select theme="myTheme" cssClass="select1"
										list="%{domainMap}" name="domainId" id="domainId"
										headerKey="-1" headerValue="--Please Select--"
										listKey="%{key}" listValue="%{value}" applyscript="true"></s:select>
								</s:else>
							</div>
						</div>
						<div class="clearFRM"></div>
						
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Alias
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div>
								<ss:select theme="myTheme" cssClass="select1" list="%{}" id="aliasId" name="aliasId" headerKey="-1"
									headerValue="--Please Select--"  applyscript="true" >
								</ss:select>
							</div>
						</div>
					</div>

			<div class="clearFRM"></div>
					
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Country:
								</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:select list="%{countryBeanList}"
									listKey="countryId" listValue="name" headerKey="-1"
									headerValue="--Please Select--" cssClass="select1"
									name="countryId" id="countryList" theme="myTheme" 
									applyscript="true"></ss:select>
							</div>
						</div>
						<div class="clearFRM"></div>


						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Currency:
								</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:select list="%{currencyBeanList}"
									listKey="currencyId" listValue="currName" headerKey="-1"
									headerValue="--Please Select--" cssClass="select1"
									name="currencyId" id="currencyList" theme="myTheme"
									applyscript="true"></ss:select>
							</div>
						</div>
						<div class="clearFRM"></div>

						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Transaction Type:
								</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:select theme="myTheme" applyscript="true" cssClass="select1"
									id="txnType" name="txnType" list="{'DEPOSIT','WITHDRAWAL'}"
									headerKey="-1" headerValue="--Please Select--"></ss:select>
							</div>

						</div>
						<div class="clearFRM"></div>


						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									VIP Level:
								</label><em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:select
									list="%{vipLevelBeanList}"
									headerKey="-1" listKey="vipLevel" listValue="vipCode"
									headerValue="--Please Select--" applyscript="true"
									cssClass="select1" name="vipLevelId" id="roleList"
									theme="myTheme"></ss:select>
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
					</div>
					<div class="box_footer" align="right">
						<ss:submit theme="myTheme" id="submitBtn" value="Search" ></ss:submit>
					</div>
				</s:form>
			</div>
			<div id="searchResult"></div>
		</div>
	</body>
</html>
